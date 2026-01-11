from typing import List, Dict, Any, Optional
from app.config import settings
import json
import logging
import httpx

# Import both clients (we'll use the appropriate one)
try:
    from anthropic import Anthropic
except ImportError:
    Anthropic = None

try:
    from openai import OpenAI
    from openai import PermissionDeniedError, AuthenticationError, APIError
except ImportError:
    OpenAI = None
    PermissionDeniedError = None
    AuthenticationError = None
    APIError = None

logger = logging.getLogger(__name__)


class VocabularyAIAgent:
    def __init__(self):
        if settings.llm_provider == "anthropic":
            if not Anthropic:
                raise ImportError("anthropic package is required. Install with: pip install anthropic")
            if not settings.anthropic_api_key:
                raise ValueError("ANTHROPIC_API_KEY is required when using Anthropic")
            self.client = Anthropic(api_key=settings.anthropic_api_key)
            self.provider = "anthropic"
        else:
            # OpenAI-compatible API (LM Studio, self-hosted, etc.)
            if not OpenAI:
                raise ImportError("openai package is required. Install with: pip install openai")
            base_url = settings.openai_base_url or "https://llm.vikashgaurav.com/v1"
            # Ensure base_url ends with /v1 for OpenAI-compatible APIs
            if not base_url.endswith("/v1"):
                if base_url.endswith("/"):
                    base_url = base_url + "v1"
                else:
                    base_url = base_url + "/v1"
            # Initialize OpenAI client with timeout and retry settings for self-hosted LLMs
            # For LM Studio and self-hosted LLMs, we may need to use default_headers
            api_key = settings.openai_api_key or "dummy"
            self.client = OpenAI(
                api_key=api_key,
                base_url=base_url,
                timeout=60.0,  # 60 second timeout for self-hosted LLMs
                max_retries=2,
                default_headers={
                    "User-Agent": "VocabMaster-AI-Agent/1.0"
                }
            )
            self.provider = "openai"
            self.model = settings.openai_model
            self.base_url = base_url
            self.api_key = api_key
            self.use_httpx_fallback = True  # Use httpx as fallback if OpenAI client fails
            logger.info(f"Initialized OpenAI client with base_url={base_url}, model={self.model}, api_key={'***' if api_key else 'None'}")
    
    def _make_llm_request(self, messages: List[Dict[str, str]], max_tokens: int, temperature: float = 0.7) -> str:
        """Make LLM request with httpx fallback if OpenAI client fails."""
        if self.provider == "anthropic":
            response = self.client.messages.create(
                model="claude-sonnet-4-20250514",
                max_tokens=max_tokens,
                messages=messages
            )
            return response.content[0].text
        else:
            # Try OpenAI client first
            try:
                response = self.client.chat.completions.create(
                    model=self.model,
                    max_tokens=max_tokens,
                    messages=messages,
                    temperature=temperature,
                )
                content = response.choices[0].message.content
                if not content:
                    raise ValueError("Empty response from LLM")
                return content
            except (PermissionDeniedError, Exception) as e:
                # Fall back to httpx if OpenAI client fails
                if self.use_httpx_fallback:
                    logger.warning(f"OpenAI client failed ({type(e).__name__}), trying httpx fallback...")
                    try:
                        httpx_response = httpx.post(
                            f"{self.base_url}/chat/completions",
                            headers={
                                "Content-Type": "application/json",
                                "Authorization": f"Bearer {self.api_key}"
                            },
                            json={
                                "model": self.model,
                                "messages": messages,
                                "max_tokens": max_tokens,
                                "temperature": temperature,
                            },
                            timeout=60.0
                        )
                        httpx_response.raise_for_status()
                        data = httpx_response.json()
                        content = data["choices"][0]["message"]["content"]
                        if not content:
                            raise ValueError("Empty response from LLM")
                        logger.info("httpx fallback successful")
                        return content
                    except Exception as httpx_error:
                        error_msg = f"Both OpenAI client and httpx fallback failed. OpenAI error: {str(e)}, httpx error: {str(httpx_error)}"
                        logger.error(error_msg)
                        raise Exception(error_msg)
                else:
                    raise Exception(f"LLM API error: {str(e)}")
    
    def generate_quiz(self, word: str, definition: str, examples: List[str] = None) -> Dict[str, Any]:
        """Generate multiple-choice quiz for a word."""
        examples_text = "\n".join([f"- {ex}" for ex in (examples or [])])
        
        prompt = f"""Create a multiple-choice quiz question for the word: {word}

Definition: {definition}

Examples:
{examples_text if examples_text else "None provided"}

Requirements:
1. Create a question that tests understanding of the word's meaning
2. Provide one correct answer
3. Provide three plausible but incorrect distractors
4. Distractors should be semantically related but clearly wrong
5. Return JSON format with: question, options (array with text and is_correct), correct_answer, explanation

Return only valid JSON, no markdown formatting."""

        try:
            logger.info(f"Making request to {self.base_url} with model {self.model}")
            logger.debug(f"Prompt preview: {prompt[:200]}...")
            content = self._make_llm_request(
                messages=[{"role": "user", "content": prompt}],
                max_tokens=1000,
                temperature=0.7
            )
        except Exception as api_error:
            if "LLM API error" not in str(api_error):
                raise Exception(f"LLM API error: {str(api_error)}")
            raise
        
        # Try to extract JSON from response
        try:
            # Remove markdown code blocks if present
            if "```json" in content:
                content = content.split("```json")[1].split("```")[0].strip()
            elif "```" in content:
                content = content.split("```")[1].split("```")[0].strip()
            
            quiz_data = json.loads(content)
            
            # Ensure correct format
            if "options" in quiz_data:
                for option in quiz_data["options"]:
                    if isinstance(option, str):
                        # Convert string options to dict format
                        quiz_data["options"] = [
                            {"text": opt, "is_correct": opt == quiz_data.get("correct_answer", "")}
                            for opt in quiz_data["options"]
                        ]
            
            return quiz_data
        except json.JSONDecodeError:
            # Fallback: create a simple quiz structure
            return {
                "question": f"What does '{word}' mean?",
                "options": [
                    {"text": definition, "is_correct": True},
                    {"text": "A different word", "is_correct": False},
                    {"text": "Another word", "is_correct": False},
                    {"text": "Yet another word", "is_correct": False}
                ],
                "correct_answer": definition,
                "explanation": f"'{word}' means {definition}"
            }
    
    def explain_word(self, word: str, definition: str, etymology: str = None, examples: List[str] = None, question: str = None) -> str:
        """Answer user questions about the word."""
        examples_text = "\n".join([f"- {ex}" for ex in (examples or [])])
        etymology_text = f"\nEtymology: {etymology}" if etymology else ""
        
        context = f"""Word: {word}
Definition: {definition}
{etymology_text}
Examples:
{examples_text if examples_text else "None provided"}
"""
        
        user_question = question or "Can you explain this word in detail?"
        full_prompt = f"{context}\n\nQuestion: {user_question}\n\nPlease provide a clear, educational explanation."
        
        try:
            return self._make_llm_request(
                messages=[{"role": "user", "content": full_prompt}],
                max_tokens=500,
                temperature=0.7
            )
        except Exception as api_error:
            raise Exception(f"LLM API error: {str(api_error)}")
    
    def generate_story(self, words: List[Dict[str, str]], user_level: str) -> str:
        """Generate guided learning story."""
        word_list = "\n".join([f"- {w['word']}: {w['definition']}" for w in words])
        
        prompt = f"""Create an engaging learning story that naturally incorporates these vocabulary words:

{word_list}

User level: {user_level}

Requirements:
- Natural narrative flow (200-300 words)
- Each word used in context
- Memorable and thematic
- Educational and engaging
- Make the story coherent and interesting

Write the story now:"""

        try:
            return self._make_llm_request(
                messages=[{"role": "user", "content": prompt}],
                max_tokens=1500,
                temperature=0.7
            )
        except Exception as api_error:
            raise Exception(f"LLM API error: {str(api_error)}")
    
    def cluster_words_thematically(self, words: List[Dict[str, str]], count: int = 20) -> List[Dict[str, str]]:
        """Cluster words thematically for story generation."""
        # Simple implementation: return first N words
        # In production, this could use AI to group words by theme
        return words[:count]
    
    def generate_word_details(self, word: str) -> Dict[str, Any]:
        """Generate comprehensive word details including definitions, etymology, pronunciation, and part of speech."""
        prompt = f"""Generate comprehensive details for the word: {word}

Please provide a JSON response with the following structure:
{{
    "definitions": [
        {{
            "text": "primary definition text",
            "is_primary": true,
            "example": "example sentence using the word"
        }},
        {{
            "text": "secondary definition text",
            "is_primary": false,
            "example": "another example sentence"
        }}
    ],
    "etymology": {{
        "origin_language": "language of origin",
        "root_word": "root word if applicable",
        "evolution": "brief evolution story"
    }},
    "pronunciation": "phonetic pronunciation (e.g., /ˈwɜrd/)",
    "parts_of_speech": ["noun", "verb"],
    "difficulty_level": 5.0,
    "importance_score": 50,
    "tone": "positive|negative|neutral"
}}

Requirements:
- Provide at least 1-2 definitions (first one should be primary)
- Include etymology information if available
- Provide phonetic pronunciation
- List all parts of speech for this word
- Set difficulty_level (1-10 scale, 5.0 is average)
- Set importance_score (1-100 scale, 50 is average)
- Set tone to "positive", "negative", or "neutral" based on the word's typical emotional connotation
- Return only valid JSON, no markdown formatting"""

        try:
            content = self._make_llm_request(
                messages=[{"role": "user", "content": prompt}],
                max_tokens=1500,
                temperature=0.7
            )
            
            # Try to extract JSON from response
            try:
                # Remove markdown code blocks if present
                if "```json" in content:
                    content = content.split("```json")[1].split("```")[0].strip()
                elif "```" in content:
                    content = content.split("```")[1].split("```")[0].strip()
                
                word_data = json.loads(content)
                
                # Validate and set defaults
                if "definitions" not in word_data or not word_data["definitions"]:
                    word_data["definitions"] = [{"text": f"A word meaning related to {word}", "is_primary": True, "example": None}]
                
                # Ensure first definition is primary
                if word_data["definitions"]:
                    word_data["definitions"][0]["is_primary"] = True
                
                # Set defaults for missing fields
                word_data.setdefault("etymology", {})
                word_data.setdefault("pronunciation", None)
                word_data.setdefault("parts_of_speech", ["noun"])
                word_data.setdefault("difficulty_level", 5.0)
                word_data.setdefault("importance_score", 50)
                
                return word_data
            except json.JSONDecodeError:
                # Fallback: create basic structure
                return {
                    "definitions": [
                        {"text": f"A word: {word}", "is_primary": True, "example": None}
                    ],
                    "etymology": {},
                    "pronunciation": None,
                    "parts_of_speech": ["noun"],
                    "difficulty_level": 5.0,
                    "importance_score": 50
                }
        except Exception as api_error:
            raise Exception(f"LLM API error: {str(api_error)}")
    
    def generate_image_prompt(self, word: str, definition: str) -> str:
        """Generate prompt for image generation."""
        prompt = f"""Create a detailed visual description for generating an image that represents: {word}

Definition: {definition}

The image should be:
- Metaphorically or literally representative
- Memorable and clear
- Suitable for educational purposes
- Visually interesting

Return a detailed image generation prompt (2-3 sentences)."""

        try:
            return self._make_llm_request(
                messages=[{"role": "user", "content": prompt}],
                max_tokens=300,
                temperature=0.7
            )
        except Exception as api_error:
            raise Exception(f"LLM API error: {str(api_error)}")
    
    def chat(self, word: str, definition: str, message: str) -> str:
        """Chat with AI about word."""
        context = f"""Word: {word}
Definition: {definition}

User message: {message}

Please provide a helpful, educational response about this word."""

        try:
            return self._make_llm_request(
                messages=[{"role": "user", "content": context}],
                max_tokens=500,
                temperature=0.7
            )
        except Exception as api_error:
            raise Exception(f"LLM API error: {str(api_error)}")

from typing import List, Dict, Any
from anthropic import Anthropic
from app.config import settings
import json


class VocabularyAIAgent:
    def __init__(self):
        self.client = Anthropic(api_key=settings.anthropic_api_key)
    
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

        response = self.client.messages.create(
            model="claude-sonnet-4-20250514",
            max_tokens=1000,
            messages=[{"role": "user", "content": prompt}]
        )
        
        content = response.content[0].text
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
        
        messages = [
            {"role": "user", "content": f"{context}\n\nQuestion: {user_question}\n\nPlease provide a clear, educational explanation."}
        ]
        
        response = self.client.messages.create(
            model="claude-sonnet-4-20250514",
            max_tokens=500,
            messages=messages
        )
        
        return response.content[0].text
    
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

        response = self.client.messages.create(
            model="claude-sonnet-4-20250514",
            max_tokens=1500,
            messages=[{"role": "user", "content": prompt}]
        )
        
        return response.content[0].text
    
    def cluster_words_thematically(self, words: List[Dict[str, str]], count: int = 20) -> List[Dict[str, str]]:
        """Cluster words thematically for story generation."""
        # Simple implementation: return first N words
        # In production, this could use AI to group words by theme
        return words[:count]
    
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

        response = self.client.messages.create(
            model="claude-sonnet-4-20250514",
            max_tokens=300,
            messages=[{"role": "user", "content": prompt}]
        )
        
        return response.content[0].text
    
    def chat(self, word: str, definition: str, message: str) -> str:
        """Chat with AI about word."""
        context = f"""Word: {word}
Definition: {definition}

User message: {message}

Please provide a helpful, educational response about this word."""

        response = self.client.messages.create(
            model="claude-sonnet-4-20250514",
            max_tokens=500,
            messages=[{"role": "user", "content": context}]
        )
        
        return response.content[0].text

from fastapi import FastAPI, HTTPException, status
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import List, Dict, Any, Optional
from app.agent import VocabularyAIAgent
from app.config import settings

app = FastAPI(
    title="VocabMaster AI Agent Service",
    description="AI Agent Service for Vocabulary Learning",
    version="1.0.0"
)

# CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"] if settings.debug else [],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Initialize AI agent
agent = VocabularyAIAgent()


class QuizRequest(BaseModel):
    word: str
    definition: str
    examples: Optional[List[str]] = None


class ExplainRequest(BaseModel):
    word: str
    definition: str
    etymology: Optional[str] = None
    examples: Optional[List[str]] = None
    question: str


class StoryRequest(BaseModel):
    words: List[Dict[str, str]]
    user_level: str


class ChatRequest(BaseModel):
    word: str
    definition: str
    message: str


@app.get("/")
async def root():
    return {"message": "VocabMaster AI Agent Service", "version": "1.0.0"}


@app.get("/health")
async def health():
    return {"status": "healthy"}


@app.post("/generate-quiz")
async def generate_quiz(request: QuizRequest):
    """Generate multiple-choice quiz."""
    try:
        result = agent.generate_quiz(
            word=request.word,
            definition=request.definition,
            examples=request.examples or []
        )
        return result
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Error generating quiz: {str(e)}"
        )


@app.post("/explain-word")
async def explain_word(request: ExplainRequest):
    """Explain word based on question."""
    try:
        answer = agent.explain_word(
            word=request.word,
            definition=request.definition,
            etymology=request.etymology,
            examples=request.examples or [],
            question=request.question
        )
        return {"answer": answer}
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Error explaining word: {str(e)}"
        )


@app.post("/generate-story")
async def generate_story(request: StoryRequest):
    """Generate guided learning story."""
    try:
        narrative = agent.generate_story(
            words=request.words,
            user_level=request.user_level
        )
        return {"narrative": narrative}
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Error generating story: {str(e)}"
        )


@app.post("/chat")
async def chat(request: ChatRequest):
    """Chat with AI about word."""
    try:
        response = agent.chat(
            word=request.word,
            definition=request.definition,
            message=request.message
        )
        return {"response": response}
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Error in chat: {str(e)}"
        )

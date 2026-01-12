from pydantic import BaseModel
from typing import List, Optional, Dict, Any


class QuizGenerateRequest(BaseModel):
    word_id: int


class QuizOption(BaseModel):
    text: str
    is_correct: bool


class QuizResponse(BaseModel):
    question: str
    options: List[QuizOption]
    correct_answer: str
    explanation: Optional[str] = None


class ExplainRequest(BaseModel):
    word_id: int
    question: str


class ExplainResponse(BaseModel):
    answer: str


class StoryGenerateRequest(BaseModel):
    word_ids: Optional[List[int]] = None
    batch_size: int = 20
    story_type: str = "daily"


class StoryResponse(BaseModel):
    story_id: int
    title: str
    narrative: str
    word_ids: List[int]
    story_type: str


class ChatRequest(BaseModel):
    word_id: int
    message: str


class ChatResponse(BaseModel):
    response: str

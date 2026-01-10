from pydantic import BaseModel
from typing import List, Optional, Dict, Any
from datetime import date


class DailyStackItem(BaseModel):
    id: int
    word_id: int
    word: str
    scheduled_date: str
    is_reviewed: bool

    class Config:
        from_attributes = True


class ReviewSubmit(BaseModel):
    word_id: int
    is_correct: bool
    question_type: str
    user_answer: Optional[str] = None
    correct_answer: str
    time_taken_seconds: Optional[int] = None
    options_presented: Optional[List[str]] = None


class ReviewResponse(BaseModel):
    success: bool
    new_level: int
    next_review_date: Optional[str] = None
    status: str
    message: str


class AddWordsRequest(BaseModel):
    word_ids: List[int]


class WordProgressDetail(BaseModel):
    word_id: int
    word: Optional[str] = None
    fibonacci_level: int
    next_review_date: Optional[str] = None
    correct_count: int
    incorrect_count: int
    last_reviewed_at: Optional[str] = None
    status: str
    added_at: Optional[str] = None
    mastered_at: Optional[str] = None


class UpcomingReview(BaseModel):
    word_id: int
    word: Optional[str] = None
    review_date: Optional[str] = None
    level: int

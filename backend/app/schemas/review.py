from pydantic import BaseModel, field_serializer
from typing import List, Optional, Dict, Any
from datetime import date, datetime


class DailyStackItem(BaseModel):
    id: int
    word_id: int
    word: str
    scheduled_date: str  # Already converted to ISO string in endpoint
    is_reviewed: bool
    level: int  # Current Fibonacci level (0-11, where 0=new, 11=mastered)

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
    next_review_date: Optional[str] = None  # Already converted to ISO string in service
    correct_count: int
    incorrect_count: int
    last_reviewed_at: Optional[str] = None  # Already converted to ISO string in service
    status: str
    added_at: Optional[str] = None  # Already converted to ISO string in service
    mastered_at: Optional[str] = None  # Already converted to ISO string in service


class UpcomingReview(BaseModel):
    word_id: int
    word: Optional[str] = None
    review_date: Optional[str] = None
    level: int

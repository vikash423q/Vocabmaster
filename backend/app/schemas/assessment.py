"""
Schemas for user assessment and leveling system.
"""
from pydantic import BaseModel
from typing import List, Optional
from datetime import datetime


class AssessmentWord(BaseModel):
    """Word data for assessment stack."""
    id: int
    word: str
    pronunciation: Optional[str] = None
    difficulty_level: float
    cefr_level: Optional[str] = None


class AssessmentStack(BaseModel):
    """Assessment stack response."""
    words: List[AssessmentWord]
    total_words: int
    is_first_assessment: bool  # True if user has never been assessed


class AssessmentResponse(BaseModel):
    """User's response to a word in assessment."""
    word_id: int
    response: str  # "know", "maybe", "don't_know"


class AssessmentSubmit(BaseModel):
    """Submit assessment responses."""
    responses: List[AssessmentResponse]


class AssessmentResult(BaseModel):
    """Assessment result after submission."""
    calculated_level: float
    responses_count: int
    words_assessed: int


class RecommendedWord(BaseModel):
    """Recommended word for user stack."""
    id: int
    word: str
    pronunciation: Optional[str] = None
    difficulty_level: float
    cefr_level: Optional[str] = None
    category_id: int
    category_name: Optional[str] = None
    importance_score: int


class StackRecommendation(BaseModel):
    """Stack recommendation response."""
    words: List[RecommendedWord]
    recommended_level: float
    user_current_level: Optional[float] = None
    total_recommended: int

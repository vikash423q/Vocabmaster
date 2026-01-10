from pydantic import BaseModel, EmailStr
from typing import Optional


class UserRegister(BaseModel):
    email: EmailStr
    username: str
    password: str
    current_level: Optional[str] = "beginner"


class UserLogin(BaseModel):
    email: EmailStr
    password: str


class Token(BaseModel):
    access_token: str
    token_type: str = "bearer"


class UserProfile(BaseModel):
    id: int
    email: str
    username: str
    current_level: str
    created_at: str
    last_active: Optional[str] = None
    settings: dict = {}

    class Config:
        from_attributes = True


class UserProfileUpdate(BaseModel):
    username: Optional[str] = None
    current_level: Optional[str] = None
    settings: Optional[dict] = None


class UserStats(BaseModel):
    total_words: int
    mastered_words: int
    learning_words: int
    reviewing_words: int
    total_quizzes: int
    correct_answers: int
    accuracy_rate: float
    words_due_today: int

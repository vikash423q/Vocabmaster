from pydantic import BaseModel, EmailStr, field_validator, field_serializer
from typing import Optional
from datetime import datetime


class UserRegister(BaseModel):
    email: EmailStr
    username: str
    password: str
    current_level: Optional[str] = "beginner"


class UserLogin(BaseModel):
    email: EmailStr
    password: str
    # Note: Password validation is handled in verify_password function
    # to allow compatibility with any password length (truncated to 72 bytes)


class Token(BaseModel):
    access_token: str
    token_type: str = "bearer"


class UserProfile(BaseModel):
    id: int
    email: str
    username: str
    current_level: str
    created_at: datetime
    last_active: Optional[datetime] = None
    settings: dict = {}

    @field_serializer('created_at', 'last_active')
    def serialize_datetime(self, value: Optional[datetime], _info) -> Optional[str]:
        """Serialize datetime to ISO format string."""
        if value is None:
            return None
        return value.isoformat()

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

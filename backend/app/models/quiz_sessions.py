from sqlalchemy import Column, Integer, ForeignKey, String, Text, Boolean, DateTime, Enum, JSON
from sqlalchemy.sql import func
from sqlalchemy.orm import relationship
import enum
from app.database import Base


class QuestionType(str, enum.Enum):
    MULTIPLE_CHOICE = "multiple_choice"
    FILL_BLANK = "fill_blank"
    AI_GENERATED = "ai_generated"


class QuizSession(Base):
    __tablename__ = "quiz_sessions"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    word_id = Column(Integer, ForeignKey("words.id"), nullable=False)
    question_type = Column(Enum(QuestionType), nullable=False)
    options_presented = Column(JSON, nullable=True)  # Array of options
    user_answer = Column(Text, nullable=True)
    correct_answer = Column(Text, nullable=False)
    is_correct = Column(Boolean, nullable=False)
    time_taken_seconds = Column(Integer, nullable=True)
    created_at = Column(DateTime(timezone=True), server_default=func.now())

    # Relationships
    user = relationship("User", back_populates="quiz_sessions")
    word = relationship("Word", back_populates="quiz_sessions")

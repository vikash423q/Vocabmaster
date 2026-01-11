from sqlalchemy import Column, Integer, String, DateTime, Enum, JSON, Numeric
from sqlalchemy.sql import func
from sqlalchemy.orm import relationship
import enum
from app.database import Base


class UserLevel(str, enum.Enum):
    BEGINNER = "beginner"
    INTERMEDIATE = "intermediate"
    ADVANCED = "advanced"


class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    email = Column(String, unique=True, index=True, nullable=False)
    username = Column(String, unique=True, index=True, nullable=False)
    password_hash = Column(String, nullable=False)
    current_level = Column(Numeric(3, 1), nullable=True)  # Float: 1.0-10.0, null = not assessed
    created_at = Column(DateTime(timezone=True), server_default=func.now())
    last_active = Column(DateTime(timezone=True), server_default=func.now(), onupdate=func.now())
    settings = Column(JSON, default={})

    # Relationships
    word_progress = relationship("UserWordProgress", back_populates="user", cascade="all, delete-orphan")
    daily_stacks = relationship("DailyWordStack", back_populates="user", cascade="all, delete-orphan")
    quiz_sessions = relationship("QuizSession", back_populates="user", cascade="all, delete-orphan")
    guided_stories = relationship("GuidedStory", back_populates="user", cascade="all, delete-orphan")

from sqlalchemy import Column, Integer, String, ForeignKey, DateTime, Numeric, Enum, JSON, Index
from sqlalchemy.sql import func
from sqlalchemy.orm import relationship
import enum
from app.database import Base


class WordSource(str, enum.Enum):
    GRE = "GRE"
    WORDPOWER = "WordPower"
    USER = "User"
    CURATED = "Curated"


class Tone(str, enum.Enum):
    POSITIVE = "POSITIVE"
    NEGATIVE = "NEGATIVE"
    NEUTRAL = "NEUTRAL"


class Word(Base):
    __tablename__ = "words"

    id = Column(Integer, primary_key=True, index=True)
    word = Column(String, unique=True, index=True, nullable=False)
    category_id = Column(Integer, ForeignKey("categories.id"), nullable=False)
    difficulty_level = Column(Numeric(3, 1), default=5.0, nullable=False)  # 1-10
    importance_score = Column(Integer, default=50, nullable=False)  # 1-100
    part_of_speech = Column(JSON, default=[])  # Array of strings
    pronunciation = Column(String, nullable=True)
    source = Column(Enum(WordSource), default=WordSource.CURATED, nullable=False)
    tone = Column(Enum(Tone), default=Tone.NEUTRAL, nullable=False)
    created_at = Column(DateTime(timezone=True), server_default=func.now())

    # Relationships
    category = relationship("Category", back_populates="words")
    definitions = relationship("WordDefinition", back_populates="word", cascade="all, delete-orphan")
    etymology = relationship("WordEtymology", back_populates="word", uselist=False, cascade="all, delete-orphan")
    media = relationship("WordMedia", back_populates="word", cascade="all, delete-orphan")
    user_progress = relationship("UserWordProgress", back_populates="word", cascade="all, delete-orphan")
    daily_stacks = relationship("DailyWordStack", back_populates="word", cascade="all, delete-orphan")
    quiz_sessions = relationship("QuizSession", back_populates="word", cascade="all, delete-orphan")

    # Indexes
    __table_args__ = (
        Index("idx_word_category", "category_id"),
        Index("idx_word_difficulty", "difficulty_level"),
        Index("idx_word_importance", "importance_score"),
    )

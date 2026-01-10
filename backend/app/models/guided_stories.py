from sqlalchemy import Column, Integer, ForeignKey, Text, DateTime, Enum, JSON
from sqlalchemy.sql import func
from sqlalchemy.orm import relationship
import enum
from app.database import Base


class StoryType(str, enum.Enum):
    DAILY = "daily"
    WEEKLY = "weekly"
    CUSTOM = "custom"


class GuidedStory(Base):
    __tablename__ = "guided_stories"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    story_type = Column(Enum(StoryType), nullable=False)
    word_ids = Column(JSON, nullable=False)  # Array of word IDs
    narrative = Column(Text, nullable=False)  # AI-generated story
    created_at = Column(DateTime(timezone=True), server_default=func.now())

    # Relationships
    user = relationship("User", back_populates="guided_stories")

from sqlalchemy import Column, Integer, String, Text, ForeignKey, Boolean, DateTime, Enum
from sqlalchemy.sql import func
from sqlalchemy.orm import relationship
import enum
from app.database import Base


class MediaType(str, enum.Enum):
    IMAGE = "image"
    QUOTE = "quote"
    VIDEO_CLIP = "video_clip"


class WordMedia(Base):
    __tablename__ = "word_media"

    id = Column(Integer, primary_key=True, index=True)
    word_id = Column(Integer, ForeignKey("words.id"), nullable=False)
    media_type = Column(Enum(MediaType), nullable=False)
    url = Column(String, nullable=False)
    source = Column(String, nullable=True)  # "AI Generated", "Movie: The Matrix", etc.
    caption = Column(Text, nullable=True)
    is_ai_generated = Column(Boolean, default=False, nullable=False)
    created_at = Column(DateTime(timezone=True), server_default=func.now())

    # Relationships
    word = relationship("Word", back_populates="media")

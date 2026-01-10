from sqlalchemy import Column, Integer, String, Text, ForeignKey, DateTime
from sqlalchemy.sql import func
from sqlalchemy.orm import relationship
from app.database import Base


class WordEtymology(Base):
    __tablename__ = "word_etymology"

    id = Column(Integer, primary_key=True, index=True)
    word_id = Column(Integer, ForeignKey("words.id"), unique=True, nullable=False)
    origin_language = Column(String, nullable=True)
    root_word = Column(String, nullable=True)
    evolution_story = Column(Text, nullable=True)
    created_at = Column(DateTime(timezone=True), server_default=func.now())

    # Relationships
    word = relationship("Word", back_populates="etymology")

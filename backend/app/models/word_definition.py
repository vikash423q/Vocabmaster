from sqlalchemy import Column, Integer, String, Text, ForeignKey, Boolean, DateTime
from sqlalchemy.sql import func
from sqlalchemy.orm import relationship
from app.database import Base


class WordDefinition(Base):
    __tablename__ = "word_definitions"

    id = Column(Integer, primary_key=True, index=True)
    word_id = Column(Integer, ForeignKey("words.id"), nullable=False)
    definition = Column(Text, nullable=False)
    example_sentence = Column(Text, nullable=True)
    is_primary = Column(Boolean, default=False, nullable=False)
    order_index = Column(Integer, default=0, nullable=False)

    # Relationships
    word = relationship("Word", back_populates="definitions")

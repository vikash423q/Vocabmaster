from sqlalchemy import Column, Integer, String, ForeignKey, Index
from sqlalchemy.orm import relationship
from app.database import Base


class WordSynonym(Base):
    __tablename__ = "word_synonyms"

    id = Column(Integer, primary_key=True, index=True)
    word_id = Column(Integer, ForeignKey("words.id", ondelete="CASCADE"), nullable=False, index=True)
    synonym = Column(String, nullable=False)
    
    # Relationships
    word = relationship("Word", back_populates="synonyms")
    
    # Indexes
    __table_args__ = (
        Index("idx_word_synonym_word", "word_id"),
        Index("idx_word_synonym_synonym", "synonym"),
    )

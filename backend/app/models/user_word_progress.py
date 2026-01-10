from sqlalchemy import Column, Integer, ForeignKey, Date, DateTime, Enum, Index, UniqueConstraint
from sqlalchemy.sql import func
from sqlalchemy.orm import relationship
import enum
from app.database import Base


class ProgressStatus(str, enum.Enum):
    LEARNING = "learning"
    REVIEWING = "reviewing"
    MASTERED = "mastered"


class UserWordProgress(Base):
    __tablename__ = "user_word_progress"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    word_id = Column(Integer, ForeignKey("words.id"), nullable=False)
    fibonacci_level = Column(Integer, default=0, nullable=False)  # 0-11 (0=new, 11=mastered)
    next_review_date = Column(Date, nullable=True, index=True)
    correct_count = Column(Integer, default=0, nullable=False)
    incorrect_count = Column(Integer, default=0, nullable=False)
    last_reviewed_at = Column(DateTime(timezone=True), nullable=True)
    status = Column(Enum(ProgressStatus), default=ProgressStatus.LEARNING, nullable=False)
    added_at = Column(DateTime(timezone=True), server_default=func.now())
    mastered_at = Column(DateTime(timezone=True), nullable=True)

    # Relationships
    user = relationship("User", back_populates="word_progress")
    word = relationship("Word", back_populates="user_progress")

    # Constraints
    __table_args__ = (
        UniqueConstraint("user_id", "word_id", name="uq_user_word"),
        Index("idx_user_next_review", "user_id", "next_review_date"),
    )

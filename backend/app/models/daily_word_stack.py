from sqlalchemy import Column, Integer, ForeignKey, Date, DateTime, Boolean, Index, UniqueConstraint
from sqlalchemy.sql import func
from sqlalchemy.orm import relationship
from app.database import Base


class DailyWordStack(Base):
    __tablename__ = "daily_word_stack"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    word_id = Column(Integer, ForeignKey("words.id"), nullable=False)
    scheduled_date = Column(Date, nullable=False, index=True)
    is_reviewed = Column(Boolean, default=False, nullable=False)
    reviewed_at = Column(DateTime(timezone=True), nullable=True)

    # Relationships
    user = relationship("User", back_populates="daily_stacks")
    word = relationship("Word", back_populates="daily_stacks")

    # Constraints
    __table_args__ = (
        UniqueConstraint("user_id", "word_id", "scheduled_date", name="uq_user_word_date"),
        Index("idx_user_scheduled_date", "user_id", "scheduled_date"),
    )

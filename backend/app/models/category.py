from sqlalchemy import Column, Integer, String, Text, ForeignKey, DateTime, Numeric
from sqlalchemy.sql import func
from sqlalchemy.orm import relationship
from app.database import Base


class Category(Base):
    __tablename__ = "categories"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, unique=True, index=True, nullable=False)
    description = Column(Text, nullable=True)
    parent_category_id = Column(Integer, ForeignKey("categories.id"), nullable=True)
    importance_weight = Column(Numeric(3, 1), default=5.0, nullable=False)  # 1-10
    created_at = Column(DateTime(timezone=True), server_default=func.now())

    # Relationships
    parent_category = relationship("Category", remote_side=[id], backref="subcategories")
    words = relationship("Word", back_populates="category", cascade="all, delete-orphan")

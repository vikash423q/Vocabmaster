from datetime import date, timedelta
from typing import List, Optional
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select, and_
from sqlalchemy.orm import selectinload
from app.models.daily_word_stack import DailyWordStack
from app.models.user_word_progress import UserWordProgress, ProgressStatus
from app.models.word import Word
from app.services.spaced_repetition_service import add_to_daily_stack


async def get_daily_stack(
    db: AsyncSession,
    user_id: int,
    target_date: Optional[date] = None
) -> List[DailyWordStack]:
    """Get words scheduled for review on a specific date."""
    if target_date is None:
        target_date = date.today()
    
    query = select(DailyWordStack).where(
        and_(
            DailyWordStack.user_id == user_id,
            DailyWordStack.scheduled_date == target_date,
            DailyWordStack.is_reviewed == False
        )
    ).options(
        selectinload(DailyWordStack.word)
    )
    
    result = await db.execute(query)
    return list(result.scalars().all())


async def populate_daily_stack_for_user(
    db: AsyncSession,
    user_id: int,
    target_date: Optional[date] = None
) -> int:
    """Populate daily stack for a user based on next_review_date."""
    if target_date is None:
        target_date = date.today()
    
    # Get all progress entries that need review on this date
    query = select(UserWordProgress).where(
        and_(
            UserWordProgress.user_id == user_id,
            UserWordProgress.next_review_date == target_date,
            UserWordProgress.status != ProgressStatus.MASTERED
        )
    )
    
    result = await db.execute(query)
    progress_entries = list(result.scalars().all())
    
    count = 0
    for progress in progress_entries:
        # Check if already in daily stack
        existing = await db.execute(
            select(DailyWordStack).where(
                and_(
                    DailyWordStack.user_id == user_id,
                    DailyWordStack.word_id == progress.word_id,
                    DailyWordStack.scheduled_date == target_date
                )
            )
        )
        if existing.scalar_one_or_none() is None:
            await add_to_daily_stack(db, user_id, progress.word_id, target_date)
            count += 1
    
    await db.commit()
    return count


async def mark_reviewed(
    db: AsyncSession,
    user_id: int,
    word_id: int,
    review_date: date
) -> None:
    """Mark a word as reviewed in the daily stack."""
    result = await db.execute(
        select(DailyWordStack).where(
            and_(
                DailyWordStack.user_id == user_id,
                DailyWordStack.word_id == word_id,
                DailyWordStack.scheduled_date == review_date
            )
        )
    )
    stack_entry = result.scalar_one_or_none()
    
    if stack_entry:
        stack_entry.is_reviewed = True
        stack_entry.reviewed_at = date.today()
        await db.commit()

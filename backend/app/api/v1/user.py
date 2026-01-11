from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import update
from app.database import get_db
from app.schemas.auth import UserProfile, UserProfileUpdate, UserStats
from app.services.progress_service import get_progress_overview
from app.api.dependencies import get_current_user
from app.models.user import User, UserLevel
from app.services.auth_service import get_user_by_username

router = APIRouter()


@router.get("/profile", response_model=UserProfile)
async def get_profile(
    current_user: User = Depends(get_current_user)
):
    """Get current user's profile."""
    return current_user


@router.patch("/profile", response_model=UserProfile)
async def update_profile(
    profile_update: UserProfileUpdate,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """Update current user's profile."""
    existing_user = await get_user_by_username(db, profile_update.username)
    if existing_user:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Username already taken"
        )

    if profile_update.username is not None:
        current_user.username = profile_update.username
    
    if profile_update.current_level is not None:
        current_user.current_level = UserLevel(profile_update.current_level)
    
    if profile_update.settings is not None:
        current_user.settings = {**current_user.settings, **profile_update.settings}
    
    await db.commit()
    await db.refresh(current_user)
    
    return current_user


@router.get("/stats", response_model=UserStats)
async def get_stats(
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """Get user statistics."""
    stats = await get_progress_overview(db, current_user.id)
    return UserStats(**stats)

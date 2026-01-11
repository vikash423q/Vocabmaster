"""
Assessment API endpoints for user level assessment.
"""
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from app.database import get_db
from app.api.dependencies import get_current_user
from app.models.user import User
from app.schemas.assessment import (
    AssessmentStack,
    AssessmentWord,
    AssessmentSubmit,
    AssessmentResult,
    StackRecommendation,
    RecommendedWord
)
from app.services.assessment_service import (
    get_assessment_stack,
    submit_assessment,
    get_stack_recommendations,
    mark_word_as_known
)

router = APIRouter()


@router.get("/stack", response_model=AssessmentStack)
async def get_assessment_stack_endpoint(
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """Get assessment stack for user.
    
    For new users: Returns 30 words (5 each of difficulty levels 4-9)
    For existing users: Returns words around their current_level for re-assessment
    """
    try:
        stack_data = await get_assessment_stack(db, current_user.id)
        
        # Format words
        words = [
            AssessmentWord(
                id=w["id"],
                word=w["word"],
                pronunciation=w["pronunciation"],
                difficulty_level=w["difficulty_level"],
                cefr_level=w["cefr_level"]
            )
            for w in stack_data["words"]
        ]
        
        return AssessmentStack(
            words=words,
            total_words=stack_data["total_words"],
            is_first_assessment=stack_data["is_first_assessment"]
        )
    except ValueError as e:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=str(e)
        )
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Error getting assessment stack: {str(e)}"
        )


@router.post("/submit", response_model=AssessmentResult)
async def submit_assessment_endpoint(
    assessment_data: AssessmentSubmit,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """Submit assessment responses and calculate user level.
    
    Scoring:
    - "don't_know": 4.0 points
    - "maybe": 5.0 points
    - "know": word's difficulty_level
    
    Average of all responses becomes user's current_level.
    """
    try:
        # Format responses for service
        responses = [
            {
                "word_id": r.word_id,
                "response": r.response
            }
            for r in assessment_data.responses
        ]
        
        result = await submit_assessment(db, current_user.id, responses)
        
        return AssessmentResult(
            calculated_level=result["calculated_level"],
            responses_count=result["responses_count"],
            words_assessed=result["words_assessed"]
        )
    except ValueError as e:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=str(e)
        )
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Error submitting assessment: {str(e)}"
        )


@router.get("/recommendations", response_model=StackRecommendation)
async def get_stack_recommendations_endpoint(
    limit: int = 20,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """Get recommended words for user's stack.
    
    Criteria:
    - Difficulty: current_level + 30% more challenging
    - Prefer words from categories user has been learning
    - Exclude words user already knows
    
    Users must complete assessment first (current_level must not be null).
    """
    if current_user.current_level is None:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="User must complete assessment first"
        )
    
    try:
        recommendations = await get_stack_recommendations(db, current_user.id, limit)
        
        # Format words
        words = [
            RecommendedWord(
                id=w["id"],
                word=w["word"],
                pronunciation=w["pronunciation"],
                difficulty_level=w["difficulty_level"],
                cefr_level=w["cefr_level"],
                category_id=w["category_id"],
                category_name=w["category_name"],
                importance_score=w["importance_score"]
            )
            for w in recommendations["words"]
        ]
        
        return StackRecommendation(
            words=words,
            recommended_level=recommendations["recommended_level"],
            user_current_level=recommendations["user_current_level"],
            total_recommended=recommendations["total_recommended"]
        )
    except ValueError as e:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=str(e)
        )
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Error getting recommendations: {str(e)}"
        )


@router.post("/mark-known/{word_id}", status_code=status.HTTP_200_OK)
async def mark_word_known_endpoint(
    word_id: int,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """Mark a word as already known.
    
    This immediately sets the word as mastered and removes it from recommendations.
    Useful when user sees a recommended word they already know.
    """
    try:
        result = await mark_word_as_known(db, current_user.id, word_id)
        return result
    except ValueError as e:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=str(e)
        )
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Error marking word as known: {str(e)}"
        )

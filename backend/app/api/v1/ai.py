from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
import httpx
from app.database import get_db
from app.schemas.ai import (
    QuizGenerateRequest,
    QuizResponse,
    ExplainRequest,
    ExplainResponse,
    StoryGenerateRequest,
    StoryResponse,
    ChatRequest,
    ChatResponse
)
from app.services.word_service import get_word_by_id
from app.api.dependencies import get_current_user
from app.models.user import User
from app.config import settings

router = APIRouter()


async def call_ai_service(endpoint: str, payload: dict) -> dict:
    """Call the AI agent service."""
    async with httpx.AsyncClient() as client:
        try:
            response = await client.post(
                f"{settings.ai_agent_service_url}{endpoint}",
                json=payload,
                timeout=30.0
            )
            response.raise_for_status()
            return response.json()
        except httpx.HTTPError as e:
            raise HTTPException(
                status_code=status.HTTP_503_SERVICE_UNAVAILABLE,
                detail=f"AI service error: {str(e)}"
            )


@router.post("/generate-quiz", response_model=QuizResponse)
async def generate_quiz(
    request: QuizGenerateRequest,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """Generate AI quiz for word."""
    word = await get_word_by_id(db, request.word_id)
    if not word:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Word not found"
        )
    
    # Get primary definition
    primary_def = None
    for defn in word.definitions:
        if defn.is_primary:
            primary_def = defn
            break
    
    if not primary_def and word.definitions:
        primary_def = word.definitions[0]
    
    payload = {
        "word": word.word,
        "definition": primary_def.definition if primary_def else "",
        "examples": [d.example_sentence for d in word.definitions if d.example_sentence]
    }
    
    result = await call_ai_service("/generate-quiz", payload)
    return QuizResponse(**result)


@router.post("/explain-word", response_model=ExplainResponse)
async def explain_word(
    request: ExplainRequest,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """Get AI explanation for word."""
    word = await get_word_by_id(db, request.word_id)
    if not word:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Word not found"
        )
    
    # Get primary definition
    primary_def = None
    for defn in word.definitions:
        if defn.is_primary:
            primary_def = defn
            break
    
    payload = {
        "word": word.word,
        "definition": primary_def.definition if primary_def else "",
        "etymology": word.etymology.evolution_story if word.etymology else None,
        "examples": [d.example_sentence for d in word.definitions if d.example_sentence],
        "question": request.question
    }
    
    result = await call_ai_service("/explain-word", payload)
    return ExplainResponse(**result)


@router.post("/generate-story", response_model=StoryResponse)
async def generate_story(
    request: StoryGenerateRequest,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """Generate guided learning story."""
    from app.models.guided_stories import GuidedStory, StoryType
    
    # If word_ids not provided, get unlearned words
    if not request.word_ids:
        # This would need to be implemented based on user's learning state
        # For now, return error
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="word_ids must be provided"
        )
    
    # Get words
    words = []
    for word_id in request.word_ids[:request.batch_size]:
        word = await get_word_by_id(db, word_id)
        if word:
            words.append(word)
    
    if not words:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="No valid words found"
        )
    
    # Prepare payload
    word_list = []
    for word in words:
        primary_def = None
        for defn in word.definitions:
            if defn.is_primary:
                primary_def = defn
                break
        if not primary_def and word.definitions:
            primary_def = word.definitions[0]
        
        word_list.append({
            "word": word.word,
            "definition": primary_def.definition if primary_def else ""
        })
    
    payload = {
        "words": word_list,
        "user_level": str(float(current_user.current_level)) if current_user.current_level else "5.0"  # Default to 5.0 if not assessed, must be string
    }
    
    result = await call_ai_service("/generate-story", payload)
    
    # Save story
    story = GuidedStory(
        user_id=current_user.id,
        story_type=StoryType(request.story_type),
        word_ids=[w.id for w in words],
        narrative=result["narrative"]
    )
    db.add(story)
    await db.commit()
    await db.refresh(story)
    
    return StoryResponse(
        story_id=story.id,
        narrative=story.narrative,
        word_ids=story.word_ids,
        story_type=story.story_type.value
    )


@router.post("/chat", response_model=ChatResponse)
async def chat(
    request: ChatRequest,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """Chat with AI about word."""
    word = await get_word_by_id(db, request.word_id)
    if not word:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Word not found"
        )
    
    # Get primary definition
    primary_def = None
    for defn in word.definitions:
        if defn.is_primary:
            primary_def = defn
            break
    
    payload = {
        "word": word.word,
        "definition": primary_def.definition if primary_def else "",
        "message": request.message
    }
    
    result = await call_ai_service("/chat", payload)
    return ChatResponse(**result)

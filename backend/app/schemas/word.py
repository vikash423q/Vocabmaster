from pydantic import BaseModel
from typing import List, Optional, Dict, Any
from app.models.word_media import MediaType
from app.models.word import Tone


class WordBase(BaseModel):
    word: str
    category_id: int
    difficulty_level: float = 5.0
    importance_score: int = 50
    part_of_speech: List[str] = []
    pronunciation: Optional[str] = None
    tone: Tone = Tone.NEUTRAL
    cefr_level: Optional[str] = None  # A1, A2, B1, B2, C1, C2


class WordCreate(WordBase):
    source: str = "User"


class WordCreateSimple(BaseModel):
    """Simple word creation - only requires the word, AI generates the rest."""
    word: str


class WordDefinitionSchema(BaseModel):
    text: str
    is_primary: bool
    examples: List[str] = []


class EtymologySchema(BaseModel):
    origin_language: Optional[str] = None
    root_word: Optional[str] = None
    evolution: Optional[str] = None


class MediaSchema(BaseModel):
    type: str
    url: str
    source: Optional[str] = None
    caption: Optional[str] = None
    is_ai_generated: bool = False


class MediaCreate(BaseModel):
    """Request schema for creating media."""
    word_id: int
    media_type: MediaType
    url: str
    source: Optional[str] = None
    caption: Optional[str] = None
    is_ai_generated: bool = False


class CategorySchema(BaseModel):
    id: int
    name: str
    description: Optional[str] = None
    parent_category_id: Optional[int] = None
    importance_weight: float = 5.0

    class Config:
        from_attributes = True


class WordDetail(BaseModel):
    id: int
    word: str
    pronunciation: Optional[str] = None
    parts_of_speech: List[str] = []
    definitions: List[WordDefinitionSchema] = []
    etymology: Optional[EtymologySchema] = None
    media: List[MediaSchema] = []
    category: Optional[CategorySchema] = None
    difficulty_level: float
    importance_score: int
    source: str
    tone: str
    cefr_level: Optional[str] = None

    class Config:
        from_attributes = True


class WordListItem(BaseModel):
    id: int
    word: str
    pronunciation: Optional[str] = None
    category_id: int
    difficulty_level: float
    importance_score: int
    tone: str
    cefr_level: Optional[str] = None

    class Config:
        from_attributes = True


class ReviewPageData(BaseModel):
    word: str
    pronunciation: Optional[str] = None
    parts_of_speech: List[str] = []
    definitions: List[WordDefinitionSchema] = []
    etymology: Optional[EtymologySchema] = None
    media: List[MediaSchema] = []
    category: Optional[CategorySchema] = None
    tone: str
    cefr_level: Optional[str] = None
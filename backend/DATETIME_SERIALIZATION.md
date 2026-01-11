# DateTime Serialization Guide

This document tracks all datetime fields in models and how they're serialized in API responses.

## Models with DateTime Fields

### User Model
- `created_at`: DateTime(timezone=True)
- `last_active`: DateTime(timezone=True)
- **Schema**: `UserProfile` ✅ Fixed with `field_serializer`
- **Status**: Returns model directly, serialization handled in schema

### UserWordProgress Model
- `last_reviewed_at`: DateTime(timezone=True)
- `added_at`: DateTime(timezone=True)
- `mastered_at`: DateTime(timezone=True)
- `next_review_date`: Date (not DateTime)
- **Schema**: `WordProgressDetail`
- **Status**: ✅ Service converts to ISO strings before returning

### DailyWordStack Model
- `reviewed_at`: DateTime(timezone=True)
- `scheduled_date`: Date (not DateTime)
- **Schema**: `DailyStackItem`
- **Status**: ✅ Endpoint converts to ISO strings manually

### QuizSession Model
- `created_at`: DateTime(timezone=True)
- **Schema**: Not returned directly in responses
- **Status**: ✅ Not exposed in API responses

### GuidedStory Model
- `created_at`: DateTime(timezone=True)
- **Schema**: `StoryResponse` (doesn't include created_at)
- **Status**: ✅ Not exposed in API responses

### Word Model
- `created_at`: DateTime(timezone=True)
- **Schema**: `WordDetail`, `WordListItem` (don't include created_at)
- **Status**: ✅ Not exposed in API responses

### Category Model
- `created_at`: DateTime(timezone=True)
- **Schema**: `CategorySchema` (doesn't include created_at)
- **Status**: ✅ Not exposed in API responses

### WordDefinition, WordEtymology, WordMedia Models
- `created_at`: DateTime(timezone=True) (if present)
- **Schema**: Not returned directly
- **Status**: ✅ Not exposed in API responses

## Fixed Issues

1. **UserProfile Schema** - Added `field_serializer` to convert `created_at` and `last_active` datetime objects to ISO format strings.

## Best Practices

1. **When returning models directly**: Use `field_serializer` in Pydantic schemas to convert datetime to strings
2. **When using services**: Convert datetime to ISO strings in service layer before returning
3. **When manually constructing responses**: Use `.isoformat()` method to convert datetime/date objects

## Example Fix Pattern

```python
from pydantic import BaseModel, field_serializer
from datetime import datetime

class MySchema(BaseModel):
    created_at: datetime
    
    @field_serializer('created_at')
    def serialize_datetime(self, value: Optional[datetime], _info) -> Optional[str]:
        if value is None:
            return None
        return value.isoformat()
```

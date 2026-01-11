from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.config import settings
from app.api.v1 import auth, words, review, ai, media, user
from app.database import engine, Base

app = FastAPI(
    title="VocabMaster API",
    description="Vocabulary Learning Application API",
    version="1.0.0"
)

# CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"] if settings.debug else [],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Include routers
app.include_router(auth.router, prefix="/api/auth", tags=["Authentication"])
app.include_router(user.router, prefix="/api/user", tags=["User"])
app.include_router(words.router, prefix="/api/words", tags=["Words"])
app.include_router(review.router, prefix="/api", tags=["Review"])
app.include_router(ai.router, prefix="/api/ai", tags=["AI"])
app.include_router(media.router, prefix="/api/media", tags=["Media"])


@app.on_event("startup")
async def startup():
    # Create database tables (in production, use migrations)
    # Only create tables if database is available
    if settings.environment == "development":
        try:
            async with engine.begin() as conn:
                await conn.run_sync(Base.metadata.create_all)
        except Exception as e:
            # Database not available - log but don't fail startup
            # This allows the API to start even if DB is temporarily unavailable
            print(f"Warning: Could not create database tables: {e}")
            print("Make sure PostgreSQL is running and accessible.")


@app.get("/")
async def root():
    return {"message": "VocabMaster API", "version": "1.0.0"}


@app.get("/health")
async def health():
    return {"status": "healthy"}

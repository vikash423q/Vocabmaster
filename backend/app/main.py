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
app.include_router(media.router, prefix="/api/words", tags=["Media"])


@app.on_event("startup")
async def startup():
    # Create database tables (in production, use migrations)
    if settings.environment == "development":
        async with engine.begin() as conn:
            await conn.run_sync(Base.metadata.create_all)


@app.get("/")
async def root():
    return {"message": "VocabMaster API", "version": "1.0.0"}


@app.get("/health")
async def health():
    return {"status": "healthy"}

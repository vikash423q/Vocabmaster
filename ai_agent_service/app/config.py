from pydantic_settings import BaseSettings
from typing import Optional


class Settings(BaseSettings):
    # LLM Provider Selection
    llm_provider: str = "openai"  # Options: "anthropic" or "openai"
    
    # Anthropic Configuration
    anthropic_api_key: Optional[str] = None
    
    # OpenAI-compatible Configuration (for LM Studio, self-hosted, etc.)
    openai_api_key: Optional[str] = "dummy"  # Can be "dummy" for self-hosted
    openai_base_url: Optional[str] = "https://llm.vikashgaurav.com/v1"  # Must include /v1 for OpenAI-compatible APIs
    openai_model: str = "openai/gpt-oss-20b"  # Model name for self-hosted LLM
    
    environment: str = "development"
    debug: bool = True
    
    class Config:
        env_file = ".env"
        case_sensitive = False


settings = Settings()

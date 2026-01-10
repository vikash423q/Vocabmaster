from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    anthropic_api_key: str
    environment: str = "development"
    debug: bool = True
    
    class Config:
        env_file = ".env"
        case_sensitive = False


settings = Settings()

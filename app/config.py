from pydantic_settings import BaseSettings
from pydantic import Field, field_validator, ConfigDict
from typing import Optional
import os
from dotenv import load_dotenv

load_dotenv()

class Settings(BaseSettings):
    MYSQL_USER: str = Field(default=os.getenv("MYSQL_USER", "root"))
    MYSQL_PASSWORD: str = Field(default=os.getenv("MYSQL_PASSWORD", ""))
    MYSQL_HOST: str = Field(default=os.getenv("MYSQL_HOST", "localhost"))
    MYSQL_PORT: int = Field(default=os.getenv("MYSQL_PORT", 3306))
    MYSQL_DB: str = Field(default=os.getenv("MYSQL_DB", "fastapi_db"))
    SECRET_KEY: str = Field(default=os.getenv("SECRET_KEY", "secret-key"))
    ALGORITHM: str = Field(default=os.getenv("ALGORITHM", "HS256"))
    ACCESS_TOKEN_EXPIRE_MINUTES: int = Field(
        default=os.getenv("ACCESS_TOKEN_EXPIRE_MINUTES", 30)
    )

    @field_validator('MYSQL_PORT', 'ACCESS_TOKEN_EXPIRE_MINUTES', mode='before')
    def parse_int(cls, value):
        if isinstance(value, str):
            return int(value)
        return value

    class Config:
        from_attributes = True
        env_file = ".env"
        extra = "ignore"

settings = Settings()
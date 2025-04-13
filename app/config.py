from pydantic import BaseSettings

class Settings(BaseSettings):
    MYSQL_USER: str = "delivery_user"
    MYSQL_PASSWORD: str = "delivery_password"
    MYSQL_HOST: str = "localhost"
    MYSQL_PORT: int = 3306
    MYSQL_DB: str = "delivery_db"
    SECRET_KEY: str = "your-secret-key"
    ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 30

    class Config:
        env_file = ".env"

settings = Settings()
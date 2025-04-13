from pydantic import BaseSettings
from dotenv import load_dotenv
from os import getenv

load_dotenv()

class Settings(BaseSettings):
    MYSQL_USER: str = getenv("MYSQL_USER")
    MYSQL_PASSWORD: str = getenv("MYSQL_PASSWORD")
    MYSQL_HOST: str = getenv("MYSQL_HOST")
    MYSQL_PORT: int = getenv("MYSQL_PORT")
    MYSQL_DB: str = getenv("MYSQL_DB")
    SECRET_KEY: str = getenv("SECRET_KEY")
    ALGORITHM: str = getenv("ALGORITHM")
    ACCESS_TOKEN_EXPIRE_MINUTES: int = int(getenv("ACCESS_TOKEN_EXPIRE_MINUTES"))

    # print(f"MYSQL_USER: {MYSQL_USER}, MYSQL_PASSWORD: {MYSQL_PASSWORD}, MYSQL_HOST: {MYSQL_HOST}, "
    #       f"MYSQL_PORT: {MYSQL_PORT}, MYSQL_DB: {MYSQL_DB}, SECRET_KEY: {SECRET_KEY}, "
    #       f"ALGORITHM: {ALGORITHM}, ACCESS_TOKEN_EXPIRE_MINUTES: {ACCESS_TOKEN_EXPIRE_MINUTES}")

    class Config:
        from_attributes = True
        env_file = ".env"

settings = Settings()
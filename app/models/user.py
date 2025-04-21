from sqlalchemy import Column, Integer, String, Text, Enum, TIMESTAMP, Boolean, Index
from app.database import Base
from datetime import datetime
from enum import Enum as PyEnum

class UserRole(str, PyEnum):
    admin = 'admin'
    manager = 'manager'
    dispatcher = 'dispatcher'

class User(Base):
    __tablename__ = 'users'

    id = Column(Integer, primary_key=True, autoincrement=True)
    username = Column(String(50), unique=True, nullable=False)
    email = Column(String(100), unique=True, nullable=False)
    hashed_password = Column(String(255), nullable=False)
    full_name = Column(String(100))
    role = Column(Enum(UserRole), default=UserRole.manager)
    is_active = Column(Boolean, default=True)
    last_login = Column(TIMESTAMP)
    created_at = Column(TIMESTAMP, default=datetime.utcnow)
    phone = Column(String(20))
    notes = Column(Text)
    
    # Индексы для ускорения поиска
    __table_args__ = (
        Index('idx_user_role', 'role'),
        Index('idx_user_active', 'is_active')
    )
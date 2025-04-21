from sqlalchemy import Column, Integer, String, Text, Enum
from app.database import Base
from enum import Enum as PyEnum

class ClientType(str, PyEnum):
    individual = "individual"
    legal = "legal"

class Client(Base):
    __tablename__ = "clients"
    
    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    type = Column(Enum(ClientType), nullable=False)
    name = Column(String(100), nullable=False)
    phone = Column(String(20))
    email = Column(String(100))
    address = Column(Text)
    
    # Поля только для юридических лиц
    legal_name = Column(String(100))
    brand_photo = Column(Text)
    ogrn = Column(String(100))
    inn = Column(String(12))
    kpp = Column(String(9))
    bank_details = Column(Text)
from pydantic import BaseModel
from typing import Optional

class ClientBase(BaseModel):
    type: str
    name: str
    phone: Optional[str] = None
    email: Optional[str] = None
    address: Optional[str] = None

class LegalClientCreate(ClientBase):
    type: str = "legal"
    legal_name: str
    brand_photo: str
    orgn: str
    inn: str
    kpp: str
    bank_details: Optional[str] = None

class IndividualClientCreate(ClientBase):
    type: str = "individual"

class Client(ClientBase):
    id: int
    legal_name: Optional[str] = None
    brand_photo: Optional[str] = None
    inn: Optional[str] = None
    ogrn: Optional[str] = None
    kpp: Optional[str] = None
    bank_details: Optional[str] = None
    
    class Config:
        orm_mode = True
        from_attributes = True
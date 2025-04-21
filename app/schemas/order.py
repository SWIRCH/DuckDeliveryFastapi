from pydantic import BaseModel
from datetime import datetime
from typing import Optional

class OrderBase(BaseModel):
    client_id: int
    courier_id: Optional[int] = None
    order_number: Optional[str] = None
    items: str
    total_price: float
    delivery_price: Optional[float] = None
    address: str
    status: str = 'new'
    customer_name: Optional[str] = None
    customer_phone: Optional[str] = None
    notes: Optional[str] = None

class OrderCreate(OrderBase):
    pass

class Order(OrderBase):
    id: int
    created_at: datetime
    updated_at: datetime

    class Config:
        from_attributes = True
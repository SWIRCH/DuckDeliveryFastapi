from pydantic import BaseModel
from datetime import datetime
from typing import Optional
from enum import Enum

class OrderStatus(str, Enum):
    new = 'new'
    accepted = 'accepted'
    processing = 'processing'
    assigned = 'assigned'
    in_progress = 'in_progress'
    delivered = 'delivered'
    canceled = 'canceled'

class OrderBase(BaseModel):
    client_id: int
    courier_id: Optional[int] = None
    order_number: Optional[str] = None
    items: str
    total_price: float
    delivery_price: Optional[float] = None
    address: str
    status: OrderStatus = OrderStatus.new
    customer_name: Optional[str] = None
    customer_phone: Optional[str] = None
    notes: Optional[str] = None

class OrderCreate(OrderBase):
    pass

class OrderUpdate(OrderBase):
    updated_at: datetime

class Order(OrderBase):
    id: int
    created_at: datetime
    updated_at: datetime

    class Config:
        from_attributes = True
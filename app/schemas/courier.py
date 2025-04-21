from pydantic import BaseModel
from datetime import datetime
from typing import Optional
from enum import Enum

class VehicleType(str, Enum):
    foot = 'foot'
    bicycle = 'bicycle'
    car = 'car'
    scooter = 'scooter'

class CourierStatus(str, Enum):
    free = 'free'
    busy = 'busy'
    on_break = 'on_break'
    offline = 'offline'

class CourierBase(BaseModel):
    name: str
    phone: str
    email: Optional[str] = None
    vehicle_type: VehicleType = VehicleType.foot
    status: CourierStatus = CourierStatus.free
    current_location: Optional[str] = None
    notes: Optional[str] = None

class CourierCreate(CourierBase):
    pass

class CourierUpdate(BaseModel):
    name: Optional[str] = None
    phone: Optional[str] = None
    email: Optional[str] = None
    vehicle_type: Optional[VehicleType] = None
    status: Optional[CourierStatus] = None
    current_location: Optional[str] = None
    notes: Optional[str] = None

class Courier(CourierBase):
    id: int
    registration_date: datetime
    last_activity: Optional[datetime] = None

    class Config:
        from_attributes = True
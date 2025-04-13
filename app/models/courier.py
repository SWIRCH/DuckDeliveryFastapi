from sqlalchemy import Column, Integer, String, Text, Enum, TIMESTAMP
from sqlalchemy.ext.declarative import declarative_base
from datetime import datetime
from enum import Enum as PyEnum

Base = declarative_base()

class VehicleType(str, PyEnum):
    foot = 'foot'
    bicycle = 'bicycle'
    car = 'car'
    scooter = 'scooter'

class CourierStatus(str, PyEnum):
    free = 'free'
    busy = 'busy'
    on_break = 'on_break'
    offline = 'offline'

class Courier(Base):
    __tablename__ = 'couriers'

    id = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(100), nullable=False)
    phone = Column(String(20), nullable=False)
    email = Column(String(100))
    vehicle_type = Column(Enum(VehicleType), default=VehicleType.foot)
    status = Column(Enum(CourierStatus), default=CourierStatus.free)
    current_location = Column(String(255))
    registration_date = Column(TIMESTAMP, default=datetime.utcnow)
    last_activity = Column(TIMESTAMP)
    notes = Column(Text)
from sqlalchemy import Column, Integer, String, Float, DateTime, ForeignKey
from sqlalchemy.orm import relationship
from app.database import Base
from datetime import datetime

class Order(Base):
    __tablename__ = "orders"

    id = Column(Integer, primary_key=True, index=True)
    customer_id = Column(Integer, ForeignKey("users.id"))
    description = Column(String(500))
    weight = Column(Float)
    dimensions = Column(String(100))  # "10x20x30"
    pickup_address = Column(String(300))
    delivery_address = Column(String(300))
    status = Column(String(50), default="created")  # created, assigned, in_progress, delivered, canceled
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    customer = relationship("User", back_populates="orders")
    deliveries = relationship("Delivery", back_populates="order")
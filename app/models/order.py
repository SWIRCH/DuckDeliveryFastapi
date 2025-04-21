from sqlalchemy import Column, Integer, String, Text, DECIMAL, Enum, TIMESTAMP, ForeignKey
from app.database import Base
from datetime import datetime
from enum import Enum as PyEnum

class OrderStatus(str, PyEnum):
    new = 'new'
    processing = 'processing'
    assigned = 'assigned'
    in_progress = 'in_progress'
    delivered = 'delivered'
    canceled = 'canceled'

    # 'new','processing','assigned','in_progress','delivered','canceled'

class Order(Base):
    __tablename__ = 'orders'

    id = Column(Integer, primary_key=True, autoincrement=True)
    client_id = Column(Integer, ForeignKey('clients.id'), nullable=False, comment='ID клиента (магазина/юрлица)')
    courier_id = Column(Integer, ForeignKey('couriers.id'), nullable=True, comment='ID назначенного курьера (если есть)')
    order_number = Column(String(20), unique=True, nullable=True, comment='Уникальный номер заказа (например, "ORD-2023-1001")')
    items = Column(Text, nullable=False, comment='Описание товаров (JSON или простой текст)')
    total_price = Column(DECIMAL(10, 2), nullable=False, comment='Общая стоимость заказа')
    delivery_price = Column(DECIMAL(10, 2), nullable=True, comment='Стоимость доставки')
    address = Column(Text, nullable=False, comment='Адрес доставки')
    status = Column(Enum(OrderStatus), default=OrderStatus.new, nullable=False, comment='Статус заказа')
    customer_name = Column(String(100), nullable=True, comment='Имя конечного покупателя (если известно)')
    customer_phone = Column(String(20), nullable=True, comment='Телефон покупателя (если известен)')
    created_at = Column(TIMESTAMP, default=datetime.utcnow, nullable=False, comment='Дата создания')
    updated_at = Column(TIMESTAMP, default=datetime.utcnow, onupdate=datetime.utcnow, nullable=False, comment='Дата обновления')
    notes = Column(Text, nullable=True, comment='Примечания менеджера')
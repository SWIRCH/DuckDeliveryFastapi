from sqlalchemy.orm import Session
from app.models.courier import Courier
from app.schemas.courier import CourierCreate, CourierUpdate

def get_courier(db: Session, courier_id: int):
    return db.query(Courier).filter(Courier.id == courier_id).first()

def get_couriers(db: Session, skip: int = 0, limit: int = 100):
    return db.query(Courier).offset(skip).limit(limit).all()

def create_courier(db: Session, courier: CourierCreate):
    db_courier = Courier(**courier.dict())
    db.add(db_courier)
    db.commit()
    db.refresh(db_courier)
    return db_courier

def update_courier(db: Session, courier_id: int, courier: CourierUpdate):
    db_courier = db.query(Courier).filter(Courier.id == courier_id).first()
    if db_courier:
        update_data = courier.dict(exclude_unset=True)
        for key, value in update_data.items():
            setattr(db_courier, key, value)
        db.commit()
        db.refresh(db_courier)
    return db_courier

def delete_courier(db: Session, courier_id: int):
    db_courier = db.query(Courier).filter(Courier.id == courier_id).first()
    if db_courier:
        db.delete(db_courier)
        db.commit()
    return db_courier
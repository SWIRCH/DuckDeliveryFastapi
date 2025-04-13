from fastapi import APIRouter, Depends, HTTPException
from typing import List
from sqlalchemy.orm import Session

from app.crud.courier import (
    get_courier, get_couriers, create_courier, 
    update_courier, delete_courier
)
from app.schemas.courier import Courier, CourierCreate, CourierUpdate
from app.database import get_db
from app.schemas.user import User
from app.core.security import check_permissions

router = APIRouter()


@router.post("/", response_model=Courier)
def create_courier_endpoint(courier: CourierCreate, db: Session = Depends(get_db), current_user: User = Depends(check_permissions({'admin', 'manager'}))):
    return create_courier(db=db, courier=courier)


@router.get("/", response_model=List[Courier])
def read_couriers(skip: int = 0, limit: int = 100, db: Session = Depends(get_db), current_user: User = Depends(check_permissions({'admin', 'manager'}))):
    return get_couriers(db, skip=skip, limit=limit)


@router.get("/{courier_id}", response_model=Courier)
def read_courier(courier_id: int, db: Session = Depends(get_db), current_user: User = Depends(check_permissions({'admin', 'manager'}))):
    db_courier = get_courier(db, courier_id=courier_id)
    if not db_courier:
        raise HTTPException(status_code=404, detail="Courier not found")
    return db_courier


@router.put("/{courier_id}", response_model=Courier)
def update_courier_endpoint(
    courier_id: int, 
    courier: CourierUpdate, 
    db: Session = Depends(get_db), 
    current_user: User = Depends(check_permissions({'admin', 'manager'}))
):
    db_courier = update_courier(db, courier_id=courier_id, courier=courier)
    if not db_courier:
        raise HTTPException(status_code=404, detail="Courier not found")
    return db_courier


@router.delete("/{courier_id}")
def delete_courier_endpoint(courier_id: int, db: Session = Depends(get_db), current_user: User = Depends(check_permissions({'admin', 'manager'}))):
    success = delete_courier(db, courier_id=courier_id)
    if not success:
        raise HTTPException(status_code=404, detail="Courier not found")
    return {"message": "Courier deleted successfully"}
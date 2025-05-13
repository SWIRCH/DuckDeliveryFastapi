from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List

from app.database import get_db
from app.schemas import Order, OrderCreate, OrderUpdate
from app.crud import order as crud
from app.schemas.user import User
from app.core.security import check_permissions

router = APIRouter()

@router.post("/", response_model=Order)
def create_new_order(order: OrderCreate, db: Session = Depends(get_db), current_user: User = Depends(check_permissions({'admin', 'manager'}))):
    return crud.create_order(db=db, order=order)


@router.get("/", response_model=List[Order])
def read_orders(skip: int = 0, limit: int = 100, db: Session = Depends(get_db), current_user: User = Depends(check_permissions({'admin', 'manager'}))):
    orders = crud.get_orders(db, skip=skip, limit=limit)
    return orders


@router.get("/{order_id}", response_model=Order)
def read_order(order_id: int, db: Session = Depends(get_db), current_user: User = Depends(check_permissions({'admin', 'manager'}))):
    db_order = crud.get_order(db, order_id=order_id)
    if db_order is None:
        raise HTTPException(status_code=404, detail="Order not found")
    return db_order


@router.put("/{order_id}")
def update_order_status(
    order_id: int, 
    order_data: OrderUpdate,
    db: Session = Depends(get_db), 
    current_user: User = Depends(check_permissions({'admin', 'manager'}))
):
    db_order = crud.update_order(db=db, order_id=order_id, order_data=order_data.dict())
    if not db_order:
        raise HTTPException(status_code=404, detail="Order not found")
    
    if current_user.role not in {'admin', 'manager'}:
        raise HTTPException(status_code=403, detail="Not enough permissions")
    
    return db_order


@router.put("/{order_id}/status")
def update_order_status(order_id: int, status: str, db: Session = Depends(get_db), current_user: User = Depends(check_permissions({'admin', 'manager'}))):
    return crud.update_order_status(db=db, order_id=order_id, status=status)


@router.delete("/{order_id}")
def delete_order_endpoint(
    order_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(check_permissions({'admin', 'manager'}))
):
    success = crud.delete_order(db, order_id=order_id)
    if not success:
        raise HTTPException(status_code=404, detail="Order not found")
    return {"message": "Order deleted successfully"}
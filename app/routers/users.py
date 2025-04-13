from fastapi import APIRouter, Depends, HTTPException
from typing import List
from sqlalchemy.orm import Session

from app.crud.user import (
    get_user, get_user_by_email, get_users,
    create_user, update_user, delete_user
)
from app.schemas.user import User, UserCreate, UserUpdate
from app.database import get_db
from app.core.security import check_permissions


router = APIRouter()


@router.post("/", response_model=User)
def create_user_endpoint(
    user: UserCreate, 
    db: Session = Depends(get_db),
    current_user: User = Depends(check_permissions({'admin', 'manager'}))
):
    db_user = get_user_by_email(db, email=user.email)
    if db_user:
        raise HTTPException(status_code=400, detail="Email already registered")
    return create_user(db=db, user=user)


@router.get("/", response_model=List[User])
def read_users(
    skip: int = 0, 
    limit: int = 100,
    db: Session = Depends(get_db),
    current_user: User = Depends(check_permissions({'admin', 'manager'}))
):
    return get_users(db, skip=skip, limit=limit)


@router.get("/{user_id}", response_model=User)
def read_user(
    user_id: int, 
    db: Session = Depends(get_db),
    current_user: User = Depends(check_permissions({'admin', 'manager'}))
):
    db_user = get_user(db, user_id=user_id)
    if not db_user:
        raise HTTPException(status_code=404, detail="User not found")
    return db_user


@router.put("/{user_id}", response_model=User)
def update_user_endpoint(
    user_id: int,
    user: UserUpdate,
    db: Session = Depends(get_db),
    current_user: User = Depends(check_permissions({'admin', 'manager'}))
):
    db_user = update_user(db, user_id=user_id, user=user)
    if not db_user:
        raise HTTPException(status_code=404, detail="User not found")
    return db_user


@router.delete("/{user_id}")
def delete_user_endpoint(
    user_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(check_permissions({'admin', 'manager'}))
):
    success = delete_user(db, user_id=user_id)
    if not success:
        raise HTTPException(status_code=404, detail="User not found")
    return {"message": "User deleted successfully"}
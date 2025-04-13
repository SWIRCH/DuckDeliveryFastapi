from fastapi import APIRouter, Depends, HTTPException
from typing import List
from sqlalchemy.orm import Session

from app.crud.client import (
    create_client,
    get_client,
    get_clients,
    update_client,
    delete_client
)
from app.schemas import Client, LegalClientCreate, IndividualClientCreate
from app.database import get_db
from app.schemas.user import User
from app.core.security import check_permissions

router = APIRouter()

@router.post("/", response_model=Client)
def create_client_endpoint(
    client: LegalClientCreate | IndividualClientCreate, 
    db: Session = Depends(get_db),
    current_user: User = Depends(check_permissions({'admin', 'manager'}))
):
    client_data = client.dict()
    return create_client(db=db, client_data=client_data)


@router.get("/{client_id}", response_model=Client)
def read_client(client_id: int, 
    db: Session = Depends(get_db),
    current_user: User = Depends(check_permissions({'admin', 'manager'}))
):
    db_client = get_client(db, client_id=client_id)
    if not db_client:
        raise HTTPException(status_code=404, detail="Client not found")
    return db_client


@router.get("/", response_model=List[Client])
def read_clients(skip: int = 0, limit: int = 100, db: Session = Depends(get_db),
    current_user: User = Depends(check_permissions({'admin', 'manager'}))):
    return get_clients(db, skip=skip, limit=limit)


@router.put("/{client_id}", response_model=Client)
def update_client_endpoint(
    client_id: int,
    client_data: LegalClientCreate | IndividualClientCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(check_permissions({'admin', 'manager'}))
):
    db_client = update_client(db, client_id=client_id, client_data=client_data.dict())
    if not db_client:
        raise HTTPException(status_code=404, detail="Client not found")
    
    if current_user.role not in {'admin', 'manager'}:
        raise HTTPException(status_code=403, detail="Not enough permissions")
    return db_client


@router.delete("/{client_id}")
def delete_client_endpoint(client_id: int, db: Session = Depends(get_db),
    current_user: User = Depends(check_permissions({'admin', 'manager'}))):
    success = delete_client(db, client_id=client_id)
    if not success:
        raise HTTPException(status_code=404, detail="Client not found")
    return {"message": "Client deleted successfully"}
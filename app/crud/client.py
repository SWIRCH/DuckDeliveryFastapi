from sqlalchemy.orm import Session
from app.models import Client
from app.schemas import Client as ClientSchema  # Импортируем Pydantic схему


def create_client(db: Session, client_data: dict):
    db_client = Client(**client_data)
    db.add(db_client)
    db.commit()
    db.refresh(db_client)
    return db_client


def get_client(db: Session, client_id: int):
    db_client = db.query(Client).filter(Client.id == client_id).first()
    if db_client:
        return ClientSchema.from_orm(db_client)
    return None


def get_clients(db: Session, skip: int = 0, limit: int = 100):
    clients = db.query(Client).offset(skip).limit(limit).all()
    return [ClientSchema.from_orm(client) for client in clients]


def update_client(db: Session, client_id: int, client_data: dict):
    db_client = db.query(Client).filter(Client.id == client_id).first()
    if db_client:
        for key, value in client_data.items():
            setattr(db_client, key, value)
        db.commit()
        db.refresh(db_client)
        return ClientSchema.from_orm(db_client)
    return None


def delete_client(db: Session, client_id: int):
    db_client = db.query(Client).filter(Client.id == client_id).first()
    if db_client:
        db.delete(db_client)
        db.commit()
        return True
    return False
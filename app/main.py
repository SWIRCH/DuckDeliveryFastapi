from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.database import engine, Base
from app.routers import users, orders, couriers, deliveries

# Создание всех таблиц в БД
Base.metadata.create_all(bind=engine)

app = FastAPI(
    title="Delivery Manager API",
    description="API для системы управления доставками",
    version="0.1.0",
)

# Настройки CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Подключение роутеров
app.include_router(users.router, prefix="/users", tags=["users"])
app.include_router(orders.router, prefix="/orders", tags=["orders"])
app.include_router(couriers.router, prefix="/couriers", tags=["couriers"])
app.include_router(deliveries.router, prefix="/deliveries", tags=["deliveries"])


@app.get("/")
def read_root():
    return {"message": "Добро пожаловать в систему управления доставками"}
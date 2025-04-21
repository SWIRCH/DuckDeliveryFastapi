from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.database import engine, Base
from app.routers import clients, orders, courier, users, auth
import warnings

warnings.filterwarnings("ignore", message="Valid config keys have changed in V2")
warnings.filterwarnings("ignore")

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
app.include_router(clients.router, prefix="/api/clients", tags=["clients"])
app.include_router(orders.router, prefix="/api/orders", tags=["orders"])
app.include_router(courier.router, prefix="/api/courier", tags=["courier"])
app.include_router(users.router, prefix="/api/users", tags=["users"])
app.include_router(auth.router, prefix="/api/auth", tags=["auth"])

@app.get("/")
def read_root():
    return {"message": "Добро пожаловать в систему управления доставками"}
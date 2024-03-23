from fastapi import FastAPI
from db.config import Base, engine

from routers.chats_router import router as chats_router
from routers.embeddings_router import router as embeddings_router
from routers.ml_models_router import router as ml_models_router

Base.metadata.create_all(bind=engine)

routers = [
    chats_router,
    embeddings_router,
    ml_models_router,
]

app = FastAPI()

for router in routers:
    app.include_router(router)

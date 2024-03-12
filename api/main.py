from fastapi import FastAPI
from settings import engine, Base

from routers.embeddings_router import router as embeddings_router
from routers.ml_models_router import router as ml_models_router


Base.metadata.create_all(bind=engine)

app = FastAPI()
app.include_router(embeddings_router)
app.include_router(ml_models_router)


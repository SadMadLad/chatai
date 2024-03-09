from fastapi import Depends, FastAPI, HTTPException
from sqlalchemy.orm import Session
from schemas import chat_schema
from crud import chat_crud
from settings import engine, Base, get_db

from routers.embeddings_router import router as embeddings_router
from routers.ml_models_router import router as ml_models_router
# from assets.transformers.remove_string_columns_transformer import (
#     RemoveStringColumnsTransformer,
# )


Base.metadata.create_all(bind=engine)

app = FastAPI()
app.include_router(embeddings_router)
app.include_router(ml_models_router)


@app.get("/chats/", response_model=list[chat_schema.Chat])
def read_chats(db: Session = Depends(get_db)):
    chats = chat_crud.get_all_chats(db)
    return chats


@app.get("/chats/{id}", response_model=chat_schema.Chat)
def read_chat(id: int, db: Session = Depends(get_db)):
    chat = chat_crud.get_chat(db, id)
    if chat is None:
        raise HTTPException(status_code=404, detail="Chat not found")
    return chat

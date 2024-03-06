from fastapi import Depends, FastAPI, HTTPException, Request
from fastapi.responses import JSONResponse
from sqlalchemy.orm import Session
from schemas import chat_schema
from crud import chat_crud
from settings import SessionLocal, engine, Base, API_CLIENT_SECRET

from routers.embeddings import router

Base.metadata.create_all(bind=engine)

app = FastAPI()
app.include_router(router)


# Dependency
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


# Authenticate Request
# @app.middleware('http')
# async def authenticate(request: Request, call_next):
#     if request.url.path == '/docs':
#         return await call_next(request)
#     else:
#         secret = request.headers.get('Authorization')

#         if secret is None or not secret.split()[1] == API_CLIENT_SECRET:
#             return JSONResponse(status_code=401, content='Unauthorized Request')
#         return await call_next(request)


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

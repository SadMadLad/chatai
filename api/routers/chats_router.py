from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from db.config import get_db
from db.serializers.completions_serializer import CompletionsSerializer
from crud import chat_crud, message_crud

from services.clients.g4f_client import G4fClient

router = APIRouter()

@router.post("/chats/{id}/autocomplete")
async def autocomplete(id: int, db: Session = Depends(get_db), limit: int = 5):
    chat = chat_crud.get_chat(db, id)

    if chat is None:
        raise HTTPException(status_code=404, detail="Chat not found")

    messages = message_crud.get_chat_messages(db, chat.id, limit=limit)
    serialized_messages = CompletionsSerializer(messages=messages).serialize()

    response = await G4fClient().get_response(serialized_messages)
    return response

from fastapi import APIRouter, HTTPException
from typing import List, Dict

from services.clients.g4f_client import G4fClient

router = APIRouter()

@router.post("/chats/autocomplete")
async def autocomplete(messages: List[Dict]):
    if not messages:
        raise HTTPException(status_code=400, detail="No messages provided")

    try:
        response = await G4fClient().get_response(messages)
        return response
    except:
        return 'Message generation failed. Please try again later.'


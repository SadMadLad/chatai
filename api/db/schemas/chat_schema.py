from pydantic import BaseModel
from datetime import datetime

class ChatBase(BaseModel):
    chat_type: int
    chat_title: str
    latest_message_at: datetime
    created_at: datetime
    updated_at: datetime

class Chat(ChatBase):
    pass

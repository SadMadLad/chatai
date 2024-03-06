from pydantic import BaseModel
from datetime import datetime


class ChatBase(BaseModel):
    chat_type: int
    latest_message_at: datetime


class ChatCreate(ChatBase):
    pass


class Chat(ChatBase):
    id: int
    created_at: datetime
    updated_at: datetime

    class Config:
        from_attributes = True

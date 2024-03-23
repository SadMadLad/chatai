from pydantic import BaseModel

class MessageBase(BaseModel):
    body: str
    role: int

class MessageCreate(MessageBase):
    pass

class Message(MessageBase):
    id: int
    chat_id: int

    class Config:
        from_attributes = True

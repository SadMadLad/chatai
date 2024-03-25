from sqlalchemy import String, Integer, Column, DateTime
from sqlalchemy.orm import relationship
from db.config import Base
from db.models.message import Message


class Chat(Base):
    __tablename__ = "chats"

    id = Column(Integer, primary_key=True)
    chat_type = Column(Integer, nullable=False)
    chat_title = Column(String)
    latest_message_at = Column(DateTime, nullable=False)

    messages = relationship(Message, back_populates="chat")

    created_at = Column(DateTime, nullable=False)
    updated_at = Column(DateTime, nullable=False)

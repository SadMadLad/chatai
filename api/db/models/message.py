from datetime import datetime

from sqlalchemy import Text, Integer, Column, DateTime, ForeignKey
from sqlalchemy.orm import relationship
from db.config import Base


class Message(Base):
    __tablename__ = "messages"

    id = Column(Integer, primary_key=True)
    body = Column(Text, nullable=False)
    role = Column(Integer, nullable=False)
    chat_id = Column(Integer, ForeignKey("chats.id"), nullable=False)

    chat = relationship("Chat", back_populates="messages")

    created_at = Column(DateTime, nullable=False, default=datetime.utcnow)
    updated_at = Column(
        DateTime, nullable=False, default=datetime.utcnow, onupdate=datetime.utcnow
    )

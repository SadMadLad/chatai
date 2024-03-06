from sqlalchemy import Integer, Column, DateTime
from settings import Base


class Chat(Base):
    __tablename__ = "chats"

    id = Column(Integer, primary_key=True)
    chat_type = Column(Integer, nullable=False)
    latest_message_at = Column(DateTime, nullable=False)

    created_at = Column(DateTime, nullable=False)
    updated_at = Column(DateTime, nullable=False)

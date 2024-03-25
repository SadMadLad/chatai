from sqlalchemy import desc
from sqlalchemy.orm import Session
from db.models.message import Message
from db.schemas.message_schema import MessageCreate


def get_message(db: Session, id: int):
    return db.query(Message).filter(Message.id == id).first()


def get_chat_messages(db: Session, chat_id: int, limit: int | None = None):
    chat_messages = (
        db.query(Message)
        .filter(Message.chat_id == chat_id)
        .order_by(desc(Message.created_at))
    )
    if limit is None:
        return chat_messages.all()

    return chat_messages.limit(limit).all()


def create_message(db: Session, message: MessageCreate, chat_id: int):
    message = Message(**message.model_dump(), chat_id=chat_id)

    db.add(message)
    db.commit()
    db.refresh(message)

    return message

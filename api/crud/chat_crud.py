from sqlalchemy.orm import Session
from db.models.chat import Chat


def get_chat(db: Session, chat_id: int):
    return db.query(Chat).filter(Chat.id == chat_id).first()

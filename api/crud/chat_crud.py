from sqlalchemy.orm import Session
from models.chat import Chat


def get_chat(db: Session, chat_id: int):
    return db.query(Chat).filter(Chat.id == chat_id).first()


def get_all_chats(db: Session):
    return db.query(Chat).all()

from sqlalchemy.orm import Session
from models.ml_model import MlModel


def get_ml_model(db: Session, ml_model_id: int):
    return db.query(MlModel).filter(MlModel.id == ml_model_id).first()

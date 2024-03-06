from sqlalchemy import Integer, Column, String, DateTime, Text, JSON, ForeignKey
from settings import Base

class MlModel(Base):
    __tablename__ = "ml_models"

    id = Column(Integer, primary_key=True)
    title = Column(String, nullable=False)
    identifier = Column(String, nullable=False, unique=True)
    description = Column(Text, nullable=False)
    model_type = Column(Integer, nullable=False)
    parameters_with_order = Column(JSON, nullable=False)
    account_id = Column(Integer, ForeignKey("account.id"))

    created_at = Column(DateTime, nullable=False)
    updated_at = Column(DateTime, nullable=False)

from fastapi import APIRouter, Depends, HTTPException
from settings import get_db
from sqlalchemy.orm import Session
from crud import ml_model_crud

router = APIRouter()

@router.get("/ml_models/{id}/prediction")
async def get_model_prediction(id: int, db: Session = Depends(get_db)):
    ml_model = ml_model_crud.get_ml_model(db, id)

    if ml_model is None:
        raise HTTPException(status_code=404, detail="ML Model not found")
    return ml_model

import os
from fastapi import APIRouter, Depends, HTTPException, Request
from fastapi.responses import FileResponse
from sqlalchemy.orm import Session
import dill
import pandas as pd
import numpy as np
import __main__

from db.config import get_db
from crud import ml_model_crud
from settings import MODELS_HTML_PATH

__main__.np = np

dill.settings["recurse"] = True

router = APIRouter()


@router.post("/ml_models/{id}/prediction")
async def get_model_prediction(
    request: Request, id: int, db: Session = Depends(get_db)
):
    ml_model = ml_model_crud.get_ml_model(db, id)

    if ml_model is None:
        raise HTTPException(status_code=404, detail="ML Model not found")

    incoming_json = await request.json()

    required_parameters = ml_model.parameters_with_order
    prediction_params = list(incoming_json.keys())

    missing_parameters = [
        param for param in required_parameters if param not in prediction_params
    ]

    if len(missing_parameters) != 0:
        raise HTTPException(
            status_code=422,
            detail=f"Incorrect parameters. Missing are: {', '.join(missing_parameters)}",
        )

    model_path = os.path.join(
        MODELS_HTML_PATH, ml_model.identifier, f"{ml_model.identifier}.pkl"
    )
    if not os.path.exists(model_path):
        raise HTTPException(status_code=404, detail="ML Model not found")
    try:
        with open(model_path, "rb") as file:
            prediction_model = dill.load(file)

        prediction_input = pd.DataFrame([incoming_json])
        prediction = prediction_model.predict(prediction_input)
        return prediction.tolist()

    except Exception as e:
        print(e)
        raise HTTPException(
            status_code=500, detail="Something went wrong. Please try later."
        )


@router.get("/ml_models/{id}/notebook_html")
async def get_model_notebook(id: int, db: Session = Depends(get_db)):
    ml_model = ml_model_crud.get_ml_model(db, id)

    if ml_model is None:
        raise HTTPException(status_code=404, detail="ML Model not found")

    ml_model_asset_path = os.path.join(MODELS_HTML_PATH, ml_model.identifier)
    ml_model_html_path = os.path.join(
        ml_model_asset_path, f"{ml_model.identifier}.html"
    )

    if not os.path.isdir(ml_model_asset_path) or not os.path.exists(ml_model_html_path):
        raise HTTPException(status_code=404, detail="Notebook HTML Missing")

    return FileResponse(ml_model_html_path, media_type="text/html")

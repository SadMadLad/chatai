from fastapi import APIRouter, Body
from typing import Any

from assets.embedding_models.gist_embedding_v0 import gist_embedding_v0

router = APIRouter()

@router.post("/embeddings")
async def get_embedding(text_list: Any = Body(None)):
    embeddings = gist_embedding_v0.encode(text_list)
    return embeddings.tolist()

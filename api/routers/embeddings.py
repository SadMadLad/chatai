from fastapi import APIRouter
from assets.embedding_models.gist_embedding_v0 import gist_embedding_v0

router = APIRouter()


@router.get("/embeddings")
async def get_embedding(text_list: list[str]):
    embeddings = gist_embedding_v0.encode(text_list)
    return embeddings.tolist()

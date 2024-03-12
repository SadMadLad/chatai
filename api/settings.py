import os
from dotenv import load_dotenv, find_dotenv

load_dotenv(find_dotenv())

DATABASE_URL = os.getenv("DATABASE_URL")
API_CLIENT_SECRET = os.getenv("API_CLIENT_SECRET")
MODELS_HTML_PATH = os.getenv("MODELS_HTML_PATH")

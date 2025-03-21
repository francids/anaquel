import os
from google import genai

MODEL_NAME = os.getenv("GEMINI_MODEL_NAME")
API_KEY = os.getenv("GEMINI_API_KEY")

client = genai.Client(api_key=API_KEY)

import os
from google import genai

MODEL_NAME = os.getenv("GEMINI_MODEL_NAME")
API_KEY = os.getenv("GEMINI_API_KEY")

client = genai.Client(api_key=API_KEY)

DEFAULT_PARAMS = {
    "temperature": 0.7,
    "max_output_tokens": 2048,
    "top_p": 0.95,
    "top_k": 40,
}

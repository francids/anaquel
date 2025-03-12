import os
from ollama import Client

MODEL_NAME = os.getenv("OLLAMA_MODEL")
HOST = os.getenv("OLLAMA_HOST", "http://localhost:11434")

client = Client(
    host=HOST,
)

DEFAULT_PARAMS = {
    "temperature": 0.7,
    "num_predict": 2048,
    "top_p": 0.95,
    "top_k": 40,
}

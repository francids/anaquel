# Anaquel API

## Configuración

Para ejecutar la API de Anaquel, se necesita tener [Ollama](https://ollama.com/) en ejecución y configurar las siguientes variables de entorno:

- `OLLAMA_MODEL`: El nombre del modelo de Ollama que se utilizará.
- `OLLAMA_HOST`: La dirección del servidor de Ollama. Por defecto, es `http://localhost:11434`.

> Puedes crear un archivo `.env` con estas variables de entorno y ejecutar la aplicación con `uv run --env-file .env main.py`.

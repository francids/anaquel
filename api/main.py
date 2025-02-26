from fastapi import FastAPI

app = FastAPI()


@app.get("/")
def root():
    return {
        "message": "Hello from Anaquel API",
    }


if __name__ == "__main__":
    from uvicorn import run
    from os import environ

    run(
        app,
        port=int(environ.get("PORT", 5000)),
    )

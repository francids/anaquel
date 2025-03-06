from fastapi import FastAPI
from routes.summary import summary_router
from routes.questions import questions_router

app = FastAPI()


@app.get("/")
@app.post("/")
def root():
    return {
        "message": "Hello from Anaquel API",
    }


app.include_router(summary_router)
app.include_router(questions_router)

if __name__ == "__main__":
    from uvicorn import run
    from os import environ

    run(
        app,
        port=int(environ.get("PORT", 5000)),
    )

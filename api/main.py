from os import environ
import json
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


def main(context):
    environ["GEMINI_MODEL_NAME"] = context.variables.get("GEMINI_MODEL_NAME")
    environ["GEMINI_API_KEY"] = context.variables.get("GEMINI_API_KEY")

    try:
        request_data = json.loads(context.req.bodyRaw or "{}")
        path = context.req.path or "/"
        method = context.req.method or "GET"

        if path.startswith("/summary"):
            if method == "POST":
                from routes.summary import generate_summary

                return generate_summary(request_data)
        elif path.startswith("/questions"):
            if method == "POST":
                from routes.questions import generate_questions

                return generate_questions(request_data)
        else:
            return {
                "message": "Hello from Anaquel API",
            }
    except Exception as e:
        return {"error": str(e), "message": "Error processing request"}

    return app


if __name__ == "__main__":
    from uvicorn import run

    run(
        app,
        port=int(environ.get("PORT", 5000)),
    )

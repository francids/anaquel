from os import environ
from fastapi import FastAPI
from routes.summary import summary_router
from routes.questions import questions_router
from utils import throw_if_missing

app = FastAPI()


@app.get("/")
@app.post("/")
def root() -> dict:
    return {
        "message": "Hello from Anaquel API",
    }


app.include_router(summary_router)
app.include_router(questions_router)


async def main(context):
    throw_if_missing(environ, ["GEMINI_API_KEY", "GEMINI_MODEL_NAME"])

    method = context.req.method
    path = context.req.path

    if path == "/" or path == "":
        return context.res.json(root())

    elif path.startswith("/summary"):
        if method == "POST":
            try:
                book_info = context.req.body_json

                from routes.summary import create_summary
                from schemas.book import BookInfo

                book = BookInfo(
                    title=book_info.get("title"), author=book_info.get("author")
                )

                result = await create_summary(book)
                return context.res.json(result)
            except Exception as e:
                return context.res.json({"error": str(e)}, status=500)

    elif path.startswith("/questions"):
        if method == "POST":
            try:
                book_info = context.req.body_json

                num_questions = int(context.req.query.get("num_questions", 5))

                from routes.questions import create_questions
                from schemas.book import BookInfo

                book = BookInfo(
                    title=book_info.get("title"), author=book_info.get("author")
                )

                result = await create_questions(book, num_questions)
                return context.res.json(result)
            except Exception as e:
                return context.res.json({"error": str(e)}, status=500)

    return context.res.json({"error": "Route not found"}, status=404)


if __name__ == "__main__":
    from uvicorn import run

    run(
        app,
        port=int(environ.get("PORT", 5000)),
    )

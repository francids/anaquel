from fastapi import APIRouter, HTTPException, Query
from ai import generate_questions_by_title_author
from schemas.questions import Questions
from schemas.book import BookInfo
from typing import Optional

questions_router = APIRouter(
    prefix="/questions",
    tags=["questions"],
)


@questions_router.post("/", response_model=Questions)
async def create_questions(
    book_info: BookInfo,
    num_questions: Optional[int] = Query(
        5, description="Number of questions to generate"
    ),
) -> Questions:
    """
    Generate literary discussion questions about a book based on its title and author.
    """
    try:
        questions = await generate_questions_by_title_author(
            book_info.title, book_info.author, num_questions
        )
        return questions
    except Exception as e:
        raise HTTPException(
            status_code=500, detail=f"Error generating book questions: {str(e)}"
        )

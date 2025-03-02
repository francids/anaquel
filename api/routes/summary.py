from fastapi import APIRouter, HTTPException
from ai import generate_summary_by_title_author
from schemas.summary import Summary
from schemas.book import BookInfo

summary_router = APIRouter(
    prefix="/summary",
    tags=["summary"],
)


@summary_router.post("/", response_model=Summary)
async def create_summary(book_info: BookInfo):
    """
    Generate a literary summary of a book based on its title and author.
    """
    try:
        summary_content = await generate_summary_by_title_author(
            book_info.title, book_info.author
        )
        return Summary(content=summary_content)
    except Exception as e:
        raise HTTPException(
            status_code=500, detail=f"Error generating book summary: {str(e)}"
        )

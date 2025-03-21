from pydantic import BaseModel, Field


class BookInfo(BaseModel):
    """
    Information about a book.
    """

    title: str = Field(..., description="The title of the book")
    author: str = Field(..., description="The author of the book")

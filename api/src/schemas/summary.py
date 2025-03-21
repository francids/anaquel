from pydantic import BaseModel, Field


class Summary(BaseModel):
    """
    Literary summary of a book.
    """

    content: str = Field(..., description="Main literary summary content of the book")

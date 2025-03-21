from pydantic import BaseModel, Field
from typing import List


class Questions(BaseModel):
    """
    Literary discussion questions generated about a book.
    """

    questions: List[str] = Field(
        ...,
        description="List of generated literary discussion questions about the book",
    )

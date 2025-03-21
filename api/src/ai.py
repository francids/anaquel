from typing import TypeVar
from model import client, MODEL_NAME
from pydantic import BaseModel
from schemas.summary import Summary
from schemas.questions import Questions

T = TypeVar("T")


async def generate_structured_content(prompt: str, response_schema: BaseModel) -> T:
    """
    Generate structured content using the AI model and return it as an instance of the provided schema.

    Args:
        prompt: The text prompt to send to the AI model
        response_schema: Pydantic model class to structure the response

    Returns:
        Structured content as an instance of the provided schema
    """

    try:
        response = client.models.generate_content(
            model=MODEL_NAME,
            contents=prompt,
            config={
                "response_mime_type": "application/json",
                "response_schema": response_schema,
            },
        )
        return response.parsed
    except Exception as e:
        print(f"Error generating structured content: {e}")
        raise e


async def generate_summary_by_title_author(title: str, author: str) -> Summary:
    """
    Generate a summary of a book based on its title and author.

    Args:
        title: The title of the book
        author: The author of the book

    Returns:
        A literary summary of the book in Markdown format
    """
    prompt = f"""
    Please provide a comprehensive literary summary of the book "{title}" by {author}.
    
    Format your response in Markdown with:
    - A title section (h1) with the book name and author
    - Section headings for plot summary, themes, characters, and literary analysis
    - Appropriate use of bold, italic, and bullet points for organization
    - A brief conclusion
    
    Your summary should capture the main plot points, themes, character development, 
    literary devices, and key insights. Focus on elements that would be valuable for 
    readers and literary analysis.
    """

    return await generate_structured_content(prompt, Summary)


async def generate_questions_by_title_author(
    title: str, author: str, num_questions: int = 5
) -> Questions:
    """
    Generate thoughtful questions based on a book identified by title and author.

    Args:
        title: The title of the book
        author: The author of the book
        num_questions: Number of questions to generate

    Returns:
        List of literary discussion questions
    """

    prompt = f"""
    Generate {num_questions} thoughtful discussion questions about the book "{title}" by {author}.
    
    The questions should encourage critical thinking about the book's themes, characters, 
    literary techniques, symbolism, and broader implications. Create questions suitable 
    for a book club or literature class discussion.
    """

    return await generate_structured_content(prompt, Questions)

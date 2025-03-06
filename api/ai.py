from typing import Dict, Any, Optional, TypeVar, Type
from model import client, MODEL_NAME, DEFAULT_PARAMS

T = TypeVar("T")


async def generate_content(
    prompt: str, parameters: Optional[Dict[str, Any]] = None
) -> str:
    """
    Generic method to generate content using Gemini AI model.

    Args:
        prompt: The text prompt to send to the AI model
        parameters: Optional model parameters to customize the generation

    Returns:
        Generated content as a string
    """
    default_params = DEFAULT_PARAMS.copy()

    if parameters:
        default_params.update(parameters)

    try:
        response = client.models.generate_content(
            model=MODEL_NAME,
            contents=[prompt],
        )
        return response.text
    except Exception as e:
        print(f"Error generating content: {e}")
        return f"Error generating content: {str(e)}"


async def generate_structured_content(
    prompt: str, response_schema: Type[T], parameters: Optional[Dict[str, Any]] = None
) -> T:
    """
    Generate structured content using Gemini AI model.

    Args:
        prompt: The text prompt to send to the AI model
        response_schema: Pydantic model class to structure the response
        parameters: Optional model parameters to customize the generation

    Returns:
        Structured content as an instance of the provided schema
    """
    default_params = DEFAULT_PARAMS.copy()

    if parameters:
        default_params.update(parameters)

    try:
        response = client.models.generate_content(
            model=MODEL_NAME,
            contents=[prompt],
            config={
                "response_mime_type": "application/json",
                "response_schema": response_schema,
            },
        )
        return response.parsed
    except Exception as e:
        print(f"Error generating structured content: {e}")
        raise e


async def generate_summary(text: str) -> str:
    """
    Generate a summary of the provided book text.

    Args:
        text: The book text to summarize

    Returns:
        A literary summary of the book
    """
    prompt = f"""
    Please provide a comprehensive literary summary of the following book:
    
    {text}
    
    Your summary should capture the main plot points, themes, character development, 
    literary devices, and key insights. Focus on elements that would be valuable for 
    readers and literary analysis.
    """

    return await generate_content(prompt, {"temperature": 0.5})


async def generate_summary_by_title_author(title: str, author: str) -> str:
    """
    Generate a summary of a book based on its title and author.

    Args:
        title: The title of the book
        author: The author of the book

    Returns:
        A literary summary of the book
    """
    prompt = f"""
    Please provide a comprehensive literary summary of the book "{title}" by {author}.
    
    Your summary should capture the main plot points, themes, character development, 
    literary devices, and key insights. Focus on elements that would be valuable for 
    readers and literary analysis.
    """

    return await generate_content(prompt, {"temperature": 0.5})


async def generate_questions_by_title_author(
    title: str, author: str, num_questions: int = 5
) -> list[str]:
    """
    Generate thoughtful questions based on a book identified by title and author.

    Args:
        title: The title of the book
        author: The author of the book
        num_questions: Number of questions to generate

    Returns:
        List of literary discussion questions
    """
    from schemas.questions import Questions

    prompt = f"""
    Generate {num_questions} thoughtful discussion questions about the book "{title}" by {author}.
    
    The questions should encourage critical thinking about the book's themes, characters, 
    literary techniques, symbolism, and broader implications. Create questions suitable 
    for a book club or literature class discussion.
    
    Return only the questions as a JSON array of strings.
    """

    try:
        result = await generate_structured_content(
            prompt, Questions, {"temperature": 0.7}
        )
        return result.questions
    except Exception:
        content = await generate_content(prompt, {"temperature": 0.7})
        questions_raw = content.strip().split("\n")
        questions = [q.strip() for q in questions_raw if q.strip() and ("?" in q)]
        return questions[:num_questions]

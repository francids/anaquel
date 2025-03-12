from typing import Dict, Any, Optional, TypeVar
from model import client, MODEL_NAME, DEFAULT_PARAMS
from pydantic import BaseModel

T = TypeVar("T")


async def generate_content(
    prompt: str, parameters: Optional[Dict[str, Any]] = None
) -> str:
    """
    Generic method to generate content using Ollama model.

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
        response = client.generate(
            model=MODEL_NAME,
            prompt=prompt,
            options=default_params,
            stream=False,
        )
        return response["response"]
    except Exception as e:
        print(f"Error generating content: {e}")
        return f"Error generating content: {str(e)}"


async def generate_structured_content(
    prompt: str, response_schema: BaseModel, parameters: Optional[Dict[str, Any]] = None
) -> T:
    """
    Generate structured content using Ollama model.

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

    formatted_prompt = f"{prompt}\n\nReturn the output as JSON, using the following schema:\n{response_schema.model_json_schema()}"

    try:
        response = client.generate(
            model=MODEL_NAME,
            prompt=formatted_prompt,
            format=response_schema.model_json_schema(),
            options=default_params,
            stream=False,
        )
        return response_schema.model_validate_json(response["response"])
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
    
    Make sure to return your response as a JSON object with a 'questions' array field containing all the generated questions.
    Example format:
    {{
      "questions": [
        "Question 1 here?",
        "Question 2 here?",
        ...
      ]
    }}
    """

    try:
        result = await generate_structured_content(
            prompt, Questions, {"temperature": 0.7}
        )
        return result.questions
    except Exception as e:
        print(f"Failed to generate structured output. {e}")
        try:
            unstructured_prompt = f"""
            Generate {num_questions} thoughtful discussion questions about the book "{title}" by {author}.
            Each question should be on a new line and start with a number and a period (e.g., "1.").
            """
            response = await generate_content(unstructured_prompt, {"temperature": 0.7})
            lines = response.strip().split("\n")
            questions = [
                line.split(". ", 1)[1] if ". " in line else line
                for line in lines
                if line.strip()
            ]
            return questions[:num_questions]
        except Exception:
            return []

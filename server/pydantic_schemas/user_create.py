from pydantic import BaseModel

# 0. Create a Schema Class (pydanticSchemas)
class UserCreate(BaseModel):
    name: str
    email: str
    password: str

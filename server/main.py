from fastapi import FastAPI
from models.base import Base
from routes import auth
from database import engine

# 0. Create a Schema Class (pydanticSchemas) Used in 5 ()
# 1. Database Connection (database) 
# 2. Create a Session with DB (models/user) DB Used in 5()
# 3. Initialize DB (models/base) Base used in 4 (Base)
# 4. Creating Table with columns and type (model/users) Used in 5()
# 5. Run Post/Get/Put

app = FastAPI()

app.include_router(auth.router, prefix="/auth")

Base.metadata.create_all(bind=engine)
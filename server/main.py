from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from sqlalchemy import Column,TEXT,VARCHAR,LargeBinary,create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base
import uuid
import bcrypt

app = FastAPI()

# 1. Database Connection
DATABASE_URL = 'postgresql://postgres:7210236abc@localhost:5432/fluttermusicapp'
engine = create_engine(DATABASE_URL)
# 2. Creating a Session with DB
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
db = SessionLocal()
 
# 3. Creating Table with columns and type
Base = declarative_base()

class User(Base):
    __tablename__ = 'users'

    id = Column(TEXT, primary_key=True)
    name = Column(VARCHAR(100))
    email = Column(VARCHAR(100))
    password = Column(LargeBinary)
    

class UserCreate(BaseModel):
    name: str
    email: str
    password: str


@app.post('/signup')
def signup_user(user: UserCreate):
    # extract the data thats coming from request
    print(user.name)
    print(user.email)
    print(user.password)
    
    # check if the user already exists in db
    user_db = db.query(User).filter(User.email == user.email).first()

    if user_db:
        raise HTTPException(400, 'user with the same email already exist!')

    # add the user to the db
    hashed_pw = bcrypt.hashpw(user.password.encode(),bcrypt.gensalt())
    user_db = User(id=str(uuid.uuid4()), name=user.name,email=user.email, password=hashed_pw)
    db.add(user_db)
    db.commit()
    db.refresh(user_db)
 
    return user_db

# 4. Initializing the Table
Base.metadata.create_all(engine)
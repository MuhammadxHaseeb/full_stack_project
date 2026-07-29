from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

# 1. Database Connection
DATABASE_URL = 'postgresql://postgres:7210236abc@localhost:5432/fluttermusicapp'
engine = create_engine(DATABASE_URL)

# 2. Creating a Session with DB
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
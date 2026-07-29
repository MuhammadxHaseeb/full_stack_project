from sqlalchemy import Column,TEXT,VARCHAR,LargeBinary
from models.base import Base

# 4. Creating Table with columns and type
class User(Base):
    __tablename__ = 'users'

    id = Column(TEXT, primary_key=True)
    name = Column(VARCHAR(100))
    email = Column(VARCHAR(100))
    password = Column(LargeBinary)

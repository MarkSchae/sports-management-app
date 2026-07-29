import enum
from sqlalchemy import Column, Integer, String, Enum
from database import Base

class UserRole(str, enum.Enum):
    coordinator = "coordinator"
    coach = "coach"
    parent = "parent"

class User(Base):
    __tablename__ = "users"
    id = Column(Integer, primary_key=True)
    email = Column(String, unique=True, nullable=False)
    hashed_password = Column(String, nullable=False)
    role = Column(Enum(UserRole), nullable=False)
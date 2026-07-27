from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, declarative_base
import os
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

# Generic DB URL for template; user can override in their project
DATABASE_URL = os.getenv("DATABASE_URL", "sqlite:///./test.db")

# Create the SQLAlchemy engine
engine = create_engine(
    DATABASE_URL,
    connect_args={"check_same_thread": False} if DATABASE_URL.startswith("sqlite") else {},
)

# Session factory to be used in dependencies or services
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# Base class for SQLAlchemy models
Base = declarative_base()

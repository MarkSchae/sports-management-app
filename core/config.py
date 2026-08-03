from dotenv import load_dotenv
import os

load_dotenv()

SECRET_KEY = os.getenv("SECRETKEY")
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 60
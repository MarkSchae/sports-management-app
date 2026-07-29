# test_db.py
#import sys
#import os

#print("Current directory:")
#print(os.getcwd())

#print("\nPython search paths:")
#for path in sys.path:
#    print(path)
from database import engine
from sqlalchemy import text

try:
    with engine.connect() as connection:
        result = connection.execute(text("SELECT 1"))
        print("Database connection successful!")
        print(result.fetchone())

except Exception as e:
    print("Database connection failed:")
    print(e)
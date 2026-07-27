# create_tables.py
from golf_app.db.session import engine, Base

# Import models so they are registered with Base
from golf_app.db.models import *

Base.metadata.create_all(bind=engine)
print("Tables created (or skipped if none exist).")


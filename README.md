# Project FastAPI Template

### A FastAPI starter template with:

- FastAPI

- SQLAlchemy

- Alembic migrations

- Environment configuration

- Project structure for scalable APIs

- Setup script for fast bootstrapping

This repository is intended to be used as a base template for new FastAPI projects.

### Features

- Structured app/ layout

- Database models with SQLAlchemy

- Alembic migrations pre-configured

- requirements.txt dependency management

- Setup script for quick environment initialization

### Installation
#### Option 1 — Using Setup Script (Recommended)
chmod +x setup.sh
./setup.sh

##### This will:

- Create virtual environment

- Install dependencies from requirements.txt

- Run database migrations

#### Option 2 — Manual Setup

- python -m venv .venv
- source .venv/bin/activate  Linux/Mac
- .venv\Scripts\activate   Windows
- pip install -r requirements.txt
alembic upgrade head

### Running the Server
uvicorn app.main:app --reload


App will be available at:

http://127.0.0.1:8000


Swagger docs:

http://127.0.0.1:8000/docs

### Running Migrations

Create a migration:

alembic revision --autogenerate -m "your message"


Apply migrations:

alembic upgrade head

### Project Structure
app/
  main.py
  models.py
  schemas.py
  routes/

alembic/
alembic.ini
requirements.txt
setup.sh

### Intended Use

This repository serves as a clean starting point for:

REST APIs

Real-time systems (to be extended)

Production-ready FastAPI backends

Backend services integrated with other systems (e.g., Rust microservices)

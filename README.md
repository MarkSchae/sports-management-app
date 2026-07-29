# Sports Operations Platform — Phase 0: Foundation

**Status:** skeleton only. No real features yet — this phase exists purely to get auth, the database, and deployment working before any actual feature gets built on top of it.

## What's implemented
- FastAPI project skeleton (`app/main.py`, `models/`, `schemas/`, `routers/`, `database.py`)
- PostgreSQL running via Docker, Alembic migrations initialized
- JWT-based auth: register, login
- Role system: `coordinator`, `coach`, `parent` — a single `User` table with a `role` field, plus a reusable dependency for role-protected routes
- Empty skeleton models for `Department`, `Team`, `Coach`, `Player`, `Venue`, `Fixture` (structure only, no business logic yet)
- Deployed to Render, connected to a Render-hosted Postgres instance

## Setup
```bash
docker compose up -d          # starts local Postgres
alembic upgrade head          # runs migrations
uvicorn app.main:app --reload # starts the API locally
```
Copy `.env.example` to `.env` and fill in real values before running. Never commit `.env`.

## Roles (so far, auth only — no feature access differences yet)
- **Coordinator** — will eventually see everything across all teams
- **Coach** — will eventually own their own team's roster and reports
- **Parent** — will eventually be read-only

## What's NOT built yet
Everything feature-related. This phase is deliberately just the plumbing: auth works, the database is reachable, the app deploys. Phase 1 starts on real functionality (team/roster entry).

## Why this phase exists on its own
Getting deploy + auth + migrations solid *before* any real feature means every later phase ships against a foundation that's already known to work, instead of debugging infrastructure and business logic at the same time.
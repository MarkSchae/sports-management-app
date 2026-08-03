from fastapi import FastAPI
from auth.auth_router import router as auth_route

app = FastAPI()

app.include_router(
    auth_route
)

@app.get("/health")
def health():
    return {"status": "ok"}
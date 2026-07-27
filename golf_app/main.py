from fastapi import FastAPI

app = FastAPI(title="Golf Pro Web API")

@app.get("/")
def root():
    return {"message": "Hello, Golf Pro Web!"}

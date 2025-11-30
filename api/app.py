from fastapi import FastAPI

app = FastAPI(title="Cloud File Processor API")


@app.get("/health")
def health():
    return {"status": "ok"}


@app.get("/debug")
def debug():
    # endpoint pomocniczy do sprawdzenia, że API działa
    return {"message": "API is running", "version": "0.1.0"}

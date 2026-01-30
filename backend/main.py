from fastapi import FastAPI
from api.routes import router

app = FastAPI(title="Face Attendance System")

app.include_router(router)

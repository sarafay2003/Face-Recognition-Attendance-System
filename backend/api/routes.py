from fastapi import APIRouter, UploadFile, File, Form
import numpy as np
import cv2
from datetime import datetime

from services.face_service import register_face, recognize_face
from services.log_service import save_attendance

router = APIRouter()


@router.post("/register")
async def register(name: str = Form(...), file: UploadFile = File(...)):
    image_bytes = await file.read()
    image = cv2.imdecode(np.frombuffer(image_bytes, np.uint8), cv2.IMREAD_COLOR)

    register_face(image, name)

    return {
        "success": True,
        "message": f"Face registered for {name}"
    }


@router.post("/attendance")
async def attendance(file: UploadFile = File(...)):
    image_bytes = await file.read()
    image = cv2.imdecode(np.frombuffer(image_bytes, np.uint8), cv2.IMREAD_COLOR)

    name = recognize_face(image)

    if not name:
        return {
            "success": False,
            "message": "No known face detected"
        }

    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    save_attendance(name, timestamp)

    return {
        "success": True,
        "message": f"Attendance marked for {name} at {timestamp}"
    }

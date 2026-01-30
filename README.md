# Face Recognition Attendance System

A full-stack application for marking attendance using face recognition.  
The system allows users to **register faces** and **mark attendance** automatically when a known face is detected.

---

## Features

- **Face Registration:** Register a user's face via the frontend UI.
- **Attendance Marking:** Detect faces and record attendance with timestamps.
- **Efficient Detection:** Only sends frames with detected faces to the backend.
- **Full-Stack:** Built with **Flutter** for frontend and **FastAPI** for backend.
- **Data Storage:** Stores face encodings and attendance logs securely.

---

## Tech Stack

- **Frontend:** Flutter, Dart, Camera plugin
- **Backend:** FastAPI, Python, OpenCV, NumPy
- **Database:** SQLite (or any preferred DB)
- **Face Recognition:** Pre-trained face embeddings with Python

---

## Folder Structure
Face-Recognition-Attendance-System/
│
├─ frontend/ # Flutter app
│ └─ lib/
│ ├─ main.dart
│ ├─ screens/
│ ├─ models/
│ └─ services/
│
├─ backend/ # FastAPI backend
│ ├─ api/
│ ├─ database/
│ ├─ services/
│ ├─ utils/
│ ├─ main.py
│ └─ requirements.txt
│
└─ README.md # Project overview





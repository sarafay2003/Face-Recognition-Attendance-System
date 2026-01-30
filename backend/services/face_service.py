import face_recognition
import os
import pickle

FACES_DIR = "data/faces"
os.makedirs(FACES_DIR, exist_ok=True)


def register_face(image, name):
    encodings = face_recognition.face_encodings(image)
    if not encodings:
        raise Exception("No face detected during registration")

    path = os.path.join(FACES_DIR, f"{name}.pkl")

    with open(path, "wb") as f:
        pickle.dump(encodings[0], f)


def recognize_face(image):
    encodings = face_recognition.face_encodings(image)
    if not encodings:
        return None

    input_encoding = encodings[0]

    for file in os.listdir(FACES_DIR):
        if not file.endswith(".pkl"):
            continue

        file_path = os.path.join(FACES_DIR, file)

        try:
            with open(file_path, "rb") as f:
                stored_encoding = pickle.load(f)

            match = face_recognition.compare_faces(
                [stored_encoding],
                input_encoding,
                tolerance=0.45
            )

            if match[0]:
                return file.replace(".pkl", "")

        except Exception as e:
            print(f"[WARNING] Skipping corrupted face file: {file} | {e}")
            continue

    return None

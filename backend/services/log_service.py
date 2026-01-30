import os

LOG_FILE = "data/logs/attendance.csv"
os.makedirs("data/logs", exist_ok=True)

if not os.path.exists(LOG_FILE):
    with open(LOG_FILE, "w") as f:
        f.write("name,time\n")


def save_attendance(name, time):
    with open(LOG_FILE, "a") as f:
        f.write(f"{name},{time}\n")

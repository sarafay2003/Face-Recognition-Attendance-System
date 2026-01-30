CREATE_LOG_TABLE = """
CREATE TABLE IF NOT EXISTS logs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    status TEXT,
    camera TEXT,
    time TEXT,
    image TEXT
);
"""

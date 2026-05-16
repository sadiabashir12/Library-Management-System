import mysql.connector
import csv

# ─── DATABASE CONFIG ───
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="YOUR_PASSWORD",
    database="library_db"
)

cursor = conn.cursor()

def import_csv(file_path, table_name, columns):
    with open(file_path, newline='', encoding='utf-8') as file:
        reader = csv.reader(file)
        next(reader)  # skip header

        query = f"INSERT INTO {table_name} ({','.join(columns)}) VALUES ({','.join(['%s']*len(columns))})"

        data = []
        for row in reader:
            data.append(row)

        cursor.executemany(query, data)
        conn.commit()

        print(f"{table_name} imported successfully with {len(data)} rows")
        
 
# 1. FIRST PARENT TABLES
import_csv("csv_files/books.csv", "books",
           ["book_id", "title", "author", "genre", "year"])

import_csv("csv_files/members.csv", "members",
           ["member_id", "name", "email", "phone"])

# 2. THEN CHILD TABLE
import_csv("csv_files/issues.csv", "issues",
           ["issue_id", "member_id", "book_id",
            "issue_date", "due_date", "return_date", "returned"])        
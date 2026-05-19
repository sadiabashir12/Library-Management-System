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


# ─── FUNCTION TO IMPORT CSV ───
def import_csv(file_path, table_name, columns):

    with open(file_path, newline='', encoding='utf-8') as file:

        reader = csv.reader(file)

        next(reader)   # Skip CSV header row

        query = f"""
        INSERT INTO {table_name}
        ({','.join(columns)})
        VALUES ({','.join(['%s'] * len(columns))})
        """

        data = []

        for row in reader:
            data.append(row)

        cursor.executemany(query, data)

        conn.commit()

        print(f"{table_name} imported successfully with {len(data)} rows")


# ─────────────────────────────────────────
# 1. PARENT TABLES FIRST
# ─────────────────────────────────────────

# AUTHORS
import_csv(
    "csv_files/AUTHORS.csv",
    "authors",
    ["author_id", "author_name"]
)

# CATEGORIES
import_csv(
    "csv_files/CATEGORIES.csv",
    "categories",
    ["category_id", "category_name"]
)

# ROLES
import_csv(
    "csv_files/ROLES.csv",
    "roles",
    ["role_id", "role_name", "max_books"]
)

# MEMBERS
import_csv(
    "csv_files/MEMBERS.csv",
    "members",
    ["member_id", "member_name", "email", "phone", "role_id"]
)

# BOOKS
import_csv(
    "csv_files/BOOKS.csv",
    "books",
    [
        "book_id",
        "title",
        "author_id",
        "category_id",
        "published_year",
        "available_copies"
    ]
)


# ─────────────────────────────────────────
# 2. CHILD TABLES
# ─────────────────────────────────────────

# ISSUES
import_csv(
    "csv_files/ISSUES.csv",
    "issues",
    [
        "issue_id",
        "member_id",
        "book_id",
        "issue_date",
        "due_date",
        "return_date",
        "returned"
    ]
)

# FINES
import_csv(
    "csv_files/FINES.csv",
    "fines",
    [
        "fine_id",
        "issue_id",
        "fine_amount",
        "fine_status"
    ]
)


# ─────────────────────────────────────────
# CLOSE CONNECTION
# ─────────────────────────────────────────

cursor.close()
conn.close()

print("\nAll CSV files imported successfully!")

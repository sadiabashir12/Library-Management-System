# Library Management System Database Normalization

# First Normal Form (1NF)

The database schema satisfies First Normal Form because all tables contain atomic values only, meaning each attribute stores a single value and there are no repeating groups or multivalued fields.

## AUTHORS
Each author has a unique author_id. Attributes such as author_name store single values only. No repeating columns or multivalued attributes exist.

## CATEGORIES
Each category record contains one unique category name. category_id uniquely identifies each row. All attributes are atomic.

## BOOKS
Each book is uniquely identified by book_id. Attributes such as title, isbn, publisher, year, quantity, and available contain single values only. Author and category information are not stored as comma-separated lists and were separated into AUTHORS and CATEGORIES tables using foreign keys.

## MEMBERS
Each member has a unique member_id. Attributes such as name, email, phone, and address contain atomic values only. role_id stores one role reference per member.

## ROLES
Each role is uniquely identified by role_id. Attributes such as role_name, max_books, borrow_days, and fine_per_day store single values only.

## ISSUES
Each issue record stores one borrowing transaction only. issue_id uniquely identifies each row. member_id and book_id reference single members and books. issue_date, due_date, return_date, and returned contain atomic values.

## FINES
Each fine record stores one penalty transaction only. fine_id uniquely identifies each row. amount and paid contain single-valued attributes only.

---

# Second Normal Form (2NF)

The schema satisfies Second Normal Form because all non-key attributes are fully dependent on the entire primary key. Tables with single-column primary keys automatically satisfy 2NF, and there are no partial dependencies.

## AUTHORS
Primary key is author_id. All attributes depend entirely on author_id.

## CATEGORIES
Primary key is category_id. All attributes depend completely on category_id.

## BOOKS
Primary key is book_id. All non-key attributes such as title, isbn, publisher, year, quantity, available, author_id, and category_id depend fully on book_id.

## MEMBERS
Primary key is member_id. All member attributes depend completely on member_id.

## ROLES
Primary key is role_id. All role attributes depend fully on role_id.

## ISSUES
Primary key is issue_id. All issue details including member_id, book_id, issue_date, due_date, return_date, and returned depend completely on issue_id.

## FINES
Primary key is fine_id. All fine-related attributes depend entirely on fine_id.

---

# Third Normal Form (3NF)

The schema satisfies Third Normal Form because there are no transitive dependencies. Non-key attributes do not depend on other non-key attributes.

## AUTHORS
Author information is stored independently in the AUTHORS table. No non-key attribute depends on another non-key attribute.

## CATEGORIES
Category details are stored separately in the CATEGORIES table. All attributes depend directly on category_id only.

## BOOKS
Author and category information were separated into AUTHORS and CATEGORIES tables to prevent repeated text values across multiple books. All book attributes depend only on book_id.

## MEMBERS
Member information is stored independently from roles. role_id acts as a foreign key reference to the ROLES table, preventing repeated role information in multiple member records.

## ROLES
Role details are stored separately from members. No transitive dependency exists.

## ISSUES
Issue transaction information is stored independently from books and members. Member and book details are referenced using foreign keys, avoiding redundancy and transitive dependency.

## FINES
Fine information is separated from ISSUES. This prevents repeated fine-related data inside issue records and ensures all attributes depend only on fine_id.

---

# Duplicate Removal and Redundancy Elimination

The following normalization decisions were made to remove redundancy and duplication from the database schema:

- Author information was removed from the BOOKS table and stored separately in the AUTHORS table.
- Category information was separated into the CATEGORIES table to avoid repeated category names across books.
- Member roles were normalized using the ROLES table instead of storing role names repeatedly inside MEMBERS.
- Book issue transactions were isolated in the ISSUES table instead of storing issue details directly in MEMBERS or BOOKS.
- Fine records were separated into the FINES table to avoid redundant fine-related data in ISSUES.
- Foreign key relationships were used to reduce duplicate information and maintain referential integrity.

---

# Final Normalization Result

After applying normalization:

- All tables satisfy 1NF, 2NF, and 3NF.
- Redundant and repeating data has been eliminated.
- Foreign key relationships maintain referential integrity between tables.
- The schema supports efficient querying and scalability.
- Update, insertion, and deletion anomalies have been minimized.
- The database structure is organized, maintainable, and suitable for the Library Management System.
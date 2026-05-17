# Library Management System Dataflow

## Data Input

Data enters the system through librarian and admin operations. Librarians add books, categories, authors, and member records into the system. Members borrow and return books through issue transactions.

## Database Flow

- Author information is stored in the AUTHORS table.
- Category information is stored in the CATEGORIES table.
- Book records are stored in the BOOKS table and reference AUTHORS and CATEGORIES through foreign keys.
- Member information is stored in the MEMBERS table.
- Member roles and borrowing limits are stored in the ROLES table.
- Book borrowing transactions are stored in the ISSUES table.
- Fine records for overdue books are stored in the FINES table.

## Table Dependencies
-The BOOKS table depends on AUTHORS and CATEGORIES.
-The ISSUES table depends on MEMBERS and BOOKS.
-The FINES table depends on the ISSUES table.

## Data Output

The system generates:
- Available books lists
- Issued books reports
- Overdue books reports
- Fine reports
- Member borrowing history
- Inventory management information

The data can also be exported for reporting and analytics purposes.

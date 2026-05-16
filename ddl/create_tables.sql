CREATE DATABASE library_management_system;

USE library_management_system;

CREATE TABLE AUTHORS (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    author_name VARCHAR(100) NOT NULL
);

CREATE TABLE CATEGORIES (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE ROLES (
    role_id INT PRIMARY KEY AUTO_INCREMENT,
    role_name VARCHAR(50) NOT NULL UNIQUE,
    max_books INT NOT NULL,
    borrow_days INT NOT NULL,
    fine_per_day DECIMAL(5,2) NOT NULL
);

CREATE TABLE MEMBERS (
    member_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    address VARCHAR(255),
    role_id INT NOT NULL,

    FOREIGN KEY (role_id)
    REFERENCES ROLES(role_id)
);

CREATE TABLE BOOKS (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    isbn VARCHAR(20) UNIQUE,
    publisher VARCHAR(100),
    year INT,
    quantity INT NOT NULL CHECK(quantity >= 0),
    available BOOLEAN DEFAULT TRUE,

    author_id INT NOT NULL,
    category_id INT NOT NULL,

    FOREIGN KEY (author_id)
    REFERENCES AUTHORS(author_id),

    FOREIGN KEY (category_id)
    REFERENCES CATEGORIES(category_id)
);

CREATE TABLE ISSUES (
    issue_id INT PRIMARY KEY AUTO_INCREMENT,

    member_id INT NOT NULL,
    book_id INT NOT NULL,

    issue_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,

    returned BOOLEAN DEFAULT FALSE,

    FOREIGN KEY (member_id)
    REFERENCES MEMBERS(member_id),

    FOREIGN KEY (book_id)
    REFERENCES BOOKS(book_id)
);

CREATE TABLE FINES (
    fine_id INT PRIMARY KEY AUTO_INCREMENT,

    issue_id INT NOT NULL UNIQUE,

    amount DECIMAL(8,2) NOT NULL CHECK(amount >= 0),

    paid BOOLEAN DEFAULT FALSE,

    FOREIGN KEY (issue_id)
    REFERENCES ISSUES(issue_id)
);

CREATE INDEX idx_books_author
ON BOOKS(author_id);

CREATE INDEX idx_books_category
ON BOOKS(category_id);

CREATE INDEX idx_issues_member
ON ISSUES(member_id);

CREATE INDEX idx_issues_book
ON ISSUES(book_id);


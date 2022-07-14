
CREATE DATABASE mysql_recursive;

USE mysql_recursive;

CREATE TABLE courses(
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE modules(
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    parent_is_course BOOLEAN NOT NULL DEFAULT TRUE,
    parent_course_id INT,
    parent_module_id INT,
    child_are_modules BOOLEAN NOT NULL DEFAULT TRUE,
    FOREIGN KEY (parent_course_id) REFERENCES courses(id),
    FOREIGN KEY (parent_module_id) REFERENCES modules(id)
);

CREATE TABLE lessons(
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    parent_module_id INT,
    FOREIGN KEY (parent_module_id) REFERENCES modules(id)
);
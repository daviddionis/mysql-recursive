
# MySQL Recursive Example

Problem: We are creating a eLearning platform that has courses. Inside this courses we have modules. Inside this modules we can have lessons or (sub)modules. Inside the (sub)modules we can have lessons or (sub)modules... and so on.

## Requirements
- MySQL or MariaDB

## Structure

```sql

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
    childs_are_lessons BOOLEAN NOT NULL DEFAULT TRUE,
    FOREIGN KEY (parent_course_id) REFERENCES courses(id),
    FOREIGN KEY (parent_module_id) REFERENCES modules(id)
);

CREATE TABLE lessons(
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    parent_module_id INT,
    FOREIGN KEY (parent_module_id) REFERENCES modules(id)
);
```

## Solution

```sql
with recursive last_level_modules_from_course
    (id, name, parent_is_course, parent_course_id, parent_module_id, childs_are_lessons) 
as (
    select 
        id, name, parent_is_course, 
        parent_course_id, parent_module_id, 
        childs_are_lessons
    from modules
    where 
        parent_course_id = 1

    union all

    select 
        m.id, m.name, m.parent_is_course, 
        m.parent_course_id, m.parent_module_id, 
        m.childs_are_lessons
    from modules m
    join last_level_modules_from_course llmfc on llmfc.id = m.parent_module_id
)
select l.id as lesson_id, l.name as lesson_name, m.id as module_id, m.name as module_name
from lessons l
join last_level_modules_from_course m on m.id = l.parent_module_id
WHERE m.childs_are_lessons = TRUE
order by l.id asc;
```

### Example Data

```sql

INSERT INTO courses (id, name) VALUES 
    (1, 'Introduction to MySQL'), 
    (2, 'MySQL Intermediate Level: Joining, Triggers and Functions'), 
    (3, 'MySQL Advanced Level: Recursive Queries');

INSERT INTO modules (id, name, parent_is_course, parent_course_id, parent_module_id, childs_are_lessons) VALUES 
    (1, 'Installing MySQL', TRUE, 1, NULL, FALSE),
    (2, 'Install Windows', FALSE, NULL, 1, TRUE),
    (3, 'Install MacOS', FALSE, NULL, 1, FALSE),
    (4, 'Install Apple Intel', FALSE, NULL, 3, TRUE),
    (5, 'Install Apple Sillicon', FALSE, NULL, 3, TRUE),

    (6, 'Data Types', TRUE, 1, NULL, FALSE),
    (7, 'Numbers', FALSE, NULL, 6, TRUE),
    (8, 'Create Table', TRUE, 1, NULL, TRUE);

INSERT INTO lessons (id, name, parent_module_id) VALUES 
    (1, 'Install Windows: Step 1', 2),
    (2, 'Install Windows: Step 2', 2),
    (3, 'Install Windows: Step 3', 2),
    
    (4, 'Install Apple Intel: Step 1', 4),
    (5, 'Install Apple Intel: Step 2', 4),
    (6, 'Install Apple Intel: Step 3', 4),

    (7, 'Install Apple Sillicon: Step 1', 5),
    (8, 'Install Apple Sillicon: Step 2', 5),
    (9, 'Install Apple Sillicon: Step 3', 5),
    
    (10, 'Numbers: Int', 7),
    (11, 'Numbers: Decimal', 7),

    (12, 'The Create Sentence', 8);
```
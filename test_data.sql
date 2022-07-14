
INSERT INTO courses (id, name) VALUES 
    (1, 'Introduction to MySQL'), 
    (2, 'MySQL Intermediate Level: Joining, Triggers and Functions'), 
    (3, 'MySQL Advanced Level: Recursive Queries');

INSERT INTO modules (id, name, parent_is_course, parent_course_id, parent_module_id) VALUES 
    (1, 'Installing MySQL', TRUE, 1, NULL),
    (2, 'Install Windows', FALSE, NULL, 1),
    (3, 'Install MacOS', FALSE, NULL, 1),
    (4, 'Install Apple Intel', FALSE, NULL, 3),
    (5, 'Install Apple Sillicon', FALSE, NULL, 3),

    (6, 'Data Types', TRUE, 1, NULL),
    (7, 'Numbers', FALSE, NULL, 6),
    (8, 'Create Table', TRUE, 1, NULL);

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
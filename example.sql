
-- Get all modules with lesson child from a course

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
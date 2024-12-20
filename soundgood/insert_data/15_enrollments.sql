INSERT INTO enrollment (student_id, lesson_id)
SELECT
    s.id as student_id,
    l.id as lesson_id
FROM student s
CROSS JOIN lesson l
JOIN group_lesson gl ON l.id = gl.lesson_id
WHERE s.id IN (SELECT id FROM student LIMIT 3)  -- First 3 students
AND l.id IN (SELECT lesson_id FROM group_lesson LIMIT 1);  -- First group lesson

-- Add enrollments for individual lessons
INSERT INTO enrollment (student_id, lesson_id)
SELECT
    s.id as student_id,
    l.id as lesson_id
FROM student s
CROSS JOIN lesson l
JOIN individual_lesson il ON l.id = il.lesson_id
WHERE s.id IN (SELECT id FROM student LIMIT 2)  -- First 2 students
AND l.id IN (SELECT lesson_id FROM individual_lesson LIMIT 2);  -- First 2 individual lessons

INSERT INTO enrollment (student_id, lesson_id)
SELECT
    s.id as student_id,
    l.id as lesson_id
FROM student s
CROSS JOIN lesson l
JOIN ensemble e ON l.id = e.lesson_id
WHERE s.id IN (SELECT id FROM student LIMIT 4)  -- First 4 students
AND l.id IN (SELECT lesson_id FROM ensemble LIMIT 1);  -- First ensemble lesson

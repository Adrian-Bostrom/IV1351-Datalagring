INSERT INTO sibling_relationship (student_id1, student_id2)
SELECT
    s1.id,
    s2.id
FROM student s1
JOIN person p1 ON s1.person_id = p1.id
JOIN student s2 ON s1.id < s2.id  -- This ensures we meet the CHECK constraint
JOIN person p2 ON s2.person_id = p2.id
WHERE
    (p1.first_name = 'Sophi' AND p2.first_name = 'Isak')
    OR (p1.first_name = 'Lil' AND p2.first_name = 'Brandais');

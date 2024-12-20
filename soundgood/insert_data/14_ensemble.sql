INSERT INTO ensemble (lesson_id, genre_id, min_students, max_students)
SELECT
    l.id,
    g.id as genre_id,
    4 as min_students,
    8 as max_students
FROM lesson l
JOIN pricing_scheme ps ON l.pricing_scheme_id = ps.id
CROSS JOIN (SELECT id FROM genre LIMIT 1) g
WHERE ps.lesson_type = 'Ensemble';

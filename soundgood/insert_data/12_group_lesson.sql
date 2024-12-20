-- Group lessons
INSERT INTO group_lesson (lesson_id, instrument_id, min_students, max_students, skill_level_id)
SELECT
    l.id,
    i.id as instrument_id,
    3 as min_students,
    5 as max_students,
    sl.id as skill_level_id
FROM lesson l
JOIN pricing_scheme ps ON l.pricing_scheme_id = ps.id
CROSS JOIN (SELECT id FROM instrument LIMIT 1) i
CROSS JOIN (SELECT id FROM skill_level LIMIT 1) sl
WHERE ps.lesson_type = 'Group';

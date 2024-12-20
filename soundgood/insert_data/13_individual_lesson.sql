INSERT INTO individual_lesson (lesson_id, instrument_id, skill_level_id)
SELECT
    l.id,
    i.id as instrument_id,
    sl.id as skill_level_id
FROM lesson l
JOIN pricing_scheme ps ON l.pricing_scheme_id = ps.id
CROSS JOIN (SELECT id FROM instrument LIMIT 1) i
CROSS JOIN (SELECT id FROM skill_level LIMIT 1) sl
WHERE ps.lesson_type = 'Individual';

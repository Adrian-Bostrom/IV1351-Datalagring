INSERT INTO booking (lesson_id, instructor_available_time_slot_id)
SELECT
    l.id as lesson_id,
    ts.id as time_slot_id
FROM lesson l
CROSS JOIN instructor_available_time_slot ts
WHERE ts.status = 'Available'
AND l.id IN (
    SELECT DISTINCT lesson_id
    FROM enrollment
)
LIMIT 5;

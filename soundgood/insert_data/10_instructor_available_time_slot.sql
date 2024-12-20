INSERT INTO instructor_available_time_slot
(instructor_id, instrument_id, start_date, end_date, status)
SELECT
    i.id as instructor_id,
    inst.id as instrument_id,
    start_date::timestamp with time zone,
    end_date::timestamp with time zone,
    status::status_enum
FROM instructor i
CROSS JOIN (
    VALUES
        ('2024-01-15 10:00:00+01'::timestamp with time zone,
         '2024-01-15 11:30:00+01'::timestamp with time zone,
         'Available'),
        ('2024-01-15 13:00:00+01'::timestamp with time zone,
         '2024-01-15 14:30:00+01'::timestamp with time zone,
         'Available'),
        ('2024-01-16 09:00:00+01'::timestamp with time zone,
         '2024-01-16 10:30:00+01'::timestamp with time zone,
         'Booked'),
        ('2024-01-22 10:00:00+01'::timestamp with time zone,
         '2024-01-22 11:30:00+01'::timestamp with time zone,
         'Available'),
        ('2024-01-23 13:00:00+01'::timestamp with time zone,
         '2024-01-23 14:30:00+01'::timestamp with time zone,
         'Booked')
    ) as slots(start_date, end_date, status)
CROSS JOIN (
    SELECT id FROM instrument LIMIT 2  -- Each instructor can teach first 2 instruments
) inst
WHERE i.id IN (  -- Get first 2 instructors
    SELECT id FROM instructor LIMIT 2
);

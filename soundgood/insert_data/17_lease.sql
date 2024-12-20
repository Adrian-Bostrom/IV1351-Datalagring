INSERT INTO lease (student_id, instrument_id, start_date, end_date)
VALUES
    -- First student rents two instruments
    ((SELECT id FROM student ORDER BY id LIMIT 1),
     (SELECT id FROM instrument WHERE type = 'Guitar' LIMIT 1),
     '2024-01-01'::timestamp with time zone,
     '2024-12-31'::timestamp with time zone),

    ((SELECT id FROM student ORDER BY id LIMIT 1),
     (SELECT id FROM instrument WHERE type = 'Piano' LIMIT 1),
     '2024-01-01'::timestamp with time zone,
     '2024-12-31'::timestamp with time zone),

    -- Second student rents one instrument
    ((SELECT id FROM student ORDER BY id OFFSET 1 LIMIT 1),
     (SELECT id FROM instrument WHERE type = 'Violin' LIMIT 1),
     '2024-01-01'::timestamp with time zone,
     '2024-12-31'::timestamp with time zone);

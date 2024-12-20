INSERT INTO student (person_id, contact_person_id, skill_level_id)
SELECT
    p.id,
    cp.id,
    (FLOOR(RANDOM() * 3) + 1)::integer as skill_level_id
FROM person p
CROSS JOIN contact_person cp
WHERE p.person_number IN (
    '20131102-0876',  -- First student
    '20210522-1447',  -- Second student
    '20101004-0096',  -- Third student
    '20040127-5771',  -- Fourth student
    '20120331-3334'   -- Fifth student
)
AND cp.person_id = (
    SELECT id FROM person
    WHERE first_name =
        CASE
            WHEN p.person_number = '20131102-0876' THEN 'Kurt'
            WHEN p.person_number = '20210522-1447' THEN 'Galvin'
            WHEN p.person_number = '20101004-0096' THEN 'Raimondo'
            WHEN p.person_number = '20040127-5771' THEN 'Jobyna'
            WHEN p.person_number = '20120331-3334' THEN 'Gustav'
        END
);

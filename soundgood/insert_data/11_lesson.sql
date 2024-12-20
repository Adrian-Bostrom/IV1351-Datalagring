-- Create lessons for group classes
INSERT INTO lesson (instructor_id, pricing_scheme_id)
SELECT
    i.id as instructor_id,
    ps.id as pricing_scheme_id
FROM instructor i
CROSS JOIN pricing_scheme ps
WHERE ps.lesson_type = 'Group'
LIMIT 3;  -- Create 3 group lessons

-- Create lessons for individual classes
INSERT INTO lesson (instructor_id, pricing_scheme_id)
SELECT
    i.id as instructor_id,
    ps.id as pricing_scheme_id
FROM instructor i
CROSS JOIN pricing_scheme ps
WHERE ps.lesson_type = 'Individual'
LIMIT 4;  -- Create 4 individual lessons

-- Create lessons for ensembles
INSERT INTO lesson (instructor_id, pricing_scheme_id)
SELECT
    i.id as instructor_id,
    ps.id as pricing_scheme_id
FROM instructor i
CROSS JOIN pricing_scheme ps
WHERE ps.lesson_type = 'Ensemble'
LIMIT 3;  -- Create 3 ensembles

INSERT INTO pricing_scheme (lesson_type, skill_level_id, price, valid_from, valid_until) VALUES
-- Individual lesson prices
((SELECT 'Individual'::lesson_type_enum),
 (SELECT id FROM skill_level WHERE skill_level = 'Beginner'),
 300.00,
 '2024-01-01'::timestamp with time zone,
 NULL),

((SELECT 'Individual'::lesson_type_enum),
 (SELECT id FROM skill_level WHERE skill_level = 'Intermediate'),
 300.00,  -- Same price for beginner/intermediate as per requirements
 '2024-01-01'::timestamp with time zone,
 NULL),

((SELECT 'Individual'::lesson_type_enum),
 (SELECT id FROM skill_level WHERE skill_level = 'Advanced'),
 400.00,  -- Higher price for advanced
 '2024-01-01'::timestamp with time zone,
 NULL),

-- Group lesson prices
((SELECT 'Group'::lesson_type_enum),
 (SELECT id FROM skill_level WHERE skill_level = 'Beginner'),
 200.00,
 '2024-01-01'::timestamp with time zone,
 NULL),

((SELECT 'Group'::lesson_type_enum),
 (SELECT id FROM skill_level WHERE skill_level = 'Intermediate'),
 200.00,
 '2024-01-01'::timestamp with time zone,
 NULL),

((SELECT 'Group'::lesson_type_enum),
 (SELECT id FROM skill_level WHERE skill_level = 'Advanced'),
 250.00,
 '2024-01-01'::timestamp with time zone,
 NULL),

-- Ensemble prices (one price for all levels since ensemble doesn't specify skill level)
((SELECT 'Ensemble'::lesson_type_enum),
 (SELECT id FROM skill_level WHERE skill_level = 'Beginner'),
 150.00,
 '2024-01-01'::timestamp with time zone,
 NULL);

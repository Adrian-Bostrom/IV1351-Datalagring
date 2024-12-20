SELECT sibling_count, COUNT(*) AS num_siblings
FROM (
    SELECT COUNT(*) AS sibling_count
    FROM student
    WHERE sibling_id IS NOT NULL
    GROUP BY sibling_id

    UNION ALL

    SELECT 0 AS sibling_count
    FROM student
    WHERE sibling_id IS NULL
) AS sibling_groups
GROUP BY sibling_count
ORDER BY sibling_count DESC;
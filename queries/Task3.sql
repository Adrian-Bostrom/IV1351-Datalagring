WITH teaching_count AS (
    SELECT
        DATE_TRUNC('month', date) AS month,
        person_id AS teacher_id,
        COUNT(*) AS teacher_count
    FROM
        public.lesson
    GROUP BY
        month,
        teacher_id
)
SELECT
    t.teacher_id,
    p.first_name,
    p.last_name,
    t.teacher_count as No_Of_Lessons
FROM
    teaching_count t
JOIN
    person p ON p.person_id = t.teacher_id
WHERE
    EXTRACT(MONTH FROM t.month) = EXTRACT(MONTH FROM CURRENT_DATE)
    AND EXTRACT(YEAR FROM t.month) = EXTRACT(YEAR FROM CURRENT_DATE)
    AND t.teacher_count > 0;
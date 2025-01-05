WITH individual_count AS (
    SELECT
        DATE_TRUNC('month', date) AS month,
        COUNT(*) AS individual_count
    FROM
        public.lesson
    RIGHT JOIN
        public.individual_lesson
    ON
        public.lesson.lesson_id = public.individual_lesson.lesson_id
    GROUP BY
        month
    ORDER BY
        month
),
ensemble_count AS (
    SELECT
        DATE_TRUNC('month', date) AS month,
        COUNT(*) AS ensemble_count
    FROM
        public.lesson
    RIGHT JOIN
        public.ensemble
    ON
        public.lesson.lesson_id = public.ensemble.lesson_id
    GROUP BY
        month
    ORDER BY
        month
),
group_count AS (
    SELECT
        DATE_TRUNC('month', date) AS month,
        COUNT(*) AS group_count
    FROM
        public.lesson
    RIGHT JOIN
        public.group_lesson
    ON
        public.lesson.lesson_id = public.group_lesson.lesson_id
    GROUP BY
        month
    ORDER BY
        month
)
SELECT
    to_char(COALESCE(i.month, e.month, g.month), 'Month') AS month,
    (COALESCE(i.individual_count, 0) + COALESCE(e.ensemble_count, 0) + COALESCE(g.group_count, 0)) AS Total,
    COALESCE(i.individual_count, 0) AS individual_count,
    COALESCE(e.ensemble_count, 0) AS ensemble_count,
    COALESCE(g.group_count, 0) AS group_count
FROM
    individual_count i
FULL OUTER JOIN
    ensemble_count e ON i.month = e.month
FULL OUTER JOIN
    group_count g ON COALESCE(i.month, e.month) = g.month
WHERE
    EXTRACT(YEAR FROM COALESCE(i.month, e.month, g.month)) = EXTRACT(YEAR FROM CURRENT_DATE);

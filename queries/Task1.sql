
-- Create a temp table for individual lesson divided by count per month
CREATE TEMP TABLE individual_count_temp AS
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
    month;

-- Create a temp table for ensembles divided by count per month

CREATE TEMP TABLE ensemble_count_temp AS
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
    month;

-- Create a temp table for group lesson divided by count per month

CREATE TEMP TABLE group_count_temp AS
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
    month;


-- Join temp tables:

SELECT 
    to_char(COALESCE(
        individual_count_temp.month, 
        ensemble_count_temp.month, 
        group_count_temp.month
    ), 'Month') AS month,
    COALESCE(individual_count_temp.individual_count,0) AS individual_count,
    COALESCE(ensemble_count_temp.ensemble_count,0) AS ensemble_count,
    COALESCE(group_count_temp.group_count,0) AS group_count
FROM 
    individual_count_temp
FULL OUTER JOIN 
    ensemble_count_temp 
ON 
    individual_count_temp.month = ensemble_count_temp.month
FULL OUTER JOIN 
    group_count_temp 
ON 
    COALESCE(
        individual_count_temp.month, 
        ensemble_count_temp.month
    ) = group_count_temp.month 
WHERE 
    EXTRACT(
        YEAR FROM COALESCE(
            individual_count_temp.month, 
            ensemble_count_temp.month, 
            group_count_temp.month
        )
    ) = 2024;
    
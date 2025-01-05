CREATE TEMP TABLE teaching_count_temp AS
SELECT 
    DATE_TRUNC('month', date) AS month,
    person_id AS teacher_id,
    COUNT(*) AS teacher_count
FROM 
    public.lesson
GROUP BY 
    month, 
    teacher_id
ORDER BY 
    month;


SELECT 
    teacher_id,
    (SELECT 
        first_name
     FROM 
        person 
     WHERE 
        person.person_id = teacher_id
    ) AS first_name,
    (SELECT 
        last_name
     FROM 
        person 
     WHERE 
        person.person_id = teacher_id
    ) AS last_name,
    teacher_count as No_Of_Lessons
FROM 
    teaching_count_temp
WHERE 
    EXTRACT(MONTH FROM month) = EXTRACT(MONTH FROM CURRENT_DATE)
    AND EXTRACT(YEAR FROM month) = EXTRACT(YEAR FROM CURRENT_DATE)
    AND teacher_count > 0;
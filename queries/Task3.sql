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
        CONCAT(first_name, ' ', last_name) 
     FROM 
        person 
     WHERE 
        person.id = teacher_id
    ) AS teacher_name,
    teacher_count as No_Of_Lessons
FROM 
    teaching_count_temp
WHERE 
    EXTRACT(MONTH FROM month) = EXTRACT(MONTH FROM CURRENT_DATE)
    AND EXTRACT(YEAR FROM month) = EXTRACT(YEAR FROM CURRENT_DATE)
    AND teacher_count > 0;
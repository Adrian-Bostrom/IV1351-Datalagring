SELECT 
    TO_CHAR(lesson.date, 'Dy') AS Day,
    ensemble.genre,
    
    CASE
        WHEN (ensemble.max_num_students - 
              (SELECT COUNT(*) 
               FROM student_attending 
               WHERE student_attending.lesson_id = lesson.lesson_id)) = 0 THEN 'No Seats'
        WHEN (ensemble.max_num_students - 
              (SELECT COUNT(*) 
               FROM student_attending 
               WHERE student_attending.lesson_id = lesson.lesson_id)) IN (1, 2) THEN '1 or 2 Seats'
        ELSE 'Many Seats'
    END AS seat_status
FROM 
    ensemble
LEFT JOIN 
    lesson 
ON 
    ensemble.lesson_id = lesson.lesson_id
WHERE 
    EXTRACT(WEEK FROM lesson.date) = EXTRACT(WEEK FROM CURRENT_DATE) + 1;
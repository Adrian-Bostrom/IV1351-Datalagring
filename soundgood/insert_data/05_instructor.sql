INSERT INTO instructor (person_id, ensemble_proficiency)
SELECT id, true FROM person
WHERE person_number IN (
    '19741205-4947',  -- Launce Faro
    '19471226-6774',  -- Aileen Botright
    '19710320-3450'   -- Berty Corker
);

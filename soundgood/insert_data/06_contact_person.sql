INSERT INTO contact_person (person_id, relation) VALUES
((SELECT id FROM person WHERE first_name = 'Kurt' AND last_name = 'Lockett'), 'Parent'),
((SELECT id FROM person WHERE first_name = 'Galvin' AND last_name = 'Lanceter'), 'Parent'),
((SELECT id FROM person WHERE first_name = 'Raimondo' AND last_name = 'Bretland'), 'Parent'),
((SELECT id FROM person WHERE first_name = 'Jobyna' AND last_name = 'Fleeming'), 'Parent'),
((SELECT id FROM person WHERE first_name = 'Gustav' AND last_name = 'Mc Cahey'), 'Parent');

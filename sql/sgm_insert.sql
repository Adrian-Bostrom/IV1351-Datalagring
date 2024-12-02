-- Inserting data into contact_person
INSERT INTO public.contact_person (relation, first_name, last_name, phone, email)
VALUES 
('Father', 'John', 'Doe', '555-1234', 'john.doe@example.com'),
('Mother', 'Jane', 'Doe', '555-5678', 'jane.doe@example.com'),
('Brother', 'Michael', 'Doe', '555-2345', 'michael.doe@example.com'),
('Sister', 'Emily', 'Doe', '555-3456', 'emily.doe@example.com'),
('Uncle', 'Robert', 'Doe', '555-4567', 'robert.doe@example.com'),
('Aunt', 'Susan', 'Doe', '555-5678', 'susan.doe@example.com'),
('Cousin', 'James', 'Doe', '555-6789', 'james.doe@example.com'),
('Grandfather', 'William', 'Doe', '555-7890', 'william.doe@example.com'),
('Grandmother', 'Margaret', 'Doe', '555-8901', 'margaret.doe@example.com'),
('Nephew', 'Alex', 'Doe', '555-9012', 'alex.doe@example.com'),
('Niece', 'Sophia', 'Doe', '555-0123', 'sophia.doe@example.com'),
('Friend', 'Chris', 'Smith', '555-1234', 'chris.smith@example.com');
('Guardian', 'Mary', 'Smith', '555-8765', 'mary.smith@example.com');


-- Inserting data into person
INSERT INTO public.person (person_number, first_name, last_name, phone, email)
VALUES 
('P123456789', 'Alice', 'Johnson', '555-1111', 'alice.johnson@example.com'),
('P987654321', 'Bob', 'Williams', '555-2222', 'bob.williams@example.com'),
('P556677889', 'Diana', 'Prince', '555-4444', 'diana.prince@example.com'),
('P223344556', 'Eve', 'Davis', '555-5555', 'eve.davis@example.com'),
('P998877665', 'Frank', 'Miller', '555-6666', 'frank.miller@example.com'),
('P334455667', 'Grace', 'Hopper', '555-7777', 'grace.hopper@example.com'),
('P667788990', 'Hank', 'Hill', '555-8888', 'hank.hill@example.com'),
('P445566778', 'Ivy', 'Anderson', '555-9999', 'ivy.anderson@example.com'),
('P778899001', 'Jack', 'Smith', '555-0000', 'jack.smith@example.com'),
('P556677112', 'Karen', 'Taylor', '555-1212', 'karen.taylor@example.com'),
('P334455889', 'Leo', 'Carter', '555-3434', 'leo.carter@example.com');
('P112233445', 'Charlie', 'Brown', '555-3333', 'charlie.brown@example.com');


-- Inserting data into renting_instrument
INSERT INTO public.renting_instrument (stock, type, brand, rent_price)
VALUES 
(7, 'Flute', 'Yamaha', 100),
(6, 'Trumpet', 'Bach', 180),
(12, 'Drums', 'Pearl', 250),
(4, 'Saxophone', 'Selmer', 220),
(9, 'Clarinet', 'Buffet', 140),
(3, 'Viola', 'Cremona', 190),
(2, 'Harp', 'Lyon & Healy', 350),
(15, 'Guitar', 'Gibson', 160),
(10, 'Cello', 'Stentor', 210),
(8, 'Tuba', 'Miraphone', 280);


-- Inserting data into rental_record
INSERT INTO public.rental_record (rent_start, rent_end, instrument_id, person_id)
VALUES 
('2024-01-01', '2024-06-01', 1, 1),  -- Alice rents a Guitar
('2024-02-15', '2024-08-15', 2, 2),  -- Bob rents a Violin
('2024-04-01', '2024-09-01', 4, 1),  -- Diana rents Instrument ID 1
('2024-05-15', '2024-10-15', 5, 2),  -- Eve rents Instrument ID 2
('2024-06-01', '2024-11-01', 6, 3),  -- Frank rents Instrument ID 3
('2024-07-10', '2024-12-10', 7, 4),  -- Grace rents Instrument ID 4
('2024-08-20', '2025-01-20', 8, 5),  -- Hank rents Instrument ID 5
('2024-09-05', '2025-02-05', 9, 6),  -- Ivy rents Instrument ID 6
('2024-10-15', '2025-03-15', 10, 7), -- Jack rents Instrument ID 7
('2024-11-01', '2025-04-01', 1, 8),  -- Alice rents Instrument ID 8
('2024-12-01', '2025-05-01', 2, 9),  -- Bob rents Instrument ID 9
('2025-01-01', '2025-06-01', 3, 10); -- Charlie rents Instrument ID 10
('2024-03-01', '2024-07-01', 3, 3);  -- Charlie rents a Piano


-- Inserting data into pricing_scheme
INSERT INTO public.pricing_scheme (price, change_date)
VALUES 
(50.0, '2024-01-01'),
(75.0, '2024-03-01'),
(100.0, '2024-05-01');


-- Inserting data into lesson
INSERT INTO public.lesson (time, date, price_id, person_id)
VALUES 
('10:00:00', '2024-06-01', 1, 1),  -- Alice teaches a lesson
('14:00:00', '2024-06-05', 2, 2),  -- Bob teaches a lesson
('16:00:00', '2024-06-10', 3, 3);  -- Charlie teaches a lesson


-- Inserting data into group_lesson
INSERT INTO public.group_lesson (lesson_id, min_enrollments, max_places, lesson_level, instrument)
VALUES 
(1, 5, 15, 1, 'Guitar'),
(2, 4, 12, 2, 'Violin');


-- Inserting data into individual_lesson
INSERT INTO public.individual_lesson (lesson_id, lesson_level, instrument)
VALUES 
(3, 3, 'Piano');


-- Inserting data into ensemble
INSERT INTO public.ensemble (lesson_id, genre, min_num_students, max_num_students)
VALUES 
(1, 'Rock', 3, 10),
(2, 'Classical', 2, 8);


-- Inserting data into instructor
INSERT INTO public.instructor (person_id, ensamble_proficiency)
VALUES 
(1, TRUE),  -- Alice is an instructor with ensemble proficiency
(2, FALSE), -- Bob is an instructor without ensemble proficiency
(3, TRUE);  -- Charlie is an instructor with ensemble proficiency


-- Inserting data into instructor_instruments
INSERT INTO public.instructor_instruments (person_id, instrument)
VALUES 
(1, 'Guitar'),
(2, 'Violin'),
(3, 'Piano');


-- Inserting data into student
INSERT INTO public.student (sibling_id, contact_id)
VALUES 
(NULL, 1),  -- Alice’s contact person is John Doe (Father)
(NULL, 2),  -- Bob’s contact person is Jane Doe (Mother)
(NULL, 3);  -- Charlie’s contact person is Mary Smith (Guardian)

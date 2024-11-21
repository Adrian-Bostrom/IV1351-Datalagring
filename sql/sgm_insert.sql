--
-- PostgreSQL database dump
--

-- Dumped from database version 13.0 (Debian 13.0-1.pgdg100+1)
-- Dumped by pg_dump version 13.0 (Debian 13.0-1.pgdg100+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: akas; Type: TABLE; Schema: public; Owner: postgres
--

--WITH person_id AS
--(INSERT INTO public.person(person_number, first_name, last_name, phone, email)
--VALUES ('192322059135', 'Goran', 'Persson', '0723682068', 'goran.persson@gmail.com')
--RETURNING id)
--INSERT INTO public.instructor (person_id, ensamble_proficiency) VALUES (false);


-- Inserting data into contact_person
INSERT INTO public.contact_person (relation, first_name, last_name, phone, email)
VALUES 
('Father', 'John', 'Doe', '555-1234', 'john.doe@example.com'),
('Mother', 'Jane', 'Doe', '555-5678', 'jane.doe@example.com'),
('Guardian', 'Mary', 'Smith', '555-8765', 'mary.smith@example.com');


-- Inserting data into person
INSERT INTO public.person (person_number, first_name, last_name, phone, email)
VALUES 
('P123456789', 'Alice', 'Johnson', '555-1111', 'alice.johnson@example.com'),
('P987654321', 'Bob', 'Williams', '555-2222', 'bob.williams@example.com'),
('P112233445', 'Charlie', 'Brown', '555-3333', 'charlie.brown@example.com');


-- Inserting data into renting_instrument
INSERT INTO public.renting_instrument (stock, type, brand, rent_price)
VALUES 
(10, 'Guitar', 'Fender', 150),
(5, 'Violin', 'Yamaha', 200),
(8, 'Piano', 'Steinway', 300);


-- Inserting data into rental_record
INSERT INTO public.rental_record (rent_start, rent_end, instrument_id, person_id)
VALUES 
('2024-01-01', '2024-06-01', 1, 1),  -- Alice rents a Guitar
('2024-02-15', '2024-08-15', 2, 2),  -- Bob rents a Violin
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

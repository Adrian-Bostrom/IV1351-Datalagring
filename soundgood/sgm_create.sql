SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

-- Create schema
DROP SCHEMA IF EXISTS public CASCADE;
CREATE SCHEMA IF NOT EXISTS public;

SET search_path TO public;

-- Create ENUM types
CREATE TYPE skill_level_enum AS ENUM ('Beginner', 'Intermediate', 'Advanced');
CREATE TYPE status_enum AS ENUM ('Booked', 'Available');
CREATE TYPE lesson_type_enum AS ENUM ('Individual', 'Group', 'Ensemble');

-- Person table - This is our base table for both students and instructors
CREATE TABLE person (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    person_number VARCHAR(13) NOT NULL UNIQUE,
    first_name VARCHAR(500) NOT NULL,
    last_name VARCHAR(500) NOT NULL,
    phone VARCHAR(500) NOT NULL,
    email VARCHAR(500) NOT NULL,
    zip VARCHAR(500) NOT NULL,
    city VARCHAR(500) NOT NULL,
    street VARCHAR(500) NOT NULL
);

-- Contact person table - Stores information about student guardians/contacts
CREATE TABLE contact_person (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    relation VARCHAR(500) NOT NULL,
    person_id INT NOT NULL,
    FOREIGN KEY (person_id) REFERENCES person(id)
);

-- Skill level table - Defines the possible skill levels
CREATE TABLE skill_level (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    skill_level skill_level_enum NOT NULL
);

-- Genre table - Stores musical genres for ensembles
CREATE TABLE genre (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    genre VARCHAR(500) NOT NULL
);

-- Instrument table - Stores the school's instrument inventory
CREATE TABLE instrument (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    type VARCHAR(500) NOT NULL,
    brand VARCHAR(500) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL
);

-- Instructor table - Extends person
CREATE TABLE instructor (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    person_id INT NOT NULL,
    ensemble_proficiency BOOLEAN NOT NULL,
    FOREIGN KEY (person_id) REFERENCES person(id),
    UNIQUE (person_id)
);

-- Student table - Extends person
CREATE TABLE student (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    person_id INT NOT NULL,
    contact_person_id INT,
    skill_level_id INT NOT NULL,
    FOREIGN KEY (person_id) REFERENCES person(id),
    FOREIGN KEY (contact_person_id) REFERENCES contact_person(id),
    FOREIGN KEY (skill_level_id) REFERENCES skill_level(id),
    UNIQUE (person_id)
);

-- Sibling relationship table - Represents siblings among students
CREATE TABLE sibling_relationship (
    student_id1 INT NOT NULL,
    student_id2 INT NOT NULL,
    PRIMARY KEY (student_id1, student_id2),
    FOREIGN KEY (student_id1) REFERENCES student(id) ON DELETE CASCADE,
    FOREIGN KEY (student_id2) REFERENCES student(id) ON DELETE CASCADE,
    CONSTRAINT not_self_sibling CHECK (student_id1 < student_id2)
);

-- Instructor available time slots
CREATE TABLE instructor_available_time_slot (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    instructor_id INT NOT NULL,
    instrument_id INT,
    start_date TIMESTAMP WITH TIME ZONE NOT NULL,
    end_date TIMESTAMP WITH TIME ZONE NOT NULL,
    status status_enum NOT NULL DEFAULT 'Available',
    FOREIGN KEY (instructor_id) REFERENCES instructor(id) ON DELETE CASCADE,
    FOREIGN KEY (instrument_id) REFERENCES instrument(id)
);

-- Pricing scheme table - Handles historical pricing
CREATE TABLE pricing_scheme (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    lesson_type lesson_type_enum NOT NULL,
    skill_level_id INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    valid_from TIMESTAMP WITH TIME ZONE NOT NULL,
    valid_until TIMESTAMP WITH TIME ZONE,
    FOREIGN KEY (skill_level_id) REFERENCES skill_level(id),
    CHECK (valid_until IS NULL OR valid_until > valid_from)
);

-- Lesson table - Base table for all lesson types
CREATE TABLE lesson (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    instructor_id INT NOT NULL,
    pricing_scheme_id INT NOT NULL,
    FOREIGN KEY (instructor_id) REFERENCES instructor(id),
    FOREIGN KEY (pricing_scheme_id) REFERENCES pricing_scheme(id)
);

-- Group lesson specialization
CREATE TABLE group_lesson (
    lesson_id INT PRIMARY KEY,
    instrument_id INT NOT NULL,
    min_students INT NOT NULL,
    max_students INT NOT NULL,
    skill_level_id INT NOT NULL,
    FOREIGN KEY (lesson_id) REFERENCES lesson(id) ON DELETE CASCADE,
    FOREIGN KEY (instrument_id) REFERENCES instrument(id),
    FOREIGN KEY (skill_level_id) REFERENCES skill_level(id),
    CHECK (min_students > 0),
    CHECK (max_students >= min_students)
);

-- Individual lesson specialization
CREATE TABLE individual_lesson (
    lesson_id INT PRIMARY KEY,
    instrument_id INT NOT NULL,
    skill_level_id INT NOT NULL,
    FOREIGN KEY (lesson_id) REFERENCES lesson(id) ON DELETE CASCADE,
    FOREIGN KEY (instrument_id) REFERENCES instrument(id),
    FOREIGN KEY (skill_level_id) REFERENCES skill_level(id)
);

-- Ensemble specialization
CREATE TABLE ensemble (
    lesson_id INT PRIMARY KEY,
    genre_id INT NOT NULL,
    min_students INT NOT NULL,
    max_students INT NOT NULL,
    FOREIGN KEY (lesson_id) REFERENCES lesson(id) ON DELETE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES genre(id),
    CHECK (min_students > 0),
    CHECK (max_students >= min_students)
);

-- Booking connects lessons to time slots
CREATE TABLE booking (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    lesson_id INT NOT NULL,
    instructor_available_time_slot_id INT NOT NULL,
    FOREIGN KEY (lesson_id) REFERENCES lesson(id) ON DELETE CASCADE,
    FOREIGN KEY (instructor_available_time_slot_id)
        REFERENCES instructor_available_time_slot(id) ON DELETE CASCADE,
    UNIQUE (instructor_available_time_slot_id)
);

-- Student lesson enrollments
CREATE TABLE enrollment (
    student_id INT NOT NULL,
    lesson_id INT NOT NULL,
    PRIMARY KEY (student_id, lesson_id),
    FOREIGN KEY (student_id) REFERENCES student(id) ON DELETE CASCADE,
    FOREIGN KEY (lesson_id) REFERENCES lesson(id) ON DELETE CASCADE
);

-- Instrument leases
CREATE TABLE lease (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    student_id INT NOT NULL,
    instrument_id INT NOT NULL,
    start_date TIMESTAMP WITH TIME ZONE NOT NULL,
    end_date TIMESTAMP WITH TIME ZONE NOT NULL,
    FOREIGN KEY (student_id) REFERENCES student(id),
    FOREIGN KEY (instrument_id) REFERENCES instrument(id),
    CHECK (end_date > start_date)
);

-- Create trigger for maximum 2 active leases per student
CREATE OR REPLACE FUNCTION check_max_leases()
RETURNS TRIGGER AS $$
BEGIN
    IF (
        SELECT COUNT(*)
        FROM lease
        WHERE student_id = NEW.student_id
        AND end_date > CURRENT_TIMESTAMP
    ) >= 2 THEN
        RAISE EXCEPTION 'Students cannot have more than 2 active instrument leases';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER enforce_max_leases
    BEFORE INSERT OR UPDATE ON lease
    FOR EACH ROW
    EXECUTE FUNCTION check_max_leases();

-- Function to check minimum students
CREATE OR REPLACE FUNCTION check_group_lesson_minimum()
RETURNS TRIGGER AS $$
BEGIN
    -- Count current enrollments for this lesson
    IF EXISTS (
        SELECT 1
        FROM group_lesson gl
        WHERE gl.lesson_id = NEW.lesson_id
        AND (
            SELECT COUNT(*)
            FROM enrollment e
            WHERE e.lesson_id = NEW.lesson_id
        ) < gl.min_students
    ) THEN
        RAISE EXCEPTION 'Not enough students enrolled. Minimum requirement not met.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger to check when booking a group lesson
CREATE TRIGGER enforce_group_lesson_minimum
    BEFORE INSERT OR UPDATE ON booking
    FOR EACH ROW
    EXECUTE FUNCTION check_group_lesson_minimum();

-- Create indexes for frequently accessed columns
CREATE INDEX idx_person_number ON person(person_number);
CREATE INDEX idx_lease_dates ON lease(start_date, end_date);
CREATE INDEX idx_time_slot_dates ON instructor_available_time_slot(start_date, end_date);
CREATE INDEX idx_pricing_dates ON pricing_scheme(valid_from, valid_until);

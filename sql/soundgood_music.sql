CREATE TABLE public.contact_person (
    contact_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    relation varchar(500) NOT NULL,
    first_name varchar(500) NOT NULL,
    last_name varchar(500) NOT NULL,
    phone varchar(500) NOT NULL,
    email varchar(500) NOT NULL
);

CREATE TABLE public.student (
    student_id INT PRIMARY KEY,
    sibling_id INT,
    contact_id INT --references contact_person(contact_id) --FK
);

CREATE TABLE public.student_attending (
    student_id INT,
    lesson_id INT
);

CREATE TABLE public.instructor (
    instructor_id INT PRIMARY KEY,
    ensamble_proficiency BOOLEAN NOT NULL
);

CREATE TABLE public.instructor_instruments (
    instrument_instructable_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    person_id INT, -- NOT NULL references person(id), --FK
    instrument varchar(500) NOT NULL
);

CREATE TABLE public.person (
    person_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    person_number varchar(12) NOT NULL,
    first_name varchar(500) NOT NULL,
    last_name varchar(500) NOT NULL,
    phone varchar(500) NOT NULL,
    email varchar(500) NOT NULL,
    address_id INT NOT NULL
);

CREATE TABLE public.address (
    address_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    zip varchar(500) NOT NULL,
    city varchar(500) NOT NULL,
    street varchar(500) NOT NULL
);

CREATE TABLE public.renting_instrument (
    instrument_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    stock INT NOT NULL,
    type varchar(500) NOT NULL,
    brand varchar(500) NOT NULL,
    rent_price INT NOT NULL
);

CREATE TABLE public.rental_record (
    rent_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    rent_start DATE NOT NULL,
    rent_end DATE,
    instrument_id INT, --references renting_instrument(instrument_id) NOT NULL, --FK
    person_id INT --references person(id) NOT NULL --FK
);

CREATE TABLE public.lesson (
    lesson_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    time TIME(6) NOT NULL,
    date DATE NOT NULL,
    price_id INT NOT NULL, --FK
    person_id INT NOT NULL --FK
);

CREATE TABLE public.group_lesson (
    lesson_id INT PRIMARY KEY, --FK (inherited?)
    min_enrollments INT NOT NULL,
    max_places INT NOT NULL,
    lesson_level INT NOT NULL,
    instrument varchar(500)
);

CREATE TABLE public.individual_lesson (
    lesson_id INT PRIMARY KEY, --FK (inherited?)
    lesson_level INT NOT NULL,
    instrument varchar(500)
);

CREATE TABLE public.ensemble (
    lesson_id INT PRIMARY KEY, --FK (inherited?)
    genre varchar(500) NOT NULL,
    min_num_students INT NOT NULL,
    max_num_students INT NOT NULL
);

CREATE TABLE public.pricing_scheme (
    price_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    price decimal(10,2) NOT NULL,
    change_date DATE NOT NULL,
    lesson_level INT NOT NULL,
    lesson_type VARCHAR(500) NOT NULL
);


ALTER TABLE public.student
ADD CONSTRAINT contact_id
FOREIGN KEY (contact_id)
REFERENCES public.contact_person(contact_id);

ALTER TABLE public.student
ADD CONSTRAINT student_id
FOREIGN KEY (student_id)
REFERENCES public.person(person_id);

ALTER TABLE public.instructor_instruments
ADD CONSTRAINT person_id
FOREIGN KEY (person_id)
REFERENCES public.person(person_id);

ALTER TABLE public.rental_record
ADD CONSTRAINT instrument_id
FOREIGN KEY (instrument_id)
REFERENCES public.renting_instrument(instrument_id);

ALTER TABLE public.rental_record
ADD CONSTRAINT person_id
FOREIGN KEY (person_id)
REFERENCES public.person(person_id);

ALTER TABLE public.instructor
ADD CONSTRAINT instructor_id
FOREIGN KEY (instructor_id)
REFERENCES public.person(person_id);

ALTER TABLE public.lesson
ADD CONSTRAINT person_id
FOREIGN KEY (person_id)
REFERENCES public.person(person_id);

ALTER TABLE public.lesson
ADD CONSTRAINT price_id
FOREIGN KEY (price_id)
REFERENCES public.pricing_scheme(price_id);

ALTER TABLE public.group_lesson
ADD CONSTRAINT lesson_id
FOREIGN KEY (lesson_id)
REFERENCES public.lesson(lesson_id);

ALTER TABLE public.individual_lesson
ADD CONSTRAINT lesson_id
FOREIGN KEY (lesson_id)
REFERENCES public.lesson(lesson_id);

ALTER TABLE public.ensemble
ADD CONSTRAINT lesson_id
FOREIGN KEY (lesson_id)
REFERENCES public.lesson(lesson_id);

ALTER TABLE public.student_attending
ADD CONSTRAINT student_id
FOREIGN KEY (student_id)
REFERENCES public.student(student_id);

ALTER TABLE public.student_attending
ADD CONSTRAINT lesson_id
FOREIGN KEY (lesson_id)
REFERENCES public.lesson(lesson_id);

ALTER TABLE public.person
ADD CONSTRAINT address_id
FOREIGN KEY (address_id)
REFERENCES public.address(address_id);

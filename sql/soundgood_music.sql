CREATE TABLE public.contact_person (
    contact_id serial PRIMARY KEY,
    relation varchar(50) NOT NULL,
    first_name varchar(50) NOT NULL,
    last_name varchar(50) NOT NULL,
    phone varchar(50) NOT NULL,
    email varchar(50) NOT NULL
);

CREATE TABLE public.student (
    student_id serial PRIMARY KEY,
    sibling_id INT,
    contact_id INT --references contact_person(contact_id) --FK
);

CREATE TABLE public.student_attending (
    student_id serial,
    lesson_id serial,
);

CREATE TABLE public.instructor (
    person_id serial PRIMARY KEY,
    ensamble_proficiency BOOLEAN NOT NULL
);

CREATE TABLE public.instructor_instruments (
    instrument_instructable_id serial PRIMARY KEY,
    person_id INT, -- NOT NULL references person(id), --FK
    instrument varchar(30) NOT NULL
);

CREATE TABLE public.person (
    id serial PRIMARY KEY,
    person_number varchar(12) NOT NULL,
    first_name varchar(50) NOT NULL,
    last_name varchar(50) NOT NULL,
    phone varchar(20) NOT NULL,
    email varchar(50) NOT NULL
);

CREATE TABLE public.address (
    address_id serial PRIMARY KEY,
    zip INT NOT NULL,
    city varchar(100) NOT NULL,
    street varchar(100) NOT NULL
);

CREATE TABLE public.renting_instrument (
    instrument_id serial PRIMARY KEY,
    stock INT NOT NULL,
    type varchar(20) NOT NULL,
    brand varchar(30) NOT NULL,
    rent_price INT NOT NULL
);

CREATE TABLE public.rental_record (
    rent_id serial PRIMARY KEY,
    rent_start DATE NOT NULL,
    rent_end DATE,
    instrument_id INT, --references renting_instrument(instrument_id) NOT NULL, --FK
    person_id INT --references person(id) NOT NULL --FK
);

CREATE TABLE public.lesson (
    lesson_id serial PRIMARY KEY,
    time TIME(6) NOT NULL,
    date DATE NOT NULL,
    price_id INT NOT NULL, --FK
    person_id INT NOT NULL --FK
);

CREATE TABLE public.group_lesson (
    lesson_id serial PRIMARY KEY, --FK (inherited?)
    min_enrollments INT NOT NULL,
    max_places INT NOT NULL,
    lesson_level INT NOT NULL,
    instrument varchar(30)
);

CREATE TABLE public.individual_lesson (
    lesson_id serial PRIMARY KEY, --FK (inherited?)
    lesson_level INT NOT NULL,
    instrument varchar(30)
);

CREATE TABLE public.ensemble (
    lesson_id serial PRIMARY KEY, --FK (inherited?)
    genre varchar(10) NOT NULL,
    min_num_students INT NOT NULL,
    max_num_students INT NOT NULL
);

CREATE TABLE public.pricing_scheme (
    price_id serial PRIMARY KEY,
    price float(10) NOT NULL,
    change_date DATE NOT NULL
);


ALTER TABLE public.student
ADD CONSTRAINT contact_id
FOREIGN KEY (contact_id)
REFERENCES public.contact_person(contact_id);

ALTER TABLE public.student
ADD CONSTRAINT student_id
FOREIGN KEY (student_id)
REFERENCES public.person(id);

ALTER TABLE public.instructor_instruments
ADD CONSTRAINT person_id
FOREIGN KEY (person_id)
REFERENCES public.person(id);

ALTER TABLE public.rental_record
ADD CONSTRAINT instrument_id
FOREIGN KEY (instrument_id)
REFERENCES public.renting_instrument(instrument_id);

ALTER TABLE public.rental_record
ADD CONSTRAINT person_id
FOREIGN KEY (person_id)
REFERENCES public.person(id);

ALTER TABLE public.instructor
ADD CONSTRAINT person_id
FOREIGN KEY (person_id)
REFERENCES public.person(id);

ALTER TABLE public.lesson
ADD CONSTRAINT person_id
FOREIGN KEY (person_id)
REFERENCES public.person(id);

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
REFERENCES public.lesson(student_id);

ALTER TABLE public.student_attending
ADD CONSTRAINT lesson_id
FOREIGN KEY (lesson_id)
REFERENCES public.lesson(lesson_id);
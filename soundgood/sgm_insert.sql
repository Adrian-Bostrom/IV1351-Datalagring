-- run_all.sql
\echo 'Starting data insertion...'

\echo 'Inserting skill levels...'
\i insert_data/01_skill_level.sql

\echo 'Inserting genres...'
\i insert_data/02_genre.sql

\echo 'Inserting instruments...'
\i insert_data/03_instrument.sql

\echo 'Inserting persons...'
\i insert_data/04_person.sql

\echo 'Inserting instructors...'
\i insert_data/05_instructor.sql

\echo 'Inserting contact persons...'
\i insert_data/06_contact_person.sql

\echo 'Inserting students...'
\i insert_data/07_student.sql

\echo 'Inserting sibling relationships...'
\i insert_data/08_sibling_relationship.sql

\echo 'Inserting pricing schemes...'
\i insert_data/09_pricing_scheme.sql

\echo 'Inserting instructor available time slots...'
\i insert_data/10_instructor_available_time_slot.sql

\echo 'Inserting lessons...'
\i insert_data/11_lesson.sql

\echo 'Inserting group lessons...'
\i insert_data/12_group_lesson.sql

\echo 'Inserting individual lessons...'
\i insert_data/13_individual_lesson.sql

\echo 'Inserting ensembles...'
\i insert_data/14_ensemble.sql

\echo 'Inserting enrollments...'
\i insert_data/15_enrollments.sql

\echo 'Inserting bookings...'
\i insert_data/16_booking.sql


\echo 'Inserting leases...'
\i insert_data/17_lease.sql

\echo 'All data inserted successfully!'

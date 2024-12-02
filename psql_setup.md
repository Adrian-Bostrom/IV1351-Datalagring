<i>ubuntu 24.04 btw</i>
# Do the download:

https://www.postgresql.org/download/

# Switch to the postgres account

	sudo -u postgres -i

# Remove authentication for postgres

edit: /etc/postgresql/<VERSION>/main/pg_hba.conf

	local   all             postgres                                peer
	# changed into
	local   all             postgres                                trust

# Switch to postgres

	psql -U postgres

# Extract data

Download the imdb_dump.sql.zip
Extract to a known folder
(if you experience priv issues move
.sql to /var/lib/postgresql/)
This will "execute" sql "scripts"
to insert or create a database.

	\i <PATH_TO_.SQL_FILE>

# Create and switch to database

	CREATE DATABASE imdb;
	\c imdb

# Good things to know

List tables

	SELECT * FROM information_schema.table;

Clear the public schema

	DROP SCHEMA public CASCADE;

Create the public schema again

	CREATE SCHEMA public;

# Go ham!

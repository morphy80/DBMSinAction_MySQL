/* Show the list of all databases in MySQL */
show databases;
/*
Tell MySQL that we want to run
our queries against the `Chinook` database
*/
use Chinook;

/* Show all of the tables in the current database */
show tables;

/* Get a description of the `Genre` table */
desc Genre;

/* Log the commands used to a text file called `file.txt` */
tee file.txt

/* Turn off the `tee` loggin feature */
notee

/* Execute queries from an SQL file called `test.sql` */
source test.sql
/* Execute a `select` query */
select * from Album limit 5;

/* Execute a table join */
select Title, Name from Album
join Artist on Album.ArtistId = Artist.ArtistId
limit 5;

/* Execute an insert */
insert into Genre (Name) values ('Trad');

/* Show the last insert performed */
SELECT LAST_INSERT_ID();

/* Filter data using `where` */
select * from Genre where GenreId = 26;

/* Update a record */
update Genre set Name = 'Traditional' where Name = 'Trad';

/* Execute another select query */
select * from Genre;

/* Execute a delete query */
delete from Genre where Name = 'Traditional';

/* Try to select the record that was just deleted */
select * from Genre where Name = 'Traditional';
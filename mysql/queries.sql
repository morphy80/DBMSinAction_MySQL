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

/*
Select the name column for each of the records in
the `Artist` table
*/
select Name from Artist;

/*
Select the `FirstName` and `LastName` for each of the
records in the `Customer` table
*/
select FirstName, LastName from Customer;

/*
Select all of the columns for every record in the `Track`
table
*/
select * from Track;

/*
Select all of the names from the `MediaType` table
*/
select Name from MediaType;

/*
Select all `Track` records where the `Composer` is `U2`
*/
select * from Track
where Composer = 'U2';

/*
Select all `Album` records where the `AlbumId` is 232;
*/
select * from Album
where AlbumId = 232;
  
/*
Select the `FirstName`, `LastName` and `Title` for every
`Employee` that has a `Title` of "IT Staff"
*/
select FirstName, LastName, Title from Employee
where Title = 'IT Staff';

/*
Select all of the data for every `Track` record across 
both the `Track` and `Album` tables
*/
select * from Track
INNER JOIN Album on Track.AlbumId = Album.AlbumId;

/*
Select the Track's Name, the Album's Title and the Artist's ArtistId for every
`Track` record across both the `Track` and `Album` tables
*/
select Name, Title, ArtistId from Track
INNER JOIN Album on Track.AlbumId = Album.AlbumId;

/*
Use MySQL's aliases to display friendlier column names
*/
select Name as Track, Title as Album, ArtistId from Track
INNER JOIN Album on Track.AlbumId = Album.AlbumId;

/*
Instead of just getting the Artist's ID, we'll do an additional join
to get the Artist's name from the `Artist` table
*/
SELECT Track.Name as Track, Title as Album, Album.ArtistId, Artist.Name as Artist from Track
INNER JOIN Album on Track.AlbumId = Album.AlbumId
INNER JOIN Artist on Album.ArtistId = Artist.ArtistId;

/*
Show all of the Track names, album titles and artist name where the artist's name
is "U2"
*/
SELECT Track.Name as Track, Title as Album, Artist.Name as Artist FROM Track
INNER JOIN Album on Track.AlbumId = Album.AlbumId
INNER JOIN Artist on Album.ArtistId = Artist.ArtistId
WHERE Artist.Name = "U2";

/*
Show all of the Track names, album titles and artist name where the artist's name
is "U2" and the name of the track is "Pride (In The Name Of Love)"
*/
SELECT Track.Name as Track, Title as Album, Artist.Name as Artist FROM Track
INNER JOIN Album on Track.AlbumId = Album.AlbumId
INNER JOIN Artist on Album.ArtistId = Artist.ArtistId
WHERE Artist.Name = "U2" AND Track.Name = "Pride (In The Name Of Love)";

/*
Show all of the track names, album titles, and artist names where the track name
is "Believe"
*/
SELECT Track.Name as Track, Title as Album, Artist.Name as Artist FROM Track
INNER JOIN Album on Track.AlbumId = Album.AlbumId
INNER JOIN Artist on Album.ArtistId = Artist.ArtistId
WHERE Track.Name = "Believe";

/*
Select every track name and the track's associated media type
*/
SELECT Track.Name, MediaType.Name FROM Track 
INNER JOIN MediaType on Track.MediaTypeId = MediaType.MediaTypeId;

/*
Select every track name and the track's associated genre, where the
name of the genre is "Jazz"
*/
SELECT Track.Name, Genre.Name FROM Track
INNER JOIN Genre on Track.GenreId = Genre.GenreId
WHERE Genre.Name = 'Jazz';

/*
Select every track name and the track's associated media type
and genre, where the name of the media type is 
"Protected AAC audio file" and the genre is "Soundtrack"
*/
SELECT Track.Name, MediaType.Name, Genre.Name FROM Track
INNER JOIN MediaType on Track.MediaTypeId = MediaType.MediaTypeId
INNER JOIN Genre on Track.GenreId = Genre.GenreId
WHERE MediaType.Name = 'Protected AAC audio file' AND Genre.Name = 'Soundtrack';

/*
Filter to only show results for the 'Grunge' playlist
*/
SELECT Playlist.Name as Playlist, Track.Name as Track, Album.Title as Album, Artist.Name as Artist FROM Playlist
INNER JOIN PlaylistTrack on Playlist.PlaylistId = PlaylistTrack.PlaylistId
JOIN Track on PlaylistTrack.TrackId = Track.TrackId
JOIN Album on Track.AlbumId = Album.AlbumId
JOIN Artist on Album.ArtistId = Artist.ArtistId
WHERE Playlist.Name = 'Grunge';

/*Find a playlist that contains only 1 track*/
SELECT Playlist.Name as Playlist, COUNT(*) From Playlist INNER JOIN PlaylistTrack on Playlist.PlaylistId = PlaylistTrack.PlaylistId  GROUP BY Playlist HAVING count(*) = 1;

/*
Order all of the `Album` records by the `Title` field in 
ascending order
*/
SELECT * FROM Album ORDER BY Title;

/*
Order all of the `Album` records by the `Title` field in
descending order
*/
SELECT * FROM Album ORDER BY Title DESC;

/*
Order all of the `Album` records by the `ArtistId` field in 
ascending order, and within that, order by `Title`
*/
SELECT * FROM Album ORDER BY ArtistId, Title;

/*
Select the Track name and the Album title and order them
by the Album title, and then by the track name
*/
SELECT Track.Name, Album.Title FROM Track
INNER JOIN Album on Track.AlbumId = Album.AlbumId
ORDER BY Album.Title, Track.Name;

/*
Select the `InvoiceDate`, `BillingCity` and `Total` from the
`Invoice` table. Order them descendingly and limit the results
to 5
*/
SELECT InvoiceDate, BillingCity, Total FROM Invoice
ORDER BY Total DESC
LIMIT 5;

/*
Select the `InvoiceDate`, `BillingAddress` and `Total` from the
`Invoice` table. Order them descendingly according to the `InvoiceDate`
*/
SELECT InvoiceDate, BillingAddress, Total FROM Invoice ORDER BY InvoiceDate DESC;

/*
Select the EmployeeId, LastName, FirstName and HireDate of the 3 Employees with the most recent HireDate
*/
SELECT EmployeeId, LastName, FirstName, HireDate FROM Employee
ORDER BY HireDate DESC, EmployeeId DESC
LIMIT 3;

/*a query that shows our 10 biggest invoices by `Total value`, in descending order
If two invoices have the same Total, the more recent should appear first.
The query should also show the `Name` of the Customer
*/
SELECT 
    concat(Customer.FirstName, " ", Customer.LastName) as Name,
    Invoice.InvoiceDate as Date,
    Invoice.Total
FROM Invoice
INNER JOIN Customer ON Invoice.CustomerId = Customer.CustomerId
ORDER BY Total DESC, Date DESC
LIMIT 10;

/*
Get a count of all of the records in the `Customer` table
*/
SELECT COUNT(*) FROM Customer;

/*
Get a count of all of the records in the `Customer` table
*/
SELECT COUNT(FirstName) FROM Customer;

/*
Get a count of all of the records in the `Customer` table
where the customer's `FirstName` is "Frank"
*/
SELECT COUNT(*) FROM Customer WHERE FirstName = 'Frank';

/*How Many Customers is Employee 4 the Sales Support Agent For?*/
SELECT COUNT(FirstName) FROM Customer WHERE SupportRepId = 4;

/*How Many Customers is Jane Peacock the Sales Support Agent For?*/
SELECT Employee.FirstName AS Employee, COUNT(Customer.FirstName) AS Customer FROM Employee
JOIN Customer ON Customer.SupportRepId = Employee.EmployeeId
WHERE Employee.FirstName = 'Jane';

/*The min funtion looks at all of the values in a specified column 
and returns the minimum*/
SELECT MIN(LastName) FROM Customer;

/*What is the date of birth of our oldest employee?*/
SELECT MIN(BirthDate) FROM Employee;

/*The max funtion looks at all of the values in a specified column 
and returns the maximum*/
SELECT MAX(LastName) FROM Customer;

/*On what date was our most recent employee hired?*/
SELECT MAX(HireDate) FROM Employee;

/*The Average function*/
SELECT AVG(Total) FROM Invoice;

/*The Round function*/
SELECT ROUND(AVG(Total), 2) FROM Invoice;

/*The Sum function*/
SELECT TOTAL FROM Invoice WHERE InvoiceId = 2;

/*Here's what we get by taking the line items from that invoice, 
multiplying the price by quantity to get the total for each line item.*/
SELECT SUM(UnitPrice * Quantity) FROM InvoiceLine
WHERE InvoiceId = 2;

/*counting how many tracks use each of the five different media types.
 we will group by the AlbumID in the track table and show the number of rows in each group.*/
SELECT COUNT(*) FROM  Track
GROUP BY AlbumId;

/*we group by the AlbumID in the track table.
Show the number of rows in each group and the AlbumID for each.*/
SELECT AlbumId, COUNT(*) FROM Track
GROUP BY AlbumId;

/*show the album title for each.*/
SELECT Album.Title, COUNT(*) FROM Track
INNER JOIN Album ON Track.AlbumId = Album.AlbumId
GROUP BY Track.AlbumId;

/* shown the cheapest track on each album using the min aggregate function.*/
SELECT AlbumId, MIN(UnitPrice) FROM Track
GROUP BY AlbumId;

/*using the max function to find the most expensive track on each album.*/
SELECT AlbumId, MAX(UnitPrice) FROM Track
GROUP BY AlbumId;

/*the total cost of each album.*/
SELECT AlbumId, ROUND(SUM(UnitPrice), 2) FROM Track
GROUP BY AlbumId;

/* join the album table to include the title of the album.*/
SELECT Album.Title, ROUND(SUM(UnitPrice), 2) FROM Track
INNER JOIN Album ON Track.AlbumId = Album.AlbumId
GROUP BY Track.AlbumId;

/*How many customers do we have in the City of Berlin?*/
SELECT COUNT(city) FROM Customer WHERE city = "Berlin";

/*How much has been made in sales for the track "The Woman King"?*/
SELECT SUM(InvoiceLine.UnitPrice * InvoiceLine.Quantity), Track.Name AS Track FROM InvoiceLine
JOIN Track ON InvoiceLine.TrackId = Track.TrackId
WHERE Track.Name = "The Woman King";

/*Create a list of the top 5 acts by number of tracks. 
The table should include the name of the artist and the number of tracks they have.*/
SELECT Artist.Name AS Artist, COUNT(Track.TrackId) AS Track FROM Artist
JOIN Album ON Artist.ArtistId = Album.ArtistId
JOIN Track ON Album.AlbumId = Track.AlbumId
GROUP BY Artist.Name
ORDER BY COUNT(Artist.Name)
DESC LIMIT 5;

/*Create a dummy `MediaType`*/
INSERT INTO MediaType (Name)
VALUES ("Test Media 1");

/*Create a new `Album` record with a name of "Boy" and an
ArtistId of 150. This ArtistId is for U2*/
INSERT INTO Album (Title, ArtistId)
VALUES ("Boy", 150);

/*Get all of the relevant information that we need to enter all of
tracks for U2's "Boy" album*/
SELECT AlbumId FROM Album WHERE Title = "Boy";

SELECT MediaTypeId FROM MediaType WHERE Name = "Protected AAC audio file";

SELECT GenreId FROM Genre WHERE Name = "Rock";

/*Use the above information to create the new tracks*/
INSERT INTO Track (Name, AlbumId, MediaTypeId, GenreId, Composer, Milliseconds, Bytes, UnitPrice)
VALUES ("I Will Follow", 348, 2, 1, "U2", 220000, 1234, 0.99);
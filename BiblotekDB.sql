USE master
go

IF DB_ID('BiblotekDB') IS NOT NULL --Hvis DB Ikke eksisterer, lav db
BEGIN
ALTER DATABASE BiblotekDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE
DROP DATABASE BiblotekDB
END

CREATE DATABASE BiblotekDB
GO
USE BiblotekDB
GO

DROP TABLE IF EXISTS Authors --Hvis tables ikke eksisterer, lav alle tables.
CREATE TABLE Authors(
AuthorID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
AuthorName NVARCHAR(50)
)

DROP TABLE IF EXISTS Books
CREATE TABLE Books( --Books Table
BookID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
Title NVARCHAR(50),
Author_ID INT FOREIGN KEY REFERENCES Authors(AuthorID),
PublishYear INT,
Genre NVARCHAR(50),
Borrowed BIT
)

DROP TABLE IF EXISTS Borrowers
CREATE TABLE Borrowers( --Borrowers Table
BorrowerID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
BorrowerName NVARCHAR(50),
Email NVARCHAR(50),
Phone INT
)
-- Indsætter værdier
INSERT INTO Authors (AuthorName)VALUES('J.K Rowling')
INSERT INTO Authors (AuthorName)VALUES('David Brian')
INSERT INTO Authors (AuthorName)VALUES('Ernest Hemingway')
INSERT INTO Authors (AuthorName)VALUES('J.R.R Tolkien')
INSERT INTO Authors (AuthorName)VALUES('Mike Mignola')

INSERT INTO Books (Title, Author_ID, PublishYear, Genre, Borrowed)VALUES('Harry Potter and the Deathly Hallows', 1, 2007, 'Youth/Fantasy', 0)
INSERT INTO Books (Title, Author_ID, PublishYear, Genre, Borrowed)VALUES('The 7 Habits of Highly Effective People', 2, 1989, 'Self-help', 0)
INSERT INTO Books (Title, Author_ID, PublishYear, Genre, Borrowed)VALUES('The Sun Also Rises', 3, 1926, 'Romance/drama', 0)
INSERT INTO Books (Title, Author_ID, PublishYear, Genre, Borrowed)VALUES('The Hobbit', 4, 1937, 'Fantasy', 0)
INSERT INTO Books (Title, Author_ID, PublishYear, Genre, Borrowed)VALUES('Hellboy Omnibus vol.1', 5, 1994, 'Fantasy/Comic', 0)

INSERT INTO Borrowers (BorrowerName, Email, Phone)
VALUES
('Hans','hans@hans.dk',12345675),
('Mads','mulle@hjhj.dk',12345674),
('John','Johnnycola@123.dk',12345673),
('Mille','mille@ans.dk',12345672),
('Janus','anus@h.dk',12345671)

GO

CREATE PROCEDURE ShowAllData AS
BEGIN
  SELECT * FROM Authors
  SELECT * FROM Books
  SELECT * FROM Borrowers

  SELECT COUNT(BookID) AS "Books in total" FROM Books

  SELECT Title AS "Book Title", Authors.AuthorID AS "Author ID", PublishYear AS "Published", Genre, Borrowed
  FROM Books
  INNER JOIN Authors ON Books.Author_ID = Authors.AuthorID
  GROUP BY Authors.AuthorID, Title, PublishYear, Genre, Borrowed;
END

GO
EXEC ShowAllData;
GO

---- Book en bog
--DECLARE @BorrowerID INT
--DECLARE @BookID INT

---- Indtast BorrowerID og BookID for at booke en bog
--SET @BorrowerID = 1 -- Skift værdien for BorrowerID til den ønskede BorrowerID
--SET @BookID = 1 -- Skift værdien for BookID til den ønskede BookID

--BEGIN TRANSACTION 
--    -- Opdater Borrowed status i Books tabellen
--    UPDATE Books SET Borrowed = 1 WHERE BookID = @BookID

--    -- Indsæt lån i BorrowersBooks tabellen
--    INSERT INTO BorrowersBooks (BorrowerID, BookID) VALUES (@BorrowerID, @BookID)

--    COMMIT -- Commit transaktionen
--    PRINT 'Bogen er blevet booket.'

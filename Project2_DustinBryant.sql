/************************************************************************************/
/*                                                                                  */
/*	Date		Programmer			Description										*/
/* --------- ---------------- ------------------------------------------------------*/
/* 10/9/20		Dustin Bryant	Intial implementation of the disk inventory db.		*/

--Create database
USE master;
DROP DATABASE IF EXISTS disk_inventoryDB;
GO
CREATE DATABASE disk_inventoryDB;
GO
USE disk_inventoryDB;

--Create User
IF SUSER_ID ('diskUserdb') IS NULL
	CREATE LOGIN diskUserdb WITH PASSWORD = 'Pa$$w0rd',
	DEFAULT_DATABASE = disk_inventoryDB;

DROP USER IF EXISTS diskUserdb;
CREATE USER diskUserdb;
ALTER ROLE db_datareader
	ADD MEMBER diskUserdb;

--Create tables
CREATE TABLE artisttype (
	artistTypeID	INT NOT NULL PRIMARY KEY IDENTITY,
	description		NVARCHAR(60) NOT NULL
);

CREATE TABLE itemtype (
	itemTypeID		INT NOT NULL PRIMARY KEY IDENTITY,
	description		NVARCHAR(60) NOT NULL
);

CREATE TABLE itemStatus (
	itemStatusID	INT NOT NULL PRIMARY KEY IDENTITY,
	description		NVARCHAR(60) NOT NULL
);

CREATE TABLE genre (
	genreID			INT NOT NULL PRIMARY KEY IDENTITY,
	description		NVARCHAR(60) NOT NULL
);

CREATE TABLE borrower (
	borrowerID		INT NOT NULL PRIMARY KEY IDENTITY,
	borrowerFName	NVARCHAR(60) NOT NULL,
	borrowerLName	NVARCHAR(60) NOT NULL,
	borrowerPhone	VARCHAR(15) NOT NULL
);

CREATE TABLE artist (
	artistID		INT NOT NULL PRIMARY KEY IDENTITY,
	artistFName		NVARCHAR(60) NOT NULL,
	artistLName		NVARCHAR(60) NOT NULL,
	artistTypeID	INT NOT NULL REFERENCES artistType(artistTypeID)
);

CREATE TABLE inventory (
	itemID			INT NOT NULL PRIMARY KEY IDENTITY,
	itemName		NVARCHAR(60) NOT NULL,
	releaseDate		DATE NOT NULL,
	genreID			INT NOT NULL REFERENCES genre(genreID),
	itemStatusID	INT NOT NULL REFERENCES itemstatus(itemStatusID),
	itemTypeID		INT NOT NULL REFERENCES itemtype(itemTypeID)
);

CREATE TABLE borrowedItem (
	borrowDate		DATETIME2 NOT NULL,
	returnDate		DATETIME2 NULL,
	borrowerID		INT NOT NULL REFERENCES borrower(borrowerID),
	itemID			INT NOT NULL REFERENCES inventory(itemID),
	PRIMARY KEY		(borrowerID, itemID)
);

CREATE TABLE artistitem (
	artistID		INT NOT NULL REFERENCES artist(artistID),
	itemID			INT NOT NULL REFERENCES inventory(itemID),
	PRIMARY KEY		(artistID, itemID)
);



CREATE DATABASE ENTV
GO
USE ENTV
GO

CREATE TABLE Staff(
	StaffID CHAR(5) PRIMARY KEY CHECK (StaffID LIKE 'ST[0-9][0-9][0-9]'),
	StaffName VARCHAR(100) NOT NULL,
	StaffEmail VARCHAR(50) NOT NULL,
	StaffGender VARCHAR(10) NOT NULL CHECK (StaffGender IN ('Male', 'Female')),
	StaffPhoneNumber VARCHAR(20) NOT NULL CHECK(StaffPhoneNumber LIKE '+62%'),
	StaffAddress VARCHAR(255) NOT NULL,
	StaffSalary INT NOT NULL,
	StaffDOB DATE NOT NULL CHECK(YEAR(StaffDOB) <= 2000)
)

CREATE TABLE Customer(
	CustomerID CHAR(5) PRIMARY KEY CHECK (CustomerID LIKE 'CU[0-9][0-9][0-9]'),
	CustomerName VARCHAR(100) NOT NULL,
	CustomerEmail VARCHAR(50) NOT NULL CHECK (CustomerEmail LIKE '%@yahoo.com' OR CustomerEmail LIKE '%gmail.com'),
	CustomerGender VARCHAR(10) NOT NULL CHECK (CustomerGender IN ('Male', 'Female')),
	CustomerPhoneNumber VARCHAR(20) NOT NULL CHECK (CustomerPhoneNumber LIKE '+62%'),
	CustomerAddress VARCHAR(255) NOT NULL,
	CustomerDOB DATE NOT NULL
)

CREATE TABLE Vendor(
	VendorID CHAR(5) PRIMARY KEY CHECK (VendorID LIKE 'VE[0-9][0-9][0-9]'),
	VendorName VARCHAR(100) NOT NULL CHECK (LEN(VendorName) > 3),
	VendorEmail VARCHAR(50) NOT NULL,
	VendorPhone VARCHAR(20) NOT NULL,
	VendorAddress VARCHAR(255) NOT NULL
)

CREATE TABLE TelevisionBrand(
	TelevisionBrandID CHAR(5) PRIMARY KEY CHECK (TelevisionBrandID LIKE 'TB[0-9][0-9][0-9]'),
	TelevisionBrandName VARCHAR(50) NOT NULL
)

CREATE TABLE Television(
	TelevisionID CHAR(5) PRIMARY KEY CHECK (TelevisionID LIKE 'TE[0-9][0-9][0-9]'),
	TelevisionBrandID CHAR(5) FOREIGN KEY REFERENCES TelevisionBrand(TelevisionBrandID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	TelevisionName VARCHAR(100) NOT NULL,
	TelevisionPrice INT NOT NULL CHECK(TelevisionPrice BETWEEN 1000000 AND 20000000)
)

CREATE TABLE PurchaseTransactionHeader(
	PurchaseTransactionID CHAR(5) PRIMARY KEY CHECK (PurchaseTransactionID LIKE 'PE[0-9][0-9][0-9]'),
	StaffID CHAR(5) FOREIGN KEY REFERENCES Staff(StaffID) NOT NULL,
	VendorID CHAR(5) FOREIGN KEY REFERENCES Vendor(VendorID) NOT NULL,
	TransactionDate DATE NOT NULL
)

CREATE TABLE PurchaseTransactionDetail(
	PurchaseTransactionID CHAR(5) FOREIGN KEY REFERENCES PurchaseTransactionHeader(PurchaseTransactionID) NOT NULL,
	TelevisionID CHAR(5) FOREIGN KEY REFERENCES Television (TelevisionID) NOT NULL,
	Quantity INT NOT NULL
)

CREATE TABLE SalesTransactionHeader (
	SalesTransactionID CHAR(5) PRIMARY KEY CHECK (SalesTransactionID LIKE 'SA[0-9][0-9][0-9]'),
	StaffID CHAR(5) FOREIGN KEY REFERENCES Staff(StaffID) NOT NULL,
	CustomerID CHAR(5) FOREIGN KEY REFERENCES Customer(CustomerID) NOT NULL,
	TransactionDate DATE NOT NULL
)

CREATE TABLE SalesTransactionDetail (
	SalesTransactionID CHAR(5) FOREIGN KEY REFERENCES SalesTransactionHeader(SalesTransactionID) NOT NULL,
	TelevisionID CHAR(5) FOREIGN KEY REFERENCES Television(TelevisionID) NOT NULL,
	Quantity INT NOT NULL
)
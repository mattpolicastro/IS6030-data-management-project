USE master;
GO

IF DB_ID('PermitsIncidents') IS NOT NULL
DROP DATABASE PermitsIncidents;
CREATE DATABASE PermitsIncidents;
GO

USE PermitsIncidents;

IF OBJECT_ID('permitsSource', 'U') IS NOT NULL
DROP TABLE dbo.permitsSource;
CREATE TABLE permitsSource(
  PERMITNUM text, 
  DESCRIPTION text, 
  APPLIEDDATE date, 
  ISSUEDDATE date, 
  COMPLETEDDATE date, 
  ORIGINALADDRESS1 text, 
  ORIGINALCITY text, 
  ORIGINALSTATE text, 
  ORIGINALZIP text, 
  JURISDICTION text, 
  PERMITCLASS text, 
  PERMITCLASSMAPPED text, 
  STATUSCURRENT text, 
  STATUSCURRENTMAPPED text, 
  WORKCLASS text, 
  WORKCLASSMAPPED text, 
  PERMITTYPE text, 
  PERMITTYPEMAPPED text, 
  COMPANYNAME text, 
  TOTALSQFT text, 
  ESTPROJECTCOSTDEC text, 
  ESTPROJECTCOSTTEXT text, 
  UNITS text, 
  PIN text, 
  PROPOSEDUSE text, 
  EXPIRESDATE text, 
  COISSUEDDATE text, 
  FEE text, 
  LINK text, 
  LATITUDE text, 
  LONGITUDE text
);
GO

BULK INSERT dbo.permitsSource
FROM 'C:\Users\Matt\Documents\projects\IS6030-data-management-project\data\permits.csv'
WITH ( 
	FIRSTROW = 2, 
	FIELDTERMINATOR = ',', 
	ROWTERMINATOR = '\n' 
);


COPY permits FROM '/Users/mattpolicastro/projects/IS 6030 Final/data/permits.csv' WITH DELIMITER ',' CSV HEADER;

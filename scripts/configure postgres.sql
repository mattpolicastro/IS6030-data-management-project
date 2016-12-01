CREATE DATABASE permitsincidents;
USE permitsincidents;

CREATE TABLE permits(
  PERMITNUM varchar, 
  DESCRIPTION varchar, 
  APPLIEDDATE date, 
  ISSUEDDATE date, 
  COMPLETEDDATE date, 
  ORIGINALADDRESS1 varchar, 
  ORIGINALCITY varchar, 
  ORIGINALSTATE varchar, 
  ORIGINALZIP varchar, 
  JURISDICTION varchar, 
  PERMITCLASS varchar, 
  PERMITCLASSMAPPED varchar, 
  STATUSCURRENT varchar, 
  STATUSCURRENTMAPPED varchar, 
  WORKCLASS varchar, 
  WORKCLASSMAPPED varchar, 
  PERMITTYPE varchar, 
  PERMITTYPEMAPPED varchar, 
  COMPANYNAME varchar, 
  TOTALSQFT varchar, 
  ESTPROJECTCOSTDEC varchar, 
  ESTPROJECTCOSTTEXT varchar, 
  UNITS varchar, 
  PIN varchar, 
  PROPOSEDUSE varchar, 
  EXPIRESDATE date, 
  COISSUEDDATE date, 
  FEE money, 
  LINK varchar, 
  LATITUDE decimal, 
  LONGITUDE decimal
);

COPY permits FROM '/Users/mattpolicastro/projects/IS 6030 Final/data/permits.csv' WITH DELIMITER ',' CSV HEADER;

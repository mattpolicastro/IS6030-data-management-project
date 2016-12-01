USE master;
GO

IF DB_ID('PermitsIncidents') IS NOT NULL
DROP DATABASE PermitsIncidents;
CREATE DATABASE PermitsIncidents;
GO

USE PermitsIncidents;

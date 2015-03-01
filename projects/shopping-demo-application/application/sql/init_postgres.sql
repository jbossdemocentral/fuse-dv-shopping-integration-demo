CREATE SCHEMA IF NOT EXISTS transactionDB;
CREATE TABLE transactiondb.transactionHistory (
transactionId SERIAL PRIMARY KEY,
customerDetails text NOT NULL,
productCode text NOT NULL,
dateOfPurchase date NOT NULL);CREATE SCHEMA IF NOT EXISTS transactionDB;
CREATE TABLE transactiondb.transactionHistory (
transactionId SERIAL PRIMARY KEY,
customerDetails text NOT NULL,
productCode text NOT NULL,
dateOfPurchase date NOT NULL);
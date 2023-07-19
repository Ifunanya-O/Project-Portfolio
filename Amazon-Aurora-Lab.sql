/* Lab Objectives:
Create an Aurora Database (DB) instance
Connect to a running Amazon Elastic Compute Cloud (Amazon EC2) instance
Configure the Amazon EC2 instance to connect to the Aurora DB instance
Create a database in the DB instance by creating tables and columns, and populate the database with data.
Query the newly created database */


-- Step 1: Create an Aurora-MySQL DB Cluster on Amazon Relational Database Service
-- On the AWS Management Console, click the Services Menu, choose the Database section and select Amazon RDS to create the database. 

-- Step 2: Connect to the Amazon EC2 Instance via the Session Manager
-- Go to Compute services and click on EC2. Then select the running instance and connect it to the AWS Command Line Interface via the Session Manager.

-- Step 3: Configure the Amazon EC2 Instance to connect to Aurora by running this Linux command
-- sudo yum install mariadb -y

-- Step 4: Copy the endpoint of your Aurora instance into a text editor
-- aurora-instance-1.cot0dnjmknma.us-west-2.rds.amazonaws.com

-- Step 5: Run this command on the AWS CLI to connect to the Aurora DB Instance
-- mysql -u admin --password='admin123' -h aurora-instance-1.cot0dnjmknma.us-west-2.rds.amazonaws.com

-- Step 6: Create a Database
-- To show the existing databases
SHOW DATABASES;

-- Create a new database named world
CREATE DATABASE world;

-- Verify that the world database has been created
SHOW DATABASES;

-- Step 7: Create a table, insert records and query them.
-- Create a new table in the world Database

USE world;
CREATE TABLE `country` (
`Code` CHAR(3) NOT NULL DEFAULT '',
`Name` CHAR(52) NOT NULL DEFAULT '',
`Continent` enum('Asia','Europe','North America','Africa','Oceania','Antarctica','South America') NOT NULL DEFAULT 'Asia',
`Region` CHAR(26) NOT NULL DEFAULT '',
`SurfaceArea` FLOAT(10,2) NOT NULL DEFAULT '0.00',
`IndepYear` SMALLINT(6) DEFAULT NULL,
`Population` INT(11) NOT NULL DEFAULT '0',
`LifeExpectancy` FLOAT(3,1) DEFAULT NULL,
`GNP` FLOAT(10,2) DEFAULT NULL,
`GNPOld` FLOAT(10,2) DEFAULT NULL,
`LocalName` CHAR(45) NOT NULL DEFAULT '',
`GovernmentForm` CHAR(45) NOT NULL DEFAULT '',
`Capital` INT(11) DEFAULT NULL,
`Code2` CHAR(2) NOT NULL DEFAULT '',
PRIMARY KEY (`Code`)
);

-- To insert new records into the 'country' table that was created

INSERT INTO `country` VALUES ('GAB','Gabon','Africa','Central Africa',267668.00,1960,1226000,50.1,5493.00,5279.00,'Le Gabon','Republic',902,'GA');

INSERT INTO `country` VALUES ('IRL','Ireland','Europe','British Islands',70273.00,1921,3775100,76.8,75921.00,73132.00,'Ireland/Éire','Republic',1447,'IE');

INSERT INTO `country` VALUES ('THA','Thailand','Asia','Southeast Asia',513115.00,1350,61399000,68.6,116416.00,153907.00,'Prathet Thai','Constitutional Monarchy',3320,'TH');

INSERT INTO `country` VALUES ('CRI','Costa Rica','North America','Central America',51100.00,1821,4023000,75.8,10226.00,9757.00,'Costa Rica','Republic',584,'CR');

INSERT INTO `country` VALUES ('AUS','Australia','Oceania','Australia and New Zealand',7741220.00,1901,18886000,79.8,351182.00,392911.00,'Australia','Constitutional Monarchy, Federation',135,'AU');

-- Use an SQL script file to load data into the database
< /home/ec2-user/world.sql

-- Query the data in the database
SELECT * FROM country WHERE GNP > 35000 and Population > 10000000;
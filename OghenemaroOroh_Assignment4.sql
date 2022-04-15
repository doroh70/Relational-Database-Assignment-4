/*
============================================
Author:  Oghenemaro David Oroh    
Student Number: 200492343
Creation date: 14/04/22
Description: Assignment 4
============================================
*/
#PART1
CREATE DATABASE Assignment4;
#Creating a database, naming it 'Assignment 4'

USE Assignment4;
# Command issued to use database assignment 4

#Question1

#Selecting the 3 columns we's like to return
SELECT 
	first_name, 
	last_name,
	email
FROM
	my_contacts
WHERE
	profession = (SELECT AVG(profession)
					FROM my_contacts
                    WHERE profession = 10); #Selecting the profession number 10 using a subquery

#QUESTION2
#Selecting the 3 columns we's like to return
SELECT
	first_name,
	last_name,
	profession
FROM
	my_contacts
WHERE
	email = (SELECT email
			FROM my_contacts
            WHERE email = 'tinfoilhat@conspiracy.ca' #Selecting the email using a subquery
            LIMIT 1); #Limiting to first occurence
            
#QUESTION3
#Selecting the 3 columns we's like to return
SELECT
	first_name,
    last_name,
    profession
FROM 
	my_contacts
INNER JOIN postal_codes ON my_contacts.postal_code = postal_codes.postal_code #Using Join statement to merge rows from 2 tables
WHERE postal_codes.city = (SELECT city
							FROM postal_codes
                            WHERE city = 'Churchill, ON' #Selecting the city using a subquery
                            LIMIT 1); #Limiting to first occurence


#PART2

#QUESTION1
#Creating a table with id and status, id is primary key
CREATE TABLE status (
	id INT NOT NULL AUTO_INCREMENT,
    status VARCHAR(30) DEFAULT NULL,
    PRIMARY KEY(id)
);

#Testing out
SELECT DISTINCT 
	status
FROM
	my_contacts; 
#married, divorced, single, committed relationship

#inserting the selected distinct status values into the new status table previously created
INSERT INTO status(status) (SELECT DISTINCT
                                        status
									  FROM
										my_contacts);
                                        
#QUESTION2
#ALREADY DONE IN Q1

#QUESTION3
#Updating contents of database to reflect the ID number from the status table using CASE
UPDATE my_contacts
SET my_contacts.status = CASE
WHEN my_contacts.status = 'married' THEN 1
WHEN my_contacts.status = 'divorced' THEN 2
WHEN my_contacts.status = 'single' THEN 3
ELSE 4
END;

#QUESTION4

/*I chose to use the 'MODIFY' as it can do everything the 'CHANGE' statement can do except renaming, which I don't
need to use in this case*/

ALTER TABLE my_contacts MODIFY status INT DEFAULT NULL;
/* Database schema to keep the structure of entire database. */

CREATE TABLE animals( 
  id int primary key,
  name varchar (25) NOT NULL,
  date_of_birth date NOT NULL,
  escape_attempts int NOT NULL,
  neutered bool NOT NULL,
  weight_kg decimal(10,2) NOT NULL
);

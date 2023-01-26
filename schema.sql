/* Database schema to keep the structure of entire database. */



CREATE TABLE animals( 
  id int primary key,
  name varchar (25) NOT NULL,
  date_of_birth date NOT NULL,
  escape_attempts int NOT NULL,
  neutered bool NOT NULL,
  weight_kg decimal(10,2) NOT NULL
);

ALTER TABLE animals
ADD species varchar(25);

-- Create a table named owners with the following columns:
  -- id: integer (set it as autoincremented PRIMARY KEY)
  -- full_name: string
  -- age: integer
CREATE TABLE owners (
	id SERIAL PRIMARY KEY,
	full_name varchar(25),
	age int
)

-- Create a table named species with the following columns:
  -- id: integer (set it as autoincremented PRIMARY KEY)
  -- name: string
CREATE TABLE species (
	id SERIAL PRIMARY KEY,
	name varchar(25)
)

-- Modify animals table:
  -- Make sure that id is set as autoincremented PRIMARY KEY
  -- Remove column species
  -- Add column species_id which is a foreign key referencing species table
  -- Add column owner_id which is a foreign key referencing the owners table
CREATE TABLE new_animals (
	id SERIAL PRIMARY KEY,
	name varchar(25),
		date_of_birth date,
		escape_attempts int,
		neutered bool,
		weight_kg decimal(10,2),
	species_id INT REFERENCES species(id),
	owner_id INT REFERENCES species(id)
); 

-- Add column species_id which is a foreign key referencing species table
ALTER TABLE animals
ADD COLUMN species_id INTEGER REFERENCES species(id);

-- Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE animals
ADD COLUMN owner_id INTEGER REFERENCES owners(id);


INSERT INTO new_animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species_id, owner_id)
SELECT name, date_of_birth, escape_attempts, neutered, weight_kg, species_id, owner_id
FROM animals;

DROP TABLE animals

ALTER TABLE new_animals RENAME TO animals;

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

-- Create a table named vets with the following columns:
  -- id: integer (set it as autoincremented PRIMARY KEY)
  -- name: string
  -- age: integer
  -- date_of_graduation: date
CREATE TABLE vets (
    id SERIAL PRIMARY KEY,
    name varchar(25),
    age INT,
    date_of_graduation DATE
);

-- There is a many-to-many relationship between the tables species and vets: 
-- a vet can specialize in multiple species, and a species can have multiple vets specialized in it. 
-- Create a "join table" called specializations to handle this relationship.
CREATE TABLE specializations (
    id SERIAL PRIMARY KEY,
    species_id INT REFERENCES species(id),
    vet_id INT REFERENCES vets(id)
);

-- There is a many-to-many relationship between the tables animals and vets: 
-- an animal can visit multiple vets and one vet can be visited by multiple animals. 
-- Create a "join table" called visits to handle this relationship, 
-- it should also keep track of the date of the visit.
CREATE TABLE visits (
    id SERIAL PRIMARY KEY,
    animal_id INT REFERENCES animals(id),
    vet_id INT REFERENCES vets(id),
    date_of_visit DATE
);

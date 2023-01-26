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

-- Insert the following data for vets:
  -- Vet William Tatcher is 45 years old and graduated Apr 23rd, 2000.
INSERT INTO vets (name, age, date_of_graduation)
VALUES ('William Tatcher', 45, '2000-04-23');

-- Vet Maisy Smith is 26 years old and graduated Jan 17th, 2019.
INSERT INTO vets (name, age, date_of_graduation)
VALUES ('Maisy Smith', 26, '2019-01-17');

-- Vet Stephanie Mendez is 64 years old and graduated May 4th, 1981.
INSERT INTO vets (name, age, date_of_graduation)
VALUES ('Stephanie Mendez', 64, '1981-05-04');

-- Vet Jack Harkness is 38 years old and graduated Jun 8th, 2008.
INSERT INTO vets (name, age, date_of_graduation)
VALUES ('Jack Harkness', 38, '2008-06-08');

-- Insert the following data for specialties:
  -- Vet William Tatcher is specialized in Pokemon.
  -- Vet Stephanie Mendez is specialized in Digimon and Pokemon.
  -- Vet Jack Harkness is specialized in Digimon.
INSERT INTO specializations (species_id, vet_id) VALUES (1, 1);
INSERT INTO specializations (species_id, vet_id) VALUES (1, 3);
INSERT INTO specializations (species_id, vet_id) VALUES (2, 3);
INSERT INTO specializations (species_id, vet_id) VALUES (2, 2);


-- Insert the following data for visits:
  -- Agumon visited William Tatcher on May 24th, 2020.
  -- Agumon visited Stephanie Mendez on Jul 22th, 2020.
  -- Gabumon visited Jack Harkness on Feb 2nd, 2021.
  -- Pikachu visited Maisy Smith on Jan 5th, 2020.
  -- Pikachu visited Maisy Smith on Mar 8th, 2020.
  -- Pikachu visited Maisy Smith on May 14th, 2020.
  -- Devimon visited Stephanie Mendez on May 4th, 2021.
  -- Charmander visited Jack Harkness on Feb 24th, 2021.
  -- Plantmon visited Maisy Smith on Dec 21st, 2019.
  -- Plantmon visited William Tatcher on Aug 10th, 2020.
  -- Plantmon visited Maisy Smith on Apr 7th, 2021.
  -- Squirtle visited Stephanie Mendez on Sep 29th, 2019.
  -- Angemon visited Jack Harkness on Oct 3rd, 2020.
  -- Angemon visited Jack Harkness on Nov 4th, 2020.
  -- Boarmon visited Maisy Smith on Jan 24th, 2019.
  -- Boarmon visited Maisy Smith on May 15th, 2019.
  -- Boarmon visited Maisy Smith on Feb 27th, 2020.
  -- Boarmon visited Maisy Smith on Aug 3rd, 2020.
  -- Blossom visited Stephanie Mendez on May 24th, 2020.
  -- Blossom visited William Tatcher on Jan 11th, 2021.
INSERT INTO visits (animal_id, vet_id, date_of_visit) VALUES (1, 1, '2020-05-24');
INSERT INTO visits (animal_id, vet_id, date_of_visit) VALUES (1, 3, '2020-07-22');
INSERT INTO visits (animal_id, vet_id, date_of_visit) VALUES (2, 4, '2021-02-02');
INSERT INTO visits (animal_id, vet_id, date_of_visit) VALUES (3, 2, '2020-01-05');
INSERT INTO visits (animal_id, vet_id, date_of_visit) VALUES (3, 2, '2020-03-08');
INSERT INTO visits (animal_id, vet_id, date_of_visit) VALUES (3, 2, '2020-05-14');
INSERT INTO visits (animal_id, vet_id, date_of_visit) VALUES (4, 3, '2021-05-04');
INSERT INTO visits (animal_id, vet_id, date_of_visit) VALUES (5, 4, '2021-02-24');
INSERT INTO visits (animal_id, vet_id, date_of_visit) VALUES (6, 2, '2019-12-21');
INSERT INTO visits (animal_id, vet_id, date_of_visit) VALUES (6, 1, '2020-08-10');
INSERT INTO visits (animal_id, vet_id, date_of_visit) VALUES (6, 2, '2021-04-07');
INSERT INTO visits (animal_id, vet_id, date_of_visit) VALUES (7, 3, '2019-09-29');
INSERT INTO visits (animal_id, vet_id, date_of_visit) VALUES (8, 4, '2020-10-03');
INSERT INTO visits (animal_id, vet_id, date_of_visit) VALUES (8, 4, '2020-11-04');
INSERT INTO visits (animal_id, vet_id, date_of_visit) VALUES (9, 2, '2019-01-24');
INSERT INTO visits (animal_id, vet_id, date_of_visit) VALUES (9, 2, '2019-05-15');
INSERT INTO visits (animal_id, vet_id, date_of_visit) VALUES (9, 2, '2020-02-27');
INSERT INTO visits (animal_id, vet_id, date_of_visit) VALUES (9, 2, '2020-08-03');
INSERT INTO visits (animal_id, vet_id, date_of_visit) VALUES (10, 3, '2020-05-24');
INSERT INTO visits (animal_id, vet_id, date_of_visit) VALUES (10, 1, '2021-01-11');


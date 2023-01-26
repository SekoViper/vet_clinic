/*Queries that provide answers to the questions from all projects.*/

-- Find all animals whose name ends in "mon".
SELECT * FROM animals WHERE name LIKE '%mon%';

-- List the name of all animals born between 2016 and 2019.
SELECT date_of_birth FROM animals WHERE date_of_birth BETWEEN TO_DATE('01/01/2016', 'DD/MM/YYYY') AND TO_DATE('01/01/2019', 'DD/MM/YYYY');

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT * FROM animals WHERE neutered = true AND escape_attempts < 3

-- List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

-- Find all animals that are neutered.
SELECT * FROM animals WHERE neutered = true;

-- Find all animals not named Gabumon.
SELECT * FROM animals WHERE name != 'Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * FROM animals WHERE weight_kg >= 10.4 and weight_kg <= 17.3;

-- Inside a transaction update the animals table by setting the species column to unspecified. Verify that change was made. Then roll back the change and verify that the species columns went back to the state before the transaction.
BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals
ROLLBACK;
SELECT * FROM animals

-- Inside a transaction:
-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
SELECT * FROM animals

-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT * FROM animals

-- Commit the transaction.
COMMIT;

-- Verify that change was made and persists after commit.
SELECT * FROM animals

-- Now, take a deep breath and... Inside a transaction delete all records in the animals table, then roll back the transaction.
BEGIN;
DELETE FROM animals
SELECT * FROM animals

-- After the rollback verify if all records in the animals table still exists. After that, you can start breathing as usual ;)
ROLLBACK;

-- Inside a transaction:
-- Delete all animals born after Jan 1st, 2022.
BEGIN;
DELETE FROM animals WHERE date_of_birth > TO_DATE('01/01/2022', 'DD/MM/YYYY');
SELECT * FROM animals

-- Create a savepoint for the transaction
SAVEPOINT deletedob01012022;

-- Update all animals' weight to be their weight multiplied by -1.
UPDATE animals SET weight_kg = weight_kg * -1;

-- Rollback to the savepoint
ROLLBACK TO deletedob01012022;

-- Update all animals' weights that are negative to be their weight multiplied by -1
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

-- Commit transaction
COMMIT;

-- How many animals are there?
SELECT COUNT(*) FROM animals

-- How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, MAX(escape_attempts) FROM animals GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg), MAX(weight_kg)FROM animals GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) from animals WHERE date_part('year', date_of_birth) > 1990 and date_part('year', date_of_birth) < 2000 GROUP BY species;

-- What animals belong to Melody Pond?
SELECT a.name, b.full_name from animals AS a, owners AS b WHERE a.owner_id = b.id AND b.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT a.name, b.name AS specises FROM animals AS a, species AS b WHERE a.species_id = b.id AND b.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT b.full_name AS ownerName, a.name AS petName  FROM animals AS a RIGHT JOIN owners AS b ON a.owner_id = b.id;

-- How many animals are there per species?
SELECT species_id, COUNT(*) FROM animals GROUP BY species_id;

-- List all Digimon owned by Jennifer Orwell.
SELECT a.name, b.full_name FROM animals AS a, owners AS b, species AS c WHERE a.owner_id = b.id AND a.species_id = c.id and b.full_name = 'Jennifer Orwell' AND c.name = 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT a.name, b.full_name FROM animals AS a, owners AS b, species AS c 
WHERE a.owner_id = b.id AND a.species_id = c.id AND b.full_name = 'Dean Winchester' AND a.escape_attempts = 0;

-- Who owns the most animals?
SELECT b.full_name, COUNT(*) FROM animals AS a, owners AS b WHERE a.owner_id = b.id GROUP BY b.full_name ORDER BY COUNT(*) DESC LIMIT 1;


Who was the last animal seen by William Tatcher?
SELECT * FROM animals WHERE id = (SELECT animal_id FROM visits WHERE vet_id = 1 ORDER BY date_of_visit DESC LIMIT 1);

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT animal_id) FROM visits WHERE vet_id = 3;

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name, species.name FROM vets LEFT JOIN specializations ON vets.id = specializations.vet_id LEFT JOIN species ON specializations.species_id = species.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name FROM animals JOIN visits ON animals.id = visits.animal_id WHERE visits.vet_id = 3 AND visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT animal_id, COUNT(*) FROM visits GROUP BY animal_id ORDER BY COUNT(animal_id) desc LIMIT 1

-- Who was Maisy Smith's first visit?
SELECT vets.name FROM vets JOIN visits ON vets.id = visits.vet_id WHERE visits.animal_id = 2 ORDER BY visits.date_of_visit LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.name, vets.name, visits.date_of_visit FROM animals JOIN visits ON animals.id = visits.animal_id JOIN vets ON visits.vet_id = vets.id ORDER BY visits.date_of_visit DESC LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(visits.animal_id) FROM visits JOIN animals ON visits.animal_id = animals.id JOIN vets ON visits.vet_id = vets.id LEFT JOIN specializations ON vets.id = specializations.vet_id LEFT JOIN species ON specializations.species_id = species.id WHERE species.id != animals.species_id;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species_id FROM animals WHERE id = (select animal_id FROM visits WHERE vet_id = 2 GROUP BY animal_id ORDER BY COUNT(animal_id) desc LIMIT 1); 

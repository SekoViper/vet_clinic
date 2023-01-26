/* Populate database with sample data. */

INSERT INTO animals VALUES (1, 'Agumon', TO_DATE('03/02/2020', 'DD/MM/YYYY'), 0, true, 10.23);
INSERT INTO animals VALUES (2, 'Gabumon', TO_DATE('15/11/2018', 'DD/MM/YYYY'), 2, true, 8);
INSERT INTO animals VALUES (3, 'Pikachu' , TO_DATE('07/01/2021', 'DD/MM/YYYY'), 1, false, 15.04);
INSERT INTO animals VALUES (4, 'Devimon' , TO_DATE('12/05/2017', 'DD/MM/YYYY'), 5, true, 11);

INSERT INTO animals VALUES (5, 'Charmander' , TO_DATE('08/02/2020', 'DD/MM/YYYY'), 0, false, -11);
INSERT INTO animals VALUES (6, 'Plantmon' , TO_DATE('15/11/2021', 'DD/MM/YYYY'), 2, true, -5.7);
INSERT INTO animals VALUES (7, 'Squirtle' , TO_DATE('02/04/1993', 'DD/MM/YYYY'), 3, false, -12.13);
INSERT INTO animals VALUES (8, 'Angemon' , TO_DATE('12/06/2005', 'DD/MM/YYYY'), 0, true, -45);
INSERT INTO animals VALUES (9, 'Boarmon' , TO_DATE('07/06/2005', 'DD/MM/YYYY'), 7, true, -20.4);
INSERT INTO animals VALUES (10, 'Blossom' , TO_DATE('13/10/1998', 'DD/MM/YYYY'), 3, true, -17);
INSERT INTO animals VALUES (11, 'Ditto' , TO_DATE('14/05/2022', 'DD/MM/YYYY'), 4, true, -22);

-- Insert the following data into the owners table:
  -- Sam Smith 34 years old.
  -- Jennifer Orwell 19 years old.
  -- Bob 45 years old.
  -- Melody Pond 77 years old.
  -- Dean Winchester 14 years old.
  -- Jodie Whittaker 38 years old.
INSERT INTO public.owners (id, full_name, age)
	VALUES
	(1, 'Sam Smith', 34),
	(2, 'Jennifer Orwell', 19),
	(3, 'Bob', 45),
	(4, 'Melody Pond', 77),
	(5, 'Dean Winchester', 14),
	(6, 'Jodie Whittaker', 38)

-- Insert the following data into the species table:
  -- Pokemon
  -- Digimon
INSERT INTO public.species (id, name)
	VALUES
	(1, 'Pokemon'),
	(2, 'Digimon')

-- Modify your inserted animals so it includes the species_id value:
  -- If the name ends in "mon" it will be Digimon
  -- All other animals are Pokemon

UPDATE animals
SET species_id = 1
WHERE name NOT LIKE '%mon';

UPDATE animals
SET species_id = 2
WHERE name LIKE '%mon';

-- Modify your inserted animals to include owner information (owner_id):
-- Sam Smith owns Agumon.
UPDATE animals
SET owner_id = 1
WHERE name = 'Agumon';

-- Jennifer Orwell owns Gabumon and Pikachu.
UPDATE animals
SET owner_id = 2
WHERE name = 'Gabumon' or name = 'Pikachu';

-- Bob owns Devimon and Plantmon.
UPDATE animals
SET owner_id = 3
WHERE name = 'Devimon' or name = 'Plantmon';

-- Melody Pond owns Charmander, Squirtle, and Blossom.
UPDATE animals
SET owner_id = 4
WHERE name = 'Charmander' or name = 'Squirtle' or name = 'Blossom';

-- Dean Winchester owns Angemon and Boarmon.
UPDATE animals
SET owner_id = 5
WHERE name = 'Angemon' or name = 'Boarmon';


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
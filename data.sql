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

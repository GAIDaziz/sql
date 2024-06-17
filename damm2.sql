-- Active: 1718008381836@@127.0.0.1@3306@database

-- Créer une base de données 
CREATE DATABASE ma_database;
-- CREATE DATABASE IF NOT EXISTS ma_database;
-- Supprimer la bdd et ses données
DROP DATABASE ma_database;
-- DROP DATABASE IF EXISTS ma_database;

-- Afficher les tables actuellement présentes dans la bdd
SHOW TABLES;
-- Afficher les colonnes d'une table
DESC person;

DROP TABLE IF EXISTS person;
CREATE TABLE person (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(128) NOT NULL,
    first_name VARCHAR(128) NOT NULL,
    age INT
);

-- CRUD : Create Read Update Delete
-- Create : la requête permettant d'ajouter une valeur dans une table, on y indique le nom de la table, la liste des colonnes à spécifier suivie des valeurs à assigner à chaque colonne, dans le même ordre
INSERT INTO nom_table (col1,col2,col3) VALUES ('valeur1', 10, 'valeur 3');

-- Dans le cas de notre table person, ça nous donne
INSERT INTO person (name, first_name, age) VALUES ("Richter", 'Franky', 65);

-- Read
SELECT * FROM ma_table;


SELECT * FROM person;
SELECT first_name,age FROM person;
SELECT * FROM person WHERE name='Richter';

-- Le LIMIT x,y permet de sauter x données et d'en afficher y
SELECT * FROM person LIMIT 2,2;

SELECT * FROM person ORDER BY id ASC;

-- Update
UPDATE nom_table SET col='valeur' WHERE id=1;

UPDATE person SET name='Jacquot',age=45 WHERE id=1;

-- Delete
DELETE FROM person WHERE id=2;




-- Supprime les données d'une table mais garde la table
-- TRUNCATE person;

INSERT INTO person (name,first_name,age) VALUES
('Sakhri', 'Lisa', 65),
('Sakhri', 'Abdala', 30),
('Gomex', 'Lisa', 25),
('Johnson', 'Alberto', 65),
('Mouriel', 'Baptiste', 18);


SELECT * FROM person WHERE id=3;
SELECT * FROM person WHERE first_name='Lisa';
SELECT * FROM person WHERE age > 50;
SELECT * FROM person WHERE name='Sakhri' AND age < 60;
SELECT * FROM person WHERE first_name!='Lisa';
SELECT * FROM person WHERE age >= 30 AND age <= 60;
-- Pareil qu'au dessus
SELECT * FROM person WHERE age BETWEEN 30 AND 60;
SELECT * FROM person WHERE first_name LIKE 'L%';
-- '%L' finit par L, 'L%' commence par L, '%L%' contient L quelque part

SELECT CONCAT(first_name,' ', name) AS full_name FROM person;

SELECT * FROM person WHERE CONCAT(first_name,name) LIKE '%as%';

SELECT * FROM person WHERE YEAR(NOW())-age > 1995;


SELECT * FROM person ORDER BY name ASC;
SELECT * FROM person ORDER BY age ASC;
SELECT * FROM person ORDER BY age DESC LIMIT 3;
SELECT * FROM person ORDER BY first_name ASC, age DESC;


--faire 1 ou 2 insert into de adresse 

CREATE TABLE adress(
    id INT PRIMARY KEY AUTO_INCREMENT,
    street VARCHAR(128),
    city VARCHAR(128),
    zip_code VARCHAR(128),
    person_id INT REFERENCES person(id)
    -- FOREIGN KEY person_id REFERENCES person(id) -- On peut aussi déclarer la FK à part
);
INSERT INTO adress(street , city , zip_code,id) VALUES
('rue de la république','grenoble','38000',1),
('rue de la gare','lyon','69800',1),
('rue de la paix','nant','38000',2),
('avenue truc truc','grenoble','44000',3),
('rue de la sant','grenoble','38000',3),
('35-48','parie','68000',2),
('rue saonté perdu','marcelle','22000',4),
('rue de la solitude','mrio-land','42000',5);

SELECT adress from person WHERE  id=5

---avec des colonne de l'adress
--faire que une perssone et plusieur adresse entre grenoble et lyon

CREATE TABLE person (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(128) NOT NULL
    
);
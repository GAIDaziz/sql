-- Active: 1718008381836@@127.0.0.1@3306@bibliothéque
DROP TABLE IF EXISTS auteur_livre;
DROP TABLE IF EXISTS amende;
DROP TABLE IF EXISTS emprunt;
DROP TABLE IF EXISTS livre;
DROP TABLE IF EXISTS auteur;
DROP TABLE IF EXISTS utilisateur;

CREATE TABLE utilisateur(
    id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(255) UNIQUE NOT NULL,
    mot_de_passe VARCHAR(255) NOT NULL,
    role VARCHAR(64) NOT NULL,
    nom VARCHAR(128),
    prenom VARCHAR(128)
);

CREATE TABLE auteur(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(128),
    prenom VARCHAR(128),
    description TEXT
);

CREATE TABLE livre(
    id INT PRIMARY KEY AUTO_INCREMENT,
    titre VARCHAR(255) NOT NULL,
    isbn VARCHAR(13) NOT NULL,
    genre VARCHAR(128),
    description TEXT,
    annee_publication YEAR,
    disponible BOOLEAN NOT NULL,
    etat VARCHAR(128)
);

CREATE TABLE emprunt(
    id INT PRIMARY KEY AUTO_INCREMENT,
    date_emprunt DATE NOT NULL,
    date_retour_reelle DATE,
    jours_autorises INT NOT NULL,
    id_utilisateur INT NOT NULL,
    id_livre INT NOT NULL,
    FOREIGN KEY (id_utilisateur)  REFERENCES utilisateur(id),
    FOREIGN KEY (id_livre)  REFERENCES livre(id)
);

CREATE TABLE amende(
    id INT PRIMARY KEY AUTO_INCREMENT,
    prix DOUBLE NOT NULL,
    date_creation DATE NOT NULL,
    date_echeance DATE NOT NULL,
    reglee BOOLEAN NOT NULL DEFAULT FALSE,
    raison TEXT NOT NULL,
    id_utilisateur INT NOT NULL,
    FOREIGN KEY (id_utilisateur)  REFERENCES utilisateur(id)
);

CREATE TABLE auteur_livre(
    id_livre INT,
    id_auteur INT,
    PRIMARY KEY(id_livre,id_auteur),
    FOREIGN KEY (id_auteur)  REFERENCES auteur(id),
    FOREIGN KEY (id_livre)  REFERENCES livre(id)
);

INSERT INTO utilisateur (email,mot_de_passe,nom,prenom,role) VALUES 
('user@test.com', 'amoiinazefoijqs', 'test', 'test', 'adherent'),
('admin@test.com', 'amoiinazefoijqs', 'admin', 'admin', 'admin'),
('bibli@test.com', 'amoiinazefoijqs', 'bibli', 'bibli', 'bibliothecaire');

INSERT INTO auteur (nom, prenom,description) VALUES 
('K. Le Guin', 'Ursula', 'descritpion'),
('E. Butler', 'Octavia', 'description'),
('Stanley Robinson', 'Kim', 'description');

INSERT INTO livre (titre,isbn,genre,etat,annee_publication,description,disponible) VALUES 
('La main gauche de la nuit', 'QSDF2R342', 'SF', 'bon', '1985', 'description', TRUE),
('Les dépossédés', 'ABDF2R342', 'SF', 'neuf', '1990', 'description', TRUE),
('Le ministère du futur', 'ABISDJOF54', 'SF', 'bon', '2022', 'description', FALSE),
('Patternist', '0539GGSDS', 'SF', 'mauvais', '1977', 'description', FALSE);

INSERT INTO emprunt (date_emprunt,jours_autorises,id_livre,id_utilisateur, date_retour_reelle) VALUES
('2024-06-01', 30, 3, 1, NULL),
('2024-06-02', 30, 4, 1, NULL),
('2024-05-12', 30, 1, 1, '2024-05-27'),
('2024-04-12', 30, 3, 1, '2024-05-18'),
('2024-05-12', 30, 1, 2, '2024-06-01');

INSERT INTO auteur_livre (id_auteur,id_livre) VALUES 
(1, 1),
(1,2),
(2,4),
(3,3);

INSERT INTO amende (date_creation,date_echeance,id_utilisateur,prix,raison,reglee) VALUES 
('2024-06-01', '2024-08-30', 1, 2.0, 'raison', FALSE),
('2024-03-01', '2024-05-30', 1, 2.0, 'raison', TRUE);

-- Faire une requête pour récupérer les emprunts EN COURS d'un⋅ adhérent⋅e avec le livre concerné ainsi que la date de retour prévue
SELECT livre.titre, emprunt.date_emprunt+INTERVAL jours_autorises DAY FROM emprunt 
INNER JOIN livre ON livre.id=emprunt.id_livre
WHERE emprunt.id_utilisateur=1 AND emprunt.date_retour_reelle IS NULL;

-- Faire une requête pour rechercher un livre à la fois par son titre,description,genre, nom et prénom d'auteur
SELECT * FROM livre
LEFT JOIN auteur_livre ON livre.id=auteur_livre.id_livre
LEFT JOIN auteur ON auteur_livre.id_auteur=auteur.id
WHERE CONCAT(livre.titre,livre.description,livre.genre,auteur.nom,auteur.prenom) LIKE '%es%';

-- Faire une requête pour récupérer la liste des adhérent⋅es
SELECT * FROM utilisateur WHERE role='adherent';

-- Faire une requête pour récupérer la liste des amendes non payées et le nom/prénom de l'utilisateur⋅ice à qui est assignée l'amende
SELECT amende.*, utilisateur.nom, utilisateur.prenom FROM amende
LEFT JOIN utilisateur ON amende.id_utilisateur=utilisateur.id
WHERE amende.reglee=FALSE;
-- Faire une requête pour récupérer les livres publiés depuis 1990
SELECT * FROM livre WHERE annee_publication>=1990;

-- Faire une requête pour récupérer la liste des adhérent, leur nombre d'emprunt en cours (le truc avec le case en vrai on le fait pas souvent et les jurés vous le demanderont pas)
SELECT utilisateur.*, COUNT(CASE WHEN date_retour_reelle IS NULL AND emprunt.id IS NOT NULL THEN 1 END) AS emprunt_en_cours FROM utilisateur 
LEFT JOIN emprunt ON utilisateur.id=emprunt.id_utilisateur
LEFT JOIN amende ON amende.id_utilisateur=utilisateur.id
GROUP BY utilisateur.id;





CREATE USER'test'@'localhost'IDENTIFIED BY '1234';



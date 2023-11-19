-- Active: 1700211668325@@127.0.0.1@3306@brief
----------------------------------------- créer la base de données-----------------------
CREATE DATABASE brief;

------------------------------------------ créer les tables------------------------------

CREATE TABLE departements (
	id int PRIMARY KEY AUTO_INCREMENT,
	nom varchar(20),
	description varchar(50));

CREATE TABLE employes (
	id int PRIMARY KEY AUTO_INCREMENT,
	nom varchar(20),
	prenom varchar(20),
	email varchar(30),
	poste varchar(20),
	departement_id int,
	FOREIGN KEY(departement_id) REFERENCES departements(id));

CREATE TABLE salles (
	id int PRIMARY KEY AUTO_INCREMENT,
	nom varchar(20),
	capacite int
);

CREATE TABLE types (
	id int PRIMARY KEY AUTO_INCREMENT,
	nom varchar(50)
);

CREATE TABLE equipements (
	id int PRIMARY KEY AUTO_INCREMENT,
	nom varchar(20),
	quantite int,
	salle_id int,
	type_id int,
	FOREIGN KEY(salle_id) REFERENCES salles(id),
	FOREIGN KEY(type_id) REFERENCES types(id)
);


CREATE TABLE reservations (
	id int PRIMARY KEY AUTO_INCREMENT,
	dateDebut date,
	dateFin date,
	salle_id int,
	employe_id int,
	FOREIGN KEY(salle_id) REFERENCES salles(id),
	FOREIGN KEY(employe_id) REFERENCES employes(id)
);
---------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------insertion des données ----------------------------------

INSERT INTO departements (nom, description)
VALUES
('Production','départements 1'),
('Ventes','départements 2'),
('Marketing','départements 3'),
('Comptabilité','départements 4'),
('Développement','départements 5');


INSERT INTO employes (nom, prenom, email, poste, departement_id)
VALUES
('el hani','ibtissam','ibti@gmail.com','scrum master',5),
('fihar','ali','ali@gmail.com','Technicien',5),
('lhdeli','abdel','abdel@gmail.com','Assistante',1),
('aleki','anas','anas@gmail.com','Cadre',1),
('aderdor','titima','titma@gmail.com','Directeur',4),
('chabab','nabil','nabil@gmail.com','Cadre',2),
('elnedi','omar','omar@gmail.com','cadre',2),
('aicha','sana','sana@gmail.com','cadre',3),
('elkoh','zak','zak@gmail.com','Directeur',3),
('said','aabila','said@gmail.com','ingenieur',3);


INSERT INTO salles (nom, capacite)
VALUES 
('agora',100),
('grande',1000),
('petite',50);


INSERT INTO types (nom)
VALUES 
('MOBILIER'),
('ÉCRAN DE PROJECTION'),
('PRISES ÉLECTRIQUES MULTIPLES'),
('MACHINE À CAFÉ'),
('ÉLÉMENTS DE DÉCORATION');


INSERT INTO equipements (nom, quantite, salle_id, type_id)
VALUES
('table',4,1,1),
('chaise',100,1,1),
('table',10,2,1),
('chaise',1000,2,1),
('table',1,3,1),
('chaise',50,3,1),
('ecran',1,1,2),
('ecran',1,2,2),
('ecran',1,3,2),
('machine',2,3,4),
('prises',10,2,5),
('prises',5,1,5),
('prises',2,3,5);


INSERT INTO reservations (date_debut, date_fin, salle_id, employe_id)
VALUES
('2023-11-16','2023-11-17',1,1),
('2023-11-16','2023-11-17',2,4),
('2023-11-16','2023-11-17',3,10),
('2023-11-20','2023-11-21',1,2),
('2023-11-22','2023-11-23',2,5),
('2023-11-29','2023-11-30',3,9),
('2023-12-11','2023-12-17',2,6),
('2023-11-18','2023-11-19',1,10);

---------------------------------------------------------------------------------------------------------------------------


----------------------------------------------- selection des données -----------------------------------------------------

SELECT * FROM employes;
SELECT * FROM salles;
SELECT * FROM departements;

SELECT * FROM employes where nom='el hani';
SELECT * FROM employes where nom='elkoh' AND prenom='zak';
SELECT * FROM employes where nom='elkoh' OR nom='el hani';

SELECT nom FROM salles WHERE capacite BETWEEN 1 AND 100;

SELECT description FROM departements WHERE nom IN ('Production', 'IT', 'Développement','HR');

SELECT * FROM equipements WHERE nom LIKE '_a%';

SELECT nom, SUM(quantite) FROM equipements GROUP BY nom;

SELECT nom, SUM(quantite) FROM equipements GROUP BY nom HAVING SUM(quantite)<100;

--order descendant
SELECT * FROM reservations ORDER BY date_debut DESC;

--order descendant
SELECT * FROM reservations ORDER BY date_fin ASC;

SELECT * FROM departements WHERE NOT nom='Marketing';

--select les 3 premiers lignes
SELECT * FROM employes LIMIT 3;

-------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------- update ----------------------------------------------------------------

UPDATE employes 
SET nom='aabila', prenom='said'
WHERE id=10;

-------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------- delete ----------------------------------------------------------------

DELETE FROM equipements
WHERE nom='prises' AND quantite =2;

-------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------- join ------------------------------------------------------------------


--les employe avec nom departement
SELECT employes.nom, employes.prenom,employes.poste, departements.nom AS departement
FROM  employes
JOIN departements ON employes.departement_id = departements.id;

SELECT e.nom, e.prenom, e.poste, d.nom AS departement
FROM employes e
JOIN departements d ON e.departement_id = d.id;

--reservation avec employe et salle
SELECT r.date_debut, r.date_fin, e.nom AS employe_nom , e.prenom AS employe_prenom , s.nom AS salle
FROM reservations r, employes e, salles s 
WHERE r.salle_id = s.id AND r.employe_id = e.id;

SELECT s.nom, e.nom , e.quantite, t.nom 
FROM equipements e , salles s, types t
WHERE e.salle_id = s.id and e.type_id = t.id;

SELECT e.nom, t.nom 
FROM equipements e
LEFT JOIN types t
ON e.type_id = t.id ;

SELECT e.nom, t.nom 
FROM types t
LEFT JOIN equipements e
ON e.type_id = t.id ;

SELECT s.nom, e.nom 
FROM equipements e
RIGHT JOIN salles s 
ON e.salle_id = s.id;

--self JOIN
SELECT  a.nom as employe1, b.nom as employe2,  a.departement_id as departement
FROM employes a, employes b
WHERE a.id <> b.id AND a.departement_id = b.departement_id;

SELECT  r.id as reservation, r.date_debut, r.date_fin, s.nom salle_nom, e.nom employe_nom
FROM reservations r, employes e, salles s
WHERE r.employe_id = e.id AND r.salle_id = s.id 
GROUP BY e.nom;

SELECT  r.id as reservation, r.date_debut, r.date_fin, s.nom salle_nom, t.nom equipements ,  e.nom employe_nom, d.nom employe_depart
FROM reservations r, employes e, departements d, salles s, types t , equipements q
WHERE r.employe_id = e.id AND r.salle_id = s.id AND e.departement_id = d.id AND q.salle_id = s.id and q.type_id = t.id
GROUP BY ;



--------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------- prcedure ---------------------------------------------------------------------------------

--creer procedure: chercher les employees par nom
CREATE Procedure chercher_employe(IN nom VARCHAR(20))
BEGIN
	SELECT * FROM employes e
	WHERE e.nom = nom;
END;


CALL chercher_employe('el hani');

--procedure pour afficher les departements

CREATE Procedure afficher_depart()
BEGIN
	SELECT * FROM departements;
END;

CALL afficher_depart();

-- procedure pour calculer et afficher duree de chaque reservation
CREATE PROCEDURE duree_reservation(in id int)
BEGIN
	SELECT DATEDIFF(r.date_fin, r.date_debut) as duree_reservation
	FROM reservations r;
END;

CALL duree_reservation(1);

-----------------------------------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------- fonction ---------------------------------------------------------------------------------

-- fonction qui retourne la quantite max des equipement

CREATE Function max_quant() RETURNS int 
BEGIN
	DECLARE m int;
	SELECT MAX(quantite) INTO m FROM equipements;
	RETURN m;
END;

--utilisation de resultat de fonction 
SELECT * FROM equipements
WHERE quantite = max_quant();

--------------------------------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------- index ---------------------------------------------------------------------------------

SHOW INDEXES FROM employes ;

SHOW INDEXES FROM salles;

CREATE INDEX IDX_employe_email ON employes(email);

CREATE INDEX IDX_type_nom ON types(nom);












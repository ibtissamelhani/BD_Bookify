# BD_Bookify
## Introduction
Bookify s'engage à créer une plateforme web dédiée à la réservation de salles. Cette documentation vise à fournir un aperçu du projet, en mettant particulièrement l'accent sur la conception de la base de données, l'utilisation de SQL et UML pour modéliser cette architecture, ainsi que la planification pour assurer la continuité de la plateforme.
## Contenu
1. [Objectif du Projet]
2. [Architecture de la Base de Données]
3. [Utilisation de SQL]
4. [Modèle UML]

## Objectif du Projet
L'objectif principal de Bookify est de fournir une plateforme conviviale permettant aux utilisateurs de réserver des salles de manière simple et efficace. Pour atteindre cet objectif, le projet se concentre sur la création d'une base de données solide, utilisant SQL pour la gestion des données et UML pour modéliser l'architecture.

## Architecture de la Base de Données
La base de données de Bookify est conçue pour stocker efficacement les informations liées aux réservations de salles. Voici une vue d'ensemble des principales entités de la base de données :
- *Salles*: Stocke des salles disponibles.
- *employees*: Enregistre les informations sur les utilisateurs de la plateforme.
- *Réservations*: Stocke les détails de chaque réservation, y compris la salle, l'employe, la date de réservation.
- *equipements*:stocke les informations sur equipements de chaque salle.
- *types*: types de chaque equipement.
- *departements*: enregistre les informations sur les differents departements.
Cette architecture permet une gestion efficace des réservations et facilite le suivi des disponibilités des salles.

## Utilisation de SQL
SQL est utilisé pour interagir avec la base de données. Les requêtes SQL sont écrites de manière à assurer la cohérence et l'intégrité des données. Des procédures stockées peuvent être utilisées pour des opérations complexes.
Exemple de requête SQL pour récupérer l'employe ou son nom est "el hani" spécifique :
``SELECT * FROM employes where nom='el hani';

## Modèle UML
Le modèle UML (Unified Modeling Language) est utilisé pour représenter graphiquement l'architecture du projet. Les diagrammes de classe UML sont utilisés pour visualiser les relations entre les différentes entités du système.


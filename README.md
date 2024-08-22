# Projet du 6ème sprint

### Description du projet
Dans le cadre du projet, il fallait étendre le modèle de données, analyser les nouvelles informations et aider les marketeurs à proposer une publicité efficace sur les réseaux sociaux en ligne.

Description de la tâche
Pour attirer de nouveaux utilisateurs, les marketeurs souhaitent diffuser des annonces sur des sites tiers pour des communautés avec une grande activité. Il est nécessaire d'identifier les groupes où une majorité de leurs membres a commencé à interagir. En termes de marketing, on les qualifierait de groupes avec une haute conversion au premier message.

### Il est nécessaire de :
Transférer depuis S3 vers la couche de staging les nouvelles données sur les entrées et sorties des utilisateurs des groupes — fichier group_log.csv.

Le fichier de log des groupes group_log.csv contient :

group_id — identifiant unique du groupe ;
user_id — identifiant unique de l'utilisateur ;
user_id_from — champ indiquant que l'utilisateur n'a pas rejoint le groupe de lui-même, mais a été ajouté par un autre membre. Si l'utilisateur a été invité par quelqu'un d'autre, ce champ ne sera pas vide ;
event — action effectuée par l'utilisateur user_id. Les valeurs possibles sont :
create — l'utilisateur a créé le groupe ;
add — l'utilisateur user_id a rejoint le groupe de lui-même ou a été ajouté ;
leave — l'utilisateur user_id a quitté le groupe ;
datetime — moment de l'événement.

Créer des tables pour les nouvelles données dans la couche de stockage permanent. Par exemple, selon le schéma :
![Image (19)](https://github.com/user-attachments/assets/3f0927db-2252-4538-a7e3-3bc703bd2908)

Transférer les nouvelles données de la zone de staging vers la couche DDS.
Calculer les indicateurs de conversion pour les dix groupes les plus anciens :

cnt_added_users — nombre d'utilisateurs ayant rejoint le groupe ;
cnt_users_in_group_with_messages — nombre de membres du groupe ayant écrit au moins un message ;
group_conversion — taux de conversion au premier message à partir de l'adhésion au groupe.

### Comment travailler avec le répertoire

1. Copiez le répertoire sur votre machine locale ::
	* `git clone https://github.com/{{ username }}/de-project-sprint-6.git`
2. Passez au répertoire du projet :: 
	* `cd de-project-sprint-6`

### Structure du répertoire
- `/src/dags`

### Comment démarrer un conteneur
Run docker-compose:
docker-compose up -d

After the container starts, you will have access to:

-- Airflow
localhost:3000/airflow

-- Database
vertica connection secured

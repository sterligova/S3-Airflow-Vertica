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

### Как работать с репозиторием
1. В вашем GitHub-аккаунте автоматически создастся репозиторий `de-project-sprint-6` после того, как вы привяжете свой GitHub-аккаунт на Платформе.
2. Скопируйте репозиторий на свой локальный компьютер, в качестве пароля укажите ваш `Access Token` (получить нужно на странице [Personal Access Tokens](https://github.com/settings/tokens)):
	* `git clone https://github.com/{{ username }}/de-project-sprint-6.git`
3. Перейдите в директорию с проектом: 
	* `cd de-project-sprint-6`
4. Выполните проект и сохраните получившийся код в локальном репозитории:
	* `git add .`
	* `git commit -m 'my best commit'`
5. Обновите репозиторий в вашем GutHub-аккаунте:
	* `git push origin main`

### Структура репозитория
- `/src/dags`

### Как запустить контейнер
Запустите локально команду:
```
docker run \
-d \
-p 3000:3000 \
-p 3002:3002 \
-p 15432:5432 \
--mount src=airflow_sp5,target=/opt/airflow \
--mount src=lesson_sp5,target=/lessons \
--mount src=db_sp5,target=/var/lib/postgresql/data \
--name=de-sprint-5-server-local \
cr.yandex/crp1r8pht0n0gl25aug1/de-pg-cr-af:latest
```

После того как запустится контейнер, вам будут доступны:
- Airflow
	- `localhost:3000/airflow`
- БД
	- `jovyan:jovyan@localhost:15432/de`

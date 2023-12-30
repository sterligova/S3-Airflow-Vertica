DROP TABLE IF EXISTS STV2023111328__STAGING.group_log;
DROP TABLE IF EXISTS STV2023111328__STAGING.group_log_rej;

CREATE TABLE STV2023111328__STAGING.group_log
(
    group_id INT NOT NULL,
    user_id INT,
    user_id_from INT,
    event varchar(50),
    datetime timestamp
);

--INSERT data with COPY from localhost
COPY STV2023111328__STAGING.group_log (group_id, user_id, user_id_from, event, datetime)
FROM LOCAL 'D:\Yandex praktikum\sprint-6\s6-lessons\dags\data\group_log.csv'
DELIMITER ','
REJECTED DATA AS TABLE STV2023111328__STAGING.group_log_rej;
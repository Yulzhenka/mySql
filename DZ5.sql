--Практическое задание по теме «Операторы, фильтрация, сортировка и ограничение»
--1. Пусть в таблице users поля created_at и updated_at оказались незаполненными. 
--Заполните их текущими датой и временем.

CREATE DATABASE storehouse;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    birthday DATE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO `users` VALUES (1,'porro','2000-05-14','2000-03-04 01:48:13','2002-10-20 06:24:05'),(2,'voluptas','1983-11-09','2016-05-11 23:42:03','1970-03-29 22:00:55'),(3,'et','1990-01-01','1997-12-25 19:40:45','1997-06-12 23:42:48'),(4,'dignissimos','1978-08-13','1971-06-24 05:42:38','2000-09-16 09:45:19'),(5,'quo','1961-08-15','2015-04-17 00:11:13','1991-02-25 14:59:17'),(6,'molestiae','1959-09-08','1970-10-16 23:01:03','1985-06-20 02:46:50'),(7,'et','2009-03-02','1990-06-14 15:38:31','1985-05-04 07:48:40'),(8,'rerum','1970-12-31','1980-04-08 02:04:00','2008-02-23 10:55:47'),(9,'possimus','1990-01-01','1976-10-29 12:13:50','2014-12-05 18:59:49'),(10,'officia','1990-04-16','1971-02-21 07:05:22','1995-04-08 02:02:45');

UPDATE users
    SET created_at = NULL;
UPDATE users
    SET updated_at = NULL;
    
UPDATE users
    SET created_at = NOW();
UPDATE users
    SET updated_at = NOW()

--2. Таблица users была неудачно спроектирована. 
-- Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате 20.10.2017 8:10. 
-- Необходимо преобразовать поля к типу DATETIME, сохранив введённые ранее значения.

ALTER TABLE users
    CHANGE COLUMN `created_at` `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CHANGE COLUMN `updated_at` `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

-- 3. В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 
-- 0, если товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом, 
-- чтобы они выводились в порядке увеличения значения value. Однако нулевые запасы должны выводиться в конце, после всех записей.

CREATE TABLE storehouses_products (
  id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    value INT unsigned NOT NULL
);

INSERT INTO `storehouses_products` VALUES (1,'et',3),(2,'officiis',1),(3,'et',0),(4,'vero',2),(5,'nobis',3),(6,'officiis',5),(7,'aut',1),(8,'iste',4),(9,'ut',1),(10,'autem',6),(11,'quasi',7),(12,'cumque',8),(13,'consequuntur',9),(14,'doloremque',9),(15,'esse',0),(16,'dolorum',9),(17,'dolor',2),(18,'sint',6),(19,'ducimus',2),(20,'reiciendis',9);

SELECT 
    value
FROM
    storehouses_products ORDER BY IF(value > 0, 0, 1), value;

-- 4. (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. 
-- Месяцы заданы в виде списка английских названий (may, august)

SELECT name, birthday FROM users WHERE MONTHNAME(birthday) IN ('may', 'august');

-- Практическое задание теме «Агрегация данных»
-- 1. Подсчитайте средний возраст пользователей в таблице users.

SELECT ROUND(AVG((TO_DAYS(NOW()) - TO_DAYS(birthday)) / 365.25), 0) AS AVG_Age FROM users;

-- 2. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
-- Следует учесть, что необходимы дни недели текущего года, а не года рождения.

SELECT
    DAYNAME(CONCAT(YEAR(NOW()), '-', SUBSTRING(birthday, 6, 10))) AS week_day_bd,
    COUNT(*) AS amount_of_bd
FROM
    users
GROUP BY 
    week_day_bd
ORDER BY
  amount_of_bd DESC;






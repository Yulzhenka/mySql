/* Практическое задание по теме "Транзакции, переменные, представления. Администрирование. 
Хранимые процедуры и функции, триггеры"

2. Создайте представление, которое выводит название (name) товарной позиции из
таблицы products и соответствующее название (name) каталога из таблицы catalogs.*/

USE `storehouse`;

CREATE OR REPLACE VIEW general_list(product_id, product_name, catalog_name)
AS
SELECT products.id, products.name, catalogs.name
FROM products 
LEFT JOIN catalogs 
ON products.catalog_id=catalogs.id;

SELECT * FROM general_list;

/* Практическое задание по теме “Хранимые процедуры и функции, триггеры"
1. Создайте хранимую функцию hello(), которая будет возвращать 
приветствие, в зависимости от текущего времени суток. 
С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", 
с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи". */

DROP PROCEDURE IF EXISTS hello;

delimiter //

CREATE PROCEDURE hello()
BEGIN
	CASE 
		WHEN CURTIME() BETWEEN '06:00:01' AND '12:00:00' 
			THEN
				SELECT 'Доброе утро!';
		WHEN CURTIME() BETWEEN '12:00:01' AND '18:00:00' 
			THEN
				SELECT 'Добрый день!';
		WHEN CURTIME() BETWEEN '18:00:01' AND '00:00:00' 
			THEN
				SELECT 'Добрый вечер!';
			ELSE
				SELECT 'Доброй ночи!';
	END CASE;
END //

delimiter ;

CALL hello();


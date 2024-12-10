CREATE DATABASE attestation

CREATE TABLE Destination(
id int PRIMARY KEY,
name char(40),
id_status int);

INSERT INTO Destination
VALUES (39, 'Калининград', 2), (77, 'Москва', 1), (53, 'Новгород', 1), (16, 'Казань', 1), (63, 'Самара', 1), (48, 'Польша', 2);

CREATE TABLE Tickets(
id int PRIMARY KEY,
id_destination int,
lowest_price int,
highest_pice int);

INSERT INTO Tickets
VALUES (1, 39, 2500, 6000),
(2, 77, 5000, 8500),
(4, 16, 8800, 11200),
(5, 63, 8800, 10500);

CREATE TABLE Status(
id int PRIMARY KEY,
name char(20));

INSERT INTO Status
VALUES (1, 'без визы'),
(2, 'с визой'),
(3, 'туристическая виза'),
(4, 'рабочая виза');

SELECT *FROM Destination
select * from Tickets
select * from Status

-- Уникальные названия маршрутов (destination.name), 
-- для которых существуют билеты (есть запись в tickets). 
-- Вывести только названия.
select DISTINCT d.name
from Tickets as t left join Destination as d
on d.id=t.id_destination

-- Дополните предыдущий запрос, 
-- ограничьте маршруты статусом «Без визы».
select DISTINCT d.name
from Tickets as t left join Destination as d
on t.id_destination=d.id
join Status as s
on d.id_status=s.id
where s.name='без визы'

-- Найдите маршруты, 
-- максимальная цена на которые выше общей средней. 
-- Общая средняя находится как 
-- среднее значение суммы lowest_price и highest_price. 
-- Вывести названия и самую высокую цену.
select d.name, t.highest_pice
from Tickets as t join Destination as d
on t.id_destination=d.id
where t.highest_pice > (
	select avg((lowest_price + highest_pice)/ 2) from Tickets);

-- Выведите статусы, 
-- которые не используются в маршрутах 
-- (нет ни одного маршрута с этими статусами).
select s.name
from Status as s
left join Destination as d
on d.id_status=s.id
where d.id_status is null
-- КЛУБ ЧИТАТЕЛЕЙ(ЛИТЕРАТУРНЫЙ КЛУБ)
USE master;
DROP DATABASE IF EXISTS LiteratureClub;
CREATE DATABASE LiteratureClub;
USE LiteratureClub;

-- ВЕРШИНЫ
-- Человек (свойства: имя, возраст, город проживания)
CREATE TABLE Person
(
	id INT IDENTITY(1, 1) PRIMARY KEY,
	name NVARCHAR(50) NOT NULL,
	age INT NOT NULL,
	city NVARCHAR(50) NOT NULL,
) AS NODE;

-- Книга (свойства: название, автор, жанр, год издания)
CREATE TABLE Book
(
	id INT IDENTITY(1, 1) PRIMARY KEY,
	name NVARCHAR(50) NOT NULL,
	author NVARCHAR(50) NOT NULL,
	genre NVARCHAR(50) NOT NULL,
	publishing_year INT NOT NULL,
) AS NODE;

-- Автор (свойства: имя, страна, год рождения)
CREATE TABLE Author
(
	id INT IDENTITY(1, 1) PRIMARY KEY,
	name NVARCHAR(50) NOT NULL,
	country NVARCHAR(50) NOT NULL,
	birth_year INT NOT NULL,
) AS NODE;

-- РЕБРА
-- Дружба (связывает узлы сущностей: человек и человек)
CREATE TABLE FriendOf AS EDGE;
ALTER TABLE FriendOf 
ADD CONSTRAINT EC_FriendOf CONNECTION (Person TO Person);

-- Читает (связывает узлы сущностей: человек и книга, свойства: дата начала чтения, дата окончания чтения, оценка)
CREATE TABLE [Read] (startDate DATE, endDate DATE, mark int) AS EDGE;
ALTER TABLE [Read] 
ADD CONSTRAINT EC_Read CONNECTION (Person TO Book);

-- Написал (связывает узлы сущностей: автор и книга)
CREATE TABLE Wrote AS EDGE;
ALTER TABLE Wrote
ADD CONSTRAINT EC_Wrote CONNECTION (Author TO Book);

-- Интересуется (связывает узлы сущностей: человек и автор)
CREATE TABLE InterestedIn AS EDGE;
ALTER TABLE InterestedIn
ADD CONSTRAINT EC_InterestedIn CONNECTION (Person TO Author);

INSERT INTO Person ([name], age, city)
VALUES (N'Пабло', 20, N'Брест'), -- 1
	   (N'Никита', 4, N'Минск'), -- 2
	   (N'Тима', 18, N'Минск'),  -- 3
	   (N'Олег', 17, N'Гомель'), -- 4
	   (N'Максим', 180, N'Светлогорск'), -- 5
	   (N'Альберт', 0, N'Донбас'), -- 6
	   (N'Илья', 19, N'Могилев'), -- 7
	   (N'Иван', 21, N'Минск'), -- 8
	   (N'Сава', 19, N'Сухарево'), -- 9
	   (N'Коля', 30, N'Пинск'); -- 10
GO

UPDATE Person 
SET city = N'Минск' 
WHERE id = 9;
GO

SELECT *
FROM Person;

INSERT INTO Book ([name], author, genre, publishing_year)
VALUES (N'1984', N'Джордж Оруэлл', N'Антиутопия', 1949),
	   (N'Властелин Колец. Том 1. Братство кольца', N'Толкин Джон Рональд Руэл', N'Зарубежная проза', 1954),
	   (N'Властелин Колец. Том 2. Две крепости', N'Толкин Джон Рональд Руэл', N'Зарубежная проза', 1954),
	   (N'Властелин Колец. Том 3. Возвращение короля', N'Толкин Джон Рональд Руэл', N'Зарубежная проза', 1954),
	   (N'Над пропастью во ржи', N'Джером Сэлинджер', N'Роман', 1951),
	   (N'Маленький принц', N'Антуан де Сент-Экзюпери', N'Философская сказка', 1943),
	   (N'Богатый папа, бедный папа', N'Роберт Кийосаки', N'Бизнес', 1997),
	   (N'Пятьдесят оттенков серого', N'Э. Л. Джеймс', N'Роман', 2011),
	   (N'Война и мир', N'Лев Николаевич Толстой', N'Роман-эпопея', 1869),
	   (N'Преступлеение и наказание', N'Фёдор Михайлович Достоевский', N'Роман', 1866),
	   (N'Мёртвые души', N'Николай Васильевич Гоголь', N'Поэма', 1842),
	   (N'Капитанская дочка', N'Александр Сергеевич Пушкин', N'Историческая повесть', 1842);
GO

SELECT *
FROM Book;

INSERT INTO Author([name], country, birth_year)
VALUES (N'Джордж Оруэлл', N'Британская Индия', 1950),
	   (N'Толкин Джон Рональд Руэл', N'Оранжевая Республика', 1892),
	   (N'Джером Сэлинджер', N'США', 1919),
	   (N'Антуан де Сент-Экзюпери', N'Франция', 1900),
	   (N'Роберт Кийосаки', N'США', 1947),
	   (N'Э. Л. Джеймс', N'Великобритания', 1963),
	   (N'Лев Николаевич Толстой', N'Российская империя', 1828),
	   (N'Фёдор Михайлович Достоевский', N'Российская империя', 1821),
	   (N'Николай Васильевич Гоголь', N'Российская империя', 1809),
	   (N'Александр Сергеевич Пушкин', N'Российская империя', 1827);
GO

Select *
FROM Author;

INSERT INTO FriendOf ($from_id, $to_id)
VALUES ((SELECT $node_id FROM Person WHERE id = 1),
	    (SELECT $node_id FROM Person WHERE id = 2)),
	   ((SELECT $node_id FROM Person WHERE id = 1),
	    (SELECT $node_id FROM Person WHERE id = 5)),
	   ((SELECT $node_id FROM Person WHERE id = 1),
	    (SELECT $node_id FROM Person WHERE id = 7)),
	   ((SELECT $node_id FROM Person WHERE id = 2),
	    (SELECT $node_id FROM Person WHERE id = 4)),
	   ((SELECT $node_id FROM Person WHERE id = 2),
	    (SELECT $node_id FROM Person WHERE id = 5)),
	   ((SELECT $node_id FROM Person WHERE id = 2),
	    (SELECT $node_id FROM Person WHERE id = 7)),
	   ((SELECT $node_id FROM Person WHERE id = 3),
	    (SELECT $node_id FROM Person WHERE id = 7)),
	   ((SELECT $node_id FROM Person WHERE id = 3),
	    (SELECT $node_id FROM Person WHERE id = 10)),
	   ((SELECT $node_id FROM Person WHERE id = 4),
	    (SELECT $node_id FROM Person WHERE id = 7)),
	   ((SELECT $node_id FROM Person WHERE id = 5),
	    (SELECT $node_id FROM Person WHERE id = 7)),
	   ((SELECT $node_id FROM Person WHERE id = 5),
	    (SELECT $node_id FROM Person WHERE id = 9)),
	   ((SELECT $node_id FROM Person WHERE id = 7),
	    (SELECT $node_id FROM Person WHERE id = 9)),
	   ((SELECT $node_id FROM Person WHERE id = 7),
	    (SELECT $node_id FROM Person WHERE id = 8)),
	   ((SELECT $node_id FROM Person WHERE id = 8),
	    (SELECT $node_id FROM Person WHERE id = 9)),
	   ((SELECT $node_id FROM Person WHERE id = 9),
	    (SELECT $node_id FROM Person WHERE id = 10));
GO

SELECT *
FROM FriendOf

INSERT INTO [Read] ($from_id, $to_id, startDate, endDate, mark)
VALUES ((SELECT $node_id FROM Person WHERE ID = 1),
	    (SELECT $node_id FROM Book WHERE ID = 1), N'2020-10-10', N'2020-10-20', 5),
	   ((SELECT $node_id FROM Person WHERE ID = 1),
		(SELECT $node_id FROM Book WHERE ID = 2), N'2020-10-20', N'2020-11-20', 7),
	   ((SELECT $node_id FROM Person WHERE ID = 1),
		(SELECT $node_id FROM Book WHERE ID = 3), N'2020-10-20', N'2020-11-20', 10),
	   ((SELECT $node_id FROM Person WHERE ID = 1),
		(SELECT $node_id FROM Book WHERE ID = 4), N'2020-10-20', N'2020-11-20', 8),
	   ((SELECT $node_id FROM Person WHERE ID = 2),
	    (SELECT $node_id FROM Book WHERE ID = 6), N'2020-10-10', N'2020-10-20', 4),
	   ((SELECT $node_id FROM Person WHERE ID = 2),
		(SELECT $node_id FROM Book WHERE ID = 9), N'2020-10-10', N'2020-11-20', 10),
	   ((SELECT $node_id FROM Person WHERE ID = 3),
		(SELECT $node_id FROM Book WHERE ID = 11), N'2020-10-10', N'2020-11-20', 3),
	   ((SELECT $node_id FROM Person WHERE ID = 4),
		(SELECT $node_id FROM Book WHERE ID = 10), N'2020-10-20', N'2020-11-20', 6),
	   ((SELECT $node_id FROM Person WHERE ID = 5),
	    (SELECT $node_id FROM Book WHERE ID = 1), N'2020-10-10', N'2020-10-20', 9),
	   ((SELECT $node_id FROM Person WHERE ID = 5),
		(SELECT $node_id FROM Book WHERE ID = 2), N'2020-10-10', N'2020-11-20', 7),
	   ((SELECT $node_id FROM Person WHERE ID = 5),
		(SELECT $node_id FROM Book WHERE ID = 3), N'2020-10-20', N'2020-11-20', 5),
	   ((SELECT $node_id FROM Person WHERE ID = 5),
		(SELECT $node_id FROM Book WHERE ID = 4), N'2020-10-10', N'2020-11-20', 7),
	   ((SELECT $node_id FROM Person WHERE ID = 5),
	    (SELECT $node_id FROM Book WHERE ID = 6), N'2020-10-10', N'2020-10-20', 4),
	   ((SELECT $node_id FROM Person WHERE ID = 5),
		(SELECT $node_id FROM Book WHERE ID = 9), N'2020-10-20', N'2020-11-20', 8),
	   ((SELECT $node_id FROM Person WHERE ID = 5),
		(SELECT $node_id FROM Book WHERE ID = 10), N'2020-10-20', N'2020-11-20', 9);
GO

INSERT INTO [Read] ($from_id, $to_id, startDate, endDate, mark)
VALUES ((SELECT $node_id FROM Person WHERE ID = 5),
		(SELECT $node_id FROM Book WHERE ID = 11), N'2020-10-20', N'2020-11-20', 10),
	   ((SELECT $node_id FROM Person WHERE ID = 5),
	    (SELECT $node_id FROM Book WHERE ID = 12), N'2020-10-10', N'2020-10-20', 8),
	   ((SELECT $node_id FROM Person WHERE ID = 6),
		(SELECT $node_id FROM Book WHERE ID = 7), N'2020-10-20', N'2020-11-20', 8),
	   ((SELECT $node_id FROM Person WHERE ID = 6),
		(SELECT $node_id FROM Book WHERE ID = 8), N'2020-10-20', N'2020-11-20', 6),
	   ((SELECT $node_id FROM Person WHERE ID = 7),
		(SELECT $node_id FROM Book WHERE ID = 1), N'2020-10-20', N'2020-11-20', 7),
	   ((SELECT $node_id FROM Person WHERE ID = 7),
	    (SELECT $node_id FROM Book WHERE ID = 2), N'2020-10-10', N'2020-10-20', 6),
	   ((SELECT $node_id FROM Person WHERE ID = 7),
		(SELECT $node_id FROM Book WHERE ID = 5), N'2020-10-20', N'2020-11-20', 6),
	   ((SELECT $node_id FROM Person WHERE ID = 7),
		(SELECT $node_id FROM Book WHERE ID = 6), N'2020-10-20', N'2020-11-20', 9),
	   ((SELECT $node_id FROM Person WHERE ID = 8),
		(SELECT $node_id FROM Book WHERE ID = 9), N'2020-10-20', N'2020-11-20', 8),
		((SELECT $node_id FROM Person WHERE ID = 8),
	    (SELECT $node_id FROM Book WHERE ID = 10), N'2020-10-10', N'2020-10-20', 4),
	   ((SELECT $node_id FROM Person WHERE ID = 8),
		(SELECT $node_id FROM Book WHERE ID = 11), N'2020-10-20', N'2020-11-20', 2),
	   ((SELECT $node_id FROM Person WHERE ID = 8),
		(SELECT $node_id FROM Book WHERE ID = 12), N'2020-10-20', N'2020-11-20', 6),
	   ((SELECT $node_id FROM Person WHERE ID = 9),
		(SELECT $node_id FROM Book WHERE ID = 5), N'2020-10-20', N'2020-11-20', 9),
	   ((SELECT $node_id FROM Person WHERE ID = 9),
	    (SELECT $node_id FROM Book WHERE ID = 1), N'2020-10-10', N'2020-10-20', 10),
	   ((SELECT $node_id FROM Person WHERE ID = 10),
		(SELECT $node_id FROM Book WHERE ID = 10), N'2020-10-20', N'2020-11-20', 8),
	   ((SELECT $node_id FROM Person WHERE ID = 1),
		(SELECT $node_id FROM Book WHERE ID = 11), N'2020-10-10', N'2020-11-20', 7);
GO

SELECT *
FROM [Read]

INSERT INTO Wrote ($from_id, $to_id)
VALUES ((SELECT $node_id FROM Author WHERE id = 1),
	    (SELECT $node_id FROM Book WHERE id = 1)),
	   ((SELECT $node_id FROM Author WHERE id = 2),
	    (SELECT $node_id FROM Book WHERE id = 2)),
	   ((SELECT $node_id FROM Author WHERE id = 2),
	    (SELECT $node_id FROM Book WHERE id = 3)),
	   ((SELECT $node_id FROM Author WHERE id = 2),
	    (SELECT $node_id FROM Book WHERE id = 4)),
	   ((SELECT $node_id FROM Author WHERE id = 3),
	    (SELECT $node_id FROM Book WHERE id = 5)),
	   ((SELECT $node_id FROM Author WHERE id = 4),
	    (SELECT $node_id FROM Book WHERE id = 6)),
	   ((SELECT $node_id FROM Author WHERE id = 5),
	    (SELECT $node_id FROM Book WHERE id = 7)),
	   ((SELECT $node_id FROM Author WHERE id = 6),
	    (SELECT $node_id FROM Book WHERE id = 8)),
	   ((SELECT $node_id FROM Author WHERE id = 7),
	    (SELECT $node_id FROM Book WHERE id = 9)),
	   ((SELECT $node_id FROM Author WHERE id = 8),
	    (SELECT $node_id FROM Book WHERE id = 10)),
	   ((SELECT $node_id FROM Author WHERE id = 9),
	    (SELECT $node_id FROM Book WHERE id = 11)),
	   ((SELECT $node_id FROM Author WHERE id = 10),
	    (SELECT $node_id FROM Book WHERE id = 12));
GO
	  
SELECT *
FROM Wrote

INSERT INTO InterestedIn ($from_id, $to_id)
VALUES ((SELECT $node_id FROM Person WHERE id = 5),
	    (SELECT $node_id FROM Author WHERE id = 1)),
	   ((SELECT $node_id FROM Person WHERE id = 5),
	    (SELECT $node_id FROM Author WHERE id = 2)),
	   ((SELECT $node_id FROM Person WHERE id = 5),
	    (SELECT $node_id FROM Author WHERE id = 4)),
	   ((SELECT $node_id FROM Person WHERE id = 5),
	    (SELECT $node_id FROM Author WHERE id = 8)),
	   ((SELECT $node_id FROM Person WHERE id = 10),
	    (SELECT $node_id FROM Author WHERE id = 7)),
	   ((SELECT $node_id FROM Person WHERE id = 4),
	    (SELECT $node_id FROM Author WHERE id = 8)),
	   ((SELECT $node_id FROM Person WHERE id = 9),
	    (SELECT $node_id FROM Author WHERE id = 4)),
	   ((SELECT $node_id FROM Person WHERE id = 3),
	    (SELECT $node_id FROM Author WHERE id = 3));
GO

SELECT *
FROM InterestedIn

-- Найдем друзей Тимы
SELECT Person1.name
	   , Person2.name AS [Friend name]
FROM Person AS Person1
	 , FriendOf
	 , Person AS Person2
WHERE MATCH(Person1-(FriendOf)->Person2)
	  AND Person1.name = N'Тима';

-- Найдем друзей друзей Ильи
SELECT Person1.name + N' дружит с ' + Person2.name AS Level1
	   , Person2.name + N' дружит с ' + Person3.name AS Level2
FROM Person AS Person1
	 , FriendOf AS Friend1
	 , Person AS Person2
	 , FriendOf AS Friend2
	 , Person AS Person3
WHERE MATCH(Person1-(Friend1)->Person2-(Friend2)->Person3)
	  AND Person1.name = N'Илья';

-- Найдем друзей Савы, которые интересуются Толстым
SELECT DISTINCT Person1.name
	   , Person2.name AS [Friend, who is interested with Tolstoy]
FROM Person AS Person1
	 , FriendOf
	 , Person AS Person2
	 , InterestedIn
	 , Author
WHERE MATCH(Person1-(FriendOf)->Person2-(InterestedIn)->Author)
	  AND Person1.name = N'Сава' AND Author.name = N'Лев Николаевич Толстой';

-- Какие друзья Пабло читали книги с 2020-10-20
SELECT DISTINCT Person1.name
	   , Person2.name AS [Friend name]
FROM Person AS Person1
	 , FriendOf
	 , Person AS Person2
	 , [Read]
	 , Book
WHERE MATCH(Person1-(FriendOf)->Person2-([Read])->Book)
	  AND Person1.name = N'Пабло' AND [Read].startDate >= N'2020-10-20';

-- Найти людей, которые дружат с Никитой и читают книгу Мертвые души
SELECT Person1.name
FROM Person AS Person1
	 , FriendOf
	 , Person AS Person2
	 , [Read]
	 , Book
WHERE MATCH(Book<-([Read])-Person1-(FriendOf)->Person2)
	  AND Person2.name = N'Никита' AND Book.name >= N'Мёртвые души';

-- Найти все книги, которые написали авторы, которыми интересуются друзья Пабло
SELECT Book.name AS [Books]
	   , Author.name AS [Author name]
	   , Person2.name AS [Friend name]
FROM Person AS Person1
	 , FriendOf
	 , Person AS Person2
	 , InterestedIn
	 , Author
	 , Wrote
	 , Book
WHERE MATCH(Person1-(FriendOf)->Person2-(InterestedIn)->Author-(Wrote)->Book)
	  AND Person1.name = N'Пабло';

-- Книги и их оценки (для Power BI)
SELECT Book.name AS [Books]
	   , Person.name AS [People]
	   , [Read].mark AS [Marks]
FROM Person
	 , [Read]
	 , Book
WHERE MATCH(Person-([Read])->Book);

-- Кратчайший путь для дружбы Пабло и Савы
WITH T1 AS
(
 SELECT Person1.name AS PersonName
       , STRING_AGG(Person2.name, '->') WITHIN GROUP (GRAPH PATH) AS Friends
	   , LAST_VALUE(Person2.name) WITHIN GROUP (GRAPH PATH) AS LastNode
 FROM Person AS Person1
	  , FriendOf FOR PATH AS fo
	  , Person FOR PATH AS Person2
 WHERE MATCH(SHORTEST_PATH(Person1(-(fo)->Person2)+))
       AND Person1.name = N'Пабло'
)
SELECT PersonName, Friends
FROM T1
WHERE LastNode = N'Сава';

-- Могут ли Пабло и Коля подружиться в 2 шага ?

DECLARE @PersonFrom AS NVARCHAR(20) = N'Пабло';
DECLARE @PersonTo AS NVARCHAR(20) = N'Коля';
WITH T1 AS
(
 SELECT Person1.name AS PersonName
	    , LAST_VALUE(Person2.name) WITHIN GROUP (GRAPH PATH) AS LastNode
 FROM Person AS Person1
	  , FriendOf FOR PATH AS fo
	  , Person FOR PATH AS Person2
 WHERE MATCH(SHORTEST_PATH(Person1(-(fo)->Person2){1,2}))
       AND Person1.name = @PersonFrom
)
SELECT TOP 1 IIF(LastNode = @PersonTo, 'Yes', 'No') AS Answer
FROM T1
ORDER BY Answer DESC
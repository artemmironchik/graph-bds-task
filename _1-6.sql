-- ���� ���������(������������ ����)
USE master;
DROP DATABASE IF EXISTS LiteratureClub;
CREATE DATABASE LiteratureClub;
USE LiteratureClub;

-- �������
-- ������� (��������: ���, �������, ����� ����������)
CREATE TABLE Person
(
	id INT IDENTITY(1, 1) PRIMARY KEY,
	name NVARCHAR(50) NOT NULL,
	age INT NOT NULL,
	city NVARCHAR(50) NOT NULL,
) AS NODE;

-- ����� (��������: ��������, �����, ����, ��� �������)
CREATE TABLE Book
(
	id INT IDENTITY(1, 1) PRIMARY KEY,
	name NVARCHAR(50) NOT NULL,
	author NVARCHAR(50) NOT NULL,
	genre NVARCHAR(50) NOT NULL,
	publishing_year INT NOT NULL,
) AS NODE;

-- ����� (��������: ���, ������, ��� ��������)
CREATE TABLE Author
(
	id INT IDENTITY(1, 1) PRIMARY KEY,
	name NVARCHAR(50) NOT NULL,
	country NVARCHAR(50) NOT NULL,
	birth_year INT NOT NULL,
) AS NODE;

-- �����
-- ������ (��������� ���� ���������: ������� � �������)
CREATE TABLE FriendOf AS EDGE;
ALTER TABLE FriendOf 
ADD CONSTRAINT EC_FriendOf CONNECTION (Person TO Person);

-- ������ (��������� ���� ���������: ������� � �����, ��������: ���� ������ ������, ���� ��������� ������, ������)
CREATE TABLE [Read] (startDate DATE, endDate DATE, mark int) AS EDGE;
ALTER TABLE [Read] 
ADD CONSTRAINT EC_Read CONNECTION (Person TO Book);

-- ������� (��������� ���� ���������: ����� � �����)
CREATE TABLE Wrote AS EDGE;
ALTER TABLE Wrote
ADD CONSTRAINT EC_Wrote CONNECTION (Author TO Book);

-- ������������ (��������� ���� ���������: ������� � �����)
CREATE TABLE InterestedIn AS EDGE;
ALTER TABLE InterestedIn
ADD CONSTRAINT EC_InterestedIn CONNECTION (Person TO Author);

INSERT INTO Person ([name], age, city)
VALUES (N'�����', 20, N'�����'), -- 1
	   (N'������', 4, N'�����'), -- 2
	   (N'����', 18, N'�����'),  -- 3
	   (N'����', 17, N'������'), -- 4
	   (N'������', 180, N'�����������'), -- 5
	   (N'�������', 0, N'������'), -- 6
	   (N'����', 19, N'�������'), -- 7
	   (N'����', 21, N'�����'), -- 8
	   (N'����', 19, N'��������'), -- 9
	   (N'����', 30, N'�����'); -- 10
GO

UPDATE Person 
SET city = N'�����' 
WHERE id = 9;
GO

SELECT *
FROM Person;

INSERT INTO Book ([name], author, genre, publishing_year)
VALUES (N'1984', N'������ ������', N'����������', 1949),
	   (N'��������� �����. ��� 1. �������� ������', N'������ ���� ������� ����', N'���������� �����', 1954),
	   (N'��������� �����. ��� 2. ��� ��������', N'������ ���� ������� ����', N'���������� �����', 1954),
	   (N'��������� �����. ��� 3. ����������� ������', N'������ ���� ������� ����', N'���������� �����', 1954),
	   (N'��� ��������� �� ���', N'������ ���������', N'�����', 1951),
	   (N'��������� �����', N'������ �� ����-��������', N'����������� ������', 1943),
	   (N'������� ����, ������ ����', N'������ ��������', N'������', 1997),
	   (N'��������� �������� ������', N'�. �. ������', N'�����', 2011),
	   (N'����� � ���', N'��� ���������� �������', N'�����-������', 1869),
	   (N'������������� � ���������', N'Ը��� ���������� �����������', N'�����', 1866),
	   (N'̸����� ����', N'������� ���������� ������', N'�����', 1842),
	   (N'����������� �����', N'��������� ��������� ������', N'������������ �������', 1842);
GO

SELECT *
FROM Book;

INSERT INTO Author([name], country, birth_year)
VALUES (N'������ ������', N'���������� �����', 1950),
	   (N'������ ���� ������� ����', N'��������� ����������', 1892),
	   (N'������ ���������', N'���', 1919),
	   (N'������ �� ����-��������', N'�������', 1900),
	   (N'������ ��������', N'���', 1947),
	   (N'�. �. ������', N'��������������', 1963),
	   (N'��� ���������� �������', N'���������� �������', 1828),
	   (N'Ը��� ���������� �����������', N'���������� �������', 1821),
	   (N'������� ���������� ������', N'���������� �������', 1809),
	   (N'��������� ��������� ������', N'���������� �������', 1827);
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

-- ������ ������ ����
SELECT Person1.name
	   , Person2.name AS [Friend name]
FROM Person AS Person1
	 , FriendOf
	 , Person AS Person2
WHERE MATCH(Person1-(FriendOf)->Person2)
	  AND Person1.name = N'����';

-- ������ ������ ������ ����
SELECT Person1.name + N' ������ � ' + Person2.name AS Level1
	   , Person2.name + N' ������ � ' + Person3.name AS Level2
FROM Person AS Person1
	 , FriendOf AS Friend1
	 , Person AS Person2
	 , FriendOf AS Friend2
	 , Person AS Person3
WHERE MATCH(Person1-(Friend1)->Person2-(Friend2)->Person3)
	  AND Person1.name = N'����';

-- ������ ������ ����, ������� ������������ �������
SELECT DISTINCT Person1.name
	   , Person2.name AS [Friend, who is interested with Tolstoy]
FROM Person AS Person1
	 , FriendOf
	 , Person AS Person2
	 , InterestedIn
	 , Author
WHERE MATCH(Person1-(FriendOf)->Person2-(InterestedIn)->Author)
	  AND Person1.name = N'����' AND Author.name = N'��� ���������� �������';

-- ����� ������ ����� ������ ����� � 2020-10-20
SELECT DISTINCT Person1.name
	   , Person2.name AS [Friend name]
FROM Person AS Person1
	 , FriendOf
	 , Person AS Person2
	 , [Read]
	 , Book
WHERE MATCH(Person1-(FriendOf)->Person2-([Read])->Book)
	  AND Person1.name = N'�����' AND [Read].startDate >= N'2020-10-20';

-- ����� �����, ������� ������ � ������� � ������ ����� ������� ����
SELECT Person1.name
FROM Person AS Person1
	 , FriendOf
	 , Person AS Person2
	 , [Read]
	 , Book
WHERE MATCH(Book<-([Read])-Person1-(FriendOf)->Person2)
	  AND Person2.name = N'������' AND Book.name >= N'̸����� ����';

-- ����� ��� �����, ������� �������� ������, �������� ������������ ������ �����
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
	  AND Person1.name = N'�����';

-- ����� � �� ������ (��� Power BI)
SELECT Book.name AS [Books]
	   , Person.name AS [People]
	   , [Read].mark AS [Marks]
FROM Person
	 , [Read]
	 , Book
WHERE MATCH(Person-([Read])->Book);

-- ���������� ���� ��� ������ ����� � ����
WITH T1 AS
(
 SELECT Person1.name AS PersonName
       , STRING_AGG(Person2.name, '->') WITHIN GROUP (GRAPH PATH) AS Friends
	   , LAST_VALUE(Person2.name) WITHIN GROUP (GRAPH PATH) AS LastNode
 FROM Person AS Person1
	  , FriendOf FOR PATH AS fo
	  , Person FOR PATH AS Person2
 WHERE MATCH(SHORTEST_PATH(Person1(-(fo)->Person2)+))
       AND Person1.name = N'�����'
)
SELECT PersonName, Friends
FROM T1
WHERE LastNode = N'����';

-- ����� �� ����� � ���� ����������� � 2 ���� ?

DECLARE @PersonFrom AS NVARCHAR(20) = N'�����';
DECLARE @PersonTo AS NVARCHAR(20) = N'����';
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
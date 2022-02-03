--Man skal huske use sådan så den ved hvor den skal gemme.
use TEC

CREATE TABLE Elever(
    ID int NOT NULL IDENTITY(1,1),
    LastName nvarchar(50) NOT NULL,
    FirstName nvarchar(50) NOT NULL,
	PRIMARY KEY(ID)
);

INSERT INTO Elever(FirstName, LastName)
Values
('Mathias', 'Clausen'),
('Claus', 'Nielsen'),
('Simon', 'Olesen');

CREATE TABLE Lærer (
    ID int NOT NULL IDENTITY(1,1),
    LastName nvarchar(50) NOT NULL,
    FirstName nvarchar(50) NOT NULL,
	ElevID int NOT NULL,
	PRIMARY KEY(ID)
);

INSERT INTO Lærer(FirstName, LastName, ElevID)
Values
('Niels', 'Henriksen', 1),
('Michael', 'Thomasen', 2),
('Klaus','Pedersen',3);

CREATE TABLE Fag (
    ID int NOT NULL IDENTITY(1,1),
	Fag nvarchar(50) NOT NULL,
	LærerID int NOT NULL,
	PRIMARY KEY (ID),
	FOREIGN Key (LærerID) REFERENCES Lærer(ID),
);

INSERT INTO Fag(Fag,LærerID)
Values
('DataBase', 1),
('Programmering', 2),
('Cisco', 3);

CREATE TABLE Klasse (
    KlasseID int NOT NULL IDENTITY(1,1),
	FagID int NOT NULL,
	ElevID int NOT NULL,
    PRIMARY KEY (KlasseID),
    FOREIGN KEY (FagID) REFERENCES Fag(ID),
	FOREIGN KEY (ElevID) REFERENCES Elever(ID)
);

INSERT INTO Klasse(FagID, ElevID)
Values
(1,1),
(2,2),
(3,3);

drop table Klasse;
drop table fag;
drop table Elever;


use TEC
--CONCAT er Ligesom Combine i C#
Select 
CONCAT(Elev.FirstName, ' ', Elev.LastName) AS 'Grundlæggende Programmering', 
Faget.Fag,
CONCAT(Lære.FirstName, ' ', Lære.LastName) As Lære
FROM Klasse AS PrintKlasse

--Join er et sæt af data
FULL outer JOIN Elever AS Elev ON ElevID = Elev.ID
FULL outer JOIN Fag As Faget ON FagID = Faget.ID
FULL outer JOIN Lærer As Lære ON LærerID = Lære.ID


-- update elev navne
use TEC
UPDATE Elever
SET FirstName = 'Martin', LastName = 'Jensen'
WHERE ID = 1;
UPDATE Elever
SET FirstName = 'Patrik', LastName = 'Nielsen'
WHERE ID = 2;
UPDATE Elever
SET FirstName = 'Susanne', LastName = 'Hansen'
WHERE ID = 3;
INSERT INTO Elever(FirstName,LastName)
Values ('Thomas','Olsen');	


--constrain = relation ift. keys der var constrain derfor slettede jeg fag foreignKey
-- fra klasse. 
use TEC
DELETE FROM Fag;

--insert into fag
INSERT INTO Fag(Fag, LærerID)
VALUES 
('Grundlæggende programmering', 1),
('Database programmering', 2),
('Studieteknik', 3);

use TEC
--CONCAT er Ligesom Combine i C#
Select 
CONCAT(Elev.FirstName, ' ', Elev.LastName) AS [Grundlæggende Programmering]
FROM Klasse AS PrintKlasse
--Join er et sæt af data
JOIN Elever AS Elev ON ElevID = Elev.ID
JOIN Fag As Faget ON FagID = Faget.ID
JOIN Lærer As Lære ON LærerID = Lære.ID

where Faget.Fag = 'Grundlæggende programmering'
order by Elev.ID DESC

use TEC
Select 
CONCAT(Elev.FirstName, ' ', Elev.LastName) AS [Database programmering]
FROM Klasse AS PrintKlasse
--Join er et sæt af data
JOIN Elever AS Elev ON ElevID = Elev.ID
JOIN Fag As Faget ON FagID = Faget.ID
JOIN Lærer As Lære ON LærerID = Lære.ID

where Faget.Fag = 'Database programmering'

Select 
CONCAT(Elev.FirstName, ' ', Elev.LastName) AS [Studieteknik] 
FROM Klasse AS PrintKlasse
--Join er et sæt af data
JOIN Elever AS Elev ON ElevID = Elev.ID
JOIN Fag As Faget ON FagID = Faget.ID
JOIN Lærer As Lære ON LærerID = Lære.ID

where Faget.Fag = 'Studieteknik'


use TEC
DECLARE @SøgElev as nvarchar(50) = 'Database programmering';

SELECT DISTINCT
CASE
    WHEN (SELECT COUNT(*) from Klasse JOIN Fag As Faget ON FagID = Faget.ID where Faget.Fag = @SøgElev) > 3 THEN 'Faget ' + @SøgElev + ' Har mere end 3 elever'
	ELSE CONCAT(Elev.FirstName,' ', Elev.LastName) 
END as [WARNING]
FROM Klasse AS PrintKlasse

JOIN Elever AS Elev ON ElevID = Elev.ID
JOIN Fag As Faget ON FagID = Faget.ID

where Faget.Fag = @SøgElev
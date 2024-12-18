--USE master;
--GO


--IF EXISTS (SELECT name FROM sys.databases WHERE name = N'MusicService')
--BEGIN
--    ALTER DATABASE MusicService SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
--    DROP DATABASE MusicService;
--END


--CREATE DATABASE MusicService
--ON PRIMARY
--(
--    NAME = MusicService_Data1,
--    FILENAME = 'C:\Data\MusicService_Data1.mdf',
--    SIZE = 150MB,
--    MAXSIZE = 500MB,
--    FILEGROWTH = 10MB
--),
--FILEGROUP MusicService_FG1
--(
--    NAME = MusicService_Data2,
--    FILENAME = 'C:\Data\MusicService_Data2.ndf',
--    SIZE = 150MB,
--    MAXSIZE = 500MB,
--    FILEGROWTH = 10MB
--),
--FILEGROUP MusicService_FG2
--(
--    NAME = MusicService_Data3,
--    FILENAME = 'C:\Data\MusicService_Data3.ndf',
--    SIZE = 150MB,
--    MAXSIZE = 500MB,
--    FILEGROWTH = 10MB
--)
--LOG ON
--(
--    NAME = MusicService_Log1,
--    FILENAME = 'C:\Log\MusicService_Log1.ldf',
--    SIZE = 10MB,
--    MAXSIZE = 500MB,
--    FILEGROWTH = 100%
--),
--(
--    NAME = MusicService_Log2,
--    FILENAME = 'C:\Log\MusicService_Log2.ldf',
--    SIZE = 10MB,
--    MAXSIZE = 500MB,
--    FILEGROWTH = 100%
--),
--(
--    NAME = MusicService_Log3,
--    FILENAME = 'C:\Log\MusicService_Log3.ldf',
--    SIZE = 10MB,
--    MAXSIZE = 500MB,
--    FILEGROWTH = 100%
--);




--IF OBJECT_ID('PlaybackSequences', 'U') IS NOT NULL
--    DROP TABLE PlaybackSequences;

--IF OBJECT_ID('UserPreferences', 'U') IS NOT NULL
--    DROP TABLE UserPreferences;

--IF OBJECT_ID('TrackGenres', 'U') IS NOT NULL
--    DROP TABLE TrackGenres;

--IF OBJECT_ID('Tracks', 'U') IS NOT NULL
--    DROP TABLE Tracks;

--IF OBJECT_ID('Genres', 'U') IS NOT NULL
--    DROP TABLE Genres;

--IF OBJECT_ID('Users', 'U') IS NOT NULL
--    DROP TABLE Users;

-- Создание таблиц
CREATE TABLE Tracks
(
    TrackID INT  IDENTITY(1,1),
    Title NVARCHAR(255) NOT NULL,
    FilePath NVARCHAR(255) NOT NULL,
    CONSTRAINT PK_Tracks PRIMARY KEY (TrackID)
);

CREATE TABLE Genres
(
    GenreID INT IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
	CONSTRAINT PK_Genres PRIMARY KEY (GenreID)
);

CREATE TABLE TrackGenres
(
    TrackID INT,
    GenreID INT,
    CONSTRAINT PK_TrackGenres PRIMARY KEY (TrackID, GenreID),
    CONSTRAINT FK_TrackGenres_Tracks FOREIGN KEY (TrackID) REFERENCES Tracks(TrackID),
    CONSTRAINT FK_TrackGenres_Genres FOREIGN KEY (GenreID) REFERENCES Genres(GenreID)
);

CREATE TABLE Users
(
    UserID INT  IDENTITY(1,1),
    Nickname NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(100) NOT NULL,
    FirstName NVARCHAR(100) NOT NULL,
	CONSTRAINT PK_Users PRIMARY KEY (UserID)
);

CREATE TABLE UserPreferences
(
    UserID INT,
    GenreID INT,
    CONSTRAINT PK_UserPreferences_User_Genre PRIMARY KEY (UserID, GenreID),
    CONSTRAINT FK_UserPreferences_Users  FOREIGN KEY (UserID) REFERENCES Users(UserID),
    CONSTRAINT FK_UserPreferences_Genre FOREIGN KEY (GenreID) REFERENCES Genres(GenreID)
);

CREATE TABLE PlaybackSequences
(
    SequenceID INT IDENTITY(1,1),
    UserID INT,
    Date DATE NOT NULL,           
    Time TIME NOT NULL,            
    FirstTrackID INT,
    SecondTrackID INT,
	CONSTRAINT PK_PlaybackSequences PRIMARY KEY (SequenceID),
    CONSTRAINT FK_PlaybackSequences_Users FOREIGN KEY (UserID) REFERENCES Users(UserID),
    CONSTRAINT FK_PlaybackSequences_FirstTrack FOREIGN KEY (FirstTrackID) REFERENCES Tracks(TrackID),
    CONSTRAINT FK_PlaybackSequences_SecondTrack FOREIGN KEY (SecondTrackID) REFERENCES Tracks(TrackID),
    CONSTRAINT CK_PlaybackSequences_Date CHECK (Date <= GETDATE())
);

INSERT INTO PlaybackSequences (UserID, Date, Time, FirstTrackID, SecondTrackID)
VALUES
-- Пользователь 1: несколько последовательностей
(1, '2024-11-01', '10:00:00', 1, 2),
(1, '2024-11-02', '11:00:00', 3, NULL),
(1, '2024-11-03', '14:00:00', 4, 5),

-- Пользователь 2: данные за текущий и предыдущие месяцы
(2, '2024-09-15', '12:30:00', 5, 2),
(2, '2024-10-10', '09:00:00', 1, NULL),
(2, '2024-11-20', '16:00:00', 4, NUll),

-- Пользователь 3: только текущий месяц
(3, '2024-11-01', '08:45:00', 2, NULL),
(3, '2024-11-15', '18:20:00', 3, 1)



select* from Tracks


INSERT INTO Users (Nickname, LastName, FirstName)
VALUES 
    ('UserA', 'Smith', 'Alice'),
    ('UserB', 'Johnson', 'Bob'),
    ('UserC', 'Williams', 'Carol')
	('Userа', 'Smith', 'Alice'),
    ('Userф', 'Johnson', 'Bob'),
    ('Userр', 'Williams', 'Carol');



INSERT INTO Tracks (Title, FilePath)
VALUES 
    ('Track 1', 'path/to/track1.mp3'),
    ('Track 2', 'path/to/track2.mp3'),
    ('Track 3', 'path/to/track3.mp3'),
    ('Track 4', 'path/to/track4.mp3'),
    ('Track 5', 'path/to/track5.mp3'),
    ('Track 6', 'path/to/track6.mp3'),
    ('Track 7', 'path/to/track7.mp3'),
    ('Track 8', 'path/to/track8.mp3'),
    ('Track 9', 'path/to/track9.mp3'),
    ('Track 10', 'path/to/track10.mp3'),
    ('Track 11', 'path/to/track11.mp3'),
    ('Track 12', 'path/to/track12.mp3'),
    ('Track 13', 'path/to/track13.mp3'),
    ('Track 14', 'path/to/track14.mp3'),
    ('Track 15', 'path/to/track15.mp3'),
    ('Track 16', 'path/to/track16.mp3'),
    ('Track 17', 'path/to/track17.mp3'),
    ('Track 18', 'path/to/track18.mp3'),
    ('Track 19', 'path/to/track19.mp3'),
    ('Track 20', 'path/to/track20.mp3');

INSERT INTO Genres (Name)
VALUES 
    ('Rock'),
    ('Pop'),
    ('Jazz');

INSERT INTO TrackGenres (TrackID, GenreID)
VALUES 
    (1, 1),  -- Track 1 - Rock
    (2, 2),  -- Track 2 - Pop
    (3, 3);  -- Track 3 - Jazz




select * from Users





	SELECT * FROM PlaybackSequences WHERE Date >= DATEADD(MONTH, -3, GETDATE());


 SELECT
        UserID,
        AVG(CAST(CASE 
                    WHEN SecondTrackID IS NULL THEN 1
                    ELSE 2
                   END AS FLOAT)) AS AvgTrackCountPrevious
    FROM
        PlaybackSequences
    WHERE
        Date >= DATEADD(MONTH, -3, GETDATE())
    GROUP BY
        UserID



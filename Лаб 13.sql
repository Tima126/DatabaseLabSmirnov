-- ‘ункци€, возвращающа€ количество треков в самой длинной последовательности воспроизведени€ дл€ заданного пользовател€.
CREATE FUNCTION GetLongestPlaybackSequenceLength (@UserID INT)
RETURNS INT
AS
BEGIN
    DECLARE @MaxLength INT;

    SELECT @MaxLength = MAX(SequenceLength)
    FROM (
        SELECT COUNT(*) AS SequenceLength
        FROM PlaybackSequences
        WHERE UserID = @UserID
        GROUP BY UserID, Date, Time
    ) AS Subquery;

    RETURN @MaxLength;
END;
SELECT dbo.GetLongestPlaybackSequenceLength(2) AS LongestSequenceLength;
-- ‘ункци€, возвращающа€ список пользователей, предпочитающих жанры, треки которых прослушивают больше 50% всех пользователей в текущем сезоне.
CREATE FUNCTION GetUsersPreferringPopularGenres()
RETURNS TABLE
AS
RETURN
(
    SELECT DISTINCT UP.UserID
    FROM UserPreferences UP
    JOIN TrackGenres TG ON UP.GenreID = TG.GenreID
    JOIN PlaybackSequences PS ON TG.TrackID = PS.FirstTrackID OR TG.TrackID = PS.SecondTrackID
    WHERE UP.GenreID IN (
        SELECT GenreID
        FROM (
            SELECT GenreID, COUNT(DISTINCT UserID) AS UserCount
            FROM UserPreferences
            GROUP BY GenreID
        ) AS GenreCounts
        WHERE UserCount > (SELECT COUNT(*) / 2 FROM Users)
    )
);





CREATE VIEW UsersWithDecreasedTrackCount AS

WITH PreviousThreeMonths AS (
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
),
CurrentMonth AS (
    SELECT
        UserID,
        AVG(CAST(CASE 
                    WHEN SecondTrackID IS NULL THEN 1
                    ELSE 2
                   END AS FLOAT)) AS AvgTrackCountCurrent
    FROM
        PlaybackSequences
    WHERE
        Date >= DATEADD(MONTH, -1, GETDATE())
    GROUP BY
        UserID
)
SELECT
    p.UserID,
    p.AvgTrackCountPrevious,
    c.AvgTrackCountCurrent
FROM
    PreviousThreeMonths p
JOIN
    CurrentMonth c ON p.UserID = c.UserID
WHERE
    c.AvgTrackCountCurrent < p.AvgTrackCountPrevious / 2;

select* from UsersWithDecreasedTrackCount
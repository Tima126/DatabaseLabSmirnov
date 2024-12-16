CREATE VIEW UserTrackCountReduction AS
WITH PlaybackSequencesWithSequence AS (
    SELECT
        UserID,
        FirstTrackID,
        SecondTrackID,
        Date,
        (SELECT COUNT(*) 
         FROM PlaybackSequences AS sub
         WHERE sub.UserID = main.UserID 
           AND sub.Date < main.Date 
           AND sub.SecondTrackID IS NULL) + 1 AS SequenceNumber
    FROM
        PlaybackSequences AS main
),
SequenceTrackCounts AS (
    SELECT
        UserID,
        SequenceNumber,
        COUNT(*) AS TrackCount,
        MIN(Date) AS SequenceStartDate 
    FROM
        PlaybackSequencesWithSequence
    GROUP BY
        UserID,
        SequenceNumber
)
SELECT
    p.UserID,
    AVG(CASE WHEN p.SequenceStartDate >= DATEADD(MONTH, -3, GETDATE()) THEN p.TrackCount END) AS AvgTrackCountPrevious,
    AVG(CASE WHEN p.SequenceStartDate >= DATEADD(MONTH, -1, GETDATE()) THEN p.TrackCount END) AS AvgTrackCountCurrent
FROM
    SequenceTrackCounts p
GROUP BY
    p.UserID
HAVING
    AVG(CASE WHEN p.SequenceStartDate >= DATEADD(MONTH, -1, GETDATE()) THEN p.TrackCount END) < 
    AVG(CASE WHEN p.SequenceStartDate >= DATEADD(MONTH, -3, GETDATE()) THEN p.TrackCount END) / 2;
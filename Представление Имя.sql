CREATE VIEW UserView AS
SELECT UserID, Nickname, LastName, FirstName
FROM Users
WHERE Nickname LIKE '[L-N]%'
WITH CHECK OPTION;

insert into UserView(Nickname, LastName,FirstName)
values('Leon', 'sff','sfsfs')

insert into UserView(Nickname, LastName,FirstName)
values('Geon', 'sff','sfsfs')

select * from UserView
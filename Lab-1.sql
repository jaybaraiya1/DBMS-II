select * from Artists
select * from Albums
select * from Songs 
 -- Part – A 
--1. Retrieve a unique genre of songs.
	select * from Songs 
	where Genre='Rhythmic'			
--2. Find top 2 albums released before 2010. 
	select top 2 Album_title from Albums
	where Release_year<2010
--3. Insert Data into the Songs Table. (1245, ‘Zaroor’, 2.55, ‘Feel good’, 1005) 
	insert into Songs values(1245,'Zaroor', 2.55, 'Feel good', 1005) 

--4. Change the Genre of the song ‘Zaroor’ to ‘Happy’ 
	update Songs
	set Genre='Happy'
	where Song_title='Zaroor'
--5. Delete an Artist ‘Ed Sheeran’ 
	delete from Artists
	where Artist_name='Ed Sheeran'
--6. Add a New Column for Rating in Songs Table. [Ratings decimal(3,2)] 
	alter table Songs
	add Rating decimal(3,2);
--7. Retrieve songs whose title starts with 'S'. 
	select * from Songs
	where Song_title like 'S%'
--8. Retrieve all songs whose title contains 'Everybody'. 
	select Song_title from Songs
	where Song_title like 'Everybody%'
--9. Display Artist Name in Uppercase. 
	select  upper(Artist_name) from Artists
--10. Find the Square Root of the Duration of a Song ‘Good Luck’ 
	select sqrt(Duration) from Songs
	where Song_title='Good Luck '
--11. Find Current Date.
	select getdate()
--12. Find the number of albums for each artist. 
	SELECT Artists.Artist_name, COUNT (Albums.Artist_id)
from Albums join Artists
on Albums.Artist_id = Artists.Artist_id
GROUP BY Artists.Artist_name
ORDER BY COUNT(Albums.Artist_id) DESC
--13. Retrieve the Album_id which has more than 5 songs in it. 
	select Album_id
	from Songs
	group by Album_id
	having COUNT(Album_id)>5
--d--14. Retrieve all songs from the album 'Album1'. (using Subquery)
	select Song_title
	from Songs
	where Album_id=(select Album_id from Albums where Album_title='Album1' )
--d--15. Retrieve all albums name from the artist ‘Aparshakti Khurana’ (using Subquery) 
	select Album_title
	from Albums
	where Artist_id=(select  Artist_id from  Artists where Artist_name='Aparshakti Khurana')
--16. Retrieve all the song titles with its album title. 
	select Songs.Song_title,Albums.Album_title
	from   Songs  join Albums
	on Songs.Album_id=Albums.Album_id

--17. Find all the songs which are released in 2020. 
	select Songs.Song_title,Albums.Release_year
	from   Songs  join Albums
	on Songs.Album_id=Albums.Album_id
	where Albums.Release_year=2020
--18. Create a view called ‘Fav_Songs’ from the songs table having songs with song_id 101-105.  
	create view Fav_Song
	as 
	select *
	from Songs
	where Song_id>101 and Song_id<105
	select * from Fav_Song
--19. Update a song name to ‘Jannat’ of song having song_id 101 in Fav_Songs view. 
	update Fav_Song
	set Song_title='Jannat'
	where Song_id=101
--20. Find all artists who have released an album in 2020.  
	select Artists.Artist_name,Albums.Release_year
	from Albums join Artists
	on Albums.Artist_id=Artists.Artist_id
	where Albums.Release_year=2020
--21. Retrieve all songs by Shreya Ghoshal and order them by duration.
	select Songs.Song_title,Albums.Release_year,Artists.Artist_name
	from Songs join Albums
	on Songs.AlbumID = Album.AlbumID
				join Artists
				ON
		  	Albums.Artist_id=Artists.Artist_id
	where Artists.Artist_name='Shreya Ghoshal '
	
--	Part – B 

--22. Retrieve all song titles by artists who have more than one album.  
		SELECT Artists.Artist_name, COUNT (Albums.Artist_id)
from Albums join Artists 
		Albums join Songs
on Albums.Artist_id = Artists.Artist_id
and
	Albums.Album_id =Songs.Album_id
 
having COUNT (Albums.Artist_id)>1


--23. Retrieve all albums along with the total number of songs.  
--24. Retrieve all songs and release year and sort them by release year.  
--25. Retrieve the total number of songs for each genre, showing genres that have more than 2 songs. 
--26. List all artists who have albums that contain more than 3 songs. 
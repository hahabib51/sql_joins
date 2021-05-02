1. List the films where the yr is 1962 [Show id, title]

SELECT id, title
 FROM movie
 WHERE yr=1962;


 id	        title
121	        To Kill a Mockingbird
479	        Dr. No
1082	    Music Man, The
1496	    What Ever Happened to Baby Jane?
1751	    Cape Fear


2. Give year of 'Citizen Kane'.


SELECT yr
FROM movie
WHERE title = 'Citizen Kane';


yr
1941


3. List all of the Star Trek movies, include the id, title and yr 
(all of these movies include the words Star Trek in the title). 
Order results by year.

SELECT id, title, yr
FROM movie
WHERE title LIKE '%Star Trek%'
ORDER BY yr;

id	title	                                yr
402	Star Trek: The Motion Picture	        1979
209	Star Trek: The Wrath of Khan	        1982
438	Star Trek III: The Search for Spock	    1984
349	Star Trek IV: The Voyage Home	        1986
472	Star Trek V: The Final Frontier	        1989
410	Star Trek VI: The Undiscovered Country	1991
280	Star Trek: Generations	                1994
68	Star Trek: First Contact	            1996
252	Star Trek: Insurrection	                1998

4. What id number does the actor 'Glenn Close' have?

SELECT id
FROM actor
WHERE name = 'Glenn Close';

id
104

5. What is the id of the film 'Casablanca'

SELECT id 
FROM movie
WHERE title = 'Casablanca';

id
27


6. Obtain the cast list for 'Casablanca'

SELECT actor.name
FROM actor
JOIN casting
ON casting.actorid = actor.id
WHERE casting.movieid = 27;

name
Humphrey Bogart
Ingrid Bergman
Claude Rains
Peter Lorre
Paul Henreid
John Qualen
Curt Bois
Conrad Veidt
Madeleine LeBeau

7. Obtain the cast list for the film 'Alien'

SELECT actor.name
FROM actor
JOIN casting
ON casting.actorid = actor.id
JOIN movie
ON movie.id = casting.movieid
WHERE movie.title = 'Alien';

Sigourney Weaver
Ian Holm
Harry Dean Stanton
Tom Skerritt
John Hurt
Veronica Cartwright
Yaphet Kotto


8. List the films in which 'Harrison Ford' has appeared

SELECT movie.title
FROM movie
JOIN casting
ON casting.movieid = movie.id
JOIN actor
ON actor.id = casting.actorid
WHERE actor.name = 'Harrison Ford';


title
Star Wars
Star Wars: Episode V - The Empire Strikes Back
Raiders of the Lost Ark
Star Wars: Episode VI - Return of the Jedi
Blade Runner
Indiana Jones and the Last Crusade
Fugitive, The
Apocalypse Now
Indiana Jones and the Temple of Doom
Air Force One
Witness
Clear and Present Danger
Patriot Games
American Graffiti
What Lies Beneath
Six Days Seven Nights
Working Girl
Sabrina
Devils Own, The
Conversation, The
Regarding Henry
Frantic
Presumed Innocent
Random Hearts
Mosquito Coast, The


9. List the films where 'Harrison Ford' has appeared - but not in the starring role. 
[Note: the ord field of casting gives the position of the actor. 
If ord=1 then this actor is in the starring role]

SELECT movie.title
FROM movie
JOIN casting
ON casting.movieid = movie.id
JOIN actor
ON actor.id = casting.actorid
WHERE actor.name = 'Harrison Ford'
AND casting.ord != 1;

Star Wars
Star Wars: Episode V - The Empire Strikes Back
Star Wars: Episode VI - Return of the Jedi
Apocalypse Now
American Graffiti
Conversation, The

10. List the films together with the leading star for all 1962 films.

SELECT movie.title, actor.name
FROM movie
JOIN casting
ON casting.movieid = movie.id
JOIN actor
ON actor.id = casting.actorid
WHERE movie.yr = 1962
AND casting.ord = 1;

title	                                name
To Kill a Mockingbird	            Gregory Peck
Dr. No	                            Sean Connery
Music Man, The	                    Robert Preston (I)
What Ever Happened to Baby Jane?	Bette Davis
Cape Fear	                        Gregory Peck


11. Which were the busiest years for 'Rock Hudson', show the year and the number of movies 
he made each year for any year in which he made more than 2 movies.

SELECT movie.yr, COUNT(*)
FROM movie
JOIN casting
ON casting.movieid = movie.id
JOIN actor
ON actor.id = casting.actorid
WHERE actor.name = 'John Travolta'
GROUP BY movie.yr
HAVING COUNT(movie.title) >= 2;

yr	
1996	2
1998	2

12.
List the film title and 
the leading actor for all of the films 'Julie Andrews' played in.

SELECT DISTINCT m.title, a.name
FROM (SELECT movie.*
      FROM movie
      JOIN casting
      ON casting.movieid = movie.id
      JOIN actor
      ON actor.id = casting.actorid
      WHERE actor.name = 'Julie Andrews') AS m
JOIN (SELECT actor.*, casting.movieid AS movieid
      FROM actor
      JOIN casting
      ON casting.actorid = actor.id
      WHERE casting.ord = 1) as a
ON m.id = a.movieid
ORDER BY m.title;


title	                name
10	                    Dudley Moore
Sound of Music, The	    Julie Andrews
Victor/Victoria	        Julie Andrews


13. Obtain a list, 
in alphabetical order, of actors 
who have had at least 15 starring roles.

SELECT actor.name
FROM actor
JOIN casting
ON casting.actorid = actor.id
WHERE casting.ord = 1
GROUP BY actor.name
HAVING COUNT(*) >= 15;

name
Al Pacino
Arnold Schwarzenegger
Clint Eastwood
Harrison Ford
Robert De Niro
Robin Williams
Sean Connery
Sylvester Stallone
Tom Hanks


14. List the films released in the year 1978 
ordered by the number of actors 
in the cast, then by title.

SELECT title, COUNT(actorid) FROM movie JOIN casting ON movie.id = movieid WHERE yr = 1978
  GROUP BY title ORDER BY COUNT(actorid) DESC, title

title	
Death on the Nile	12
Capricorn One	11
Foul Play	11
Heaven Can Wait	11
Animal House	9
Boys from Brazil, The	9
Midnight Express	9
Superman	9
Watership Down	9
Deer Hunter, The	8
Grease	8
Halloween	8
Attack of the Killer Tomatoes!	7
Coma	7
Damien: Omen II	7
Days of Heaven	6
Up in Smoke	6
Dawn of the Dead	5

15. List all the people who have worked with 'Art Garfunkel'.

SELECT a.name
  FROM (SELECT movie.*
          FROM movie
          JOIN casting
            ON casting.movieid = movie.id
          JOIN actor
            ON actor.id = casting.actorid
         WHERE actor.name = 'Art Garfunkel') AS m
  JOIN (SELECT actor.*, casting.movieid
          FROM actor
          JOIN casting
            ON casting.actorid = actor.id
         WHERE actor.name != 'Art Garfunkel') as a
    ON m.id = a.movieid;

    

    name
Jon Voight
Orson Welles
Martin Sheen
Richard Benjamin
Martin Balsam
Alan Arkin
Bob Balaban
Anthony Perkins
Jack Gilford
Buck Henry
Norman Fell
Bob Newhart
Bill Paxton
Kurtwood Smith
Julian Sands
Sherilyn Fenn
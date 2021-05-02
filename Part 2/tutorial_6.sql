1. show the matchid and player name for all goals scored by Germany. 
To identify German players, check for: teamid = 'GER'

SELECT matchid, player
FROM goal
WHERE teamid = 'GER';

matchid	player
1008	Mario Gómez
1010	Mario Gómez
1010	Mario Gómez
1012	Lukas Podolski
1012	Lars Bender
1026	Philipp Lahm
1026	Sami Khedira
1026	Miroslav Klose
1026	Marco Reus
1030	Mesut Özil

2. Show id, stadium, team1, team2 for just game 1012

SELECT id,stadium,team1,team2
FROM game
WHERE id = 1012;

id	    stadium	    team1	team2
1012	Arena Lviv	DEN	    GER

3. show the player, teamid, stadium and mdate for every German goal.

SELECT player, teamid, mdate
FROM game
JOIN goal ON (game.id = goal.matchid)
WHERE teamid = 'GER';

player	        teamid	        mdate
Mario Gómez	    GER	    2012-06-09T00:00:00
Mario Gómez	    GER	    2012-06-13T00:00:00
Mario Gómez	    GER	    2012-06-13T00:00:00
Lukas Podolski	GER	    2012-06-17T00:00:00
Lars Bender	    GER	    2012-06-17T00:00:00
Philipp Lahm	GER	    2012-06-22T00:00:00
Sami Khedira	GER	    2012-06-22T00:00:00
Miroslav Klose	GER	    2012-06-22T00:00:00
Marco Reus	    GER	    2012-06-22T00:00:00
Mesut Özil	    GER	    2012-06-28T00:00:00

4. Show the team1, team2 and player for every goal scored 
by a player called Mario player LIKE 'Mario%'

SELECT team1, team2, player
FROM goal
JOIN game ON (game.id = goal.matchid)
WHERE player LIKE 'Mario%';

team1	team2	player
GER	    POR	    Mario Gómez
NED	    GER 	Mario Gómez
NED	    GER	    Mario Gómez
IRL	    CRO	    Mario Mandžukic
IRL	    CRO	    Mario Mandžukic
ITA	    CRO	    Mario Mandžukic
ITA	    IRL 	Mario Balotelli
GER	    ITA	    Mario Balotelli
GER	    ITA	    Mario Balotelli

5. Show player, teamid, coach, gtime 
for all goals scored in the first 10 minutes gtime<=10

SELECT player, teamid, coach, gtime
FROM goal
JOIN eteam ON (goal.teamid = eteam.id)
WHERE gtime <= 10;

player	        teamid	    coach	        gtime
Petr Jirácek	CZE	        Michal Bílek	    3
Václav Pilar	CZE	        Michal Bílek	    6
Mario Mandžukic	CRO	        Slaven Bilic	    3
Fernando Torres	ESP	        Vicente del Bosque	4


6. List the dates of the matches and the name of the team 
in which 'Fernando Santos' was the team1 coach.

SELECT mdate, teamname
FROM game
JOIN eteam ON (game.team1 = eteam.id)
WHERE coach = 'Fernando Santos';

mdate	            teamname
2012-06-12T00:00:00	Greece
2012-06-16T00:00:00	Greece

7. List the player for every goal scored in a game 
where the stadium was 'National Stadium, Warsaw'

SELECT player
FROM goal
JOIN game ON (goal.matchid = game.id)
WHERE stadium = 'National Stadium, Warsaw';

player
Dimitris Salpingidis
Robert Lewandowski
Jakub Blaszczykowski
Alan Dzagoev
Giorgos Karagounis
Cristiano Ronaldo
Mesut Özil
Mario Balotelli
Mario Balotelli

8. Show the name of all players who scored a goal against Germany.

SELECT DISTINCT player
FROM game
JOIN goal ON goal.matchid = game.id
WHERE (team1 = 'GER' OR team2 = 'GER')
AND teamid <> 'GER';

player
Dimitris Salpingidis
Georgios Samaras
Mario Balotelli
Michael Krohn-Dehli
Robin van Persie

9. Show teamname and the total number of goals scored.

SELECT teamname, COUNT(player) goals_scored
FROM eteam JOIN goal ON eteam.id = goal.teamid
GROUP BY teamname

teamname	goals_scored
Croatia	4
Czech Republic	4
Denmark	4
England	5
France	3
Germany	10
Greece	5
Italy	6
Netherlands	2
Poland	2
Portugal	6
Republic of Ireland	1
Russia	5
Spain	12
Sweden	5
Ukraine	2


10. Show the stadium and the number of goals scored in each stadium.

SELECT stadium, COUNT(player) goals_scored
FROM game
JOIN goal ON game.id = goal.matchid
GROUP BY stadium;

stadium	        goals_scored
Arena Lviv      	                9
Donbass Arena	                    7
Metalist Stadium	                7
National Stadium, Warsaw	        9
Olimpiyskiy National Sports Complex	14
PGE Arena Gdansk	                13
Stadion Miejski (Poznan)	         8
Stadion Miejski (Wroclaw)	        9

11.For every match involving 'POL', 
show the matchid, date and the number of goals scored.


SELECT matchid, mdate, COUNT(player) goals_scored
FROM game
JOIN goal ON goal.matchid = game.id
WHERE (team1 = 'POL' OR team2 = 'POL')
GROUP BY goal.matchid, mdate;

matchid	mdate	goals_scored
1001	2012-06-08T00:00:00	2
1004	2012-06-12T00:00:00	2
1005	2012-06-16T00:00:00	1

12. For every match where 'GER' scored, show matchid, 
match date and the number of goals scored by 'GER'

SELECT matchid, mdate, COUNT(player)
FROM game
JOIN goal ON game.id = goal.matchid
WHERE teamid = 'GER'
GROUP BY game.id, goal.matchid, game.mdate;

matchid	mdate	            score
1008	2012-06-09T00:00:00	    1
1010	2012-06-13T00:00:00	    2
1012	2012-06-17T00:00:00	    2
1026	2012-06-22T00:00:00	    4
1030	2012-06-28T00:00:00	    1

List every match with the goals scored by each team as shown. 

Sort your result by mdate, matchid, team1 and team2.

SELECT mdate,
  team1,
  SUM(CASE WHEN teamid=team1 THEN 1 ELSE 0 END) score1,
  team2,
  SUM(CASE WHEN teamid=team2 THEN 1 ELSE 0 END) score2
  FROM game LEFT JOIN goal ON matchid = id 
GROUP BY mdate,matchid,team1,team2;


mdate	            team1	score1	team2	score2
2012-06-08T00:00:00	POL	        1	GRE	        1
2012-06-08T00:00:00	RUS	        4	CZE	        1
2012-06-09T00:00:00	NED	        0	DEN	        1
2012-06-09T00:00:00	GER	        1	POR	        0
2012-06-10T00:00:00	ESP	        1	ITA	        1
2012-06-10T00:00:00	IRL	        1	CRO	        3
2012-06-11T00:00:00	FRA	        1	ENG	        1
2012-06-11T00:00:00	UKR	        2	SWE	        1
2012-06-12T00:00:00	GRE	        1	CZE	        2
2012-06-12T00:00:00	POL	        1	RUS	        1
2012-06-13T00:00:00	DEN	        2	POR	        3
2012-06-13T00:00:00	NED	        1	GER	        2
2012-06-14T00:00:00	ITA	        1	CRO	        1
2012-06-14T00:00:00	ESP	        4	IRL     	0
2012-06-15T00:00:00	UKR	        0	FRA     	2
2012-06-15T00:00:00	SWE	        2	ENG         3
2012-06-16T00:00:00	CZE	        1	POL     	0
2012-06-16T00:00:00	GRE	        1	RUS	        0
2012-06-17T00:00:00	POR	        2	NED	        1
2012-06-17T00:00:00	DEN	        1	GER	        2
2012-06-18T00:00:00	CRO	        0	ESP	        1
2012-06-18T00:00:00	ITA	        2	IRL	        0
2012-06-19T00:00:00	ENG	        1	UKR	        0
2012-06-19T00:00:00	SWE	        2	FRA	        0
2012-06-21T00:00:00	CZE     	0	POR	        1
2012-06-22T00:00:00	GER	        4	GRE	        2
2012-06-23T00:00:00	ESP	        2	FRA	        0
2012-06-24T00:00:00	ENG     	0	ITA     	0
2012-06-27T00:00:00	POR     	0	ESP     	0
2012-06-28T00:00:00	GER     	1	ITA	        2
2012-07-01T00:00:00	ESP     	4	ITA	        0
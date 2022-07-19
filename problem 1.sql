create database assignment;
use assignment;
CREATE TABLE matches (
id int(11) NOT NULL,
  match_id int(64) NOT NULL,
  host_team int(64) NOT NULL,
  guest_team int(64) NOT NULL,
  host_goals int(64) NOT NULL,
  guest_goals int(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO matches (id, match_id, host_team, guest_team, host_goals, guest_goals) VALUES
(1, 1, 10, 20, 3, 0),
(2, 2, 30, 10, 2, 2),
(3, 3, 10, 50, 5, 1),
(4, 4, 20, 30, 1, 0),
(5, 5, 50, 30, 1, 0);

select * from matches;

ALTER TABLE matches
  ADD PRIMARY KEY (id);
  
ALTER TABLE matches
  MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
commit;
  
CREATE TABLE teams (
  id int(11) NOT NULL,
  team_id int(64) NOT NULL,
  team_name varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO teams (id, team_id, team_name) VALUES
(1, 10, 'FC Barcelona'),
(2, 20, 'NewYork FC'),
(3, 30, 'Atlanta FC'),
(4, 40, 'Chicago FC'),
(5, 50, 'Toronto FC');

ALTER TABLE teams
  ADD PRIMARY KEY (id);
  
ALTER TABLE teams
  MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
commit;

-- created temp table to calculate point for both the host and guest team with given condition

With score_goal as
(
SELECT *, 
CASE WHEN host_goals > guest_goals THEN 3 
WHEN host_goals = guest_goals THEN 1 
WHEN host_goals < guest_goals THEN 0 
END as host_points,
CASE WHEN host_goals < guest_goals THEN 3 
WHEN host_goals = guest_goals THEN 1 
WHEN host_goals > guest_goals THEN 0 
END as guest_points

FROM Matches
)


, total_point as(
SELECT 
	a.TEAM_ID,
	SUM(a.TOTAL_PT) AS TOTAL_SCORE
FROM
(
SELECT
  host_team as team_id,
  SUM(host_points) as total_pt
 FROM 
	score_goal 
 GROUP BY 1
 UNION ALL
 SELECT
  guest_team as team_id,
  SUM(guest_points) as total_pt
 FROM 
	score_goal
 GROUP BY 1

) as a
GROUP BY 1
)

-- we fetch the team_id, team_name and num_points using a sub_query.

SELECT distinct 
tm.TEAM_ID,
tm.TEAM_NAME,
coalesce(tp.total_score,0) as num_points
From
(select distinct team_id, team_name from Teams) as tm
left join
Total_point as tp
on tm.team_id=tp.team_id
Order by Tp.total_score DESC, tm.TEAM_ID ASC;
  


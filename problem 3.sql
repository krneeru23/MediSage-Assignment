CREATE TABLE activities (
  id int(11) NOT NULL,
  name varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


INSERT INTO activities (id, name) VALUES
(1, 'Eating'),
(2, 'Singing'),
(3, 'Horse Riding');

ALTER TABLE activities
  ADD PRIMARY KEY (id);
  
ALTER TABLE activities
  MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
  
  
CREATE TABLE friends (
  id int(11) NOT NULL,
  name varchar(255) NOT NULL,
  activity varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO friends (id, name, activity) VALUES
(1, 'Jonathan D.', 'Eating'),
(2, 'Jade W.', 'Singing'),
(3, 'Victor J.', 'Singing'),
(4, 'Elvis Q.', 'Eating'),
(5, 'Daniel A.', 'Eating'),
(6, 'Bob B.', 'Horse Riding');

select * from activities;

ALTER TABLE friends
  ADD PRIMARY KEY (id);
  
ALTER TABLE friends
  MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

-- create a temp table and using subquery 
  
WITH activity_count as (
SELECT
    activity,
    COUNT(*) as total_count
FROM Friends
GROUP BY 1
)
select activity from friends group by 1 having count(*)<(select max(total_count) from activity_count) and 
count(*)>(select min(total_count) from activity_count);

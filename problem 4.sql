CREATE TABLE exams (
  exam_id int(64) NOT NULL,
  student_id int(64) NOT NULL,
  score int(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO exams (exam_id, student_id, score) VALUES
(10, 1, 70),
(10, 2, 80),
(10, 3, 90),
(20, 1, 80),
(30, 1, 70),
(30, 3, 80),
(30, 4, 90),
(40, 1, 60),
(40, 2, 70),
(40, 4, 80);


CREATE TABLE students (
  student_id int(64) NOT NULL,
  student_name varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO students (student_id, student_name) VALUES
(1, 'Daniel'),
(2, 'Jade'),
(3, 'Stella'),
(4, 'Jonathan'),
(5, 'Will');

/* Write an SQL query to report the students (student_id, student_name) being quiet in all exams.
 Do not return the student who has never taken any exam.*/
 
select distinct s.student_id, s.student_name
from students as s join exams as e
on s.student_id = e.student_id
where s.student_id not in 
(select e1.student_id
from exams as e1  join
(select exam_id, min(score) as min_score, max(score) as max_score
from exams
group by exam_id) as e2
on e1.exam_id = e2.exam_id
where e1.score = e2.min_score or e1.score = e2.max_score)
order by student_id;

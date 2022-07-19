use assignment;

CREATE TABLE employee (
  employee_id int(64) NOT NULL,
  name varchar(255) NOT NULL,
  experience_years int(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO employee (employee_id, name, experience_years) VALUES
(1, 'Suraj', 3),
(2, 'Anurag', 2),
(3, 'John', 3),
(4, 'Nikhil', 2);

select * from employee;



CREATE TABLE project (
  project_id int(64) NOT NULL,
  employee_id int(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



INSERT INTO project (project_id, employee_id) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 1),
(2, 4);


-- create a temp table the name of employee_rank
-- using dense_rank() because in ques, they asked in case of tie report all employee with max no of exp in yrs.

with employee_rank as
(Select 
p.project_id,
p.employee_id,
e.experience_years,
Dense_rank() over (partition by p.project_id order by e.experience_years desc) as rank_experience
From 
project as p
Join
Employee  as e
on p.employee_id=e.employee_id
) 
select distinct project_id, employee_id from employee_rank where rank_experience=1;
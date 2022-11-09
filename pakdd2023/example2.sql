SELECT count(*) FROM department 
WHERE department_id NOT IN 
(SELECT department_id FROM management)
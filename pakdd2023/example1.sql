SELECT T1.department_id, T1.name, count(*) 
FROM management AS T2 JOIN department AS T1 
ON T1.department_id=T2.department_id 
GROUP BY T1.department_id
HAVING count(*) > 1
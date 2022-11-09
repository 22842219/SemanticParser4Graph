MATCH ()-[T2:management]-(T1:department)
WITH T1.Department_ID AS Department_ID, 
count(*) AS count, T1.Name AS Name
WHERE count  > 1
RETURN Department_ID, Name, count

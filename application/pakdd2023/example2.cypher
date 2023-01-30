MATCH (d:department)
WHERE NOT (d:department)-[:management]-()
RETURN count(*)

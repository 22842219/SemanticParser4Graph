SELECT count(*) FROM head WHERE age  >  56
SELECT name ,  born_state ,  age FROM head ORDER BY age
SELECT creation ,  name ,  budget_in_billions FROM department
SELECT max(budget_in_billions) ,  min(budget_in_billions) FROM department
SELECT avg(num_employees) FROM department WHERE ranking BETWEEN 10 AND 15
SELECT name FROM head WHERE born_state != 'California'
SELECT DISTINCT T1.creation FROM department AS T1 JOIN management AS T2 ON T1.department_id  =  T2.department_id JOIN head AS T3 ON T2.head_id  =  T3.head_id WHERE T3.born_state  =  'Alabama'
SELECT born_state FROM head GROUP BY born_state HAVING count(*)  >=  3
SELECT creation FROM department GROUP BY creation ORDER BY count(*) DESC LIMIT 1
SELECT T1.name ,  T1.num_employees FROM department AS T1 JOIN management AS T2 ON T1.department_id  =  T2.department_id WHERE T2.temporary_acting  =  'Yes'
SELECT count(*) FROM department WHERE department_id NOT IN (SELECT department_id FROM management);
SELECT DISTINCT T1.age FROM management AS T2 JOIN head AS T1 ON T1.head_id  =  T2.head_id WHERE T2.temporary_acting  =  'Yes'
SELECT T1.department_id ,  T1.name ,  count(*) FROM management AS T2 JOIN department AS T1 ON T1.department_id  =  T2.department_id GROUP BY T1.department_id HAVING count(*)  >  1
SELECT head_id ,  name FROM head WHERE name LIKE '%Ha%'
SELECT count(*) FROM farm
SELECT count(*) FROM farm
SELECT Total_Horses FROM farm ORDER BY Total_Horses ASC
SELECT Total_Horses FROM farm ORDER BY Total_Horses ASC
SELECT Hosts FROM farm_competition WHERE Theme !=  'Aliens'
SELECT Hosts FROM farm_competition WHERE Theme !=  'Aliens'
SELECT Theme FROM farm_competition ORDER BY YEAR ASC
SELECT Theme FROM farm_competition ORDER BY YEAR ASC
SELECT max(Cows) ,  min(Cows) FROM farm
SELECT max(Cows) ,  min(Cows) FROM farm
SELECT Official_Name FROM city ORDER BY Population DESC
SELECT Official_Name FROM city ORDER BY Population DESC
SELECT Official_Name ,  Status FROM city ORDER BY Population DESC LIMIT 1
SELECT Official_Name ,  Status FROM city ORDER BY Population DESC LIMIT 1
SELECT T2.Year ,  T1.Official_Name FROM city AS T1 JOIN farm_competition AS T2 ON T1.City_ID  =  T2.Host_city_ID
SELECT T2.Year ,  T1.Official_Name FROM city AS T1 JOIN farm_competition AS T2 ON T1.City_ID  =  T2.Host_city_ID
SELECT T1.Official_Name FROM city AS T1 JOIN farm_competition AS T2 ON T1.City_ID  =  T2.Host_city_ID GROUP BY T2.Host_city_ID HAVING COUNT(*)  >  1
SELECT T1.Official_Name FROM city AS T1 JOIN farm_competition AS T2 ON T1.City_ID  =  T2.Host_city_ID GROUP BY T2.Host_city_ID HAVING COUNT(*)  >  1
SELECT T1.Status FROM city AS T1 JOIN farm_competition AS T2 ON T1.City_ID  =  T2.Host_city_ID GROUP BY T2.Host_city_ID ORDER BY COUNT(*) DESC LIMIT 1
SELECT T1.Status FROM city AS T1 JOIN farm_competition AS T2 ON T1.City_ID  =  T2.Host_city_ID GROUP BY T2.Host_city_ID ORDER BY COUNT(*) DESC LIMIT 1
SELECT T2.Theme FROM city AS T1 JOIN farm_competition AS T2 ON T1.City_ID  =  T2.Host_city_ID WHERE T1.Population  >  1000
SELECT T2.Theme FROM city AS T1 JOIN farm_competition AS T2 ON T1.City_ID  =  T2.Host_city_ID WHERE T1.Population  >  1000
SELECT Status FROM city GROUP BY Status ORDER BY COUNT(*) ASC
SELECT Status FROM city GROUP BY Status ORDER BY COUNT(*) ASC
SELECT Status FROM city GROUP BY Status ORDER BY COUNT(*) DESC LIMIT 1
SELECT Status FROM city GROUP BY Status ORDER BY COUNT(*) DESC LIMIT 1
SELECT Official_Name FROM city WHERE City_ID NOT IN (SELECT Host_city_ID FROM farm_competition)
SELECT Official_Name FROM city WHERE City_ID NOT IN (SELECT Host_city_ID FROM farm_competition)
SELECT Official_Name FROM city WHERE Population  >  1500 OR Population  <  500
SELECT Official_Name FROM city WHERE Population  >  1500 OR Population  <  500
SELECT Census_Ranking FROM city WHERE Status !=  "Village"
SELECT Census_Ranking FROM city WHERE Status !=  "Village"
SELECT T1.course_name FROM courses AS T1 JOIN student_course_registrations AS T2 ON T1.course_id = T2.course_Id GROUP BY T1.course_id ORDER BY count(*) DESC LIMIT 1
SELECT T1.course_name FROM courses AS T1 JOIN student_course_registrations AS T2 ON T1.course_id = T2.course_Id GROUP BY T1.course_id ORDER BY count(*) DESC LIMIT 1
SELECT student_id FROM student_course_registrations GROUP BY student_id ORDER BY count(*) LIMIT 1
SELECT student_id FROM student_course_registrations GROUP BY student_id ORDER BY count(*) LIMIT 1
SELECT T2.first_name ,  T2.last_name FROM candidates AS T1 JOIN people AS T2 ON T1.candidate_id = T2.person_id
SELECT T2.first_name ,  T2.last_name FROM candidates AS T1 JOIN people AS T2 ON T1.candidate_id = T2.person_id
SELECT student_id FROM student_course_attendance
SELECT student_id FROM student_course_attendance
SELECT T1.student_id ,  T2.course_name FROM student_course_registrations AS T1 JOIN courses AS T2 ON T1.course_id = T2.course_id
SELECT candidate_id FROM candidate_assessments ORDER BY assessment_date DESC LIMIT 1
SELECT candidate_id FROM candidate_assessments ORDER BY assessment_date DESC LIMIT 1
SELECT T1.student_details FROM students AS T1 JOIN student_course_registrations AS T2 ON T1.student_id = T2.student_id GROUP BY T1.student_id ORDER BY count(*) DESC LIMIT 1
SELECT T1.student_details FROM students AS T1 JOIN student_course_registrations AS T2 ON T1.student_id = T2.student_id GROUP BY T1.student_id ORDER BY count(*) DESC LIMIT 1
SELECT T1.student_id ,  count(*) FROM students AS T1 JOIN student_course_registrations AS T2 ON T1.student_id = T2.student_id GROUP BY T1.student_id
SELECT T1.student_id ,  count(*) FROM students AS T1 JOIN student_course_registrations AS T2 ON T1.student_id = T2.student_id GROUP BY T1.student_id
SELECT T3.course_name ,  count(*) FROM students AS T1 JOIN student_course_registrations AS T2 ON T1.student_id = T2.student_id JOIN courses AS T3 ON T2.course_id = T3.course_id GROUP BY T2.course_id
SELECT T3.course_name ,  count(*) FROM students AS T1 JOIN student_course_registrations AS T2 ON T1.student_id = T2.student_id JOIN courses AS T3 ON T2.course_id = T3.course_id GROUP BY T2.course_id
SELECT candidate_id FROM candidate_assessments WHERE asessment_outcome_code = "Pass"
SELECT candidate_id FROM candidate_assessments WHERE asessment_outcome_code = "Pass"
SELECT T3.cell_mobile_number FROM candidates AS T1 JOIN candidate_assessments AS T2 ON T1.candidate_id = T2.candidate_id JOIN people AS T3 ON T1.candidate_id = T3.person_id WHERE T2.asessment_outcome_code = "Fail"
SELECT T3.cell_mobile_number FROM candidates AS T1 JOIN candidate_assessments AS T2 ON T1.candidate_id = T2.candidate_id JOIN people AS T3 ON T1.candidate_id = T3.person_id WHERE T2.asessment_outcome_code = "Fail"
SELECT student_id FROM student_course_attendance WHERE course_id  =  301
SELECT student_id FROM student_course_attendance WHERE course_id  =  301
SELECT student_id FROM student_course_attendance WHERE course_id = 301 ORDER BY date_of_attendance DESC LIMIT 1
SELECT student_id FROM student_course_attendance WHERE course_id = 301 ORDER BY date_of_attendance DESC LIMIT 1
SELECT DISTINCT T1.city FROM addresses AS T1 JOIN people_addresses AS T2 ON T1.address_id = T2.address_id
SELECT DISTINCT T1.city FROM addresses AS T1 JOIN people_addresses AS T2 ON T1.address_id = T2.address_id
SELECT DISTINCT T1.city FROM addresses AS T1 JOIN people_addresses AS T2 ON T1.address_id = T2.address_id JOIN students AS T3 ON T2.person_id = T3.student_id
SELECT DISTINCT T1.city FROM addresses AS T1 JOIN people_addresses AS T2 ON T1.address_id = T2.address_id JOIN students AS T3 ON T2.person_id = T3.student_id
SELECT course_name FROM courses ORDER BY course_name
SELECT course_name FROM courses ORDER BY course_name
SELECT first_name FROM people ORDER BY first_name
SELECT first_name FROM people ORDER BY first_name
SELECT date FROM weather WHERE max_temperature_f  >  85
SELECT date FROM weather WHERE max_temperature_f  >  85
SELECT city ,  max(lat) FROM station GROUP BY city
SELECT city ,  max(lat) FROM station GROUP BY city
SELECT start_station_name ,  end_station_name FROM trip ORDER BY id LIMIT 3
SELECT start_station_name ,  end_station_name FROM trip ORDER BY id LIMIT 3
SELECT id FROM trip ORDER BY duration LIMIT 1
SELECT id FROM trip ORDER BY duration LIMIT 1
SELECT zip_code  ,  avg(mean_temperature_f) FROM weather WHERE date LIKE "8/%" GROUP BY zip_code
SELECT zip_code  ,  avg(mean_temperature_f) FROM weather WHERE date LIKE "8/%" GROUP BY zip_code
SELECT DISTINCT T1.name FROM station AS T1 JOIN status AS T2 ON T1.id  =  T2.station_id WHERE T2.bikes_available  =  7
SELECT DISTINCT T1.name FROM station AS T1 JOIN status AS T2 ON T1.id  =  T2.station_id WHERE T2.bikes_available  =  7
SELECT start_station_name ,  start_station_id FROM trip WHERE start_date LIKE "8/%" GROUP BY start_station_name ORDER BY COUNT(*) DESC LIMIT 1
SELECT start_station_name ,  start_station_id FROM trip WHERE start_date LIKE "8/%" GROUP BY start_station_name ORDER BY COUNT(*) DESC LIMIT 1
SELECT bike_id FROM trip WHERE zip_code  =  94002 GROUP BY bike_id ORDER BY COUNT(*) DESC LIMIT 1
SELECT bike_id FROM trip WHERE zip_code  =  94002 GROUP BY bike_id ORDER BY COUNT(*) DESC LIMIT 1
SELECT T1.lat ,  T1.long ,  T1.city FROM station AS T1 JOIN trip AS T2 ON T1.id  =  T2.start_station_id ORDER BY T2.duration LIMIT 1
SELECT T1.lat ,  T1.long ,  T1.city FROM station AS T1 JOIN trip AS T2 ON T1.id  =  T2.start_station_id ORDER BY T2.duration LIMIT 1
SELECT cloud_cover FROM weather WHERE zip_code  =  94107 GROUP BY cloud_cover ORDER BY COUNT (*) DESC LIMIT 3
SELECT cloud_cover FROM weather WHERE zip_code  =  94107 GROUP BY cloud_cover ORDER BY COUNT (*) DESC LIMIT 3
SELECT date ,  zip_code FROM weather WHERE max_temperature_f  >=  80
SELECT date ,  zip_code FROM weather WHERE max_temperature_f  >=  80
SELECT zip_code , count(*) FROM weather WHERE max_wind_Speed_mph  >=  25 GROUP BY zip_code
SELECT zip_code , count(*) FROM weather WHERE max_wind_Speed_mph  >=  25 GROUP BY zip_code
SELECT T1.id ,  T2.installation_date FROM trip AS T1 JOIN station AS T2 ON T1.end_station_id  =  T2.id
SELECT T1.id ,  T2.installation_date FROM trip AS T1 JOIN station AS T2 ON T1.end_station_id  =  T2.id
SELECT T1.id FROM trip AS T1 JOIN station AS T2 ON T1.start_station_id  =  T2.id ORDER BY T2.dock_count DESC LIMIT 1
SELECT T1.id FROM trip AS T1 JOIN station AS T2 ON T1.start_station_id  =  T2.id ORDER BY T2.dock_count DESC LIMIT 1
SELECT date FROM weather WHERE zip_code  =  94107 AND EVENTS != "Fog" AND EVENTS != "Rain"
SELECT date FROM weather WHERE zip_code  =  94107 AND EVENTS != "Fog" AND EVENTS != "Rain"
SELECT name ,  lat ,  city FROM station ORDER BY lat LIMIT 1
SELECT name ,  lat ,  city FROM station ORDER BY lat LIMIT 1
SELECT date ,  mean_temperature_f ,  mean_humidity FROM weather ORDER BY max_gust_speed_mph DESC LIMIT 3
SELECT date ,  mean_temperature_f ,  mean_humidity FROM weather ORDER BY max_gust_speed_mph DESC LIMIT 3
SELECT city ,  COUNT(*) FROM station GROUP BY city HAVING COUNT(*)  >=  15
SELECT city ,  COUNT(*) FROM station GROUP BY city HAVING COUNT(*)  >=  15
SELECT start_station_id ,  start_station_name FROM trip GROUP BY start_station_name HAVING COUNT(*)  >=  200
SELECT start_station_id ,  start_station_name FROM trip GROUP BY start_station_name HAVING COUNT(*)  >=  200
SELECT date ,  cloud_cover FROM weather ORDER BY cloud_cover DESC LIMIT 5
SELECT date ,  cloud_cover FROM weather ORDER BY cloud_cover DESC LIMIT 5
SELECT id ,  duration FROM trip ORDER BY duration DESC LIMIT 3
SELECT id ,  duration FROM trip ORDER BY duration DESC LIMIT 3
SELECT T1.name ,  T1.long ,  avg(T2.duration) FROM station AS T1 JOIN trip AS T2 ON T1.id  =  T2.start_station_id GROUP BY T2.start_station_id
SELECT T1.name ,  T1.long ,  avg(T2.duration) FROM station AS T1 JOIN trip AS T2 ON T1.id  =  T2.start_station_id GROUP BY T2.start_station_id
SELECT T1.name ,  T1.lat ,  min(T2.duration) FROM station AS T1 JOIN trip AS T2 ON T1.id  =  T2.end_station_id GROUP BY T2.end_station_id
SELECT T1.name ,  T1.lat ,  min(T2.duration) FROM station AS T1 JOIN trip AS T2 ON T1.id  =  T2.end_station_id GROUP BY T2.end_station_id
SELECT DISTINCT start_station_name FROM trip WHERE duration  <  100
SELECT DISTINCT start_station_name FROM trip WHERE duration  <  100
SELECT date FROM weather WHERE mean_sea_level_pressure_inches BETWEEN 30.3 AND 31
SELECT date FROM weather WHERE mean_sea_level_pressure_inches BETWEEN 30.3 AND 31
SELECT DISTINCT T1.id ,  T1.name FROM station AS T1 JOIN status AS T2 ON T1.id  =  T2.station_id WHERE T2.bikes_available  >  12
SELECT DISTINCT T1.id ,  T1.name FROM station AS T1 JOIN status AS T2 ON T1.id  =  T2.station_id WHERE T2.bikes_available  >  12
SELECT count(*) FROM book
SELECT Writer FROM book ORDER BY Writer ASC
SELECT Title FROM book ORDER BY Issues ASC
SELECT Title FROM book WHERE Writer != "Elaine Lee"
SELECT Title ,  Issues FROM book
SELECT Publication_Date FROM publication ORDER BY Price DESC
SELECT DISTINCT Publisher FROM publication WHERE Price  >  5000000
SELECT Publisher FROM publication ORDER BY Price DESC LIMIT 1
SELECT T1.Title ,  T2.Publication_Date FROM book AS T1 JOIN publication AS T2 ON T1.Book_ID  =  T2.Book_ID
SELECT T1.Writer FROM book AS T1 JOIN publication AS T2 ON T1.Book_ID  =  T2.Book_ID WHERE T2.Price  >  4000000
SELECT T1.Title FROM book AS T1 JOIN publication AS T2 ON T1.Book_ID  =  T2.Book_ID ORDER BY T2.Price DESC
SELECT Publisher FROM publication GROUP BY Publisher HAVING COUNT(*)  >  1
SELECT Publisher ,  COUNT(*) FROM publication GROUP BY Publisher
SELECT Publication_Date FROM publication GROUP BY Publication_Date ORDER BY COUNT(*) DESC LIMIT 1
SELECT Writer FROM book GROUP BY Writer HAVING COUNT(*)  >  1
SELECT Title FROM book WHERE Book_ID NOT IN (SELECT Book_ID FROM publication)
SELECT Price FROM publication WHERE Publisher  =  "Person" OR Publisher  =  "Wiley"
SELECT count(*) FROM actor
SELECT count(*) FROM actor
SELECT Name FROM actor ORDER BY Name ASC
SELECT Name FROM actor ORDER BY Name ASC
SELECT Character ,  Duration FROM actor
SELECT Character ,  Duration FROM actor
SELECT Name FROM actor WHERE Age != 20
SELECT Name FROM actor WHERE Age != 20
SELECT Character FROM actor ORDER BY age DESC
SELECT Character FROM actor ORDER BY age DESC
SELECT Duration FROM actor ORDER BY Age DESC LIMIT 1
SELECT Duration FROM actor ORDER BY Age DESC LIMIT 1
SELECT Name FROM musical WHERE Nominee  =  "Bob Fosse"
SELECT Name FROM musical WHERE Nominee  =  "Bob Fosse"
SELECT DISTINCT Nominee FROM musical WHERE Award != "Tony Award"
SELECT DISTINCT Nominee FROM musical WHERE Award != "Tony Award"
SELECT T1.Name ,  T2.Name FROM actor AS T1 JOIN musical AS T2 ON T1.Musical_ID  =  T2.Musical_ID
SELECT T1.Name ,  T2.Name FROM actor AS T1 JOIN musical AS T2 ON T1.Musical_ID  =  T2.Musical_ID
SELECT T1.Name FROM actor AS T1 JOIN musical AS T2 ON T1.Musical_ID  =  T2.Musical_ID WHERE T2.Name  =  "The Phantom of the Opera"
SELECT T1.Name FROM actor AS T1 JOIN musical AS T2 ON T1.Musical_ID  =  T2.Musical_ID WHERE T2.Name  =  "The Phantom of the Opera"
SELECT T1.Name FROM actor AS T1 JOIN musical AS T2 ON T1.Musical_ID  =  T2.Musical_ID ORDER BY T2.Year DESC
SELECT T1.Name FROM actor AS T1 JOIN musical AS T2 ON T1.Musical_ID  =  T2.Musical_ID ORDER BY T2.Year DESC
SELECT T2.Name ,  COUNT(*) FROM actor AS T1 JOIN musical AS T2 ON T1.Musical_ID  =  T2.Musical_ID GROUP BY T1.Musical_ID
SELECT T2.Name ,  COUNT(*) FROM actor AS T1 JOIN musical AS T2 ON T1.Musical_ID  =  T2.Musical_ID GROUP BY T1.Musical_ID
SELECT T2.Name FROM actor AS T1 JOIN musical AS T2 ON T1.Musical_ID  =  T2.Musical_ID GROUP BY T1.Musical_ID HAVING COUNT(*)  >=  3
SELECT T2.Name FROM actor AS T1 JOIN musical AS T2 ON T1.Musical_ID  =  T2.Musical_ID GROUP BY T1.Musical_ID HAVING COUNT(*)  >=  3
SELECT Nominee ,  COUNT(*) FROM musical GROUP BY Nominee
SELECT Nominee ,  COUNT(*) FROM musical GROUP BY Nominee
SELECT Nominee FROM musical GROUP BY Nominee ORDER BY COUNT(*) DESC LIMIT 1
SELECT Nominee FROM musical GROUP BY Nominee ORDER BY COUNT(*) DESC LIMIT 1
SELECT RESULT FROM musical GROUP BY RESULT ORDER BY COUNT(*) DESC LIMIT 1
SELECT RESULT FROM musical GROUP BY RESULT ORDER BY COUNT(*) DESC LIMIT 1
SELECT Nominee FROM musical GROUP BY Nominee HAVING COUNT(*)  >  2
SELECT Nominee FROM musical GROUP BY Nominee HAVING COUNT(*)  >  2
SELECT Name FROM musical WHERE Musical_ID NOT IN (SELECT Musical_ID FROM actor)
SELECT Name FROM musical WHERE Musical_ID NOT IN (SELECT Musical_ID FROM actor)
SELECT Nominee FROM musical WHERE Award  =  "Tony Award" OR Award  =  "Cleavant Derricks"
SELECT Nominee FROM musical WHERE Award  =  "Tony Award" OR Award  =  "Cleavant Derricks"
SELECT email FROM user_profiles WHERE name  =  'Mary'
SELECT partitionid FROM user_profiles WHERE name  =  'Iron Man'
SELECT count(*) FROM user_profiles
SELECT count(*) FROM tweets
SELECT name ,  email FROM user_profiles WHERE name LIKE '%Swift%'
SELECT name FROM user_profiles WHERE email LIKE '%superstar%' OR email LIKE '%edu%'
SELECT text FROM tweets WHERE text LIKE '%intern%'
SELECT name ,  email FROM user_profiles WHERE followers  >  1000
SELECT T1.name ,  T1.email FROM user_profiles AS T1 JOIN follows AS T2 ON T1.uid  =  T2.f1 GROUP BY T2.f1 HAVING count(*)  >  1
SELECT T1.name FROM user_profiles AS T1 JOIN tweets AS T2 ON T1.uid  =  T2.uid GROUP BY T2.uid HAVING count(*)  >  1
SELECT T2.f1 FROM user_profiles AS T1 JOIN follows AS T2 ON T1.uid  =  T2.f2 WHERE T1.name  =  "Mary" OR T1.name  =  "Susan"
SELECT name FROM user_profiles ORDER BY followers DESC LIMIT 1
SELECT name ,  email FROM user_profiles ORDER BY followers LIMIT 1
SELECT name ,  followers FROM user_profiles ORDER BY followers DESC
SELECT name FROM user_profiles ORDER BY followers DESC LIMIT 5
SELECT text FROM tweets ORDER BY createdate
SELECT T1.name ,  count(*) FROM user_profiles AS T1 JOIN tweets AS T2 ON T1.uid  =  T2.uid GROUP BY T2.uid
SELECT T1.name ,  T1.partitionid FROM user_profiles AS T1 JOIN tweets AS T2 ON T1.uid  =  T2.uid GROUP BY T2.uid HAVING count(*)  <  2
SELECT T1.name ,  count(*) FROM user_profiles AS T1 JOIN tweets AS T2 ON T1.uid  =  T2.uid GROUP BY T2.uid HAVING count(*)  >  1
SELECT avg(followers) FROM user_profiles WHERE UID NOT IN (SELECT UID FROM tweets)
SELECT distinct(catalog_entry_name) FROM catalog_contents
SELECT distinct(catalog_entry_name) FROM catalog_contents
SELECT attribute_data_type FROM Attribute_Definitions GROUP BY attribute_data_type HAVING count(*)  >  3
SELECT attribute_data_type FROM Attribute_Definitions GROUP BY attribute_data_type HAVING count(*)  >  3
SELECT attribute_data_type FROM Attribute_Definitions WHERE attribute_name  =  "Green"
SELECT attribute_data_type FROM Attribute_Definitions WHERE attribute_name  =  "Green"
SELECT catalog_level_name ,  catalog_level_number FROM Catalog_Structure WHERE catalog_level_number BETWEEN 5 AND 10
SELECT catalog_level_name ,  catalog_level_number FROM Catalog_Structure WHERE catalog_level_number BETWEEN 5 AND 10
SELECT distinct(catalog_publisher) FROM catalogs WHERE catalog_publisher LIKE "%Murray%"
SELECT distinct(catalog_publisher) FROM catalogs WHERE catalog_publisher LIKE "%Murray%"
SELECT catalog_entry_name FROM catalog_contents ORDER BY price_in_dollars DESC LIMIT 1
SELECT catalog_entry_name FROM catalog_contents ORDER BY price_in_dollars DESC LIMIT 1
SELECT catalog_entry_name FROM catalog_contents ORDER BY height DESC LIMIT 1
SELECT catalog_entry_name FROM catalog_contents ORDER BY height DESC LIMIT 1
SELECT catalog_entry_name FROM catalog_contents ORDER BY capacity ASC LIMIT 1
SELECT catalog_entry_name FROM catalog_contents ORDER BY capacity ASC LIMIT 1
SELECT catalog_entry_name FROM catalog_contents WHERE product_stock_number LIKE "2%"
SELECT catalog_entry_name FROM catalog_contents WHERE product_stock_number LIKE "2%"
SELECT catalog_entry_name FROM catalog_contents WHERE LENGTH  <  3 OR width  >  5
SELECT catalog_entry_name FROM catalog_contents WHERE LENGTH  <  3 OR width  >  5
SELECT catalog_entry_name ,  capacity FROM Catalog_Contents WHERE price_in_dollars  >  700
SELECT catalog_entry_name ,  capacity FROM Catalog_Contents WHERE price_in_dollars  >  700
SELECT date_of_latest_revision FROM Catalogs GROUP BY date_of_latest_revision HAVING count(*)  >  1
SELECT date_of_latest_revision FROM Catalogs GROUP BY date_of_latest_revision HAVING count(*)  >  1
SELECT count(*) FROM catalog_contents
SELECT count(*) FROM catalog_contents
SELECT catalog_entry_name FROM catalog_contents WHERE next_entry_id  >  8
SELECT catalog_entry_name FROM catalog_contents WHERE next_entry_id  >  8
SELECT count(*) FROM Aircraft
SELECT count(*) FROM Aircraft
SELECT name ,  distance FROM Aircraft
SELECT name ,  distance FROM Aircraft
SELECT aid FROM Aircraft WHERE distance  >  1000
SELECT aid FROM Aircraft WHERE distance  >  1000
SELECT count(*) FROM Aircraft WHERE distance BETWEEN 1000 AND 5000
SELECT count(*) FROM Aircraft WHERE distance BETWEEN 1000 AND 5000
SELECT name ,  distance FROM Aircraft WHERE aid  =  12
SELECT name ,  distance FROM Aircraft WHERE aid  =  12
SELECT min(distance) ,  avg(distance) ,  max(distance) FROM Aircraft
SELECT min(distance) ,  avg(distance) ,  max(distance) FROM Aircraft
SELECT aid ,  name FROM Aircraft ORDER BY distance DESC LIMIT 1
SELECT aid ,  name FROM Aircraft ORDER BY distance DESC LIMIT 1
SELECT name FROM Aircraft ORDER BY distance LIMIT 3
SELECT name FROM Aircraft ORDER BY distance LIMIT 3
SELECT count(*) FROM Employee
SELECT count(*) FROM Employee
SELECT name ,  salary FROM Employee ORDER BY salary
SELECT name ,  salary FROM Employee ORDER BY salary
SELECT eid FROM Employee WHERE salary  >  100000
SELECT eid FROM Employee WHERE salary  >  100000
SELECT count(*) FROM Employee WHERE salary BETWEEN 100000 AND 200000
SELECT count(*) FROM Employee WHERE salary BETWEEN 100000 AND 200000
SELECT name ,  salary FROM Employee WHERE eid  =  242518965
SELECT name ,  salary FROM Employee WHERE eid  =  242518965
SELECT eid ,  name FROM Employee ORDER BY salary DESC LIMIT 1
SELECT eid ,  name FROM Employee ORDER BY salary DESC LIMIT 1
SELECT name FROM Employee ORDER BY salary ASC LIMIT 3
SELECT name FROM Employee ORDER BY salary ASC LIMIT 3
SELECT eid ,  salary FROM Employee WHERE name  =  'Mark Young'
SELECT eid ,  salary FROM Employee WHERE name  =  'Mark Young'
SELECT count(*) FROM Flight
SELECT count(*) FROM Flight
SELECT flno ,  origin ,  destination FROM Flight ORDER BY origin
SELECT flno ,  origin ,  destination FROM Flight ORDER BY origin
SELECT flno FROM Flight WHERE origin  =  "Los Angeles"
SELECT flno FROM Flight WHERE origin  =  "Los Angeles"
SELECT origin FROM Flight WHERE destination  =  "Honolulu"
SELECT origin FROM Flight WHERE destination  =  "Honolulu"
SELECT departure_date ,  arrival_date FROM Flight WHERE origin  =  "Los Angeles" AND destination  =  "Honolulu"
SELECT departure_date ,  arrival_date FROM Flight WHERE origin  =  "Los Angeles" AND destination  =  "Honolulu"
SELECT flno FROM Flight WHERE distance  >  2000
SELECT flno FROM Flight WHERE distance  >  2000
SELECT avg(price) FROM Flight WHERE origin  =  "Los Angeles" AND destination  =  "Honolulu"
SELECT avg(price) FROM Flight WHERE origin  =  "Los Angeles" AND destination  =  "Honolulu"
SELECT origin ,  destination FROM Flight WHERE price  >  300
SELECT origin ,  destination FROM Flight WHERE price  >  300
SELECT flno ,  distance FROM Flight ORDER BY price DESC LIMIT 1
SELECT flno ,  distance FROM Flight ORDER BY price DESC LIMIT 1
SELECT flno FROM Flight ORDER BY distance ASC LIMIT 3
SELECT flno FROM Flight ORDER BY distance ASC LIMIT 3
SELECT origin ,  count(*) FROM Flight GROUP BY origin
SELECT origin ,  count(*) FROM Flight GROUP BY origin
SELECT destination ,  count(*) FROM Flight GROUP BY destination
SELECT destination ,  count(*) FROM Flight GROUP BY destination
SELECT origin FROM Flight GROUP BY origin ORDER BY count(*) DESC LIMIT 1
SELECT origin FROM Flight GROUP BY origin ORDER BY count(*) DESC LIMIT 1
SELECT T2.name FROM Flight AS T1 JOIN Aircraft AS T2 ON T1.aid  =  T2.aid WHERE T1.flno  =  99
SELECT T2.name FROM Flight AS T1 JOIN Aircraft AS T2 ON T1.aid  =  T2.aid WHERE T1.flno  =  99
SELECT T1.flno FROM Flight AS T1 JOIN Aircraft AS T2 ON T1.aid  =  T2.aid WHERE T2.name  =  "Airbus A340-300"
SELECT T1.flno FROM Flight AS T1 JOIN Aircraft AS T2 ON T1.aid  =  T2.aid WHERE T2.name  =  "Airbus A340-300"
SELECT T2.name ,  count(*) FROM Flight AS T1 JOIN Aircraft AS T2 ON T1.aid  =  T2.aid GROUP BY T1.aid
SELECT T2.name ,  count(*) FROM Flight AS T1 JOIN Aircraft AS T2 ON T1.aid  =  T2.aid GROUP BY T1.aid
SELECT T2.name FROM Flight AS T1 JOIN Aircraft AS T2 ON T1.aid  =  T2.aid GROUP BY T1.aid HAVING count(*)  >= 2
SELECT T2.name FROM Flight AS T1 JOIN Aircraft AS T2 ON T1.aid  =  T2.aid GROUP BY T1.aid HAVING count(*)  >= 2
SELECT T3.name FROM Employee AS T1 JOIN Certificate AS T2 ON T1.eid  =  T2.eid JOIN Aircraft AS T3 ON T3.aid  =  T2.aid WHERE T1.name  =  "John Williams"
SELECT T3.name FROM Employee AS T1 JOIN Certificate AS T2 ON T1.eid  =  T2.eid JOIN Aircraft AS T3 ON T3.aid  =  T2.aid WHERE T1.name  =  "John Williams"
SELECT T1.name FROM Employee AS T1 JOIN Certificate AS T2 ON T1.eid  =  T2.eid JOIN Aircraft AS T3 ON T3.aid  =  T2.aid WHERE T3.name  =  "Boeing 737-800"
SELECT T1.name FROM Employee AS T1 JOIN Certificate AS T2 ON T1.eid  =  T2.eid JOIN Aircraft AS T3 ON T3.aid  =  T2.aid WHERE T3.name  =  "Boeing 737-800"
SELECT T2.name FROM Certificate AS T1 JOIN Aircraft AS T2 ON T2.aid  =  T1.aid WHERE T2.distance  >  5000 GROUP BY T1.aid ORDER BY count(*)  >=  5
SELECT T2.name FROM Certificate AS T1 JOIN Aircraft AS T2 ON T2.aid  =  T1.aid WHERE T2.distance  >  5000 GROUP BY T1.aid ORDER BY count(*)  >=  5
SELECT T1.name ,  T1.salary FROM Employee AS T1 JOIN Certificate AS T2 ON T1.eid  =  T2.eid GROUP BY T1.eid ORDER BY count(*) DESC LIMIT 1
SELECT T1.name ,  T1.salary FROM Employee AS T1 JOIN Certificate AS T2 ON T1.eid  =  T2.eid GROUP BY T1.eid ORDER BY count(*) DESC LIMIT 1
SELECT T1.name FROM Employee AS T1 JOIN Certificate AS T2 ON T1.eid  =  T2.eid JOIN Aircraft AS T3 ON T3.aid  =  T2.aid WHERE T3.distance  >  5000 GROUP BY T1.eid ORDER BY count(*) DESC LIMIT 1
SELECT T1.name FROM Employee AS T1 JOIN Certificate AS T2 ON T1.eid  =  T2.eid JOIN Aircraft AS T3 ON T3.aid  =  T2.aid WHERE T3.distance  >  5000 GROUP BY T1.eid ORDER BY count(*) DESC LIMIT 1
SELECT DISTINCT allergytype FROM Allergy_type
SELECT DISTINCT allergytype FROM Allergy_type
SELECT allergy ,  allergytype FROM Allergy_type
SELECT allergy ,  allergytype FROM Allergy_type
SELECT DISTINCT allergy FROM Allergy_type WHERE allergytype  =  "food"
SELECT DISTINCT allergy FROM Allergy_type WHERE allergytype  =  "food"
SELECT allergytype FROM Allergy_type WHERE allergy  =  "Cat"
SELECT allergytype FROM Allergy_type WHERE allergy  =  "Cat"
SELECT count(*) FROM Allergy_type WHERE allergytype  =  "animal"
SELECT count(*) FROM Allergy_type WHERE allergytype  =  "animal"
SELECT allergytype ,  count(*) FROM Allergy_type GROUP BY allergytype
SELECT allergytype ,  count(*) FROM Allergy_type GROUP BY allergytype
SELECT allergytype FROM Allergy_type GROUP BY allergytype ORDER BY count(*) DESC LIMIT 1
SELECT allergytype FROM Allergy_type GROUP BY allergytype ORDER BY count(*) DESC LIMIT 1
SELECT allergytype FROM Allergy_type GROUP BY allergytype ORDER BY count(*) ASC LIMIT 1
SELECT allergytype FROM Allergy_type GROUP BY allergytype ORDER BY count(*) ASC LIMIT 1
SELECT count(*) FROM Student
SELECT count(*) FROM Student
SELECT Fname ,  Lname FROM Student
SELECT Fname ,  Lname FROM Student
SELECT DISTINCT Major FROM Student
SELECT DISTINCT Major FROM Student
SELECT DISTINCT city_code FROM Student
SELECT DISTINCT city_code FROM Student
SELECT Fname ,  Lname ,  Age FROM Student WHERE Sex  =  'F'
SELECT Fname ,  Lname ,  Age FROM Student WHERE Sex  =  'F'
SELECT StuID FROM Student WHERE Sex  =  'M'
SELECT StuID FROM Student WHERE Sex  =  'M'
SELECT count(*) FROM Student WHERE age  =  18
SELECT count(*) FROM Student WHERE age  =  18
SELECT StuID FROM Student WHERE age  >  20
SELECT StuID FROM Student WHERE age  >  20
SELECT city_code FROM Student WHERE LName  =  "Kim"
SELECT city_code FROM Student WHERE LName  =  "Kim"
SELECT Advisor FROM Student WHERE StuID  =  1004
SELECT Advisor FROM Student WHERE StuID  =  1004
SELECT count(*) FROM Student WHERE city_code  =  "HKG" OR city_code  =  "CHI"
SELECT count(*) FROM Student WHERE city_code  =  "HKG" OR city_code  =  "CHI"
SELECT major ,  count(*) FROM Student GROUP BY major
SELECT major ,  count(*) FROM Student GROUP BY major
SELECT major FROM Student GROUP BY major ORDER BY count(*) DESC LIMIT 1
SELECT major FROM Student GROUP BY major ORDER BY count(*) DESC LIMIT 1
SELECT age ,  count(*) FROM Student GROUP BY age
SELECT age ,  count(*) FROM Student GROUP BY age
SELECT city_code ,  count(*) FROM Student GROUP BY city_code
SELECT city_code ,  count(*) FROM Student GROUP BY city_code
SELECT advisor ,  count(*) FROM Student GROUP BY advisor
SELECT advisor ,  count(*) FROM Student GROUP BY advisor
SELECT advisor FROM Student GROUP BY advisor ORDER BY count(*) DESC LIMIT 1
SELECT advisor FROM Student GROUP BY advisor ORDER BY count(*) DESC LIMIT 1
SELECT StuID FROM Has_allergy GROUP BY StuID HAVING count(*)  >=  2
SELECT StuID FROM Has_allergy GROUP BY StuID HAVING count(*)  >=  2
SELECT Allergy FROM Has_allergy GROUP BY Allergy ORDER BY count(*) DESC LIMIT 1
SELECT Allergy FROM Has_allergy GROUP BY Allergy ORDER BY count(*) DESC LIMIT 1
SELECT Allergy ,  count(*) FROM Has_allergy GROUP BY Allergy
SELECT Allergy ,  count(*) FROM Has_allergy GROUP BY Allergy
SELECT T2.allergytype ,  count(*) FROM Has_allergy AS T1 JOIN Allergy_type AS T2 ON T1.allergy  =  T2.allergy GROUP BY T2.allergytype
SELECT T2.allergytype ,  count(*) FROM Has_allergy AS T1 JOIN Allergy_type AS T2 ON T1.allergy  =  T2.allergy GROUP BY T2.allergytype
SELECT T1.Allergy ,  T1.AllergyType FROM Allergy_type AS T1 JOIN Has_allergy AS T2 ON T1.Allergy  =  T2.Allergy JOIN Student AS T3 ON T3.StuID  =  T2.StuID WHERE T3.Fname  =  "Lisa" ORDER BY T1.Allergy
SELECT T1.Allergy ,  T1.AllergyType FROM Allergy_type AS T1 JOIN Has_allergy AS T2 ON T1.Allergy  =  T2.Allergy JOIN Student AS T3 ON T3.StuID  =  T2.StuID WHERE T3.Fname  =  "Lisa" ORDER BY T1.Allergy
SELECT DISTINCT T1.fname ,  T1.city_code FROM Student AS T1 JOIN Has_Allergy AS T2 ON T1.stuid  =  T2.stuid WHERE T2.Allergy  =  "Milk" OR T2.Allergy  =  "Cat"
SELECT DISTINCT T1.fname ,  T1.city_code FROM Student AS T1 JOIN Has_Allergy AS T2 ON T1.stuid  =  T2.stuid WHERE T2.Allergy  =  "Milk" OR T2.Allergy  =  "Cat"
SELECT billing_country ,  COUNT(*) FROM invoices GROUP BY billing_country ORDER BY count(*) DESC LIMIT 5;
SELECT billing_country ,  COUNT(*) FROM invoices GROUP BY billing_country ORDER BY count(*) DESC LIMIT 5;
SELECT T1.first_name ,  T1.last_name FROM customers AS T1 JOIN invoices AS T2 ON T2.customer_id  =  T1.id ORDER BY T2.invoice_date DESC LIMIT 5;
SELECT T1.first_name ,  T1.last_name FROM customers AS T1 JOIN invoices AS T2 ON T2.customer_id  =  T1.id ORDER BY T2.invoice_date DESC LIMIT 5;
SELECT T1.first_name ,  T1.last_name ,  COUNT(*) FROM customers AS T1 JOIN invoices AS T2 ON T2.customer_id  =  T1.id GROUP BY T1.id ORDER BY COUNT(*) DESC LIMIT 10;
SELECT T1.first_name ,  T1.last_name ,  COUNT(*) FROM customers AS T1 JOIN invoices AS T2 ON T2.customer_id  =  T1.id GROUP BY T1.id ORDER BY COUNT(*) DESC LIMIT 10;
SELECT T1.name ,  COUNT(*) FROM genres AS T1 JOIN tracks AS T2 ON T2.genre_id  =  T1.id GROUP BY T1.id ORDER BY count(*) DESC LIMIT 5;
SELECT T1.name ,  COUNT(*) FROM genres AS T1 JOIN tracks AS T2 ON T2.genre_id  =  T1.id GROUP BY T1.id ORDER BY count(*) DESC LIMIT 5;
SELECT title FROM albums;
SELECT title FROM albums;
SELECT title FROM albums ORDER BY title;
SELECT title FROM albums ORDER BY title;
SELECT title FROM albums WHERE title LIKE 'A%' ORDER BY title;
SELECT title FROM albums WHERE title LIKE 'A%' ORDER BY title;
SELECT T1.first_name ,  T1.last_name FROM customers AS T1 JOIN invoices AS T2 ON T2.customer_id  =  T1.id ORDER BY total LIMIT 10;
SELECT T1.first_name ,  T1.last_name FROM customers AS T1 JOIN invoices AS T2 ON T2.customer_id  =  T1.id ORDER BY total LIMIT 10;
SELECT billing_state ,  COUNT(*) FROM invoices WHERE billing_country  =  "USA" GROUP BY billing_state;
SELECT billing_state ,  COUNT(*) FROM invoices WHERE billing_country  =  "USA" GROUP BY billing_state;
SELECT billing_state ,  COUNT(*) FROM invoices WHERE billing_country  =  "USA" GROUP BY billing_state ORDER BY COUNT(*) DESC LIMIT 1;
SELECT billing_state ,  COUNT(*) FROM invoices WHERE billing_country  =  "USA" GROUP BY billing_state ORDER BY COUNT(*) DESC LIMIT 1;
SELECT T1.title FROM albums AS T1 JOIN artists AS T2 ON  T1.artist_id = T2.id WHERE T2.name = "Aerosmith";
SELECT T1.title FROM albums AS T1 JOIN artists AS T2 ON  T1.artist_id = T2.id WHERE T2.name = "Aerosmith";
SELECT company FROM customers WHERE first_name = "Eduardo" AND last_name = "Martins";
SELECT company FROM customers WHERE first_name = "Eduardo" AND last_name = "Martins";
SELECT email ,  phone FROM customers WHERE first_name = "Astrid" AND last_name = "Gruber";
SELECT email ,  phone FROM customers WHERE first_name = "Astrid" AND last_name = "Gruber";
SELECT country FROM customers WHERE first_name = "Roberto" AND last_name = "Almeida";
SELECT country FROM customers WHERE first_name = "Roberto" AND last_name = "Almeida";
SELECT title ,  phone ,  hire_date FROM employees WHERE first_name = "Nancy" AND last_name = "Edwards";
SELECT title ,  phone ,  hire_date FROM employees WHERE first_name = "Nancy" AND last_name = "Edwards";
SELECT T2.first_name , T2.last_name FROM employees AS T1 JOIN employees AS T2 ON T1.id = T2.reports_to WHERE T1.first_name = "Nancy" AND T1.last_name = "Edwards";
SELECT T2.first_name , T2.last_name FROM employees AS T1 JOIN employees AS T2 ON T1.id = T2.reports_to WHERE T1.first_name = "Nancy" AND T1.last_name = "Edwards";
SELECT address FROM employees WHERE first_name = "Nancy" AND last_name = "Edwards";
SELECT address FROM employees WHERE first_name = "Nancy" AND last_name = "Edwards";
SELECT T1.first_name , T1.last_name FROM employees AS T1 JOIN customers AS T2 ON T1.id  =  T2.support_rep_id GROUP BY T1.id ORDER BY count(*) DESC LIMIT 1
SELECT T1.first_name , T1.last_name FROM employees AS T1 JOIN customers AS T2 ON T1.id  =  T2.support_rep_id GROUP BY T1.id ORDER BY count(*) DESC LIMIT 1
SELECT phone FROM employees WHERE first_name = "Nancy" AND last_name = "Edwards";
SELECT phone FROM employees WHERE first_name = "Nancy" AND last_name = "Edwards";
SELECT first_name , last_name FROM employees ORDER BY birth_date DESC LIMIT 1;
SELECT first_name , last_name FROM employees ORDER BY birth_date DESC LIMIT 1;
SELECT first_name , last_name FROM employees ORDER BY hire_date ASC LIMIT 10;
SELECT first_name , last_name FROM employees ORDER BY hire_date ASC LIMIT 10;
SELECT count(*) ,  city FROM employees WHERE title  =  'IT Staff' GROUP BY city
SELECT count(*) ,  city FROM employees WHERE title  =  'IT Staff' GROUP BY city
SELECT name FROM media_types;
SELECT name FROM media_types;
SELECT DISTINCT name FROM genres;
SELECT DISTINCT name FROM genres;
SELECT name FROM playlists;
SELECT name FROM playlists;
SELECT composer FROM tracks WHERE name = "Fast As a Shark";
SELECT composer FROM tracks WHERE name = "Fast As a Shark";
SELECT milliseconds FROM tracks WHERE name = "Fast As a Shark";
SELECT milliseconds FROM tracks WHERE name = "Fast As a Shark";
SELECT T2.name FROM genres AS T1 JOIN tracks AS T2 ON T1.id = T2.genre_id WHERE T1.name = "Rock";
SELECT T2.name FROM genres AS T1 JOIN tracks AS T2 ON T1.id = T2.genre_id WHERE T1.name = "Rock";
SELECT T1.title FROM albums AS T1 JOIN tracks AS T2 ON T1.id = T2.genre_id WHERE T2.name = "Balls to the Wall";
SELECT T1.title FROM albums AS T1 JOIN tracks AS T2 ON T1.id = T2.genre_id WHERE T2.name = "Balls to the Wall";
SELECT T2.name FROM albums AS T1 JOIN tracks AS T2 ON T1.id = T2.genre_id WHERE T1.title = "Balls to the Wall";
SELECT T2.name FROM albums AS T1 JOIN tracks AS T2 ON T1.id = T2.genre_id WHERE T1.title = "Balls to the Wall";
SELECT T2.name FROM genres AS T1 JOIN tracks AS T2 ON T1.id = T2.genre_id JOIN media_types AS T3 ON T3.id = T2.media_type_id WHERE T1.name = "Rock" AND T3.name = "MPEG audio file";
SELECT T2.name FROM genres AS T1 JOIN tracks AS T2 ON T1.id = T2.genre_id JOIN media_types AS T3 ON T3.id = T2.media_type_id WHERE T1.name = "Rock" AND T3.name = "MPEG audio file";
SELECT T2.name FROM genres AS T1 JOIN tracks AS T2 ON T1.id = T2.genre_id JOIN media_types AS T3 ON T3.id = T2.media_type_id WHERE T1.name = "Rock" OR T3.name = "MPEG audio file";
SELECT T2.name FROM genres AS T1 JOIN tracks AS T2 ON T1.id = T2.genre_id JOIN media_types AS T3 ON T3.id = T2.media_type_id WHERE T1.name = "Rock" OR T3.name = "MPEG audio file";
SELECT T2.name FROM genres AS T1 JOIN tracks AS T2 ON T1.id = T2.genre_id WHERE T1.name = "Rock" OR T1.name = "Jazz"
SELECT T2.name FROM genres AS T1 JOIN tracks AS T2 ON T1.id = T2.genre_id WHERE T1.name = "Rock" OR T1.name = "Jazz"
SELECT T1.name FROM tracks AS T1 JOIN playlist_tracks AS T2 ON T1.id = T2.track_id JOIN playlists AS T3 ON T3.id = T2.playlist_id WHERE T3.name = "Movies";
SELECT T1.name FROM tracks AS T1 JOIN playlist_tracks AS T2 ON T1.id = T2.track_id JOIN playlists AS T3 ON T3.id = T2.playlist_id WHERE T3.name = "Movies";
SELECT T1.name FROM tracks AS T1 JOIN invoice_lines AS T2 ON T1.id = T2.track_id JOIN invoices AS T3 ON T3.id = T2.invoice_id JOIN customers AS T4 ON T4.id = T3.customer_id WHERE T4.first_name = "Daan" AND T4.last_name = "Peeters";
SELECT T1.name FROM tracks AS T1 JOIN invoice_lines AS T2 ON T1.id = T2.track_id JOIN invoices AS T3 ON T3.id = T2.invoice_id JOIN customers AS T4 ON T4.id = T3.customer_id WHERE T4.first_name = "Daan" AND T4.last_name = "Peeters";
SELECT unit_price FROM tracks WHERE name = "Fast As a Shark";
SELECT unit_price FROM tracks WHERE name = "Fast As a Shark";
SELECT count(*) ,  T1.name FROM genres AS T1 JOIN tracks AS T2 ON T1.id = T2.genre_id GROUP BY T1.name;
SELECT count(*) ,  T1.name FROM genres AS T1 JOIN tracks AS T2 ON T1.id = T2.genre_id GROUP BY T1.name;
SELECT count(*) FROM editor
SELECT Name FROM editor ORDER BY Age ASC
SELECT Name ,  Age FROM editor
SELECT Name FROM editor WHERE Age  >  25
SELECT Name FROM editor WHERE Age  =  24 OR Age  =  25
SELECT Name FROM editor ORDER BY Age ASC LIMIT 1
SELECT Age ,  COUNT(*) FROM editor GROUP BY Age
SELECT DISTINCT Theme FROM journal
SELECT T2.Name ,  T3.Theme FROM journal_committee AS T1 JOIN editor AS T2 ON T1.Editor_ID  =  T2.Editor_ID JOIN journal AS T3 ON T1.Journal_ID  =  T3.Journal_ID
SELECT T2.Name ,  T3.Theme FROM journal_committee AS T1 JOIN editor AS T2 ON T1.Editor_ID  =  T2.Editor_ID JOIN journal AS T3 ON T1.Journal_ID  =  T3.Journal_ID
SELECT T2.Name ,  T2.age ,  T3.Theme FROM journal_committee AS T1 JOIN editor AS T2 ON T1.Editor_ID  =  T2.Editor_ID JOIN journal AS T3 ON T1.Journal_ID  =  T3.Journal_ID ORDER BY T3.Theme ASC
SELECT T2.Name FROM journal_committee AS T1 JOIN editor AS T2 ON T1.Editor_ID  =  T2.Editor_ID JOIN journal AS T3 ON T1.Journal_ID  =  T3.Journal_ID WHERE T3.Sales  >  3000
SELECT T1.editor_id ,  T1.Name ,  COUNT(*) FROM editor AS T1 JOIN journal_committee AS T2 ON T1.Editor_ID  =  T2.Editor_ID GROUP BY T1.editor_id
SELECT T1.Name FROM editor AS T1 JOIN journal_committee AS T2 ON T1.Editor_ID  =  T2.Editor_ID GROUP BY T1.Name HAVING COUNT(*)  >=  2
SELECT Name FROM editor WHERE editor_id NOT IN (SELECT editor_id FROM journal_committee)
SELECT avg(T1.sales) FROM journal AS T1 JOIN journal_committee AS T2 ON T1.journal_ID  =  T2.journal_ID WHERE T2.work_type  =  'Photo'
SELECT count(*) FROM Accounts
SELECT count(*) FROM Accounts
SELECT account_id ,  customer_id ,  account_name FROM Accounts
SELECT account_id ,  customer_id ,  account_name FROM Accounts
SELECT other_account_details FROM Accounts WHERE account_name  =  "338"
SELECT other_account_details FROM Accounts WHERE account_name  =  "338"
SELECT T2.customer_first_name ,  T2.customer_last_name ,  T2.customer_phone FROM Accounts AS T1 JOIN Customers AS T2 ON T1.customer_id  =  T2.customer_id WHERE T1.account_name  =  "162"
SELECT T2.customer_first_name ,  T2.customer_last_name ,  T2.customer_phone FROM Accounts AS T1 JOIN Customers AS T2 ON T1.customer_id  =  T2.customer_id WHERE T1.account_name  =  "162"
SELECT customer_id ,  count(*) FROM Accounts GROUP BY customer_id
SELECT customer_id ,  count(*) FROM Accounts GROUP BY customer_id
SELECT customer_id ,  count(*) FROM Accounts GROUP BY customer_id ORDER BY count(*) DESC LIMIT 1
SELECT customer_id ,  count(*) FROM Accounts GROUP BY customer_id ORDER BY count(*) DESC LIMIT 1
SELECT T2.customer_first_name ,  T2.customer_last_name ,  T1.customer_id FROM Accounts AS T1 JOIN Customers AS T2 ON T1.customer_id  =  T2.customer_id GROUP BY T1.customer_id ORDER BY count(*) ASC LIMIT 1
SELECT T2.customer_first_name ,  T2.customer_last_name ,  T1.customer_id FROM Accounts AS T1 JOIN Customers AS T2 ON T1.customer_id  =  T2.customer_id GROUP BY T1.customer_id ORDER BY count(*) ASC LIMIT 1
SELECT DISTINCT T1.customer_first_name ,  T1.customer_last_name FROM Customers AS T1 JOIN Accounts AS T2 ON T1.customer_id  =  T2.customer_id
SELECT DISTINCT T1.customer_first_name ,  T1.customer_last_name FROM Customers AS T1 JOIN Accounts AS T2 ON T1.customer_id  =  T2.customer_id
SELECT count(*) FROM Customers
SELECT count(*) FROM Customers
SELECT customer_id ,  customer_first_name ,  customer_last_name ,  customer_phone FROM Customers
SELECT customer_id ,  customer_first_name ,  customer_last_name ,  customer_phone FROM Customers
SELECT customer_phone ,  customer_email FROM Customers WHERE customer_first_name  =  "Aniyah" AND customer_last_name  =  "Feest"
SELECT customer_phone ,  customer_email FROM Customers WHERE customer_first_name  =  "Aniyah" AND customer_last_name  =  "Feest"
SELECT count(*) FROM Customers_cards
SELECT count(*) FROM Customers_cards
SELECT card_id ,  customer_id ,  card_type_code ,  card_number FROM Customers_cards
SELECT card_id ,  customer_id ,  card_type_code ,  card_number FROM Customers_cards
SELECT T2.customer_first_name ,  T2.customer_last_name ,  T2.customer_phone FROM Customers_cards AS T1 JOIN Customers AS T2 ON T1.customer_id  =  T2.customer_id WHERE T1.card_number  =  "4560596484842"
SELECT T2.customer_first_name ,  T2.customer_last_name ,  T2.customer_phone FROM Customers_cards AS T1 JOIN Customers AS T2 ON T1.customer_id  =  T2.customer_id WHERE T1.card_number  =  "4560596484842"
SELECT count(*) FROM Customers_cards AS T1 JOIN Customers AS T2 ON T1.customer_id  =  T2.customer_id WHERE T2.customer_first_name  =  "Art" AND T2.customer_last_name  =  "Turcotte"
SELECT count(*) FROM Customers_cards AS T1 JOIN Customers AS T2 ON T1.customer_id  =  T2.customer_id WHERE T2.customer_first_name  =  "Art" AND T2.customer_last_name  =  "Turcotte"
SELECT count(*) FROM Customers_cards WHERE card_type_code  =  "Debit"
SELECT count(*) FROM Customers_cards WHERE card_type_code  =  "Debit"
SELECT customer_id ,  count(*) FROM Customers_cards GROUP BY customer_id
SELECT customer_id ,  count(*) FROM Customers_cards GROUP BY customer_id
SELECT T1.customer_id ,  T2.customer_first_name ,  T2.customer_last_name FROM Customers_cards AS T1 JOIN Customers AS T2 ON T1.customer_id  =  T2.customer_id GROUP BY T1.customer_id HAVING count(*)  >=  2
SELECT T1.customer_id ,  T2.customer_first_name ,  T2.customer_last_name FROM Customers_cards AS T1 JOIN Customers AS T2 ON T1.customer_id  =  T2.customer_id GROUP BY T1.customer_id HAVING count(*)  >=  2
SELECT T1.customer_id ,  T2.customer_first_name ,  T2.customer_last_name FROM Customers_cards AS T1 JOIN Customers AS T2 ON T1.customer_id  =  T2.customer_id GROUP BY T1.customer_id ORDER BY count(*) ASC LIMIT 1
SELECT T1.customer_id ,  T2.customer_first_name ,  T2.customer_last_name FROM Customers_cards AS T1 JOIN Customers AS T2 ON T1.customer_id  =  T2.customer_id GROUP BY T1.customer_id ORDER BY count(*) ASC LIMIT 1
SELECT card_type_code ,  count(*) FROM Customers_cards GROUP BY card_type_code
SELECT card_type_code ,  count(*) FROM Customers_cards GROUP BY card_type_code
SELECT card_type_code FROM Customers_cards GROUP BY card_type_code ORDER BY count(*) DESC LIMIT 1
SELECT card_type_code FROM Customers_cards GROUP BY card_type_code ORDER BY count(*) DESC LIMIT 1
SELECT card_type_code FROM Customers_cards GROUP BY card_type_code HAVING count(*)  >=  5
SELECT card_type_code FROM Customers_cards GROUP BY card_type_code HAVING count(*)  >=  5
SELECT DISTINCT card_type_code FROM Customers_Cards
SELECT DISTINCT card_type_code FROM Customers_Cards
SELECT DISTINCT transaction_type FROM Financial_Transactions
SELECT DISTINCT transaction_type FROM Financial_Transactions
SELECT T2.card_type_code ,  count(*) FROM Financial_transactions AS T1 JOIN Customers_cards AS T2 ON T1.card_id  =  T2.card_id GROUP BY T2.card_type_code
SELECT T2.card_type_code ,  count(*) FROM Financial_transactions AS T1 JOIN Customers_cards AS T2 ON T1.card_id  =  T2.card_id GROUP BY T2.card_type_code
SELECT transaction_type ,  count(*) FROM Financial_transactions GROUP BY transaction_type
SELECT transaction_type ,  count(*) FROM Financial_transactions GROUP BY transaction_type
SELECT account_id ,  count(*) FROM Financial_transactions GROUP BY account_id
SELECT account_id ,  count(*) FROM Financial_transactions GROUP BY account_id
SELECT count(*) FROM track
SELECT count(*) FROM track
SELECT name ,  LOCATION FROM track
SELECT name ,  LOCATION FROM track
SELECT name ,  seating FROM track WHERE year_opened  >  2000 ORDER BY seating
SELECT name ,  seating FROM track WHERE year_opened  >  2000 ORDER BY seating
SELECT name ,  LOCATION ,  seating FROM track ORDER BY year_opened DESC LIMIT 1
SELECT name ,  LOCATION ,  seating FROM track ORDER BY year_opened DESC LIMIT 1
SELECT min(seating) ,  max(seating) ,  avg(seating) FROM track
SELECT min(seating) ,  max(seating) ,  avg(seating) FROM track
SELECT DISTINCT LOCATION FROM track
SELECT DISTINCT LOCATION FROM track
SELECT count(*) FROM race
SELECT count(*) FROM race
SELECT DISTINCT CLASS FROM race
SELECT DISTINCT CLASS FROM race
SELECT name ,  CLASS ,  date FROM race
SELECT name ,  CLASS ,  date FROM race
SELECT CLASS ,  count(*) FROM race GROUP BY CLASS
SELECT CLASS ,  count(*) FROM race GROUP BY CLASS
SELECT CLASS FROM race GROUP BY CLASS ORDER BY count(*) DESC LIMIT 1
SELECT CLASS FROM race GROUP BY CLASS ORDER BY count(*) DESC LIMIT 1
SELECT CLASS FROM race GROUP BY CLASS HAVING count(*)  >=  2
SELECT CLASS FROM race GROUP BY CLASS HAVING count(*)  >=  2
SELECT year_opened FROM track WHERE seating BETWEEN 4000 AND 5000
SELECT year_opened FROM track WHERE seating BETWEEN 4000 AND 5000
SELECT T2.name ,  count(*) FROM race AS T1 JOIN track AS T2 ON T1.track_id  =  T2.track_id GROUP BY T1.track_id
SELECT T2.name ,  count(*) FROM race AS T1 JOIN track AS T2 ON T1.track_id  =  T2.track_id GROUP BY T1.track_id
SELECT T2.name FROM race AS T1 JOIN track AS T2 ON T1.track_id  =  T2.track_id GROUP BY T1.track_id ORDER BY count(*) DESC LIMIT 1
SELECT T2.name FROM race AS T1 JOIN track AS T2 ON T1.track_id  =  T2.track_id GROUP BY T1.track_id ORDER BY count(*) DESC LIMIT 1
SELECT T1.name ,  T1.date ,  T2.name FROM race AS T1 JOIN track AS T2 ON T1.track_id  =  T2.track_id
SELECT T1.name ,  T1.date ,  T2.name FROM race AS T1 JOIN track AS T2 ON T1.track_id  =  T2.track_id
SELECT T2.name ,  T2.location FROM race AS T1 JOIN track AS T2 ON T1.track_id  =  T2.track_id GROUP BY T1.track_id HAVING count(*)  =  1
SELECT T2.name ,  T2.location FROM race AS T1 JOIN track AS T2 ON T1.track_id  =  T2.track_id GROUP BY T1.track_id HAVING count(*)  =  1
SELECT count(*) FROM member WHERE Membership_card  =  'Black'
SELECT count(*) ,  address FROM member GROUP BY address
SELECT name FROM member WHERE address  =  'Harford' OR address  =  'Waterbury'
SELECT name ,  member_id FROM member WHERE Membership_card  =  'Black' OR age  <  30
SELECT Time_of_purchase ,  age ,  address FROM member ORDER BY Time_of_purchase
SELECT Membership_card FROM member GROUP BY Membership_card HAVING count(*)  >  5
SELECT count(*) FROM member WHERE address != 'Hartford'
SELECT address FROM shop ORDER BY open_year
SELECT address ,  num_of_staff FROM shop WHERE shop_id NOT IN (SELECT shop_id FROM happy_hour)
SELECT shop_id ,  count(*) FROM happy_hour GROUP BY shop_id ORDER BY count(*) DESC LIMIT 1
SELECT MONTH FROM happy_hour GROUP BY MONTH ORDER BY count(*) DESC LIMIT 1
SELECT MONTH FROM happy_hour GROUP BY MONTH HAVING count(*)  >  2
SELECT Name FROM GENRE
SELECT Name FROM GENRE
SELECT FirstName ,  LastName FROM EMPLOYEE WHERE City  =  "Calgary"
SELECT FirstName ,  LastName FROM EMPLOYEE WHERE City  =  "Calgary"
SELECT distinct(BillingCountry) FROM INVOICE
SELECT distinct(BillingCountry) FROM INVOICE
SELECT Name FROM ARTIST WHERE Name LIKE "%a%"
SELECT Name FROM ARTIST WHERE Name LIKE "%a%"
SELECT Title FROM ALBUM AS T1 JOIN ARTIST AS T2 ON T1.ArtistId  =  T2.ArtistId WHERE T2.Name  =  "AC/DC"
SELECT Title FROM ALBUM AS T1 JOIN ARTIST AS T2 ON T1.ArtistId  =  T2.ArtistId WHERE T2.Name  =  "AC/DC"
SELECT T2.Name FROM ALBUM AS T1 JOIN ARTIST AS T2 ON T1.ArtistId  =  T2.ArtistId WHERE T1.Title  =  "Balls to the Wall"
SELECT T2.Name FROM ALBUM AS T1 JOIN ARTIST AS T2 ON T1.ArtistId  =  T2.ArtistId WHERE T1.Title  =  "Balls to the Wall"
SELECT T2.Name FROM ALBUM AS T1 JOIN ARTIST AS T2 ON T1.ArtistId  =  T2.ArtistId GROUP BY T2.Name ORDER BY COUNT(*) DESC LIMIT 1
SELECT T2.Name FROM ALBUM AS T1 JOIN ARTIST AS T2 ON T1.ArtistId  =  T2.ArtistId GROUP BY T2.Name ORDER BY COUNT(*) DESC LIMIT 1
SELECT Name FROM TRACK WHERE Name LIKE '%you%'
SELECT Name FROM TRACK WHERE Name LIKE '%you%'
SELECT T1.Title ,  T2.AlbumID ,  COUNT(*) FROM ALBUM AS T1 JOIN TRACK AS T2 ON T1.AlbumId  =  T2.AlbumId GROUP BY T2.AlbumID
SELECT T1.Title ,  T2.AlbumID ,  COUNT(*) FROM ALBUM AS T1 JOIN TRACK AS T2 ON T1.AlbumId  =  T2.AlbumId GROUP BY T2.AlbumID
SELECT T1.Name FROM GENRE AS T1 JOIN TRACK AS T2 ON T1.GenreId  =  T2.GenreId GROUP BY T2.GenreId ORDER BY COUNT(*) DESC LIMIT 1
SELECT T1.Name FROM GENRE AS T1 JOIN TRACK AS T2 ON T1.GenreId  =  T2.GenreId GROUP BY T2.GenreId ORDER BY COUNT(*) DESC LIMIT 1
SELECT T1.Name FROM MEDIATYPE AS T1 JOIN TRACK AS T2 ON T1.MediaTypeId  =  T2.MediaTypeId GROUP BY T2.MediaTypeId ORDER BY COUNT(*) ASC LIMIT 1
SELECT T1.Name FROM MEDIATYPE AS T1 JOIN TRACK AS T2 ON T1.MediaTypeId  =  T2.MediaTypeId GROUP BY T2.MediaTypeId ORDER BY COUNT(*) ASC LIMIT 1
SELECT T1.Title ,  T2.AlbumID FROM ALBUM AS T1 JOIN TRACK AS T2 ON T1.AlbumId  =  T2.AlbumId WHERE T2.UnitPrice  >  1 GROUP BY T2.AlbumID
SELECT T1.Title ,  T2.AlbumID FROM ALBUM AS T1 JOIN TRACK AS T2 ON T1.AlbumId  =  T2.AlbumId WHERE T2.UnitPrice  >  1 GROUP BY T2.AlbumID
SELECT T2.FirstName ,  T2.LastName FROM CUSTOMER AS T1 JOIN EMPLOYEE AS T2 ON T1.SupportRepId  =  T2.EmployeeId WHERE T1.FirstName  =  "Leonie"
SELECT T2.FirstName ,  T2.LastName FROM CUSTOMER AS T1 JOIN EMPLOYEE AS T2 ON T1.SupportRepId  =  T2.EmployeeId WHERE T1.FirstName  =  "Leonie"
SELECT T2.City FROM CUSTOMER AS T1 JOIN EMPLOYEE AS T2 ON T1.SupportRepId  =  T2.EmployeeId WHERE T1.PostalCode  =  "70174"
SELECT T2.City FROM CUSTOMER AS T1 JOIN EMPLOYEE AS T2 ON T1.SupportRepId  =  T2.EmployeeId WHERE T1.PostalCode  =  "70174"
SELECT T2.InvoiceDate FROM CUSTOMER AS T1 JOIN INVOICE AS T2 ON T1.CustomerId  =  T2.CustomerId WHERE T1.FirstName  =  "Astrid" AND LastName  =  "Gruber"
SELECT T2.InvoiceDate FROM CUSTOMER AS T1 JOIN INVOICE AS T2 ON T1.CustomerId  =  T2.CustomerId WHERE T1.FirstName  =  "Astrid" AND LastName  =  "Gruber"
SELECT DISTINCT T1.FirstName FROM CUSTOMER AS T1 JOIN INVOICE AS T2 ON T1.CustomerId  =  T2.CustomerId WHERE T1.country  =  "Brazil"
SELECT DISTINCT T1.FirstName FROM CUSTOMER AS T1 JOIN INVOICE AS T2 ON T1.CustomerId  =  T2.CustomerId WHERE T1.country  =  "Brazil"
SELECT DISTINCT T1.Address FROM CUSTOMER AS T1 JOIN INVOICE AS T2 ON T1.CustomerId  =  T2.CustomerId WHERE T1.country  =  "Germany"
SELECT DISTINCT T1.Address FROM CUSTOMER AS T1 JOIN INVOICE AS T2 ON T1.CustomerId  =  T2.CustomerId WHERE T1.country  =  "Germany"
SELECT Phone FROM EMPLOYEE
SELECT Phone FROM EMPLOYEE
SELECT T1.FirstName ,  T1.SupportRepId FROM CUSTOMER AS T1 JOIN EMPLOYEE AS T2 ON T1.SupportRepId  =  T2.EmployeeId GROUP BY T1.SupportRepId HAVING COUNT(*)  >=  10
SELECT T1.FirstName ,  T1.SupportRepId FROM CUSTOMER AS T1 JOIN EMPLOYEE AS T2 ON T1.SupportRepId  =  T2.EmployeeId GROUP BY T1.SupportRepId HAVING COUNT(*)  >=  10
SELECT T1.LastName FROM CUSTOMER AS T1 JOIN EMPLOYEE AS T2 ON T1.SupportRepId  =  T2.EmployeeId GROUP BY T1.SupportRepId HAVING COUNT(*)  <=  20
SELECT T1.LastName FROM CUSTOMER AS T1 JOIN EMPLOYEE AS T2 ON T1.SupportRepId  =  T2.EmployeeId GROUP BY T1.SupportRepId HAVING COUNT(*)  <=  20
SELECT Title FROM ALBUM ORDER BY Title
SELECT Title FROM ALBUM ORDER BY Title
SELECT BirthDate FROM EMPLOYEE WHERE City  =  "Edmonton"
SELECT BirthDate FROM EMPLOYEE WHERE City  =  "Edmonton"
SELECT distinct(UnitPrice) FROM TRACK
SELECT distinct(UnitPrice) FROM TRACK
SELECT customer_phone FROM available_policies
SELECT customer_phone FROM available_policies
SELECT customer_phone FROM available_policies WHERE policy_type_code  =  "Life Insurance"
SELECT customer_phone FROM available_policies WHERE policy_type_code  =  "Life Insurance"
SELECT policy_type_code FROM available_policies GROUP BY policy_type_code ORDER BY count(*) DESC LIMIT 1
SELECT policy_type_code FROM available_policies GROUP BY policy_type_code ORDER BY count(*) DESC LIMIT 1
SELECT policy_type_code FROM available_policies GROUP BY policy_type_code HAVING count(*)  >  4
SELECT policy_type_code FROM available_policies GROUP BY policy_type_code HAVING count(*)  >  4
SELECT service_name FROM services ORDER BY service_name
SELECT service_name FROM services ORDER BY service_name
SELECT count(*) FROM services
SELECT count(*) FROM services
SELECT customer_id FROM customers WHERE customer_name LIKE "%Diana%"
SELECT customer_id FROM customers WHERE customer_name LIKE "%Diana%"
SELECT max(settlement_amount) ,  min(settlement_amount) FROM settlements
SELECT max(settlement_amount) ,  min(settlement_amount) FROM settlements
SELECT customer_id ,  customer_name FROM customers ORDER BY customer_id ASC
SELECT customer_id ,  customer_name FROM customers ORDER BY customer_id ASC
SELECT count(*) FROM enzyme
SELECT count(*) FROM enzyme
SELECT name FROM enzyme ORDER BY name DESC
SELECT name FROM enzyme ORDER BY name DESC
SELECT name ,  LOCATION FROM enzyme
SELECT name ,  LOCATION FROM enzyme
SELECT max(OMIM) FROM enzyme
SELECT max(OMIM) FROM enzyme
SELECT product ,  chromosome ,  porphyria FROM enzyme WHERE LOCATION  =  'Cytosol'
SELECT product ,  chromosome ,  porphyria FROM enzyme WHERE LOCATION  =  'Cytosol'
SELECT name FROM enzyme WHERE product != 'Heme'
SELECT name FROM enzyme WHERE product != 'Heme'
SELECT name ,  trade_name FROM medicine WHERE FDA_approved  =  'Yes'
SELECT name ,  trade_name FROM medicine WHERE FDA_approved  =  'Yes'
SELECT T1.name FROM enzyme AS T1 JOIN medicine_enzyme_interaction AS T2 ON T1.id  =  T2.enzyme_id JOIN medicine AS T3 ON T2.medicine_id  =  T3.id WHERE T3.name  =  'Amisulpride' AND T2.interaction_type  =  'inhibitor'
SELECT T1.name FROM enzyme AS T1 JOIN medicine_enzyme_interaction AS T2 ON T1.id  =  T2.enzyme_id JOIN medicine AS T3 ON T2.medicine_id  =  T3.id WHERE T3.name  =  'Amisulpride' AND T2.interaction_type  =  'inhibitor'
SELECT T1.id ,  T1.Name FROM medicine AS T1 JOIN medicine_enzyme_interaction AS T2 ON T2.medicine_id  =  T1.id GROUP BY T1.id HAVING count(*)  >=  2
SELECT T1.id ,  T1.Name FROM medicine AS T1 JOIN medicine_enzyme_interaction AS T2 ON T2.medicine_id  =  T1.id GROUP BY T1.id HAVING count(*)  >=  2
SELECT T1.id ,  T1.Name ,  T1.FDA_approved FROM medicine AS T1 JOIN medicine_enzyme_interaction AS T2 ON T2.medicine_id  =  T1.id GROUP BY T1.id ORDER BY count(*) DESC
SELECT T1.id ,  T1.Name ,  T1.FDA_approved FROM medicine AS T1 JOIN medicine_enzyme_interaction AS T2 ON T2.medicine_id  =  T1.id GROUP BY T1.id ORDER BY count(*) DESC
SELECT T1.id ,  T1.name FROM enzyme AS T1 JOIN medicine_enzyme_interaction AS T2 ON T1.id  =  T2.enzyme_id WHERE T2.interaction_type  =  'activitor' GROUP BY T1.id ORDER BY count(*) DESC LIMIT 1
SELECT T1.id ,  T1.name FROM enzyme AS T1 JOIN medicine_enzyme_interaction AS T2 ON T1.id  =  T2.enzyme_id WHERE T2.interaction_type  =  'activitor' GROUP BY T1.id ORDER BY count(*) DESC LIMIT 1
SELECT T1.interaction_type FROM medicine_enzyme_interaction AS T1 JOIN medicine AS T2 ON T1.medicine_id  =  T2.id JOIN enzyme AS T3 ON T1.enzyme_id  =  T3.id WHERE T3.name  =  'ALA synthase' AND T2.name  =  'Aripiprazole'
SELECT T1.interaction_type FROM medicine_enzyme_interaction AS T1 JOIN medicine AS T2 ON T1.medicine_id  =  T2.id JOIN enzyme AS T3 ON T1.enzyme_id  =  T3.id WHERE T3.name  =  'ALA synthase' AND T2.name  =  'Aripiprazole'
SELECT count(*) FROM medicine WHERE FDA_approved  =  'No'
SELECT count(*) FROM medicine WHERE FDA_approved  =  'No'
SELECT count(*) FROM enzyme WHERE id NOT IN ( SELECT enzyme_id FROM medicine_enzyme_interaction );
SELECT count(*) FROM enzyme WHERE id NOT IN ( SELECT enzyme_id FROM medicine_enzyme_interaction );
SELECT T1.id ,  T1.trade_name FROM medicine AS T1 JOIN medicine_enzyme_interaction AS T2 ON T2.medicine_id  =  T1.id GROUP BY T1.id HAVING COUNT(*)  >=  3
SELECT T1.id ,  T1.trade_name FROM medicine AS T1 JOIN medicine_enzyme_interaction AS T2 ON T2.medicine_id  =  T1.id GROUP BY T1.id HAVING COUNT(*)  >=  3
SELECT DISTINCT T1.name ,  T1.location ,  T1.product FROM enzyme AS T1 JOIN medicine_enzyme_interaction AS T2 ON T2.enzyme_id  =  T1.id WHERE T2.interaction_type  =  'inhibitor'
SELECT DISTINCT T1.name ,  T1.location ,  T1.product FROM enzyme AS T1 JOIN medicine_enzyme_interaction AS T2 ON T2.enzyme_id  =  T1.id WHERE T2.interaction_type  =  'inhibitor'
SELECT name FROM enzyme WHERE name LIKE "%ALA%"
SELECT name FROM enzyme WHERE name LIKE "%ALA%"
SELECT trade_name ,  count(*) FROM medicine GROUP BY trade_name
SELECT trade_name ,  count(*) FROM medicine GROUP BY trade_name
SELECT school ,  nickname FROM university ORDER BY founded
SELECT school ,  nickname FROM university ORDER BY founded
SELECT school ,  LOCATION FROM university WHERE affiliation  =  'Public'
SELECT school ,  LOCATION FROM university WHERE affiliation  =  'Public'
SELECT founded FROM university ORDER BY enrollment DESC LIMIT 1
SELECT founded FROM university ORDER BY enrollment DESC LIMIT 1
SELECT founded FROM university WHERE affiliation != 'Public' ORDER BY founded DESC LIMIT 1
SELECT founded FROM university WHERE affiliation != 'Public' ORDER BY founded DESC LIMIT 1
SELECT acc_percent FROM basketball_match ORDER BY acc_percent DESC LIMIT 1
SELECT acc_percent FROM basketball_match ORDER BY acc_percent DESC LIMIT 1
SELECT avg(enrollment) FROM university WHERE founded  <  1850
SELECT avg(enrollment) FROM university WHERE founded  <  1850
SELECT enrollment ,  primary_conference FROM university ORDER BY founded LIMIT 1
SELECT enrollment ,  primary_conference FROM university ORDER BY founded LIMIT 1
SELECT count(*) FROM university WHERE school_id NOT IN (SELECT school_id FROM basketball_match)
SELECT count(*) FROM university WHERE school_id NOT IN (SELECT school_id FROM basketball_match)
SELECT school FROM university WHERE founded  >  1850 OR affiliation  =  'Public'
SELECT school FROM university WHERE founded  >  1850 OR affiliation  =  'Public'
SELECT count(*) ,  affiliation FROM university WHERE enrollment  >  20000 GROUP BY affiliation
SELECT count(*) ,  affiliation FROM university WHERE enrollment  >  20000 GROUP BY affiliation
SELECT max(Enrollment) FROM university
SELECT max(Enrollment) FROM university
SELECT team_name FROM basketball_match ORDER BY All_Home DESC
SELECT team_name FROM basketball_match ORDER BY All_Home DESC
SELECT Model_name FROM chip_model WHERE Launch_year BETWEEN 2002 AND 2004;
SELECT Model_name ,  RAM_MiB FROM chip_model ORDER BY RAM_MiB ASC LIMIT 1;
SELECT chip_model ,  screen_mode FROM phone WHERE Hardware_Model_name = "LG-P760";
SELECT count(*) FROM phone WHERE Company_name = "Nokia Corporation";
SELECT T2.Hardware_Model_name ,  T2.Company_name FROM chip_model AS T1 JOIN phone AS T2 ON T1.Model_name  =  T2.chip_model WHERE T1.Launch_year = 2002 OR T1.RAM_MiB  >  32;
SELECT Hardware_Model_name ,  Company_name FROM phone WHERE Accreditation_type LIKE 'Full';
SELECT T1.Char_cells ,  T1.Pixels ,  T1.Hardware_colours FROM screen_mode AS T1 JOIN phone AS T2 ON T1.Graphics_mode = T2.screen_mode WHERE T2.Hardware_Model_name = "LG-P760";
SELECT T2.Hardware_Model_name ,  T2.Company_name FROM screen_mode AS T1 JOIN phone AS T2 ON T1.Graphics_mode = T2.screen_mode WHERE T1.Type  =  "Graphics";
SELECT Company_name FROM phone GROUP BY Company_name HAVING count(*)  >  1;
SELECT max(used_kb) , min(used_kb) , avg(used_kb) FROM screen_mode;
SELECT T2.Hardware_Model_name FROM chip_model AS T1 JOIN phone AS T2 ON T1.Model_name  =  T2.chip_model WHERE T1.Launch_year = 2002 ORDER BY T1.RAM_MiB DESC LIMIT 1;
SELECT T1.WiFi , T3.Type FROM chip_model AS T1 JOIN phone AS T2 ON T1.Model_name  =  T2.chip_model JOIN screen_mode AS T3 ON T2.screen_mode = T3.Graphics_mode WHERE T2.Hardware_Model_name = "LG-P760";
SELECT T2.Hardware_Model_name FROM chip_model AS T1 JOIN phone AS T2 ON T1.Model_name  =  T2.chip_model JOIN screen_mode AS T3 ON T2.screen_mode = T3.Graphics_mode WHERE T3.Type = "Text" OR T1.RAM_MiB  >  32;
SELECT DISTINCT T2.Hardware_Model_name , T2.Company_name FROM screen_mode AS T1 JOIN phone AS T2 ON T1.Graphics_mode = T2.screen_mode WHERE T1.used_kb BETWEEN 10 AND 15;
SELECT Accreditation_type ,  count(*) FROM phone GROUP BY Accreditation_type
SELECT Accreditation_type ,  count(*) FROM phone GROUP BY Accreditation_type
SELECT Accreditation_level FROM phone GROUP BY Accreditation_level HAVING count(*)  >  3
SELECT count(*) FROM chip_model WHERE wifi  =  'No'
SELECT count(*) FROM chip_model WHERE wifi  =  'No'
SELECT model_name FROM chip_model ORDER BY launch_year
SELECT count(*) FROM country
SELECT count(*) FROM country
SELECT Country_name ,  Capital FROM country
SELECT Country_name ,  Capital FROM country
SELECT Official_native_language FROM country WHERE Official_native_language LIKE "%English%"
SELECT Official_native_language FROM country WHERE Official_native_language LIKE "%English%"
SELECT DISTINCT POSITION FROM match_season
SELECT DISTINCT POSITION FROM match_season
SELECT Player FROM match_season WHERE College  =  "UCLA"
SELECT Player FROM match_season WHERE College  =  "UCLA"
SELECT DISTINCT POSITION FROM match_season WHERE College  =  "UCLA" OR College  =  "Duke"
SELECT DISTINCT POSITION FROM match_season WHERE College  =  "UCLA" OR College  =  "Duke"
SELECT Draft_Pick_Number ,  Draft_Class FROM match_season WHERE POSITION  =  "Defender"
SELECT Draft_Pick_Number ,  Draft_Class FROM match_season WHERE POSITION  =  "Defender"
SELECT Player ,  Years_Played FROM player
SELECT Player ,  Years_Played FROM player
SELECT Name FROM Team
SELECT Name FROM Team
SELECT T2.Season ,  T2.Player ,  T1.Country_name FROM country AS T1 JOIN match_season AS T2 ON T1.Country_id  =  T2.Country
SELECT T2.Season ,  T2.Player ,  T1.Country_name FROM country AS T1 JOIN match_season AS T2 ON T1.Country_id  =  T2.Country
SELECT T2.Player FROM country AS T1 JOIN match_season AS T2 ON T1.Country_id  =  T2.Country WHERE T1.Country_name  =  "Indonesia"
SELECT T2.Player FROM country AS T1 JOIN match_season AS T2 ON T1.Country_id  =  T2.Country WHERE T1.Country_name  =  "Indonesia"
SELECT DISTINCT T2.Position FROM country AS T1 JOIN match_season AS T2 ON T1.Country_id  =  T2.Country WHERE T1.Capital  =  "Dublin"
SELECT DISTINCT T2.Position FROM country AS T1 JOIN match_season AS T2 ON T1.Country_id  =  T2.Country WHERE T1.Capital  =  "Dublin"
SELECT T1.Official_native_language FROM country AS T1 JOIN match_season AS T2 ON T1.Country_id  =  T2.Country WHERE T2.College  =  "Maryland" OR T2.College  =  "Duke"
SELECT T1.Official_native_language FROM country AS T1 JOIN match_season AS T2 ON T1.Country_id  =  T2.Country WHERE T2.College  =  "Maryland" OR T2.College  =  "Duke"
SELECT T1.Season ,  T1.Player ,  T2.Name FROM match_season AS T1 JOIN team AS T2 ON T1.Team  =  T2.Team_id
SELECT T1.Season ,  T1.Player ,  T2.Name FROM match_season AS T1 JOIN team AS T2 ON T1.Team  =  T2.Team_id
SELECT T1.Position FROM match_season AS T1 JOIN team AS T2 ON T1.Team  =  T2.Team_id WHERE T2.Name  =  "Ryley Goldner"
SELECT T1.Position FROM match_season AS T1 JOIN team AS T2 ON T1.Team  =  T2.Team_id WHERE T2.Name  =  "Ryley Goldner"
SELECT T1.Player , T1.Years_Played FROM player AS T1 JOIN team AS T2 ON T1.Team  =  T2.Team_id WHERE T2.Name  =  "Columbus Crew"
SELECT T1.Player , T1.Years_Played FROM player AS T1 JOIN team AS T2 ON T1.Team  =  T2.Team_id WHERE T2.Name  =  "Columbus Crew"
SELECT POSITION ,  COUNT(*) FROM match_season GROUP BY POSITION
SELECT POSITION ,  COUNT(*) FROM match_season GROUP BY POSITION
SELECT Country_name ,  COUNT(*) FROM country AS T1 JOIN match_season AS T2 ON T1.Country_id  =  T2.Country GROUP BY T1.Country_name
SELECT Country_name ,  COUNT(*) FROM country AS T1 JOIN match_season AS T2 ON T1.Country_id  =  T2.Country GROUP BY T1.Country_name
SELECT player FROM match_season ORDER BY College ASC
SELECT player FROM match_season ORDER BY College ASC
SELECT POSITION FROM match_season GROUP BY POSITION ORDER BY count(*) DESC LIMIT 1
SELECT POSITION FROM match_season GROUP BY POSITION ORDER BY count(*) DESC LIMIT 1
SELECT College FROM match_season GROUP BY College ORDER BY count(*) DESC LIMIT 3
SELECT College FROM match_season GROUP BY College ORDER BY count(*) DESC LIMIT 3
SELECT College FROM match_season GROUP BY College HAVING count(*)  >=  2
SELECT College FROM match_season GROUP BY College HAVING count(*)  >=  2
SELECT count(*) FROM climber
SELECT count(*) FROM climber
SELECT Name FROM climber ORDER BY Points DESC
SELECT Name FROM climber ORDER BY Points DESC
SELECT Name FROM climber WHERE Country != "Switzerland"
SELECT Name FROM climber WHERE Country != "Switzerland"
SELECT max(Points) FROM climber WHERE Country  =  "United Kingdom"
SELECT max(Points) FROM climber WHERE Country  =  "United Kingdom"
SELECT Name FROM mountain ORDER BY Name ASC
SELECT Name FROM mountain ORDER BY Name ASC
SELECT Country FROM mountain WHERE Height  >  5000
SELECT Country FROM mountain WHERE Height  >  5000
SELECT Name FROM mountain ORDER BY Height DESC LIMIT 1
SELECT Name FROM mountain ORDER BY Height DESC LIMIT 1
SELECT T1.Name ,  T2.Name FROM climber AS T1 JOIN mountain AS T2 ON T1.Mountain_ID  =  T2.Mountain_ID
SELECT T1.Name ,  T2.Name FROM climber AS T1 JOIN mountain AS T2 ON T1.Mountain_ID  =  T2.Mountain_ID
SELECT T1.Name ,  T2.Height FROM climber AS T1 JOIN mountain AS T2 ON T1.Mountain_ID  =  T2.Mountain_ID
SELECT T1.Name ,  T2.Height FROM climber AS T1 JOIN mountain AS T2 ON T1.Mountain_ID  =  T2.Mountain_ID
SELECT T2.Height FROM climber AS T1 JOIN mountain AS T2 ON T1.Mountain_ID  =  T2.Mountain_ID ORDER BY T1.Points DESC LIMIT 1
SELECT T2.Height FROM climber AS T1 JOIN mountain AS T2 ON T1.Mountain_ID  =  T2.Mountain_ID ORDER BY T1.Points DESC LIMIT 1
SELECT DISTINCT T2.Name FROM climber AS T1 JOIN mountain AS T2 ON T1.Mountain_ID  =  T2.Mountain_ID WHERE T1.Country  =  "West Germany"
SELECT DISTINCT T2.Name FROM climber AS T1 JOIN mountain AS T2 ON T1.Mountain_ID  =  T2.Mountain_ID WHERE T1.Country  =  "West Germany"
SELECT T1.Time FROM climber AS T1 JOIN mountain AS T2 ON T1.Mountain_ID  =  T2.Mountain_ID WHERE T2.Country  =  "Uganda"
SELECT T1.Time FROM climber AS T1 JOIN mountain AS T2 ON T1.Mountain_ID  =  T2.Mountain_ID WHERE T2.Country  =  "Uganda"
SELECT Country ,  COUNT(*) FROM climber GROUP BY Country
SELECT Country ,  COUNT(*) FROM climber GROUP BY Country
SELECT Country FROM mountain GROUP BY Country HAVING COUNT(*)  >  1
SELECT Country FROM mountain GROUP BY Country HAVING COUNT(*)  >  1
SELECT Name FROM mountain WHERE Mountain_ID NOT IN (SELECT Mountain_ID FROM climber)
SELECT Name FROM mountain WHERE Mountain_ID NOT IN (SELECT Mountain_ID FROM climber)
SELECT Range FROM mountain GROUP BY Range ORDER BY COUNT(*) DESC LIMIT 1
SELECT Range FROM mountain GROUP BY Range ORDER BY COUNT(*) DESC LIMIT 1
SELECT Name FROM mountain WHERE Height  >  5000 OR Prominence  >  1000
SELECT Name FROM mountain WHERE Height  >  5000 OR Prominence  >  1000
SELECT count(*) FROM body_builder
SELECT Total FROM body_builder ORDER BY Total ASC
SELECT Snatch ,  Clean_Jerk FROM body_builder ORDER BY Snatch ASC
SELECT avg(Snatch) FROM body_builder
SELECT Clean_Jerk FROM body_builder ORDER BY Total DESC LIMIT 1
SELECT Birth_Date FROM People ORDER BY Height ASC
SELECT T2.Name FROM body_builder AS T1 JOIN people AS T2 ON T1.People_ID  =  T2.People_ID
SELECT T2.Name FROM body_builder AS T1 JOIN people AS T2 ON T1.People_ID  =  T2.People_ID WHERE T1.Total  >  300
SELECT T2.Name FROM body_builder AS T1 JOIN people AS T2 ON T1.People_ID  =  T2.People_ID ORDER BY T2.Weight DESC LIMIT 1
SELECT T2.Birth_Date ,  T2.Birth_Place FROM body_builder AS T1 JOIN people AS T2 ON T1.People_ID  =  T2.People_ID ORDER BY T1.Total DESC LIMIT 1
SELECT T2.Height FROM body_builder AS T1 JOIN people AS T2 ON T1.People_ID  =  T2.People_ID WHERE T1.Total  <  315
SELECT avg(T1.Total) FROM body_builder AS T1 JOIN people AS T2 ON T1.People_ID  =  T2.People_ID WHERE T2.Height  >  200
SELECT T2.Name FROM body_builder AS T1 JOIN people AS T2 ON T1.People_ID  =  T2.People_ID ORDER BY T1.Total DESC
SELECT Birth_Place ,  COUNT(*) FROM people GROUP BY Birth_Place
SELECT Birth_Place FROM people GROUP BY Birth_Place ORDER BY COUNT(*) DESC LIMIT 1
SELECT Birth_Place FROM people GROUP BY Birth_Place HAVING COUNT(*)  >=  2
SELECT Height ,  Weight FROM people ORDER BY Height DESC
SELECT count(*) FROM people WHERE people_id NOT IN (SELECT People_ID FROM body_builder)
SELECT T2.weight FROM body_builder AS T1 JOIN people AS T2 ON T1.people_id  =  T2.people_id WHERE T1.snatch  >  140 OR T2.height  >  200;
SELECT min(snatch) FROM body_builder
SELECT count(*) FROM election
SELECT Votes FROM election ORDER BY Votes DESC
SELECT Date ,  Vote_Percent FROM election
SELECT min(Vote_Percent) ,  max(Vote_Percent) FROM election
SELECT Name ,  Party FROM representative
SELECT Name FROM Representative WHERE Party != "Republican"
SELECT Lifespan FROM representative WHERE State  =  "New York" OR State  =  "Indiana"
SELECT T2.Name ,  T1.Date FROM election AS T1 JOIN representative AS T2 ON T1.Representative_ID  =  T2.Representative_ID
SELECT T2.Name FROM election AS T1 JOIN representative AS T2 ON T1.Representative_ID  =  T2.Representative_ID WHERE Votes  >  10000
SELECT T2.Name FROM election AS T1 JOIN representative AS T2 ON T1.Representative_ID  =  T2.Representative_ID ORDER BY votes DESC
SELECT T2.Party FROM election AS T1 JOIN representative AS T2 ON T1.Representative_ID  =  T2.Representative_ID ORDER BY votes ASC LIMIT 1
SELECT T2.Lifespan FROM election AS T1 JOIN representative AS T2 ON T1.Representative_ID  =  T2.Representative_ID ORDER BY Vote_Percent DESC
SELECT avg(T1.Votes) FROM election AS T1 JOIN representative AS T2 ON T1.Representative_ID  =  T2.Representative_ID WHERE T2.Party  =  "Republican"
SELECT Party ,  COUNT(*) FROM representative GROUP BY Party
SELECT Party ,  COUNT(*) FROM representative GROUP BY Party ORDER BY COUNT(*) DESC LIMIT 1
SELECT Party FROM representative GROUP BY Party HAVING COUNT(*)  >=  3
SELECT State FROM representative GROUP BY State HAVING COUNT(*)  >=  2
SELECT Name FROM representative WHERE Representative_ID NOT IN (SELECT Representative_ID FROM election)
SELECT count(*) FROM Apartment_Bookings
SELECT count(*) FROM Apartment_Bookings
SELECT booking_start_date ,  booking_end_date FROM Apartment_Bookings
SELECT booking_start_date ,  booking_end_date FROM Apartment_Bookings
SELECT DISTINCT building_description FROM Apartment_Buildings
SELECT DISTINCT building_description FROM Apartment_Buildings
SELECT building_short_name FROM Apartment_Buildings WHERE building_manager	 =  "Emma"
SELECT building_short_name FROM Apartment_Buildings WHERE building_manager	 =  "Emma"
SELECT building_address ,  building_phone FROM Apartment_Buildings WHERE building_manager	 =  "Brenden"
SELECT building_address ,  building_phone FROM Apartment_Buildings WHERE building_manager	 =  "Brenden"
SELECT building_full_name FROM Apartment_Buildings WHERE building_full_name LIKE "%court%"
SELECT building_full_name FROM Apartment_Buildings WHERE building_full_name LIKE "%court%"
SELECT min(bathroom_count) ,  max(bathroom_count) FROM Apartments
SELECT min(bathroom_count) ,  max(bathroom_count) FROM Apartments
SELECT apt_number ,  room_count FROM Apartments
SELECT apt_number ,  room_count FROM Apartments
SELECT apt_number FROM Apartments WHERE apt_type_code  =  "Flat"
SELECT apt_number FROM Apartments WHERE apt_type_code  =  "Flat"
SELECT guest_first_name ,  guest_last_name FROM Guests
SELECT guest_first_name ,  guest_last_name FROM Guests
SELECT date_of_birth FROM Guests WHERE gender_code  =  "Male"
SELECT date_of_birth FROM Guests WHERE gender_code  =  "Male"
SELECT T1.booking_status_code FROM Apartment_Bookings AS T1 JOIN Apartments AS T2 ON T1.apt_id  =  T2.apt_id WHERE T2.apt_number  =  "Suite 634"
SELECT T1.booking_status_code FROM Apartment_Bookings AS T1 JOIN Apartments AS T2 ON T1.apt_id  =  T2.apt_id WHERE T2.apt_number  =  "Suite 634"
SELECT DISTINCT T2.apt_number FROM Apartment_Bookings AS T1 JOIN Apartments AS T2 ON T1.apt_id  =  T2.apt_id WHERE T1.booking_status_code  =  "Confirmed"
SELECT DISTINCT T2.apt_number FROM Apartment_Bookings AS T1 JOIN Apartments AS T2 ON T1.apt_id  =  T2.apt_id WHERE T1.booking_status_code  =  "Confirmed"
SELECT T2.guest_first_name ,  T2.guest_last_name FROM Apartment_Bookings AS T1 JOIN Guests AS T2 ON T1.guest_id  =  T2.guest_id WHERE T1.booking_status_code  =  "Confirmed"
SELECT T2.guest_first_name ,  T2.guest_last_name FROM Apartment_Bookings AS T1 JOIN Guests AS T2 ON T1.guest_id  =  T2.guest_id WHERE T1.booking_status_code  =  "Confirmed"
SELECT T1.facility_code FROM Apartment_Facilities AS T1 JOIN Apartments AS T2 ON T1.apt_id  =  T2.apt_id WHERE T2.bedroom_count  >  4
SELECT T1.facility_code FROM Apartment_Facilities AS T1 JOIN Apartments AS T2 ON T1.apt_id  =  T2.apt_id WHERE T2.bedroom_count  >  4
SELECT T1.building_address FROM Apartment_Buildings AS T1 JOIN Apartments AS T2 ON T1.building_id  =  T2.building_id WHERE T2.bathroom_count  >  2
SELECT T1.building_address FROM Apartment_Buildings AS T1 JOIN Apartments AS T2 ON T1.building_id  =  T2.building_id WHERE T2.bathroom_count  >  2
SELECT T2.apt_type_code ,  T2.apt_number FROM Apartment_Buildings AS T1 JOIN Apartments AS T2 ON T1.building_id  =  T2.building_id WHERE T1.building_manager  =  "Kyle"
SELECT T2.apt_type_code ,  T2.apt_number FROM Apartment_Buildings AS T1 JOIN Apartments AS T2 ON T1.building_id  =  T2.building_id WHERE T1.building_manager  =  "Kyle"
SELECT 	booking_status_code ,  COUNT(*) FROM Apartment_Bookings GROUP BY booking_status_code
SELECT 	booking_status_code ,  COUNT(*) FROM Apartment_Bookings GROUP BY booking_status_code
SELECT apt_number FROM Apartments ORDER BY room_count ASC
SELECT apt_number FROM Apartments ORDER BY room_count ASC
SELECT apt_number FROM Apartments ORDER BY bedroom_count DESC LIMIT 1
SELECT apt_number FROM Apartments ORDER BY bedroom_count DESC LIMIT 1
SELECT apt_type_code ,  COUNT(*) FROM Apartments GROUP BY apt_type_code ORDER BY COUNT(*) ASC
SELECT apt_type_code ,  COUNT(*) FROM Apartments GROUP BY apt_type_code ORDER BY COUNT(*) ASC
SELECT apt_type_code FROM Apartments GROUP BY apt_type_code ORDER BY count(*) DESC LIMIT 1
SELECT apt_type_code FROM Apartments GROUP BY apt_type_code ORDER BY count(*) DESC LIMIT 1
SELECT apt_type_code FROM Apartments WHERE bathroom_count  >  1 GROUP BY apt_type_code ORDER BY count(*) DESC LIMIT 1
SELECT apt_type_code FROM Apartments WHERE bathroom_count  >  1 GROUP BY apt_type_code ORDER BY count(*) DESC LIMIT 1
SELECT gender_code ,  COUNT(*) FROM Guests GROUP BY gender_code ORDER BY COUNT(*) DESC
SELECT gender_code ,  COUNT(*) FROM Guests GROUP BY gender_code ORDER BY COUNT(*) DESC
SELECT count(*) FROM Apartments WHERE apt_id NOT IN (SELECT apt_id FROM Apartment_Facilities)
SELECT count(*) FROM Apartments WHERE apt_id NOT IN (SELECT apt_id FROM Apartment_Facilities)
SELECT count(*) FROM game WHERE season  >  2007
SELECT Date FROM game ORDER BY home_team DESC
SELECT season ,  home_team ,  away_team FROM game
SELECT max(home_games) ,  min(home_games) ,  avg(home_games) FROM stadium
SELECT average_attendance FROM stadium WHERE capacity_percentage  >  100
SELECT player ,  number_of_matches ,  SOURCE FROM injury_accident WHERE injury != 'Knee problem'
SELECT T1.season FROM game AS T1 JOIN injury_accident AS T2 ON T1.id  =  T2.game_id WHERE T2.player  =  'Walter Samuel'
SELECT T1.id ,  T1.score ,  T1.date FROM game AS T1 JOIN injury_accident AS T2 ON T2.game_id  =  T1.id GROUP BY T1.id HAVING count(*)  >=  2
SELECT T1.id ,  T1.name FROM stadium AS T1 JOIN game AS T2 ON T1.id  =  T2.stadium_id JOIN injury_accident AS T3 ON T2.id  =  T3.game_id GROUP BY T1.id ORDER BY count(*) DESC LIMIT 1
SELECT T1.id ,  T1.name FROM stadium AS T1 JOIN game AS T2 ON T1.id  =  T2.stadium_id JOIN injury_accident AS T3 ON T2.id  =  T3.game_id GROUP BY T1.id ORDER BY count(*) DESC LIMIT 1
SELECT T1.season ,  T2.name FROM game AS T1 JOIN stadium AS T2 ON T1.stadium_id  =  T2.id JOIN injury_accident AS T3 ON T1.id  =  T3.game_id WHERE T3.injury  =  'Foot injury' OR T3.injury  =  'Knee problem'
SELECT count(*) FROM game WHERE id NOT IN ( SELECT game_id FROM injury_accident )
SELECT name FROM stadium WHERE name LIKE "%Bank%"
SELECT T1.id ,  count(*) FROM stadium AS T1 JOIN game AS T2 ON T1.id  =  T2.stadium_id GROUP BY T1.id
SELECT T1.date ,  T2.player FROM game AS T1 JOIN injury_accident AS T2 ON T1.id  =  T2.game_id ORDER BY T1.season DESC
SELECT T1.name ,  T2.name FROM Country AS T1 JOIN League AS T2 ON T1.id  =  T2.country_id
SELECT DISTINCT T1.player_name FROM Player AS T1 JOIN Player_Attributes AS T2 ON T1.player_api_id = T2.player_api_id WHERE T2.crossing  >  90 AND T2.preferred_foot  =  "right"
SELECT DISTINCT T1.player_name FROM Player AS T1 JOIN Player_Attributes AS T2 ON T1.player_api_id = T2.player_api_id WHERE T2.preferred_foot  =  "left" AND T2.overall_rating  >=  85 AND T2.overall_rating  <=  90
SELECT preferred_foot ,  count(*) FROM Player_Attributes WHERE overall_rating  >  80 GROUP BY preferred_foot
SELECT count(*) FROM performance
SELECT HOST FROM performance ORDER BY Attendance ASC
SELECT Date ,  LOCATION FROM performance
SELECT Attendance FROM performance WHERE LOCATION  =  "TD Garden" OR LOCATION  =  "Bell Centre"
SELECT Date FROM performance ORDER BY Attendance DESC LIMIT 1
SELECT LOCATION ,  COUNT(*) FROM performance GROUP BY LOCATION
SELECT LOCATION FROM performance GROUP BY LOCATION ORDER BY COUNT(*) DESC LIMIT 1
SELECT LOCATION FROM performance GROUP BY LOCATION HAVING COUNT(*)  >=  2
SELECT T2.Name ,  T3.Location FROM member_attendance AS T1 JOIN member AS T2 ON T1.Member_ID  =  T2.Member_ID JOIN performance AS T3 ON T1.Performance_ID  =  T3.Performance_ID
SELECT T2.Name ,  T3.Location FROM member_attendance AS T1 JOIN member AS T2 ON T1.Member_ID  =  T2.Member_ID JOIN performance AS T3 ON T1.Performance_ID  =  T3.Performance_ID ORDER BY T2.Name ASC
SELECT T3.Date FROM member_attendance AS T1 JOIN member AS T2 ON T1.Member_ID  =  T2.Member_ID JOIN performance AS T3 ON T1.Performance_ID  =  T3.Performance_ID WHERE T2.Role  =  "Violin"
SELECT T2.Name ,  T3.Date FROM member_attendance AS T1 JOIN member AS T2 ON T1.Member_ID  =  T2.Member_ID JOIN performance AS T3 ON T1.Performance_ID  =  T3.Performance_ID ORDER BY T3.Attendance DESC
SELECT DISTINCT building FROM classroom WHERE capacity  >  50
SELECT DISTINCT building FROM classroom WHERE capacity  >  50
SELECT building ,  room_number FROM classroom WHERE capacity BETWEEN 50 AND 100
SELECT building ,  room_number FROM classroom WHERE capacity BETWEEN 50 AND 100
SELECT dept_name ,  building FROM department ORDER BY budget DESC LIMIT 1
SELECT dept_name ,  building FROM department ORDER BY budget DESC LIMIT 1
SELECT name FROM student WHERE dept_name  =  'History' ORDER BY tot_cred DESC LIMIT 1
SELECT name FROM student WHERE dept_name  =  'History' ORDER BY tot_cred DESC LIMIT 1
SELECT T1.title FROM course AS T1 JOIN prereq AS T2 ON T1.course_id  =  T2.course_id GROUP BY T2.course_id HAVING count(*)  =  2
SELECT T1.title FROM course AS T1 JOIN prereq AS T2 ON T1.course_id  =  T2.course_id GROUP BY T2.course_id HAVING count(*)  =  2
SELECT T1.title ,  T1.credits , T1.dept_name FROM course AS T1 JOIN prereq AS T2 ON T1.course_id  =  T2.course_id GROUP BY T2.course_id HAVING count(*)  >  1
SELECT T1.title ,  T1.credits , T1.dept_name FROM course AS T1 JOIN prereq AS T2 ON T1.course_id  =  T2.course_id GROUP BY T2.course_id HAVING count(*)  >  1
SELECT title FROM course WHERE course_id NOT IN (SELECT course_id FROM prereq)
SELECT title FROM course WHERE course_id NOT IN (SELECT course_id FROM prereq)
SELECT dept_name FROM instructor WHERE name LIKE '%Soisalon%'
SELECT dept_name FROM instructor WHERE name LIKE '%Soisalon%'
SELECT name FROM instructor WHERE dept_name  =  'Statistics' ORDER BY salary LIMIT 1
SELECT name FROM instructor WHERE dept_name  =  'Statistics' ORDER BY salary LIMIT 1
SELECT DISTINCT T1.name FROM student AS T1 JOIN takes AS T2 ON T1.id  =  T2.id WHERE YEAR  =  2009 OR YEAR  =  2010
SELECT DISTINCT T1.name FROM student AS T1 JOIN takes AS T2 ON T1.id  =  T2.id WHERE YEAR  =  2009 OR YEAR  =  2010
SELECT dept_name FROM course GROUP BY dept_name ORDER BY count(*) DESC LIMIT 3
SELECT dept_name FROM course GROUP BY dept_name ORDER BY count(*) DESC LIMIT 3
SELECT title FROM course ORDER BY title ,  credits
SELECT title FROM course ORDER BY title ,  credits
SELECT dept_name FROM department ORDER BY budget LIMIT 1
SELECT dept_name FROM department ORDER BY budget LIMIT 1
SELECT dept_name ,  building FROM department ORDER BY budget DESC
SELECT dept_name ,  building FROM department ORDER BY budget DESC
SELECT name FROM instructor ORDER BY salary DESC LIMIT 1
SELECT name FROM instructor ORDER BY salary DESC LIMIT 1
SELECT name ,  dept_name FROM student ORDER BY tot_cred
SELECT name ,  dept_name FROM student ORDER BY tot_cred
SELECT T1.title ,  T3.name FROM course AS T1 JOIN teaches AS T2 ON T1.course_id  =  T2.course_id JOIN instructor AS T3 ON T2.id  =  T3.id WHERE YEAR  =  2008 ORDER BY T1.title
SELECT T1.title ,  T3.name FROM course AS T1 JOIN teaches AS T2 ON T1.course_id  =  T2.course_id JOIN instructor AS T3 ON T2.id  =  T3.id WHERE YEAR  =  2008 ORDER BY T1.title
SELECT T1.name FROM instructor AS T1 JOIN advisor AS T2 ON T1.id  =  T2.i_id GROUP BY T2.i_id HAVING count(*)  >  1
SELECT T1.name FROM instructor AS T1 JOIN advisor AS T2 ON T1.id  =  T2.i_id GROUP BY T2.i_id HAVING count(*)  >  1
SELECT T1.name FROM student AS T1 JOIN advisor AS T2 ON T1.id  =  T2.s_id GROUP BY T2.s_id HAVING count(*)  >  1
SELECT T1.name FROM student AS T1 JOIN advisor AS T2 ON T1.id  =  T2.s_id GROUP BY T2.s_id HAVING count(*)  >  1
SELECT count(*) ,  building FROM classroom WHERE capacity  >  50 GROUP BY building
SELECT count(*) ,  building FROM classroom WHERE capacity  >  50 GROUP BY building
SELECT title FROM course GROUP BY title HAVING count(*)  >  1
SELECT title FROM course GROUP BY title HAVING count(*)  >  1
SELECT YEAR FROM SECTION GROUP BY YEAR ORDER BY count(*) DESC LIMIT 1
SELECT YEAR FROM SECTION GROUP BY YEAR ORDER BY count(*) DESC LIMIT 1
SELECT dept_name FROM student GROUP BY dept_name ORDER BY count(*) DESC LIMIT 1
SELECT dept_name FROM student GROUP BY dept_name ORDER BY count(*) DESC LIMIT 1
SELECT count(*) ,  dept_name FROM student GROUP BY dept_name
SELECT count(*) ,  dept_name FROM student GROUP BY dept_name
SELECT i_id FROM advisor AS T1 JOIN student AS T2 ON T1.s_id  =  T2.id WHERE T2.dept_name  =  'History'
SELECT i_id FROM advisor AS T1 JOIN student AS T2 ON T1.s_id  =  T2.id WHERE T2.dept_name  =  'History'
SELECT T2.name ,  T2.salary FROM advisor AS T1 JOIN instructor AS T2 ON T1.i_id  =  T2.id JOIN student AS T3 ON T1.s_id  =  T3.id WHERE T3.dept_name  =  'History'
SELECT T2.name ,  T2.salary FROM advisor AS T1 JOIN instructor AS T2 ON T1.i_id  =  T2.id JOIN student AS T3 ON T1.s_id  =  T3.id WHERE T3.dept_name  =  'History'
SELECT title FROM course WHERE course_id NOT IN (SELECT course_id FROM prereq)
SELECT title FROM course WHERE course_id NOT IN (SELECT course_id FROM prereq)
SELECT T1.title FROM course AS T1 JOIN SECTION AS T2 ON T1.course_id  =  T2.course_id WHERE building  =  'Chandler' AND semester  =  'Fall' AND YEAR  =  2010
SELECT T1.title FROM course AS T1 JOIN SECTION AS T2 ON T1.course_id  =  T2.course_id WHERE building  =  'Chandler' AND semester  =  'Fall' AND YEAR  =  2010
SELECT T1.name FROM instructor AS T1 JOIN teaches AS T2 ON T1.id  =  T2.id JOIN course AS T3 ON T2.course_id  =  T3.course_id WHERE T3.title  =  'C Programming'
SELECT T1.name FROM instructor AS T1 JOIN teaches AS T2 ON T1.id  =  T2.id JOIN course AS T3 ON T2.course_id  =  T3.course_id WHERE T3.title  =  'C Programming'
SELECT T2.name ,  T2.salary FROM advisor AS T1 JOIN instructor AS T2 ON T1.i_id  =  T2.id JOIN student AS T3 ON T1.s_id  =  T3.id WHERE T3.dept_name  =  'Math'
SELECT T2.name ,  T2.salary FROM advisor AS T1 JOIN instructor AS T2 ON T1.i_id  =  T2.id JOIN student AS T3 ON T1.s_id  =  T3.id WHERE T3.dept_name  =  'Math'
SELECT T2.name FROM advisor AS T1 JOIN instructor AS T2 ON T1.i_id  =  T2.id JOIN student AS T3 ON T1.s_id  =  T3.id WHERE T3.dept_name  =  'Math' ORDER BY T3.tot_cred
SELECT T2.name FROM advisor AS T1 JOIN instructor AS T2 ON T1.i_id  =  T2.id JOIN student AS T3 ON T1.s_id  =  T3.id WHERE T3.dept_name  =  'Math' ORDER BY T3.tot_cred
SELECT T2.name FROM advisor AS T1 JOIN instructor AS T2 ON T1.i_id  =  T2.id JOIN student AS T3 ON T1.s_id  =  T3.id ORDER BY T3.tot_cred DESC LIMIT 1
SELECT T2.name FROM advisor AS T1 JOIN instructor AS T2 ON T1.i_id  =  T2.id JOIN student AS T3 ON T1.s_id  =  T3.id ORDER BY T3.tot_cred DESC LIMIT 1
SELECT name FROM instructor WHERE id NOT IN (SELECT id FROM teaches)
SELECT name FROM instructor WHERE id NOT IN (SELECT id FROM teaches)
SELECT name FROM instructor WHERE id NOT IN (SELECT id FROM teaches WHERE semester  =  'Spring')
SELECT name FROM instructor WHERE id NOT IN (SELECT id FROM teaches WHERE semester  =  'Spring')
SELECT name FROM student WHERE id NOT IN (SELECT T1.id FROM takes AS T1 JOIN course AS T2 ON T1.course_id  =  T2.course_id WHERE T2.dept_name  =  'Biology')
SELECT name FROM student WHERE id NOT IN (SELECT T1.id FROM takes AS T1 JOIN course AS T2 ON T1.course_id  =  T2.course_id WHERE T2.dept_name  =  'Biology')
SELECT T3.name FROM course AS T1 JOIN takes AS T2 ON T1.course_id  =  T2.course_id JOIN student AS T3 ON T2.id  =  T3.id WHERE T1.dept_name  =  'Statistics'
SELECT T3.name FROM course AS T1 JOIN takes AS T2 ON T1.course_id  =  T2.course_id JOIN student AS T3 ON T2.id  =  T3.id WHERE T1.dept_name  =  'Statistics'
SELECT T2.building ,  T2.room_number ,  T2.semester ,  T2.year FROM course AS T1 JOIN SECTION AS T2 ON T1.course_id  =  T2.course_id WHERE T1.dept_name  =  'Psychology' ORDER BY T1.title
SELECT T2.building ,  T2.room_number ,  T2.semester ,  T2.year FROM course AS T1 JOIN SECTION AS T2 ON T1.course_id  =  T2.course_id WHERE T1.dept_name  =  'Psychology' ORDER BY T1.title
SELECT name ,  course_id FROM instructor AS T1 JOIN teaches AS T2 ON T1.ID  =  T2.ID
SELECT name ,  course_id FROM instructor AS T1 JOIN teaches AS T2 ON T1.ID  =  T2.ID
SELECT name ,  course_id FROM instructor AS T1 JOIN teaches AS T2 ON T1.ID  =  T2.ID WHERE T1.dept_name  =  'Art'
SELECT name ,  course_id FROM instructor AS T1 JOIN teaches AS T2 ON T1.ID  =  T2.ID WHERE T1.dept_name  =  'Art'
SELECT name FROM instructor WHERE name LIKE '%dar%'
SELECT name FROM instructor WHERE name LIKE '%dar%'
SELECT DISTINCT name FROM  instructor ORDER BY name
SELECT DISTINCT name FROM  instructor ORDER BY name
SELECT course_id FROM SECTION WHERE semester  =  'Fall' AND YEAR  =  2009 UNION SELECT course_id FROM SECTION WHERE semester  =  'Spring' AND YEAR  =  2010
SELECT course_id FROM SECTION WHERE semester  =  'Fall' AND YEAR  =  2009 UNION SELECT course_id FROM SECTION WHERE semester  =  'Spring' AND YEAR  =  2010
SELECT count(*) FROM debate
SELECT Venue FROM debate ORDER BY Num_of_Audience ASC
SELECT Date ,  Venue FROM debate
SELECT Date FROM debate WHERE Num_of_Audience  >  150
SELECT Name FROM  people WHERE Age  =  35 OR Age  =  36
SELECT Party FROM people ORDER BY Age ASC LIMIT 1
SELECT Party ,  COUNT(*) FROM people GROUP BY Party
SELECT Party FROM people GROUP BY Party ORDER BY COUNT(*) DESC LIMIT 1
SELECT DISTINCT Venue FROM debate
SELECT T3.Name ,  T2.Date ,  T2.Venue FROM debate_people AS T1 JOIN debate AS T2 ON T1.Debate_ID  =  T2.Debate_ID JOIN people AS T3 ON T1.Affirmative  =  T3.People_ID
SELECT T3.Name ,  T2.Date ,  T2.Venue FROM debate_people AS T1 JOIN debate AS T2 ON T1.Debate_ID  =  T2.Debate_ID JOIN people AS T3 ON T1.Negative  =  T3.People_ID ORDER BY T3.Name ASC
SELECT T3.Name FROM debate_people AS T1 JOIN debate AS T2 ON T1.Debate_ID  =  T2.Debate_ID JOIN people AS T3 ON T1.Affirmative  =  T3.People_ID WHERE T2.Num_of_Audience  >  200
SELECT T2.Name ,  COUNT(*) FROM debate_people AS T1 JOIN people AS T2 ON T1.Affirmative  =  T2.People_ID GROUP BY T2.Name
SELECT T2.Name FROM debate_people AS T1 JOIN people AS T2 ON T1.Negative  =  T2.People_ID GROUP BY T2.Name HAVING COUNT(*)  >=  2
SELECT customer_details FROM customers ORDER BY customer_details
SELECT customer_details FROM customers ORDER BY customer_details
SELECT policy_type_code FROM policies GROUP BY policy_type_code ORDER BY count(*) DESC LIMIT 1
SELECT policy_type_code FROM policies GROUP BY policy_type_code ORDER BY count(*) DESC LIMIT 1
SELECT policy_type_code FROM policies GROUP BY policy_type_code HAVING count(*)  >  2
SELECT policy_type_code FROM policies GROUP BY policy_type_code HAVING count(*)  >  2
SELECT count(*) FROM claims_processing_stages
SELECT count(*) FROM claims_processing_stages
SELECT customer_details FROM customers WHERE customer_details LIKE "%Diana%"
SELECT customer_details FROM customers WHERE customer_details LIKE "%Diana%"
SELECT policy_type_code ,  count(*) FROM policies GROUP BY policy_type_code
SELECT policy_type_code ,  count(*) FROM policies GROUP BY policy_type_code
SELECT claim_status_description FROM claims_processing_stages WHERE claim_status_name  =  "Open"
SELECT claim_status_description FROM claims_processing_stages WHERE claim_status_name  =  "Open"
SELECT count(*) FROM Accounts
SELECT count(*) FROM Accounts
SELECT account_id ,  date_account_opened ,  account_name ,  other_account_details FROM Accounts
SELECT account_id ,  date_account_opened ,  account_name ,  other_account_details FROM Accounts
SELECT T1.account_id ,  T1.date_account_opened ,  T1.account_name ,  T1.other_account_details FROM Accounts AS T1 JOIN Customers AS T2 ON T1.customer_id  =  T2.customer_id WHERE T2.customer_first_name  =  'Meaghan'
SELECT T1.account_id ,  T1.date_account_opened ,  T1.account_name ,  T1.other_account_details FROM Accounts AS T1 JOIN Customers AS T2 ON T1.customer_id  =  T2.customer_id WHERE T2.customer_first_name  =  'Meaghan'
SELECT T1.account_name ,  T1.other_account_details FROM Accounts AS T1 JOIN Customers AS T2 ON T1.customer_id  =  T2.customer_id WHERE T2.customer_first_name  =  "Meaghan" AND T2.customer_last_name  =  "Keeling"
SELECT T1.account_name ,  T1.other_account_details FROM Accounts AS T1 JOIN Customers AS T2 ON T1.customer_id  =  T2.customer_id WHERE T2.customer_first_name  =  "Meaghan" AND T2.customer_last_name  =  "Keeling"
SELECT T2.customer_first_name ,  T2.customer_last_name FROM Accounts AS T1 JOIN Customers AS T2 ON T1.customer_id  =  T2.customer_id WHERE T1.account_name  =  "900"
SELECT T2.customer_first_name ,  T2.customer_last_name FROM Accounts AS T1 JOIN Customers AS T2 ON T1.customer_id  =  T2.customer_id WHERE T1.account_name  =  "900"
SELECT count(*) FROM Customers WHERE customer_id NOT IN (SELECT customer_id FROM Accounts)
SELECT count(*) FROM Customers WHERE customer_id NOT IN (SELECT customer_id FROM Accounts)
SELECT DISTINCT T1.customer_first_name ,  T1.customer_last_name ,  T1.phone_number FROM Customers AS T1 JOIN Accounts AS T2 ON T1.customer_id  =  T2.customer_id
SELECT DISTINCT T1.customer_first_name ,  T1.customer_last_name ,  T1.phone_number FROM Customers AS T1 JOIN Accounts AS T2 ON T1.customer_id  =  T2.customer_id
SELECT count(*) ,  customer_id FROM Accounts GROUP BY customer_id
SELECT count(*) ,  customer_id FROM Accounts GROUP BY customer_id
SELECT T1.customer_id ,  T2.customer_first_name ,  T2.customer_last_name ,  count(*) FROM Accounts AS T1 JOIN Customers AS T2 ON T1.customer_id  =  T2.customer_id GROUP BY T1.customer_id
SELECT T1.customer_id ,  T2.customer_first_name ,  T2.customer_last_name ,  count(*) FROM Accounts AS T1 JOIN Customers AS T2 ON T1.customer_id  =  T2.customer_id GROUP BY T1.customer_id
SELECT T2.customer_first_name ,  T1.customer_id FROM Accounts AS T1 JOIN Customers AS T2 ON T1.customer_id  =  T2.customer_id GROUP BY T1.customer_id HAVING count(*)  >=  2
SELECT T2.customer_first_name ,  T1.customer_id FROM Accounts AS T1 JOIN Customers AS T2 ON T1.customer_id  =  T2.customer_id GROUP BY T1.customer_id HAVING count(*)  >=  2
SELECT count(*) FROM Customers
SELECT count(*) FROM Customers
SELECT gender ,  count(*) FROM Customers GROUP BY gender
SELECT gender ,  count(*) FROM Customers GROUP BY gender
SELECT count(*) ,  account_id FROM Financial_transactions
SELECT count(*) ,  account_id FROM Financial_transactions
SELECT T2.account_name ,  T1.account_id ,  count(*) FROM Financial_transactions AS T1 JOIN Accounts AS T2 ON T1.account_id  =  T2.account_id GROUP BY T1.account_id
SELECT T2.account_name ,  T1.account_id ,  count(*) FROM Financial_transactions AS T1 JOIN Accounts AS T2 ON T1.account_id  =  T2.account_id GROUP BY T1.account_id
SELECT account_id FROM Financial_transactions GROUP BY account_id ORDER BY count(*) DESC LIMIT 1
SELECT account_id FROM Financial_transactions GROUP BY account_id ORDER BY count(*) DESC LIMIT 1
SELECT T1.account_id ,  T2.account_name FROM Financial_transactions AS T1 JOIN Accounts AS T2 ON T1.account_id  =  T2.account_id GROUP BY T1.account_id HAVING count(*)  >=  4
SELECT T1.account_id ,  T2.account_name FROM Financial_transactions AS T1 JOIN Accounts AS T2 ON T1.account_id  =  T2.account_id GROUP BY T1.account_id HAVING count(*)  >=  4
SELECT DISTINCT product_size FROM Products
SELECT DISTINCT product_size FROM Products
SELECT DISTINCT product_color FROM Products
SELECT DISTINCT product_color FROM Products
SELECT invoice_number ,  count(*) FROM Financial_transactions GROUP BY invoice_number
SELECT invoice_number ,  count(*) FROM Financial_transactions GROUP BY invoice_number
SELECT T2.invoice_number ,  T2.invoice_date FROM Financial_transactions AS T1 JOIN Invoices AS T2 ON T1.invoice_number  =  T2.invoice_number GROUP BY T1.invoice_number ORDER BY count(*) DESC LIMIT 1
SELECT T2.invoice_number ,  T2.invoice_date FROM Financial_transactions AS T1 JOIN Invoices AS T2 ON T1.invoice_number  =  T2.invoice_number GROUP BY T1.invoice_number ORDER BY count(*) DESC LIMIT 1
SELECT count(*) FROM Invoices
SELECT count(*) FROM Invoices
SELECT T1.invoice_date ,  T1.order_id ,  T2.order_details FROM Invoices AS T1 JOIN Orders AS T2 ON T1.order_id  =  T2.order_id
SELECT T1.invoice_date ,  T1.order_id ,  T2.order_details FROM Invoices AS T1 JOIN Orders AS T2 ON T1.order_id  =  T2.order_id
SELECT order_id ,  count(*) FROM Invoices GROUP BY order_id
SELECT order_id ,  count(*) FROM Invoices GROUP BY order_id
SELECT T2.order_id ,  T2.order_details FROM Invoices AS T1 JOIN Orders AS T2 ON T1.order_id  =  T2.order_id GROUP BY T2.order_id HAVING count(*)  >  2
SELECT T2.order_id ,  T2.order_details FROM Invoices AS T1 JOIN Orders AS T2 ON T1.order_id  =  T2.order_id GROUP BY T2.order_id HAVING count(*)  >  2
SELECT T2.customer_last_name ,  T1.customer_id ,  T2.phone_number FROM Orders AS T1 JOIN Customers AS T2 ON T1.customer_id  =  T2.customer_id GROUP BY T1.customer_id ORDER BY count(*) DESC LIMIT 1
SELECT T2.customer_last_name ,  T1.customer_id ,  T2.phone_number FROM Orders AS T1 JOIN Customers AS T2 ON T1.customer_id  =  T2.customer_id GROUP BY T1.customer_id ORDER BY count(*) DESC LIMIT 1
SELECT order_id ,  count(*) FROM Order_items GROUP BY order_id
SELECT order_id ,  count(*) FROM Order_items GROUP BY order_id
SELECT T2.product_name ,  count(*) FROM Order_items AS T1 JOIN Products AS T2 ON T1.product_id  =  T2.product_id JOIN Orders AS T3 ON T3.order_id  =  T1.order_id GROUP BY T2.product_name
SELECT T2.product_name ,  count(*) FROM Order_items AS T1 JOIN Products AS T2 ON T1.product_id  =  T2.product_id JOIN Orders AS T3 ON T3.order_id  =  T1.order_id GROUP BY T2.product_name
SELECT count(*) FROM Church WHERE Open_Date  <  1850
SELECT name ,  open_date ,  organized_by FROM Church
SELECT name FROM church ORDER BY open_date DESC
SELECT open_date FROM church GROUP BY open_date HAVING count(*)  >=  2
SELECT organized_by ,  name FROM church WHERE open_date BETWEEN 1830 AND 1840
SELECT open_date ,  count(*) FROM church GROUP BY open_date
SELECT name ,  open_date FROM church ORDER BY open_date DESC LIMIT 3
SELECT count(*) FROM people WHERE is_male  =  'F' AND age  >  30
SELECT min(age) ,  max(age) ,  avg(age) FROM people
SELECT T2.name ,  T3.name FROM wedding AS T1 JOIN people AS T2 ON T1.male_id  =  T2.people_id JOIN people AS T3 ON T1.female_id  =  T3.people_id WHERE T1.year  >  2014
SELECT T1.name FROM church AS T1 JOIN wedding AS T2 ON T1.church_id  =  T2.church_id GROUP BY T1.church_id HAVING count(*)  >=  2
SELECT T2.name FROM wedding AS T1 JOIN people AS T2 ON T1.female_id  =  T2.people_id WHERE T1.year  =  2016 AND T2.is_male  =  'F' AND T2.country  =  'Canada'
SELECT T4.name FROM wedding AS T1 JOIN people AS T2 ON T1.male_id  =  T2.people_id JOIN people AS T3 ON T1.female_id  =  T3.people_id JOIN church AS T4 ON T4.church_id  =  T1.church_id WHERE T2.age  >  30 OR T3.age  >  30
SELECT country ,  count(*) FROM people GROUP BY country
SELECT count(*) FROM artist
SELECT count(*) FROM artist
SELECT name ,  age ,  country FROM artist ORDER BY Year_Join
SELECT name ,  age ,  country FROM artist ORDER BY Year_Join
SELECT DISTINCT country FROM artist
SELECT DISTINCT country FROM artist
SELECT name ,  year_join FROM artist WHERE country != 'United States'
SELECT name ,  year_join FROM artist WHERE country != 'United States'
SELECT count(*) FROM artist WHERE age  >  46 AND year_join  >  1990
SELECT count(*) FROM artist WHERE age  >  46 AND year_join  >  1990
SELECT avg(age) ,  min(age) FROM artist WHERE country  =  'United States'
SELECT avg(age) ,  min(age) FROM artist WHERE country  =  'United States'
SELECT name FROM artist ORDER BY year_join DESC LIMIT 1
SELECT name FROM artist ORDER BY year_join DESC LIMIT 1
SELECT count(*) FROM exhibition WHERE YEAR  >=  2005
SELECT count(*) FROM exhibition WHERE YEAR  >=  2005
SELECT theme ,  YEAR FROM exhibition WHERE ticket_price  <  15
SELECT theme ,  YEAR FROM exhibition WHERE ticket_price  <  15
SELECT T2.name ,  count(*) FROM exhibition AS T1 JOIN artist AS T2 ON T1.artist_id  =  T2.artist_id GROUP BY T1.artist_id
SELECT T2.name ,  count(*) FROM exhibition AS T1 JOIN artist AS T2 ON T1.artist_id  =  T2.artist_id GROUP BY T1.artist_id
SELECT T2.name , T2.country FROM exhibition AS T1 JOIN artist AS T2 ON T1.artist_id  =  T2.artist_id GROUP BY T1.artist_id ORDER BY count(*) DESC LIMIT 1
SELECT T2.name , T2.country FROM exhibition AS T1 JOIN artist AS T2 ON T1.artist_id  =  T2.artist_id GROUP BY T1.artist_id ORDER BY count(*) DESC LIMIT 1
SELECT name FROM artist WHERE artist_id NOT IN (SELECT artist_id FROM exhibition)
SELECT name FROM artist WHERE artist_id NOT IN (SELECT artist_id FROM exhibition)
SELECT theme ,  YEAR FROM exhibition ORDER BY ticket_price DESC
SELECT theme ,  YEAR FROM exhibition ORDER BY ticket_price DESC
SELECT T2.theme ,  T1.date ,  T1.attendance FROM exhibition_record AS T1 JOIN exhibition AS T2 ON T1.exhibition_id  =  T2.exhibition_id WHERE T2.year  =  2004
SELECT T2.theme ,  T1.date ,  T1.attendance FROM exhibition_record AS T1 JOIN exhibition AS T2 ON T1.exhibition_id  =  T2.exhibition_id WHERE T2.year  =  2004
SELECT count(*) FROM exhibition_record AS T1 JOIN exhibition AS T2 ON T1.exhibition_id  =  T2.exhibition_id WHERE T1.attendance  >  100 OR T2.ticket_price  <  10
SELECT count(*) FROM exhibition_record AS T1 JOIN exhibition AS T2 ON T1.exhibition_id  =  T2.exhibition_id WHERE T1.attendance  >  100 OR T2.ticket_price  <  10
SELECT i_id FROM item WHERE title  =  "orange"
SELECT count(*) FROM review
SELECT count(*) FROM useracct
SELECT min(rank) FROM review
SELECT T1.title FROM item AS T1 JOIN review AS T2 ON T1.i_id  =  T2.i_id WHERE T2.rating  =  10
SELECT T1.title FROM item AS T1 JOIN review AS T2 ON T1.i_id  =  T2.i_id WHERE T2.rating  <  5
SELECT title FROM item ORDER BY title
SELECT T1.name FROM useracct AS T1 JOIN review AS T2 ON T1.u_id  =  T2.u_id GROUP BY T2.u_id ORDER BY count(*) DESC LIMIT 1
SELECT T1.name ,  avg(T2.rating) FROM useracct AS T1 JOIN review AS T2 ON T1.u_id  =  T2.u_id GROUP BY T2.u_id
SELECT T1.name ,  count(*) FROM useracct AS T1 JOIN review AS T2 ON T1.u_id  =  T2.u_id GROUP BY T2.u_id
SELECT T1.name FROM useracct AS T1 JOIN review AS T2 ON T1.u_id  =  T2.u_id ORDER BY T2.rating DESC LIMIT 1
SELECT T1.name ,  avg(trust) FROM useracct AS T1 JOIN trust AS T2 ON T1.u_id  =  T2.target_u_id GROUP BY T2.target_u_id
SELECT T1.name FROM useracct AS T1 JOIN trust AS T2 ON T1.u_id  =  T2.target_u_id ORDER BY trust LIMIT 1
SELECT count(*) FROM player
SELECT Player_name FROM player ORDER BY Votes ASC
SELECT Gender ,  Occupation FROM player
SELECT Player_name ,  residence FROM player WHERE Occupation != "Researcher"
SELECT Sponsor_name FROM player WHERE Residence  =  "Brandon" OR Residence  =  "Birtle"
SELECT Player_name FROM player ORDER BY Votes DESC LIMIT 1
SELECT Occupation ,  COUNT(*) FROM player GROUP BY Occupation
SELECT Residence FROM player GROUP BY Residence HAVING COUNT(*)  >=  2
SELECT T3.Player_name ,  T2.coach_name FROM player_coach AS T1 JOIN coach AS T2 ON T1.Coach_ID  =  T2.Coach_ID JOIN player AS T3 ON T1.Player_ID  =  T3.Player_ID
SELECT T3.Player_name FROM player_coach AS T1 JOIN coach AS T2 ON T1.Coach_ID  =  T2.Coach_ID JOIN player AS T3 ON T1.Player_ID  =  T3.Player_ID WHERE T2.Rank  =  1
SELECT T3.Player_name ,  T2.coach_name FROM player_coach AS T1 JOIN coach AS T2 ON T1.Coach_ID  =  T2.Coach_ID JOIN player AS T3 ON T1.Player_ID  =  T3.Player_ID ORDER BY T3.Votes DESC
SELECT Player_name FROM player WHERE Player_ID NOT IN (SELECT Player_ID FROM player_coach)
SELECT T1.club_id ,  T1.club_name, count(*) FROM club AS T1 JOIN coach AS T2 ON T1.club_id  =  T2.club_id GROUP BY T1.club_id
SELECT T1.club_id ,  T1.gold FROM match_result AS T1 JOIN coach AS T2 ON T1.club_id  =  T2.club_id GROUP BY T1.club_id ORDER BY count(*) DESC LIMIT 1
SELECT count(*) FROM gymnast
SELECT count(*) FROM gymnast
SELECT Total_Points FROM gymnast ORDER BY Total_Points DESC
SELECT Total_Points FROM gymnast ORDER BY Total_Points DESC
SELECT Total_Points FROM gymnast ORDER BY Floor_Exercise_Points DESC
SELECT Total_Points FROM gymnast ORDER BY Floor_Exercise_Points DESC
SELECT avg(Horizontal_Bar_Points) FROM gymnast
SELECT avg(Horizontal_Bar_Points) FROM gymnast
SELECT Name FROM People ORDER BY Name ASC
SELECT Name FROM People ORDER BY Name ASC
SELECT T2.Name FROM gymnast AS T1 JOIN people AS T2 ON T1.Gymnast_ID  =  T2.People_ID
SELECT T2.Name FROM gymnast AS T1 JOIN people AS T2 ON T1.Gymnast_ID  =  T2.People_ID
SELECT T2.Name FROM gymnast AS T1 JOIN people AS T2 ON T1.Gymnast_ID  =  T2.People_ID WHERE T2.Hometown != "Santo Domingo"
SELECT T2.Name FROM gymnast AS T1 JOIN people AS T2 ON T1.Gymnast_ID  =  T2.People_ID WHERE T2.Hometown != "Santo Domingo"
SELECT Age FROM people ORDER BY Height DESC LIMIT 1
SELECT Age FROM people ORDER BY Height DESC LIMIT 1
SELECT Name FROM People ORDER BY Age DESC LIMIT 5
SELECT Name FROM People ORDER BY Age DESC LIMIT 5
SELECT T1.Total_Points FROM gymnast AS T1 JOIN people AS T2 ON T1.Gymnast_ID  =  T2.People_ID ORDER BY T2.Age ASC LIMIT 1
SELECT T1.Total_Points FROM gymnast AS T1 JOIN people AS T2 ON T1.Gymnast_ID  =  T2.People_ID ORDER BY T2.Age ASC LIMIT 1
SELECT avg(T2.Age) FROM gymnast AS T1 JOIN people AS T2 ON T1.Gymnast_ID  =  T2.People_ID
SELECT avg(T2.Age) FROM gymnast AS T1 JOIN people AS T2 ON T1.Gymnast_ID  =  T2.People_ID
SELECT T2.Hometown ,  COUNT(*) FROM gymnast AS T1 JOIN people AS T2 ON T1.Gymnast_ID  =  T2.People_ID GROUP BY T2.Hometown
SELECT T2.Hometown ,  COUNT(*) FROM gymnast AS T1 JOIN people AS T2 ON T1.Gymnast_ID  =  T2.People_ID GROUP BY T2.Hometown
SELECT T2.Hometown FROM gymnast AS T1 JOIN people AS T2 ON T1.Gymnast_ID  =  T2.People_ID GROUP BY T2.Hometown ORDER BY COUNT(*) DESC LIMIT 1
SELECT T2.Hometown FROM gymnast AS T1 JOIN people AS T2 ON T1.Gymnast_ID  =  T2.People_ID GROUP BY T2.Hometown ORDER BY COUNT(*) DESC LIMIT 1
SELECT T2.Hometown FROM gymnast AS T1 JOIN people AS T2 ON T1.Gymnast_ID  =  T2.People_ID GROUP BY T2.Hometown HAVING COUNT(*)  >=  2
SELECT T2.Hometown FROM gymnast AS T1 JOIN people AS T2 ON T1.Gymnast_ID  =  T2.People_ID GROUP BY T2.Hometown HAVING COUNT(*)  >=  2
SELECT T2.Name FROM gymnast AS T1 JOIN people AS T2 ON T1.Gymnast_ID  =  T2.People_ID ORDER BY T2.Height ASC
SELECT T2.Name FROM gymnast AS T1 JOIN people AS T2 ON T1.Gymnast_ID  =  T2.People_ID ORDER BY T2.Height ASC
SELECT T2.Age FROM gymnast AS T1 JOIN people AS T2 ON T1.Gymnast_ID  =  T2.People_ID ORDER BY T1.Total_Points DESC
SELECT T2.Age FROM gymnast AS T1 JOIN people AS T2 ON T1.Gymnast_ID  =  T2.People_ID ORDER BY T1.Total_Points DESC
SELECT count(*) FROM accounts
SELECT count(*) FROM accounts
SELECT avg(balance) FROM checking
SELECT avg(balance) FROM checking
SELECT T2.balance ,  T3.balance FROM accounts AS T1 JOIN checking AS T2 ON T1.custid  =  T2.custid JOIN savings AS T3 ON T1.custid  =  T3.custid WHERE T1.name  =  'Brown'
SELECT T2.balance ,  T3.balance FROM accounts AS T1 JOIN checking AS T2 ON T1.custid  =  T2.custid JOIN savings AS T3 ON T1.custid  =  T3.custid WHERE T1.name  =  'Brown'
SELECT name FROM accounts ORDER BY name
SELECT name FROM accounts ORDER BY name
SELECT T1.name ,  T2.balance FROM accounts AS T1 JOIN checking AS T2 ON T1.custid  =  T2.custid JOIN savings AS T3 ON T1.custid  =  T3.custid ORDER BY T3.balance LIMIT 1
SELECT T1.name ,  T2.balance FROM accounts AS T1 JOIN checking AS T2 ON T1.custid  =  T2.custid JOIN savings AS T3 ON T1.custid  =  T3.custid ORDER BY T3.balance LIMIT 1
SELECT count(*) ,  T1.name FROM accounts AS T1 JOIN checking AS T2 ON T1.custid  =  T2.custid GROUP BY T1.name
SELECT count(*) ,  T1.name FROM accounts AS T1 JOIN checking AS T2 ON T1.custid  =  T2.custid GROUP BY T1.name
SELECT T3.balance FROM accounts AS T1 JOIN checking AS T2 ON T1.custid  =  T2.custid JOIN savings AS T3 ON T1.custid  =  T3.custid ORDER BY T2.balance DESC LIMIT 1
SELECT T3.balance FROM accounts AS T1 JOIN checking AS T2 ON T1.custid  =  T2.custid JOIN savings AS T3 ON T1.custid  =  T3.custid ORDER BY T2.balance DESC LIMIT 1
SELECT T2.balance ,  T1.name FROM accounts AS T1 JOIN checking AS T2 ON T1.custid  =  T2.custid JOIN savings AS T3 ON T1.custid  =  T3.custid ORDER BY T3.balance LIMIT 1
SELECT T2.balance ,  T1.name FROM accounts AS T1 JOIN checking AS T2 ON T1.custid  =  T2.custid JOIN savings AS T3 ON T1.custid  =  T3.custid ORDER BY T3.balance LIMIT 1
SELECT T2.balance ,  T3.balance ,  T1.name FROM accounts AS T1 JOIN checking AS T2 ON T1.custid  =  T2.custid JOIN savings AS T3 ON T1.custid  =  T3.custid
SELECT T2.balance ,  T3.balance ,  T1.name FROM accounts AS T1 JOIN checking AS T2 ON T1.custid  =  T2.custid JOIN savings AS T3 ON T1.custid  =  T3.custid
SELECT T1.name FROM accounts AS T1 JOIN checking AS T2 ON T1.custid  =  T2.custid JOIN savings AS T3 ON T1.custid  =  T3.custid WHERE T2.balance  >  T3.balance
SELECT T1.name FROM accounts AS T1 JOIN checking AS T2 ON T1.custid  =  T2.custid JOIN savings AS T3 ON T1.custid  =  T3.custid WHERE T2.balance  >  T3.balance
SELECT T1.name ,  T2.balance FROM accounts AS T1 JOIN savings AS T2 ON T1.custid  =  T2.custid ORDER BY T2.balance DESC LIMIT 3
SELECT T1.name ,  T2.balance FROM accounts AS T1 JOIN savings AS T2 ON T1.custid  =  T2.custid ORDER BY T2.balance DESC LIMIT 3
SELECT count(*) FROM browser WHERE market_share  >=  5
SELECT name FROM browser ORDER BY market_share DESC
SELECT id ,  name ,  market_share FROM browser
SELECT id ,  market_share FROM browser WHERE name  =  'Safari'
SELECT name ,  operating_system FROM web_client_accelerator WHERE CONNECTION != 'Broadband'
SELECT T1.name FROM browser AS T1 JOIN accelerator_compatible_browser AS T2 ON T1.id  =  T2.browser_id JOIN web_client_accelerator AS T3 ON T2.accelerator_id  =  T3.id WHERE T3.name  =  'CProxy' AND T2.compatible_since_year  >  1998
SELECT T1.id ,  T1.Name FROM web_client_accelerator AS T1 JOIN accelerator_compatible_browser AS T2 ON T2.accelerator_id  =  T1.id GROUP BY T1.id HAVING count(*)  >=  2
SELECT T1.id ,  T1.name FROM browser AS T1 JOIN accelerator_compatible_browser AS T2 ON T1.id  =  T2.browser_id GROUP BY T1.id ORDER BY count(*) DESC LIMIT 1
SELECT count(*) FROM web_client_accelerator WHERE id NOT IN ( SELECT accelerator_id FROM accelerator_compatible_browser );
SELECT DISTINCT T1.name FROM web_client_accelerator AS T1 JOIN accelerator_compatible_browser AS T2 ON T2.accelerator_id  =  T1.id JOIN browser AS T3 ON T2.browser_id  =  T3.id WHERE T3.market_share  >  15;
SELECT name FROM web_client_accelerator WHERE name LIKE "%Opera%"
SELECT Operating_system ,  count(*) FROM web_client_accelerator GROUP BY Operating_system
SELECT count(*) FROM wrestler
SELECT count(*) FROM wrestler
SELECT Name FROM wrestler ORDER BY Days_held DESC
SELECT Name FROM wrestler ORDER BY Days_held DESC
SELECT Name FROM wrestler ORDER BY Days_held ASC LIMIT 1
SELECT Name FROM wrestler ORDER BY Days_held ASC LIMIT 1
SELECT DISTINCT Reign FROM wrestler WHERE LOCATION != "Tokyo , Japan"
SELECT DISTINCT Reign FROM wrestler WHERE LOCATION != "Tokyo , Japan"
SELECT Name ,  LOCATION FROM wrestler
SELECT Name ,  LOCATION FROM wrestler
SELECT Elimination_Move FROM Elimination WHERE Team  =  "Team Orton"
SELECT Elimination_Move FROM Elimination WHERE Team  =  "Team Orton"
SELECT T2.Name ,  T1.Elimination_Move FROM elimination AS T1 JOIN wrestler AS T2 ON T1.Wrestler_ID  =  T2.Wrestler_ID
SELECT T2.Name ,  T1.Elimination_Move FROM elimination AS T1 JOIN wrestler AS T2 ON T1.Wrestler_ID  =  T2.Wrestler_ID
SELECT T2.Name ,  T1.Team FROM elimination AS T1 JOIN wrestler AS T2 ON T1.Wrestler_ID  =  T2.Wrestler_ID ORDER BY T2.Days_held DESC
SELECT T2.Name ,  T1.Team FROM elimination AS T1 JOIN wrestler AS T2 ON T1.Wrestler_ID  =  T2.Wrestler_ID ORDER BY T2.Days_held DESC
SELECT T1.Time FROM elimination AS T1 JOIN wrestler AS T2 ON T1.Wrestler_ID  =  T2.Wrestler_ID ORDER BY T2.Days_held DESC LIMIT 1
SELECT T1.Time FROM elimination AS T1 JOIN wrestler AS T2 ON T1.Wrestler_ID  =  T2.Wrestler_ID ORDER BY T2.Days_held DESC LIMIT 1
SELECT T1.Time FROM elimination AS T1 JOIN wrestler AS T2 ON T1.Wrestler_ID  =  T2.Wrestler_ID WHERE T2.Days_held  >  50
SELECT T1.Time FROM elimination AS T1 JOIN wrestler AS T2 ON T1.Wrestler_ID  =  T2.Wrestler_ID WHERE T2.Days_held  >  50
SELECT Team ,  COUNT(*) FROM elimination GROUP BY Team
SELECT Team ,  COUNT(*) FROM elimination GROUP BY Team
SELECT Team FROM elimination GROUP BY Team HAVING COUNT(*)  >  3
SELECT Team FROM elimination GROUP BY Team HAVING COUNT(*)  >  3
SELECT Reign ,  Days_held FROM wrestler
SELECT Reign ,  Days_held FROM wrestler
SELECT Name FROM wrestler WHERE Days_held  <  100
SELECT Name FROM wrestler WHERE Days_held  <  100
SELECT Reign FROM wrestler GROUP BY Reign ORDER BY COUNT(*) DESC LIMIT 1
SELECT Reign FROM wrestler GROUP BY Reign ORDER BY COUNT(*) DESC LIMIT 1
SELECT LOCATION FROM wrestler GROUP BY LOCATION HAVING COUNT(*)  >  2
SELECT LOCATION FROM wrestler GROUP BY LOCATION HAVING COUNT(*)  >  2
SELECT TIME FROM elimination WHERE Eliminated_By  =  "Punk" OR Eliminated_By  =  "Orton"
SELECT TIME FROM elimination WHERE Eliminated_By  =  "Punk" OR Eliminated_By  =  "Orton"
SELECT count(*) FROM school
SELECT count(*) FROM school
SELECT school_name FROM school ORDER BY school_name
SELECT school_name ,  LOCATION ,  mascot FROM school
SELECT school_name FROM school ORDER BY enrollment LIMIT 1
SELECT avg(enrollment) ,  max(enrollment) ,  min(enrollment) FROM school
SELECT amount ,  donator_name FROM endowment ORDER BY amount DESC LIMIT 1
SELECT count(*) FROM budget WHERE budgeted  >  3000 AND YEAR  <=  2001
SELECT count(*) FROM budget WHERE budgeted  >  3000 AND YEAR  <=  2001
SELECT T2.school_name ,  T1.budgeted ,  T1.invested FROM budget AS T1 JOIN school AS T2 ON T1.school_id  =  T2.school_id WHERE T1.year  >=  2002
SELECT DISTINCT donator_name FROM endowment
SELECT count(*) FROM budget WHERE budgeted  <  invested
SELECT T1.School_name ,  T1.Mascot ,  T1.IHSAA_Football_Class FROM school AS T1 JOIN budget AS T2 ON T1.school_id  =  T2.school_id WHERE Budgeted  >  6000 OR YEAR  <  2003 ORDER BY T2.total_budget_percent_invested ,  T2.total_budget_percent_budgeted
SELECT count(*) FROM building
SELECT name ,  street_address ,  floors FROM building ORDER BY floors
SELECT name FROM building ORDER BY height_feet DESC LIMIT 1
SELECT avg(floors) ,  max(floors) ,  min(floors) FROM building
SELECT name FROM building WHERE height_feet  >=  200 AND floors  >=  20
SELECT institution ,  LOCATION FROM institution WHERE founded  >  1990 AND TYPE  =  'Private'
SELECT TYPE FROM institution GROUP BY TYPE ORDER BY count(*) DESC LIMIT 1
SELECT TYPE FROM institution WHERE founded  >  1990 AND enrollment  >=  1000
SELECT name FROM building WHERE building_id NOT IN (SELECT building_id FROM institution)
SELECT T1.name ,  count(*) FROM building AS T1 JOIN institution AS T2 ON T1.building_id  =  T2.building_id GROUP BY T1.building_id
SELECT T1.name ,  T1.height_feet FROM building AS T1 JOIN institution AS T2 ON T1.building_id  =  T2.building_id WHERE T2.founded  >  1880 GROUP BY T1.building_id HAVING count(*)  >=  2
SELECT DISTINCT TYPE FROM institution
SELECT T1.institution ,  count(*) FROM institution AS T1 JOIN protein AS T2 ON T1.institution_id  =  T2.institution_id GROUP BY T1.institution_id
SELECT count(*) FROM institution AS T1 JOIN protein AS T2 ON T1.institution_id  =  T2.institution_id WHERE T1.founded  >  1880 OR T1.type  =  'Private'
SELECT T2.protein_name ,  T1.institution FROM institution AS T1 JOIN protein AS T2 ON T1.institution_id  =  T2.institution_id
SELECT count(*) FROM institution WHERE institution_id NOT IN (SELECT institution_id FROM protein)
SELECT count(*) FROM cinema
SELECT count(*) FROM cinema
SELECT name ,  openning_year ,  capacity FROM cinema
SELECT DISTINCT LOCATION FROM cinema
SELECT DISTINCT LOCATION FROM cinema
SELECT name ,  openning_year FROM cinema ORDER BY openning_year DESC
SELECT name ,  LOCATION FROM cinema ORDER BY capacity DESC LIMIT 1
SELECT avg(capacity) ,  min(capacity) ,  max(capacity) FROM cinema WHERE openning_year  >=  2011
SELECT LOCATION ,  count(*) FROM cinema GROUP BY LOCATION
SELECT LOCATION FROM cinema WHERE openning_year  >=  2010 GROUP BY LOCATION ORDER BY count(*) DESC LIMIT 1
SELECT LOCATION FROM cinema WHERE capacity  >  300 GROUP BY LOCATION HAVING count(*)  >=  2
SELECT LOCATION FROM cinema WHERE capacity  >  300 GROUP BY LOCATION HAVING count(*)  >=  2
SELECT title ,  directed_by FROM film
SELECT title ,  directed_by FROM film
SELECT DISTINCT directed_by FROM film
SELECT DISTINCT directed_by FROM film
SELECT directed_by ,  count(*) FROM film GROUP BY directed_by
SELECT title ,  directed_by FROM film WHERE film_id NOT IN (SELECT film_id FROM schedule)
SELECT LOCATION FROM cinema WHERE capacity  >  300 GROUP BY LOCATION HAVING count(*)  >  1
SELECT LOCATION FROM cinema WHERE capacity  >  300 GROUP BY LOCATION HAVING count(*)  >  1
SELECT T1.good_or_bad_customer FROM customers AS T1 JOIN discount_coupons AS T2 ON T1.coupon_id  =  T2.coupon_id WHERE T2.coupon_amount  =  500
SELECT T1.customer_id ,  T1.first_name ,  count(*) FROM Customers AS T1 JOIN bookings AS T2 ON T1.customer_id  =  T2.customer_id GROUP BY T1.customer_id
SELECT T1.booking_id ,  T1.amount_of_refund FROM Bookings AS T1 JOIN Payments AS T2 ON T1.booking_id  =  T2.booking_id GROUP BY T1.booking_id ORDER BY count(*) DESC LIMIT 1
SELECT product_id FROM products_booked GROUP BY product_id HAVING count(*)  =  3
SELECT T3.booking_start_date ,   T3.booking_end_date FROM Products_for_hire AS T1 JOIN products_booked AS T2 ON T1.product_id  =  T2.product_id JOIN bookings AS T3 ON T2.booking_id  =  T3.booking_id WHERE T1.product_name  =  'Book collection A'
SELECT T2.product_name FROM view_product_availability AS T1 JOIN products_for_hire AS T2 ON T1.product_id  =  T2.product_id WHERE T1.available_yn  =  1
SELECT first_name ,  last_name ,  gender_mf FROM customers WHERE good_or_bad_customer  =  'good' ORDER BY last_name
SELECT DISTINCT payment_type_code FROM payments
SELECT daily_hire_cost FROM Products_for_hire WHERE product_name LIKE '%Book%'
SELECT payment_date FROM payments WHERE amount_paid  >  300 OR payment_type_code  =  'Check'
SELECT product_name ,  product_description FROM products_for_hire WHERE product_type_code  =  'Cutlery' AND daily_hire_cost  <  20
SELECT count(*) FROM phone
SELECT Name FROM phone ORDER BY Price ASC
SELECT Memory_in_G ,  Carrier FROM phone
SELECT DISTINCT Carrier FROM phone WHERE Memory_in_G  >  32
SELECT Name FROM phone WHERE Carrier  =  "Sprint" OR Carrier  =  "TMobile"
SELECT Carrier FROM phone ORDER BY Price DESC LIMIT 1
SELECT Carrier ,  COUNT(*) FROM phone GROUP BY Carrier
SELECT Carrier FROM phone GROUP BY Carrier ORDER BY COUNT(*) DESC LIMIT 1
SELECT T3.Name ,  T2.District FROM phone_market AS T1 JOIN market AS T2 ON T1.Market_ID  =  T2.Market_ID JOIN phone AS T3 ON T1.Phone_ID  =  T3.Phone_ID
SELECT T3.Name ,  T2.District FROM phone_market AS T1 JOIN market AS T2 ON T1.Market_ID  =  T2.Market_ID JOIN phone AS T3 ON T1.Phone_ID  =  T3.Phone_ID ORDER BY T2.Ranking
SELECT T3.Name FROM phone_market AS T1 JOIN market AS T2 ON T1.Market_ID  =  T2.Market_ID JOIN phone AS T3 ON T1.Phone_ID  =  T3.Phone_ID WHERE T2.Num_of_shops  >  50
SELECT count(*) FROM company
SELECT count(*) FROM company
SELECT company ,  rank FROM company ORDER BY Sales_billion DESC
SELECT company ,  rank FROM company ORDER BY Sales_billion DESC
SELECT company ,  main_industry FROM company WHERE headquarters != 'USA'
SELECT company ,  main_industry FROM company WHERE headquarters != 'USA'
SELECT company ,  headquarters FROM company ORDER BY market_value DESC
SELECT company ,  headquarters FROM company ORDER BY market_value DESC
SELECT min(market_value) ,  max(market_value) ,  avg(market_value) FROM company
SELECT min(market_value) ,  max(market_value) ,  avg(market_value) FROM company
SELECT DISTINCT main_industry FROM company
SELECT DISTINCT main_industry FROM company
SELECT headquarters ,  count(*) FROM company GROUP BY headquarters
SELECT headquarters ,  count(*) FROM company GROUP BY headquarters
SELECT headquarters FROM company WHERE main_industry  =  'Banking' GROUP BY headquarters HAVING count(*)  >=  2
SELECT headquarters FROM company WHERE main_industry  =  'Banking' GROUP BY headquarters HAVING count(*)  >=  2
SELECT station_id ,  LOCATION ,  manager_name FROM gas_station ORDER BY open_year
SELECT station_id ,  LOCATION ,  manager_name FROM gas_station ORDER BY open_year
SELECT count(*) FROM gas_station WHERE open_year BETWEEN 2000 AND 2005
SELECT count(*) FROM gas_station WHERE open_year BETWEEN 2000 AND 2005
SELECT LOCATION ,  count(*) FROM gas_station GROUP BY LOCATION ORDER BY count(*)
SELECT LOCATION ,  count(*) FROM gas_station GROUP BY LOCATION ORDER BY count(*)
SELECT company ,  main_industry FROM company WHERE company_id NOT IN (SELECT company_id FROM station_company)
SELECT company ,  main_industry FROM company WHERE company_id NOT IN (SELECT company_id FROM station_company)
SELECT T3.manager_name FROM station_company AS T1 JOIN company AS T2 ON T1.company_id  =  T2.company_id JOIN gas_station AS T3 ON T1.station_id  =  T3.station_id WHERE T2.company  =  'ExxonMobil'
SELECT T3.manager_name FROM station_company AS T1 JOIN company AS T2 ON T1.company_id  =  T2.company_id JOIN gas_station AS T3 ON T1.station_id  =  T3.station_id WHERE T2.company  =  'ExxonMobil'
SELECT T3.location FROM station_company AS T1 JOIN company AS T2 ON T1.company_id  =  T2.company_id JOIN gas_station AS T3 ON T1.station_id  =  T3.station_id WHERE T2.market_value  >  100
SELECT T3.location FROM station_company AS T1 JOIN company AS T2 ON T1.company_id  =  T2.company_id JOIN gas_station AS T3 ON T1.station_id  =  T3.station_id WHERE T2.market_value  >  100
SELECT manager_name FROM gas_station WHERE open_year  >  2000 GROUP BY manager_name ORDER BY count(*) DESC LIMIT 1
SELECT manager_name FROM gas_station WHERE open_year  >  2000 GROUP BY manager_name ORDER BY count(*) DESC LIMIT 1
SELECT LOCATION FROM gas_station ORDER BY open_year
SELECT LOCATION FROM gas_station ORDER BY open_year
SELECT rank ,  company ,  market_value FROM company WHERE main_industry  =  'Banking' ORDER BY sales_billion ,  profits_billion
SELECT rank ,  company ,  market_value FROM company WHERE main_industry  =  'Banking' ORDER BY sales_billion ,  profits_billion
SELECT T3.location ,  T3.Representative_Name FROM station_company AS T1 JOIN company AS T2 ON T1.company_id  =  T2.company_id JOIN gas_station AS T3 ON T1.station_id  =  T3.station_id ORDER BY T2.Assets_billion DESC LIMIT 3
SELECT T3.location ,  T3.Representative_Name FROM station_company AS T1 JOIN company AS T2 ON T1.company_id  =  T2.company_id JOIN gas_station AS T3 ON T1.station_id  =  T3.station_id ORDER BY T2.Assets_billion DESC LIMIT 3
SELECT count(*) FROM region
SELECT count(*) FROM region
SELECT minister ,  took_office ,  left_office FROM party ORDER BY left_office
SELECT minister ,  took_office ,  left_office FROM party ORDER BY left_office
SELECT minister FROM party WHERE took_office  >  1961 OR took_office  <  1959
SELECT minister FROM party WHERE took_office  >  1961 OR took_office  <  1959
SELECT minister FROM party WHERE party_name != 'Progress Party'
SELECT minister FROM party WHERE party_name != 'Progress Party'
SELECT minister ,  party_name FROM party ORDER BY took_office DESC
SELECT minister ,  party_name FROM party ORDER BY took_office DESC
SELECT minister FROM party ORDER BY left_office DESC LIMIT 1
SELECT minister FROM party ORDER BY left_office DESC LIMIT 1
SELECT T1.member_name ,  T2.party_name FROM Member AS T1 JOIN party AS T2 ON T1.party_id  =  T2.party_id
SELECT T1.member_name ,  T2.party_name FROM Member AS T1 JOIN party AS T2 ON T1.party_id  =  T2.party_id
SELECT T2.party_name ,  count(*) FROM Member AS T1 JOIN party AS T2 ON T1.party_id  =  T2.party_id GROUP BY T1.party_id
SELECT T2.party_name ,  count(*) FROM Member AS T1 JOIN party AS T2 ON T1.party_id  =  T2.party_id GROUP BY T1.party_id
SELECT T2.party_name FROM Member AS T1 JOIN party AS T2 ON T1.party_id  =  T2.party_id GROUP BY T1.party_id ORDER BY count(*) DESC LIMIT 1
SELECT T2.party_name FROM Member AS T1 JOIN party AS T2 ON T1.party_id  =  T2.party_id GROUP BY T1.party_id ORDER BY count(*) DESC LIMIT 1
SELECT T1.party_name ,  T2.region_name FROM party AS T1 JOIN region AS T2 ON T1.region_id  =  T2.region_id
SELECT T1.party_name ,  T2.region_name FROM party AS T1 JOIN region AS T2 ON T1.region_id  =  T2.region_id
SELECT T1.member_name FROM Member AS T1 JOIN party AS T2 ON T1.party_id  =  T2.party_id WHERE T2.Party_name != "Progress Party"
SELECT T1.member_name FROM Member AS T1 JOIN party AS T2 ON T1.party_id  =  T2.party_id WHERE T2.Party_name != "Progress Party"
SELECT count(*) FROM party_events
SELECT count(*) FROM party_events
SELECT T2.party_name ,  count(*) FROM party_events AS T1 JOIN party AS T2 ON T1.party_id  =  T2.party_id GROUP BY T1.party_id
SELECT T2.party_name ,  count(*) FROM party_events AS T1 JOIN party AS T2 ON T1.party_id  =  T2.party_id GROUP BY T1.party_id
SELECT T2.party_name FROM party_events AS T1 JOIN party AS T2 ON T1.party_id  =  T2.party_id GROUP BY T1.party_id HAVING count(*)  >=  2
SELECT T2.party_name FROM party_events AS T1 JOIN party AS T2 ON T1.party_id  =  T2.party_id GROUP BY T1.party_id HAVING count(*)  >=  2
SELECT T1.member_name FROM member AS T1 JOIN party_events AS T2 ON T1.member_id  =  T2.member_in_charge_id GROUP BY T2.member_in_charge_id ORDER BY count(*) DESC LIMIT 1
SELECT T1.member_name FROM member AS T1 JOIN party_events AS T2 ON T1.member_id  =  T2.member_in_charge_id GROUP BY T2.member_in_charge_id ORDER BY count(*) DESC LIMIT 1
SELECT event_name FROM party_events GROUP BY event_name HAVING count(*)  >  2
SELECT event_name FROM party_events GROUP BY event_name HAVING count(*)  >  2
SELECT count(*) FROM pilot
SELECT Pilot_name FROM pilot ORDER BY Rank ASC
SELECT POSITION ,  Team FROM pilot
SELECT DISTINCT POSITION FROM pilot WHERE Age  >  30
SELECT Pilot_name FROM pilot WHERE Team  =  "Bradley" OR Team  =  "Fordham"
SELECT Join_Year FROM pilot ORDER BY Rank ASC LIMIT 1
SELECT Nationality ,  COUNT(*) FROM pilot GROUP BY Nationality
SELECT Nationality FROM pilot GROUP BY Nationality ORDER BY COUNT(*) DESC LIMIT 1
SELECT T3.Pilot_name ,  T2.Model FROM pilot_record AS T1 JOIN aircraft AS T2 ON T1.Aircraft_ID  =  T2.Aircraft_ID JOIN pilot AS T3 ON T1.Pilot_ID  =  T3.Pilot_ID
SELECT T3.Pilot_name ,  T2.Fleet_Series FROM pilot_record AS T1 JOIN aircraft AS T2 ON T1.Aircraft_ID  =  T2.Aircraft_ID JOIN pilot AS T3 ON T1.Pilot_ID  =  T3.Pilot_ID ORDER BY T3.Rank
SELECT T2.Fleet_Series FROM pilot_record AS T1 JOIN aircraft AS T2 ON T1.Aircraft_ID  =  T2.Aircraft_ID JOIN pilot AS T3 ON T1.Pilot_ID  =  T3.Pilot_ID WHERE T3.Age  <  34
SELECT T2.Pilot_name ,  COUNT(*) FROM pilot_record AS T1 JOIN pilot AS T2 ON T1.pilot_ID  =  T2.pilot_ID GROUP BY T2.Pilot_name
SELECT T2.Pilot_name ,  COUNT(*) FROM pilot_record AS T1 JOIN pilot AS T2 ON T1.pilot_ID  =  T2.pilot_ID GROUP BY T2.Pilot_name HAVING COUNT(*)  >  1
SELECT Pilot_name FROM pilot WHERE Pilot_ID NOT IN (SELECT Pilot_ID FROM pilot_record)
SELECT document_status_code FROM Ref_Document_Status;
SELECT document_status_description FROM Ref_Document_Status WHERE document_status_code = "working";
SELECT document_type_code FROM Ref_Document_Types;
SELECT document_type_description FROM Ref_Document_Types WHERE document_type_code = "Paper";
SELECT shipping_agent_name FROM Ref_Shipping_Agents;
SELECT shipping_agent_code FROM Ref_Shipping_Agents WHERE shipping_agent_name = "UPS";
SELECT role_code FROM ROLES;
SELECT role_description FROM ROLES WHERE role_code = "ED";
SELECT count(*) FROM Employees;
SELECT T1.role_description FROM ROLES AS T1 JOIN Employees AS T2 ON T1.role_code = T2.role_code WHERE T2.employee_name = "Koby";
SELECT document_id ,  receipt_date FROM Documents;
SELECT T1.role_description ,  T2.role_code ,  count(*) FROM ROLES AS T1 JOIN Employees AS T2 ON T1.role_code = T2.role_code GROUP BY T2.role_code;
SELECT count(*) FROM Documents WHERE document_status_code = "done";
SELECT document_type_code FROM Documents WHERE document_id = 2;
SELECT document_id FROM Documents WHERE document_status_code = "done" AND document_type_code = "Paper";
SELECT receipt_date FROM Documents WHERE document_id = 3;
SELECT mailing_date FROM Documents_Mailed WHERE document_id = 7;
SELECT draft_details FROM Document_Drafts WHERE document_id = 7;
SELECT document_id , count(*) FROM Draft_Copies GROUP BY document_id HAVING count(*)  >  1;
SELECT dname FROM department ORDER BY mgr_start_date
SELECT Dependent_name FROM dependent WHERE relationship  =  'Spouse'
SELECT count(*) FROM dependent WHERE sex  =  'F'
SELECT fname ,  lname FROM employee WHERE salary  >  30000
SELECT count(*) ,  sex FROM employee WHERE salary  <  50000 GROUP BY sex
SELECT fname ,  lname ,  address FROM employee ORDER BY Bdate
SELECT T1.event_details FROM EVENTS AS T1 JOIN Services AS T2 ON T1.Service_ID  =  T2.Service_ID WHERE T2.Service_Type_Code  =  'Marriage'
SELECT T1.event_id ,  T1.event_details FROM EVENTS AS T1 JOIN Participants_in_Events AS T2 ON T1.Event_ID  =  T2.Event_ID GROUP BY T1.Event_ID HAVING count(*)  >  1
SELECT T1.Participant_ID ,  T1.Participant_Type_Code ,  count(*) FROM Participants AS T1 JOIN Participants_in_Events AS T2 ON T1.Participant_ID  =  T2.Participant_ID GROUP BY T1.Participant_ID
SELECT Participant_ID ,  Participant_Type_Code ,  Participant_Details FROM  Participants
SELECT count(*) FROM participants WHERE participant_type_code  =  'Organizer'
SELECT service_type_code FROM services ORDER BY service_type_code
SELECT service_id ,  event_details FROM EVENTS
SELECT participant_type_code FROM participants GROUP BY participant_type_code ORDER BY count(*) DESC LIMIT 1
SELECT T3.service_id ,  T4.Service_Type_Code FROM participants AS T1 JOIN Participants_in_Events AS T2 ON T1.Participant_ID  =  T2.Participant_ID JOIN EVENTS AS T3 ON T2.Event_ID   =  T3.Event_ID JOIN services AS T4 ON T3.service_id  =  T4.service_id GROUP BY T3.service_id ORDER BY count(*) ASC LIMIT 1
SELECT count(*) FROM EVENTS WHERE event_id NOT IN (SELECT event_id FROM Participants_in_Events)
SELECT name FROM races ORDER BY date DESC LIMIT 1
SELECT name FROM races ORDER BY date DESC LIMIT 1
SELECT name ,  date FROM races ORDER BY date DESC LIMIT 1
SELECT name ,  date FROM races ORDER BY date DESC LIMIT 1
SELECT name FROM races WHERE YEAR = 2017
SELECT name FROM races WHERE YEAR = 2017
SELECT DISTINCT name FROM races WHERE YEAR BETWEEN 2014 AND 2017
SELECT DISTINCT name FROM races WHERE YEAR BETWEEN 2014 AND 2017
SELECT DISTINCT T1.forename ,  T1.surname FROM drivers AS T1 JOIN laptimes AS T2 ON T1.driverid = T2.driverid WHERE T2.milliseconds < 93000
SELECT DISTINCT T1.forename ,  T1.surname FROM drivers AS T1 JOIN laptimes AS T2 ON T1.driverid = T2.driverid WHERE T2.milliseconds < 93000
SELECT DISTINCT T1.driverid ,  T1.nationality FROM drivers AS T1 JOIN laptimes AS T2 ON T1.driverid = T2.driverid WHERE T2.milliseconds >  100000
SELECT DISTINCT T1.driverid ,  T1.nationality FROM drivers AS T1 JOIN laptimes AS T2 ON T1.driverid = T2.driverid WHERE T2.milliseconds >  100000
SELECT T1.driverid ,  T1.forename ,  T1.surname FROM drivers AS T1 JOIN laptimes AS T2 ON T1.driverid = T2.driverid WHERE POSITION  =  '1' GROUP BY T1.driverid HAVING count(*)  >=  2
SELECT T1.driverid ,  T1.forename ,  T1.surname FROM drivers AS T1 JOIN laptimes AS T2 ON T1.driverid = T2.driverid WHERE POSITION  =  '1' GROUP BY T1.driverid HAVING count(*)  >=  2
SELECT T2.name ,  T2.year FROM results AS T1 JOIN races AS T2 ON T1.raceid = T2.raceid JOIN drivers AS T3 ON T1.driverid = T3.driverid WHERE T3.forename = "Lewis"
SELECT T2.name ,  T2.year FROM results AS T1 JOIN races AS T2 ON T1.raceid = T2.raceid JOIN drivers AS T3 ON T1.driverid = T3.driverid WHERE T3.forename = "Lewis"
SELECT forename ,  surname FROM drivers WHERE nationality = "German"
SELECT forename ,  surname FROM drivers WHERE nationality = "German"
SELECT DISTINCT T1.forename FROM drivers AS T1 JOIN driverstandings AS T2 ON T1.driverid = T2.driverid WHERE T2.position = 1 AND T2.wins = 1
SELECT DISTINCT T1.forename FROM drivers AS T1 JOIN driverstandings AS T2 ON T1.driverid = T2.driverid WHERE T2.position = 1 AND T2.wins = 1
SELECT DISTINCT T1.forename FROM drivers AS T1 JOIN driverstandings AS T2 ON T1.driverid = T2.driverid WHERE T2.position = 1 AND T2.wins = 1 AND T2.points > 20
SELECT DISTINCT T1.forename FROM drivers AS T1 JOIN driverstandings AS T2 ON T1.driverid = T2.driverid WHERE T2.position = 1 AND T2.wins = 1 AND T2.points > 20
SELECT count(*) ,  nationality FROM constructors GROUP BY nationality
SELECT count(*) ,  nationality FROM constructors GROUP BY nationality
SELECT count(*) ,  constructorid FROM constructorStandings GROUP BY constructorid
SELECT count(*) ,  constructorid FROM constructorStandings GROUP BY constructorid
SELECT T1.name FROM races AS T1 JOIN circuits AS T2 ON T1.circuitid = T2.circuitid WHERE T2.country = "Spain" AND T1.year > 2017
SELECT T1.name FROM races AS T1 JOIN circuits AS T2 ON T1.circuitid = T2.circuitid WHERE T2.country = "Spain" AND T1.year > 2017
SELECT DISTINCT T1.name FROM races AS T1 JOIN circuits AS T2 ON T1.circuitid = T2.circuitid WHERE T2.country = "Spain" AND T1.year > 2000
SELECT DISTINCT T1.name FROM races AS T1 JOIN circuits AS T2 ON T1.circuitid = T2.circuitid WHERE T2.country = "Spain" AND T1.year > 2000
SELECT DISTINCT forename FROM drivers ORDER BY forename ASC
SELECT DISTINCT forename FROM drivers ORDER BY forename ASC
SELECT DISTINCT name FROM races ORDER BY name DESC
SELECT DISTINCT name FROM races ORDER BY name DESC
SELECT name FROM races WHERE YEAR BETWEEN 2009 AND 2011
SELECT name FROM races WHERE YEAR BETWEEN 2009 AND 2011
SELECT name FROM races WHERE TIME > "12:00:00" OR TIME < "09:00:00"
SELECT name FROM races WHERE TIME > "12:00:00" OR TIME < "09:00:00"
SELECT T1.forename ,  T1.surname ,  T1.driverid FROM drivers AS T1 JOIN pitstops AS T2 ON T1.driverid  =  T2.driverid GROUP BY T1.driverid HAVING count(*)  >  8 UNION SELECT T1.forename ,  T1.surname ,  T1.driverid FROM drivers AS T1 JOIN results AS T2 ON T1.driverid  =  T2.driverid GROUP BY T1.driverid HAVING count(*)  >  5
SELECT T1.forename ,  T1.surname ,  T1.driverid FROM drivers AS T1 JOIN pitstops AS T2 ON T1.driverid  =  T2.driverid GROUP BY T1.driverid HAVING count(*)  >  8 UNION SELECT T1.forename ,  T1.surname ,  T1.driverid FROM drivers AS T1 JOIN results AS T2 ON T1.driverid  =  T2.driverid GROUP BY T1.driverid HAVING count(*)  >  5
SELECT T1.driverid ,  T1.surname FROM drivers AS T1 JOIN results AS T2 ON T1.driverid  =  T2.driverid JOIN races AS T3 ON T2.raceid = T3.raceid WHERE T3.year > 2010 GROUP BY T1.driverid ORDER BY count(*) DESC LIMIT 1
SELECT T1.driverid ,  T1.surname FROM drivers AS T1 JOIN results AS T2 ON T1.driverid  =  T2.driverid JOIN races AS T3 ON T2.raceid = T3.raceid WHERE T3.year > 2010 GROUP BY T1.driverid ORDER BY count(*) DESC LIMIT 1
SELECT name FROM circuits WHERE country = "UK" OR country = "Malaysia"
SELECT name FROM circuits WHERE country = "UK" OR country = "Malaysia"
SELECT circuitid ,  LOCATION FROM circuits WHERE country = "France" OR country = "Belgium"
SELECT circuitid ,  LOCATION FROM circuits WHERE country = "France" OR country = "Belgium"
SELECT T1.name FROM constructors AS T1 JOIN constructorstandings AS T2 ON T1.constructorid = T2.constructorid WHERE T1.nationality = "Japanese" AND T2.points > 5
SELECT T1.name FROM constructors AS T1 JOIN constructorstandings AS T2 ON T1.constructorid = T2.constructorid WHERE T1.nationality = "Japanese" AND T2.points > 5
SELECT T1.driverid ,  T1.forename ,  count(*) FROM drivers AS T1 JOIN results AS T2 ON T1.driverid = T2.driverid JOIN races AS T3 ON T2.raceid = T3.raceid GROUP BY T1.driverid HAVING count(*)  >=  2
SELECT T1.driverid ,  T1.forename ,  count(*) FROM drivers AS T1 JOIN results AS T2 ON T1.driverid = T2.driverid JOIN races AS T3 ON T2.raceid = T3.raceid GROUP BY T1.driverid HAVING count(*)  >=  2
SELECT T1.driverid ,  count(*) FROM drivers AS T1 JOIN results AS T2 ON T1.driverid = T2.driverid JOIN races AS T3 ON T2.raceid = T3.raceid GROUP BY T1.driverid HAVING count(*)  <=  30
SELECT T1.driverid ,  count(*) FROM drivers AS T1 JOIN results AS T2 ON T1.driverid = T2.driverid JOIN races AS T3 ON T2.raceid = T3.raceid GROUP BY T1.driverid HAVING count(*)  <=  30
SELECT T1.driverid ,  T1.surname FROM drivers AS T1 JOIN results AS T2 ON T1.driverid = T2.driverid JOIN races AS T3 ON T2.raceid = T3.raceid GROUP BY T1.driverid ORDER BY count(*) DESC LIMIT 1
SELECT T1.driverid ,  T1.surname FROM drivers AS T1 JOIN results AS T2 ON T1.driverid = T2.driverid JOIN races AS T3 ON T2.raceid = T3.raceid GROUP BY T1.driverid ORDER BY count(*) DESC LIMIT 1
SELECT count(*) FROM technician
SELECT count(*) FROM technician
SELECT Name FROM technician ORDER BY Age ASC
SELECT Name FROM technician ORDER BY Age ASC
SELECT Team ,  Starting_Year FROM technician
SELECT Team ,  Starting_Year FROM technician
SELECT Name FROM technician WHERE Team != "NYY"
SELECT Name FROM technician WHERE Team != "NYY"
SELECT Name FROM technician WHERE Age  =  36 OR Age  =  37
SELECT Name FROM technician WHERE Age  =  36 OR Age  =  37
SELECT Starting_Year FROM technician ORDER BY Age DESC LIMIT 1
SELECT Starting_Year FROM technician ORDER BY Age DESC LIMIT 1
SELECT Team ,  COUNT(*) FROM technician GROUP BY Team
SELECT Team ,  COUNT(*) FROM technician GROUP BY Team
SELECT Team FROM technician GROUP BY Team ORDER BY COUNT(*) DESC LIMIT 1
SELECT Team FROM technician GROUP BY Team ORDER BY COUNT(*) DESC LIMIT 1
SELECT Team FROM technician GROUP BY Team HAVING COUNT(*)  >=  2
SELECT Team FROM technician GROUP BY Team HAVING COUNT(*)  >=  2
SELECT T3.Name ,  T2.Machine_series FROM repair_assignment AS T1 JOIN machine AS T2 ON T1.machine_id  =  T2.machine_id JOIN technician AS T3 ON T1.technician_ID  =  T3.technician_ID
SELECT T3.Name ,  T2.Machine_series FROM repair_assignment AS T1 JOIN machine AS T2 ON T1.machine_id  =  T2.machine_id JOIN technician AS T3 ON T1.technician_ID  =  T3.technician_ID
SELECT T3.Name FROM repair_assignment AS T1 JOIN machine AS T2 ON T1.machine_id  =  T2.machine_id JOIN technician AS T3 ON T1.technician_ID  =  T3.technician_ID ORDER BY T2.quality_rank
SELECT T3.Name FROM repair_assignment AS T1 JOIN machine AS T2 ON T1.machine_id  =  T2.machine_id JOIN technician AS T3 ON T1.technician_ID  =  T3.technician_ID ORDER BY T2.quality_rank
SELECT T3.Name FROM repair_assignment AS T1 JOIN machine AS T2 ON T1.machine_id  =  T2.machine_id JOIN technician AS T3 ON T1.technician_ID  =  T3.technician_ID WHERE T2.value_points  >  70
SELECT T3.Name FROM repair_assignment AS T1 JOIN machine AS T2 ON T1.machine_id  =  T2.machine_id JOIN technician AS T3 ON T1.technician_ID  =  T3.technician_ID WHERE T2.value_points  >  70
SELECT T2.Name ,  COUNT(*) FROM repair_assignment AS T1 JOIN technician AS T2 ON T1.technician_ID  =  T2.technician_ID GROUP BY T2.Name
SELECT T2.Name ,  COUNT(*) FROM repair_assignment AS T1 JOIN technician AS T2 ON T1.technician_ID  =  T2.technician_ID GROUP BY T2.Name
SELECT Name FROM technician WHERE technician_id NOT IN (SELECT technician_id FROM repair_assignment)
SELECT Name FROM technician WHERE technician_id NOT IN (SELECT technician_id FROM repair_assignment)
SELECT count(*) FROM entrepreneur
SELECT count(*) FROM entrepreneur
SELECT Company FROM entrepreneur ORDER BY Money_Requested DESC
SELECT Company FROM entrepreneur ORDER BY Money_Requested DESC
SELECT Company ,  Investor FROM entrepreneur
SELECT Company ,  Investor FROM entrepreneur
SELECT avg(Money_Requested) FROM entrepreneur
SELECT avg(Money_Requested) FROM entrepreneur
SELECT Name FROM People ORDER BY Weight ASC
SELECT Name FROM People ORDER BY Weight ASC
SELECT T2.Name FROM entrepreneur AS T1 JOIN people AS T2 ON T1.People_ID  =  T2.People_ID
SELECT T2.Name FROM entrepreneur AS T1 JOIN people AS T2 ON T1.People_ID  =  T2.People_ID
SELECT T2.Name FROM entrepreneur AS T1 JOIN people AS T2 ON T1.People_ID  =  T2.People_ID WHERE T1.Investor != "Rachel Elnaugh"
SELECT T2.Name FROM entrepreneur AS T1 JOIN people AS T2 ON T1.People_ID  =  T2.People_ID WHERE T1.Investor != "Rachel Elnaugh"
SELECT Weight FROM people ORDER BY Height ASC LIMIT 1
SELECT Weight FROM people ORDER BY Height ASC LIMIT 1
SELECT T2.Name FROM entrepreneur AS T1 JOIN people AS T2 ON T1.People_ID  =  T2.People_ID ORDER BY T2.Weight DESC LIMIT 1
SELECT T2.Name FROM entrepreneur AS T1 JOIN people AS T2 ON T1.People_ID  =  T2.People_ID ORDER BY T2.Weight DESC LIMIT 1
SELECT T2.Date_of_Birth FROM entrepreneur AS T1 JOIN people AS T2 ON T1.People_ID  =  T2.People_ID WHERE T1.Investor  =  "Simon Woodroffe" OR T1.Investor  =  "Peter Jones"
SELECT T2.Date_of_Birth FROM entrepreneur AS T1 JOIN people AS T2 ON T1.People_ID  =  T2.People_ID WHERE T1.Investor  =  "Simon Woodroffe" OR T1.Investor  =  "Peter Jones"
SELECT T2.Weight FROM entrepreneur AS T1 JOIN people AS T2 ON T1.People_ID  =  T2.People_ID ORDER BY T1.Money_Requested DESC
SELECT T2.Weight FROM entrepreneur AS T1 JOIN people AS T2 ON T1.People_ID  =  T2.People_ID ORDER BY T1.Money_Requested DESC
SELECT Investor ,  COUNT(*) FROM entrepreneur GROUP BY Investor
SELECT Investor ,  COUNT(*) FROM entrepreneur GROUP BY Investor
SELECT Investor FROM entrepreneur GROUP BY Investor ORDER BY COUNT(*) DESC LIMIT 1
SELECT Investor FROM entrepreneur GROUP BY Investor ORDER BY COUNT(*) DESC LIMIT 1
SELECT Investor FROM entrepreneur GROUP BY Investor HAVING COUNT(*)  >=  2
SELECT Investor FROM entrepreneur GROUP BY Investor HAVING COUNT(*)  >=  2
SELECT T2.Name ,  T1.Company FROM entrepreneur AS T1 JOIN people AS T2 ON T1.People_ID  =  T2.People_ID ORDER BY T1.Money_Requested
SELECT T2.Name ,  T1.Company FROM entrepreneur AS T1 JOIN people AS T2 ON T1.People_ID  =  T2.People_ID ORDER BY T1.Money_Requested
SELECT Name FROM people WHERE People_ID NOT IN (SELECT People_ID FROM entrepreneur)
SELECT Name FROM people WHERE People_ID NOT IN (SELECT People_ID FROM entrepreneur)
SELECT T1.Company FROM entrepreneur AS T1 JOIN people AS T2 ON T1.People_ID  =  T2.People_ID ORDER BY T2.Height DESC LIMIT 1
SELECT T1.Company FROM entrepreneur AS T1 JOIN people AS T2 ON T1.People_ID  =  T2.People_ID ORDER BY T2.Height DESC LIMIT 1
SELECT count(*) FROM perpetrator
SELECT Date FROM perpetrator ORDER BY Killed DESC
SELECT Injured FROM perpetrator ORDER BY Injured ASC
SELECT avg(Injured) FROM perpetrator
SELECT LOCATION FROM perpetrator ORDER BY Killed DESC LIMIT 1
SELECT Name FROM People ORDER BY Height ASC
SELECT T1.Name FROM people AS T1 JOIN perpetrator AS T2 ON T1.People_ID  =  T2.People_ID
SELECT T1.Name FROM people AS T1 JOIN perpetrator AS T2 ON T1.People_ID  =  T2.People_ID WHERE T2.Country != "China"
SELECT T1.Name FROM people AS T1 JOIN perpetrator AS T2 ON T1.People_ID  =  T2.People_ID ORDER BY T1.Weight DESC LIMIT 1
SELECT T1.Name FROM people AS T1 JOIN perpetrator AS T2 ON T1.People_ID  =  T2.People_ID WHERE T2.Country  =  "China" OR T2.Country  =  "Japan"
SELECT T1.Height FROM people AS T1 JOIN perpetrator AS T2 ON T1.People_ID  =  T2.People_ID ORDER BY T2.Injured DESC
SELECT Country ,  COUNT(*) FROM perpetrator GROUP BY Country
SELECT Country ,  COUNT(*) FROM perpetrator GROUP BY Country ORDER BY COUNT(*) DESC LIMIT 1
SELECT Country ,  COUNT(*) FROM perpetrator GROUP BY Country HAVING COUNT(*)  >=  2
SELECT T1.Name FROM people AS T1 JOIN perpetrator AS T2 ON T1.People_ID  =  T2.People_ID ORDER BY T2.Year DESC
SELECT Name FROM people WHERE People_ID NOT IN (SELECT People_ID FROM perpetrator)
SELECT T2.Date FROM people AS T1 JOIN perpetrator AS T2 ON T1.People_ID  =  T2.People_ID ORDER BY T1.Height DESC LIMIT 1
SELECT max(YEAR) FROM perpetrator;
SELECT campus FROM campuses WHERE county  =  "Los Angeles"
SELECT campus FROM campuses WHERE county  =  "Los Angeles"
SELECT campus FROM campuses WHERE LOCATION  =  "Chico"
SELECT campus FROM campuses WHERE LOCATION  =  "Chico"
SELECT campus FROM campuses WHERE YEAR  =  1958
SELECT campus FROM campuses WHERE YEAR  =  1958
SELECT campus FROM campuses WHERE YEAR  <  1800
SELECT campus FROM campuses WHERE YEAR  <  1800
SELECT campus FROM campuses WHERE YEAR  >=  1935 AND YEAR  <=  1939
SELECT campus FROM campuses WHERE YEAR  >=  1935 AND YEAR  <=  1939
SELECT campus FROM campuses WHERE LOCATION  =  "Northridge" AND county  =  "Los Angeles" UNION SELECT campus FROM campuses WHERE LOCATION  =  "San Francisco" AND county  =  "San Francisco"
SELECT campus FROM campuses WHERE LOCATION  =  "Northridge" AND county  =  "Los Angeles" UNION SELECT campus FROM campuses WHERE LOCATION  =  "San Francisco" AND county  =  "San Francisco"
SELECT campus FROM campuses WHERE county  =  "Los Angeles" AND YEAR  >  1950
SELECT campus FROM campuses WHERE county  =  "Los Angeles" AND YEAR  >  1950
SELECT T1.campus FROM campuses AS T1 JOIN faculty AS T2 ON T1.id  =  T2.campus WHERE T2.year  =  2003 ORDER BY T2.faculty DESC LIMIT 1
SELECT T1.campus FROM campuses AS T1 JOIN faculty AS T2 ON T1.id  =  T2.campus WHERE T2.year  =  2003 ORDER BY T2.faculty DESC LIMIT 1
SELECT avg(campusfee) FROM csu_fees WHERE YEAR  =  2005
SELECT avg(campusfee) FROM csu_fees WHERE YEAR  =  2005
SELECT count(*) FROM campuses WHERE county  =  "Los Angeles"
SELECT count(*) FROM campuses WHERE county  =  "Los Angeles"
SELECT campus FROM campuses WHERE county  =  "Los Angeles"
SELECT campus FROM campuses WHERE county  =  "Los Angeles"
SELECT faculty FROM faculty AS T1 JOIN campuses AS T2 ON T1.campus  =  T2.id WHERE T1.year  =  2002 AND T2.campus  =  "Long Beach State University"
SELECT faculty FROM faculty AS T1 JOIN campuses AS T2 ON T1.campus  =  T2.id WHERE T1.year  =  2002 AND T2.campus  =  "Long Beach State University"
SELECT faculty FROM faculty AS T1 JOIN campuses AS T2 ON T1.campus  =  T2.id WHERE T1.year  =  2004 AND T2.campus  =  "San Francisco State University"
SELECT faculty FROM faculty AS T1 JOIN campuses AS T2 ON T1.campus  =  T2.id WHERE T1.year  =  2004 AND T2.campus  =  "San Francisco State University"
SELECT count(*) FROM campuses
SELECT count(*) FROM campuses
SELECT count(*) FROM candidate
SELECT count(*) FROM candidate
SELECT poll_source FROM candidate GROUP BY poll_source ORDER BY count(*) DESC LIMIT 1
SELECT poll_source FROM candidate GROUP BY poll_source ORDER BY count(*) DESC LIMIT 1
SELECT support_rate FROM candidate ORDER BY support_rate DESC LIMIT 3
SELECT support_rate FROM candidate ORDER BY support_rate DESC LIMIT 3
SELECT Candidate_ID FROM candidate ORDER BY oppose_rate LIMIT 1
SELECT Candidate_ID FROM candidate ORDER BY oppose_rate LIMIT 1
SELECT Support_rate ,  Consider_rate ,  Oppose_rate FROM candidate ORDER BY unsure_rate
SELECT Support_rate ,  Consider_rate ,  Oppose_rate FROM candidate ORDER BY unsure_rate
SELECT poll_source FROM candidate ORDER BY oppose_rate DESC LIMIT 1
SELECT poll_source FROM candidate ORDER BY oppose_rate DESC LIMIT 1
SELECT name FROM people ORDER BY date_of_birth
SELECT name FROM people ORDER BY date_of_birth
SELECT avg(height) ,  avg(weight) FROM people WHERE sex  =  'M'
SELECT avg(height) ,  avg(weight) FROM people WHERE sex  =  'M'
SELECT name FROM people WHERE height  >  200 OR height  <  190
SELECT name FROM people WHERE height  >  200 OR height  <  190
SELECT name FROM people WHERE people_id NOT IN (SELECT people_id FROM candidate)
SELECT name FROM people WHERE people_id NOT IN (SELECT people_id FROM candidate)
SELECT count(*) ,  sex FROM people WHERE weight  >  85 GROUP BY sex
SELECT count(*) ,  sex FROM people WHERE weight  >  85 GROUP BY sex
SELECT max(support_rate) ,  min(consider_rate) ,  min(oppose_rate) FROM candidate
SELECT max(support_rate) ,  min(consider_rate) ,  min(oppose_rate) FROM candidate
SELECT title FROM Movie WHERE director = 'Steven Spielberg'
SELECT title FROM Movie WHERE director = 'Steven Spielberg'
SELECT title FROM Movie WHERE director = 'James Cameron' AND YEAR  >  2000
SELECT title FROM Movie WHERE director = 'James Cameron' AND YEAR  >  2000
SELECT count(*) FROM Movie WHERE YEAR  <  2000
SELECT count(*) FROM Movie WHERE YEAR  <  2000
SELECT director FROM Movie WHERE title  = 'Avatar'
SELECT director FROM Movie WHERE title  = 'Avatar'
SELECT count(*) FROM Reviewer
SELECT count(*) FROM Reviewer
SELECT rID FROM Reviewer WHERE name LIKE "%Mike%"
SELECT rID FROM Reviewer WHERE name LIKE "%Mike%"
SELECT rID FROM Reviewer WHERE name  =  "Daniel Lewis"
SELECT rID FROM Reviewer WHERE name  =  "Daniel Lewis"
SELECT DISTINCT YEAR FROM Movie AS T1 JOIN Rating AS T2 ON T1.mID  =  T2.mID WHERE T2.stars  >=  4 ORDER BY T1.year
SELECT DISTINCT YEAR FROM Movie AS T1 JOIN Rating AS T2 ON T1.mID  =  T2.mID WHERE T2.stars  >=  4 ORDER BY T1.year
SELECT T2.name ,  avg(T1.stars) FROM Rating AS T1 JOIN Reviewer AS T2 ON T1.rID  =  T2.rID GROUP BY T2.name
SELECT T2.name ,  avg(T1.stars) FROM Rating AS T1 JOIN Reviewer AS T2 ON T1.rID  =  T2.rID GROUP BY T2.name
SELECT DISTINCT name FROM Reviewer AS T1 JOIN Rating AS T2 ON T1.rID  =  T2.rID WHERE ratingDate  =  "null"
SELECT DISTINCT name FROM Reviewer AS T1 JOIN Rating AS T2 ON T1.rID  =  T2.rID WHERE ratingDate  =  "null"
SELECT T3.name ,  T2.title ,  T1.stars ,  T1.ratingDate FROM Rating AS T1 JOIN Movie AS T2 ON T1.mID  =  T2.mID JOIN Reviewer AS T3 ON T1.rID  =  T3.rID ORDER BY T3.name ,  T2.title ,  T1.stars
SELECT T3.name ,  T2.title ,  T1.stars ,  T1.ratingDate FROM Rating AS T1 JOIN Movie AS T2 ON T1.mID  =  T2.mID JOIN Reviewer AS T3 ON T1.rID  =  T3.rID ORDER BY T3.name ,  T2.title ,  T1.stars
SELECT T2.name FROM Rating AS T1 JOIN Reviewer AS T2 ON T1.rID  =  T2.rID GROUP BY T1.rID HAVING COUNT(*)  >=  3
SELECT T2.name FROM Rating AS T1 JOIN Reviewer AS T2 ON T1.rID  =  T2.rID GROUP BY T1.rID HAVING COUNT(*)  >=  3
SELECT DISTINCT T3.name FROM Rating AS T1 JOIN Movie AS T2 ON T1.mID  =  T2.mID JOIN Reviewer AS T3 ON T1.rID  =  T3.rID WHERE T2.title  =  'Gone with the Wind'
SELECT DISTINCT T3.name FROM Rating AS T1 JOIN Movie AS T2 ON T1.mID  =  T2.mID JOIN Reviewer AS T3 ON T1.rID  =  T3.rID WHERE T2.title  =  'Gone with the Wind'
SELECT DISTINCT T2.director FROM Rating AS T1 JOIN Movie AS T2 ON T1.mID  =  T2.mID JOIN Reviewer AS T3 ON T1.rID  =  T3.rID WHERE T3.name  =  'Sarah Martinez'
SELECT DISTINCT T2.director FROM Rating AS T1 JOIN Movie AS T2 ON T1.mID  =  T2.mID JOIN Reviewer AS T3 ON T1.rID  =  T3.rID WHERE T3.name  =  'Sarah Martinez'
SELECT DISTINCT T3.name ,  T2.title ,  T1.stars FROM Rating AS T1 JOIN Movie AS T2 ON T1.mID  =  T2.mID JOIN Reviewer AS T3 ON T1.rID  =  T3.rID WHERE T2.director  =  T3.name
SELECT DISTINCT T3.name ,  T2.title ,  T1.stars FROM Rating AS T1 JOIN Movie AS T2 ON T1.mID  =  T2.mID JOIN Reviewer AS T3 ON T1.rID  =  T3.rID WHERE T2.director  =  T3.name
SELECT director FROM Movie WHERE director != "null" GROUP BY director HAVING count(*)  =  1
SELECT director FROM Movie WHERE director != "null" GROUP BY director HAVING count(*)  =  1
SELECT count(*) ,  T1.director FROM Movie AS T1 JOIN Rating AS T2 ON T1.mID  =  T2.mID GROUP BY T1.director
SELECT count(*) ,  T1.director FROM Movie AS T1 JOIN Rating AS T2 ON T1.mID  =  T2.mID GROUP BY T1.director
SELECT T2.title ,  T2.year FROM Rating AS T1 JOIN Movie AS T2 ON T1.mID  =  T2.mID ORDER BY T1.stars DESC LIMIT 3
SELECT T2.title ,  T2.year FROM Rating AS T1 JOIN Movie AS T2 ON T1.mID  =  T2.mID ORDER BY T1.stars DESC LIMIT 3
SELECT T2.title ,  T1.rID ,  T1.stars ,  min(T1.stars) FROM Rating AS T1 JOIN Movie AS T2 ON T1.mID  =  T2.mID GROUP BY T1.rID
SELECT T2.title ,  T1.rID ,  T1.stars ,  min(T1.stars) FROM Rating AS T1 JOIN Movie AS T2 ON T1.mID  =  T2.mID GROUP BY T1.rID
SELECT T2.title ,  T1.stars ,  T2.director ,  min(T1.stars) FROM Rating AS T1 JOIN Movie AS T2 ON T1.mID  =  T2.mID GROUP BY T2.director
SELECT T2.title ,  T1.stars ,  T2.director ,  min(T1.stars) FROM Rating AS T1 JOIN Movie AS T2 ON T1.mID  =  T2.mID GROUP BY T2.director
SELECT T2.title ,  T1.mID FROM Rating AS T1 JOIN Movie AS T2 ON T1.mID  =  T2.mID GROUP BY T1.mID ORDER BY count(*) DESC LIMIT 1
SELECT T2.title ,  T1.mID FROM Rating AS T1 JOIN Movie AS T2 ON T1.mID  =  T2.mID GROUP BY T1.mID ORDER BY count(*) DESC LIMIT 1
SELECT T2.title FROM Rating AS T1 JOIN Movie AS T2 ON T1.mID  =  T2.mID WHERE T1.stars BETWEEN 3 AND 5
SELECT T2.title FROM Rating AS T1 JOIN Movie AS T2 ON T1.mID  =  T2.mID WHERE T1.stars BETWEEN 3 AND 5
SELECT T2.name FROM Rating AS T1 JOIN Reviewer AS T2 ON T1.rID  =  T2.rID WHERE T1.stars  >  3
SELECT T2.name FROM Rating AS T1 JOIN Reviewer AS T2 ON T1.rID  =  T2.rID WHERE T1.stars  >  3
SELECT mID ,  avg(stars) FROM Rating WHERE mID NOT IN (SELECT T1.mID FROM Rating AS T1 JOIN Reviewer AS T2 ON T1.rID  =  T2.rID WHERE T2.name  =  "Brittany Harris") GROUP BY mID
SELECT mID ,  avg(stars) FROM Rating WHERE mID NOT IN (SELECT T1.mID FROM Rating AS T1 JOIN Reviewer AS T2 ON T1.rID  =  T2.rID WHERE T2.name  =  "Brittany Harris") GROUP BY mID
SELECT mID ,  avg(stars) FROM Rating GROUP BY mID HAVING count(*)  >=  2
SELECT mID ,  avg(stars) FROM Rating GROUP BY mID HAVING count(*)  >=  2
SELECT rID FROM Rating WHERE stars != 4
SELECT rID FROM Rating WHERE stars != 4
SELECT DISTINCT T2.title FROM Rating AS T1 JOIN Movie AS T2 ON T1.mID  =  T2.mID JOIN Reviewer AS T3 ON T1.rID  =  T3.rID WHERE T3.name  =  'Brittany Harris' OR T2.year  >  2000
SELECT DISTINCT T2.title FROM Rating AS T1 JOIN Movie AS T2 ON T1.mID  =  T2.mID JOIN Reviewer AS T3 ON T1.rID  =  T3.rID WHERE T3.name  =  'Brittany Harris' OR T2.year  >  2000
SELECT title FROM Movie WHERE director  =  "James Cameron" OR YEAR   <  1980
SELECT title FROM Movie WHERE director  =  "James Cameron" OR YEAR   <  1980
SELECT count(*) FROM county_public_safety
SELECT count(*) FROM county_public_safety
SELECT Name FROM county_public_safety ORDER BY Population DESC
SELECT Name FROM county_public_safety ORDER BY Population DESC
SELECT DISTINCT Police_force FROM county_public_safety WHERE LOCATION != "East"
SELECT DISTINCT Police_force FROM county_public_safety WHERE LOCATION != "East"
SELECT min(Crime_rate) ,  max(Crime_rate) FROM county_public_safety
SELECT min(Crime_rate) ,  max(Crime_rate) FROM county_public_safety
SELECT Crime_rate FROM county_public_safety ORDER BY Police_officers ASC
SELECT Crime_rate FROM county_public_safety ORDER BY Police_officers ASC
SELECT Name FROM city ORDER BY Name ASC
SELECT Name FROM city ORDER BY Name ASC
SELECT Hispanic FROM city WHERE Black  >  10
SELECT Hispanic FROM city WHERE Black  >  10
SELECT Name FROM county_public_safety ORDER BY Population DESC LIMIT 1
SELECT Name FROM county_public_safety ORDER BY Population DESC LIMIT 1
SELECT Name FROM city ORDER BY White DESC LIMIT 5
SELECT Name FROM city ORDER BY White DESC LIMIT 5
SELECT T1.Name ,  T2.Name FROM city AS T1 JOIN county_public_safety AS T2 ON T1.County_ID  =  T2.County_ID
SELECT T1.Name ,  T2.Name FROM city AS T1 JOIN county_public_safety AS T2 ON T1.County_ID  =  T2.County_ID
SELECT T1.White ,  T2.Crime_rate FROM city AS T1 JOIN county_public_safety AS T2 ON T1.County_ID  =  T2.County_ID
SELECT T1.White ,  T2.Crime_rate FROM city AS T1 JOIN county_public_safety AS T2 ON T1.County_ID  =  T2.County_ID
SELECT T2.Crime_rate FROM city AS T1 JOIN county_public_safety AS T2 ON T1.County_ID  =  T2.County_ID WHERE T1.White  >  90
SELECT T2.Crime_rate FROM city AS T1 JOIN county_public_safety AS T2 ON T1.County_ID  =  T2.County_ID WHERE T1.White  >  90
SELECT Police_force ,  COUNT(*) FROM county_public_safety GROUP BY Police_force
SELECT Police_force ,  COUNT(*) FROM county_public_safety GROUP BY Police_force
SELECT LOCATION FROM county_public_safety GROUP BY LOCATION ORDER BY COUNT(*) DESC LIMIT 1
SELECT LOCATION FROM county_public_safety GROUP BY LOCATION ORDER BY COUNT(*) DESC LIMIT 1
SELECT Name FROM county_public_safety WHERE County_ID NOT IN (SELECT County_ID FROM city)
SELECT Name FROM county_public_safety WHERE County_ID NOT IN (SELECT County_ID FROM city)
SELECT Case_burden FROM county_public_safety ORDER BY Population DESC
SELECT Case_burden FROM county_public_safety ORDER BY Population DESC
SELECT roomName FROM Rooms WHERE basePrice  <  160 AND beds =  2 AND decor  =  'modern';
SELECT roomName FROM Rooms WHERE basePrice  <  160 AND beds =  2 AND decor  =  'modern';
SELECT roomName ,  RoomId FROM Rooms WHERE basePrice  >  160 AND maxOccupancy  >  2;
SELECT roomName ,  RoomId FROM Rooms WHERE basePrice  >  160 AND maxOccupancy  >  2;
SELECT T2.roomName FROM Reservations AS T1 JOIN Rooms AS T2 ON T1.Room  =  T2.RoomId GROUP BY T1.Room ORDER BY count(*) DESC LIMIT 1;
SELECT T2.roomName FROM Reservations AS T1 JOIN Rooms AS T2 ON T1.Room  =  T2.RoomId GROUP BY T1.Room ORDER BY count(*) DESC LIMIT 1;
SELECT kids FROM Reservations WHERE FirstName = "ROY" AND LastName  =  "SWEAZY";
SELECT kids FROM Reservations WHERE FirstName = "ROY" AND LastName  =  "SWEAZY";
SELECT count(*) FROM Reservations WHERE FirstName = "ROY" AND LastName  =  "SWEAZY";
SELECT count(*) FROM Reservations WHERE FirstName = "ROY" AND LastName  =  "SWEAZY";
SELECT Adults FROM Reservations WHERE CheckIn  =  "2010-10-23" AND FirstName  =  "CONRAD" AND LastName  =  "SELBIG";
SELECT Adults FROM Reservations WHERE CheckIn  =  "2010-10-23" AND FirstName  =  "CONRAD" AND LastName  =  "SELBIG";
SELECT Kids FROM Reservations WHERE CheckIn  =  "2010-09-21" AND FirstName  =  "DAMIEN" AND LastName  =  "TRACHSEL";
SELECT Kids FROM Reservations WHERE CheckIn  =  "2010-09-21" AND FirstName  =  "DAMIEN" AND LastName  =  "TRACHSEL";
SELECT roomName ,  decor FROM Rooms WHERE bedtype  =  'King' ORDER BY basePrice;
SELECT roomName ,  decor FROM Rooms WHERE bedtype  =  'King' ORDER BY basePrice;
SELECT roomName ,  basePrice FROM Rooms ORDER BY basePrice ASC LIMIT 1;
SELECT roomName ,  basePrice FROM Rooms ORDER BY basePrice ASC LIMIT 1;
SELECT decor FROM Rooms WHERE roomName  =  "Recluse and defiance";
SELECT decor FROM Rooms WHERE roomName  =  "Recluse and defiance";
SELECT count(*) FROM Reservations AS T1 JOIN Rooms AS T2 ON T1.Room  =  T2.RoomId WHERE T2.maxOccupancy  =  T1.Adults + T1.Kids;
SELECT count(*) FROM Reservations AS T1 JOIN Rooms AS T2 ON T1.Room  =  T2.RoomId WHERE T2.maxOccupancy  =  T1.Adults + T1.Kids;
SELECT T1.firstname ,  T1.lastname FROM Reservations AS T1 JOIN Rooms AS T2 ON T1.Room  =  T2.RoomId WHERE T1.Rate - T2.basePrice  >  0
SELECT T1.firstname ,  T1.lastname FROM Reservations AS T1 JOIN Rooms AS T2 ON T1.Room  =  T2.RoomId WHERE T1.Rate - T2.basePrice  >  0
SELECT count(*) FROM Rooms;
SELECT count(*) FROM Rooms;
SELECT count(*) FROM Rooms WHERE bedType  =  "King";
SELECT count(*) FROM Rooms WHERE bedType  =  "King";
SELECT bedType ,  count(*) FROM Rooms GROUP BY bedType;
SELECT bedType ,  count(*) FROM Rooms GROUP BY bedType;
SELECT roomName FROM Rooms ORDER BY maxOccupancy DESC LIMIT 1;
SELECT roomName FROM Rooms ORDER BY maxOccupancy DESC LIMIT 1;
SELECT RoomId ,  roomName FROM Rooms ORDER BY basePrice DESC LIMIT 1;
SELECT RoomId ,  roomName FROM Rooms ORDER BY basePrice DESC LIMIT 1;
SELECT roomName ,  bedType FROM Rooms WHERE decor = "traditional";
SELECT roomName ,  bedType FROM Rooms WHERE decor = "traditional";
SELECT decor ,  count(*) FROM Rooms WHERE bedType = "King" GROUP BY decor;
SELECT decor ,  count(*) FROM Rooms WHERE bedType = "King" GROUP BY decor;
SELECT roomName FROM Rooms ORDER BY basePrice;
SELECT roomName FROM Rooms ORDER BY basePrice;
SELECT decor , count(*) FROM Rooms WHERE basePrice  >  120 GROUP BY decor;
SELECT decor , count(*) FROM Rooms WHERE basePrice  >  120 GROUP BY decor;
SELECT roomName FROM Rooms WHERE bedType  =  "King" OR bedType  =  "Queen";
SELECT roomName FROM Rooms WHERE bedType  =  "King" OR bedType  =  "Queen";
SELECT RoomId ,  roomName FROM Rooms ORDER BY basePrice DESC LIMIT 3;
SELECT RoomId ,  roomName FROM Rooms ORDER BY basePrice DESC LIMIT 3;
SELECT count(*) FROM rooms WHERE roomid NOT IN (SELECT DISTINCT room FROM reservations)
SELECT count(*) FROM rooms WHERE roomid NOT IN (SELECT DISTINCT room FROM reservations)
SELECT T2.roomName ,  count(*) ,  T1.Room FROM Reservations AS T1 JOIN Rooms AS T2 ON T1.Room  =  T2.RoomId GROUP BY T1.Room
SELECT T2.roomName ,  count(*) ,  T1.Room FROM Reservations AS T1 JOIN Rooms AS T2 ON T1.Room  =  T2.RoomId GROUP BY T1.Room
SELECT T2.roomName FROM Reservations AS T1 JOIN Rooms AS T2 ON T1.Room  =  T2.RoomId GROUP BY T1.Room HAVING count(*)  >  60
SELECT T2.roomName FROM Reservations AS T1 JOIN Rooms AS T2 ON T1.Room  =  T2.RoomId GROUP BY T1.Room HAVING count(*)  >  60
SELECT roomname FROM rooms WHERE baseprice BETWEEN 120 AND 150
SELECT roomname FROM rooms WHERE baseprice BETWEEN 120 AND 150
SELECT T2.roomName FROM Reservations AS T1 JOIN Rooms AS T2 ON T1.Room  =  T2.RoomId WHERE firstname LIKE '%ROY%'
SELECT T2.roomName FROM Reservations AS T1 JOIN Rooms AS T2 ON T1.Room  =  T2.RoomId WHERE firstname LIKE '%ROY%'
SELECT T1.cmi_details FROM Customer_Master_Index AS T1 JOIN CMI_Cross_References AS T2 ON T1.master_customer_id  =  T2.master_customer_id WHERE T2.source_system_code  =  'Tax'
SELECT T1.cmi_cross_ref_id ,  T1.source_system_code FROM CMI_Cross_References AS T1 JOIN Council_Tax AS T2 ON T1.cmi_cross_ref_id  =  T2.cmi_cross_ref_id GROUP BY T1.cmi_cross_ref_id HAVING count(*)  >=  1
SELECT T2.cmi_cross_ref_id ,  T2.master_customer_id ,  count(*) FROM Business_Rates AS T1 JOIN CMI_Cross_References AS T2 ON T1.cmi_cross_ref_id  =  T2.cmi_cross_ref_id GROUP BY T2.cmi_cross_ref_id
SELECT T1.source_system_code ,  T2.council_tax_id FROM CMI_Cross_References AS T1 JOIN Benefits_Overpayments AS T2 ON T1.cmi_cross_ref_id  =  T2.cmi_cross_ref_id ORDER BY T2.council_tax_id
SELECT T1.source_system_code ,  T1.master_customer_id ,  T2.council_tax_id FROM CMI_Cross_References AS T1 JOIN Parking_Fines AS T2 ON T1.cmi_cross_ref_id  =  T2.cmi_cross_ref_id
SELECT T1.council_tax_id FROM Rent_Arrears AS T1 JOIN CMI_Cross_References AS T2 ON T1.cmi_cross_ref_id  =  T2.cmi_cross_ref_id JOIN Customer_Master_Index AS T3 ON T3.master_customer_id  =  T2.master_customer_id WHERE T3.cmi_details != 'Schmidt ,  Kertzmann and Lubowitz'
SELECT T1.electoral_register_id FROM Electoral_Register AS T1 JOIN CMI_Cross_References AS T2 ON T1.cmi_cross_ref_id  =  T2.cmi_cross_ref_id WHERE T2.source_system_code  =  'Electoral' OR T2.source_system_code  =  'Tax'
SELECT council_tax_id ,  cmi_cross_ref_id FROM parking_fines
SELECT count(*) FROM rent_arrears
SELECT DISTINCT T2.source_system_code FROM customer_master_index AS T1 JOIN cmi_cross_references AS T2 ON T1.master_customer_id  =  T2.master_customer_id WHERE T1.cmi_details  =  'Gottlieb ,  Becker and Wyman'
SELECT DISTINCT source_system_code FROM cmi_cross_references WHERE source_system_code LIKE '%en%'
SELECT count(*) FROM party
SELECT count(*) FROM party
SELECT Party_Theme FROM party ORDER BY Number_of_hosts ASC
SELECT Party_Theme FROM party ORDER BY Number_of_hosts ASC
SELECT Party_Theme ,  LOCATION FROM party
SELECT Party_Theme ,  LOCATION FROM party
SELECT First_year ,  Last_year FROM party WHERE Party_Theme  =  "Spring" OR Party_Theme  =  "Teqnology"
SELECT First_year ,  Last_year FROM party WHERE Party_Theme  =  "Spring" OR Party_Theme  =  "Teqnology"
SELECT avg(Number_of_hosts) FROM party
SELECT avg(Number_of_hosts) FROM party
SELECT LOCATION FROM party ORDER BY Number_of_hosts DESC LIMIT 1
SELECT LOCATION FROM party ORDER BY Number_of_hosts DESC LIMIT 1
SELECT Nationality ,  COUNT(*) FROM HOST GROUP BY Nationality
SELECT Nationality ,  COUNT(*) FROM HOST GROUP BY Nationality
SELECT Nationality FROM HOST GROUP BY Nationality ORDER BY COUNT(*) DESC LIMIT 1
SELECT Nationality FROM HOST GROUP BY Nationality ORDER BY COUNT(*) DESC LIMIT 1
SELECT T3.Party_Theme ,  T2.Name FROM party_host AS T1 JOIN HOST AS T2 ON T1.Host_ID  =  T2.Host_ID JOIN party AS T3 ON T1.Party_ID  =  T3.Party_ID
SELECT T3.Party_Theme ,  T2.Name FROM party_host AS T1 JOIN HOST AS T2 ON T1.Host_ID  =  T2.Host_ID JOIN party AS T3 ON T1.Party_ID  =  T3.Party_ID
SELECT T3.Location ,  T2.Name FROM party_host AS T1 JOIN HOST AS T2 ON T1.Host_ID  =  T2.Host_ID JOIN party AS T3 ON T1.Party_ID  =  T3.Party_ID ORDER BY T2.Age
SELECT T3.Location ,  T2.Name FROM party_host AS T1 JOIN HOST AS T2 ON T1.Host_ID  =  T2.Host_ID JOIN party AS T3 ON T1.Party_ID  =  T3.Party_ID ORDER BY T2.Age
SELECT T3.Location FROM party_host AS T1 JOIN HOST AS T2 ON T1.Host_ID  =  T2.Host_ID JOIN party AS T3 ON T1.Party_ID  =  T3.Party_ID WHERE T2.Age  >  50
SELECT T3.Location FROM party_host AS T1 JOIN HOST AS T2 ON T1.Host_ID  =  T2.Host_ID JOIN party AS T3 ON T1.Party_ID  =  T3.Party_ID WHERE T2.Age  >  50
SELECT T2.Name FROM party_host AS T1 JOIN HOST AS T2 ON T1.Host_ID  =  T2.Host_ID JOIN party AS T3 ON T1.Party_ID  =  T3.Party_ID WHERE T3.Number_of_hosts  >  20
SELECT T2.Name FROM party_host AS T1 JOIN HOST AS T2 ON T1.Host_ID  =  T2.Host_ID JOIN party AS T3 ON T1.Party_ID  =  T3.Party_ID WHERE T3.Number_of_hosts  >  20
SELECT Name ,  Nationality FROM HOST ORDER BY Age DESC LIMIT 1
SELECT Name ,  Nationality FROM HOST ORDER BY Age DESC LIMIT 1
SELECT Name FROM HOST WHERE Host_ID NOT IN (SELECT Host_ID FROM party_host)
SELECT Name FROM HOST WHERE Host_ID NOT IN (SELECT Host_ID FROM party_host)
SELECT count(*) FROM region
SELECT count(*) FROM region
SELECT region_code ,  region_name FROM region ORDER BY region_code
SELECT region_code ,  region_name FROM region ORDER BY region_code
SELECT region_name FROM region ORDER BY region_name
SELECT region_name FROM region ORDER BY region_name
SELECT region_name FROM region WHERE region_name != 'Denmark'
SELECT region_name FROM region WHERE region_name != 'Denmark'
SELECT count(*) FROM storm WHERE Number_Deaths  >  0
SELECT count(*) FROM storm WHERE Number_Deaths  >  0
SELECT name ,  dates_active ,  number_deaths FROM storm WHERE number_deaths  >=  1
SELECT name ,  dates_active ,  number_deaths FROM storm WHERE number_deaths  >=  1
SELECT avg(damage_millions_USD) ,  max(damage_millions_USD) FROM storm WHERE max_speed  >  1000
SELECT avg(damage_millions_USD) ,  max(damage_millions_USD) FROM storm WHERE max_speed  >  1000
SELECT name ,  damage_millions_USD FROM storm ORDER BY max_speed DESC
SELECT name ,  damage_millions_USD FROM storm ORDER BY max_speed DESC
SELECT region_name FROM region WHERE region_id NOT IN (SELECT region_id FROM affected_region)
SELECT region_name FROM region WHERE region_id NOT IN (SELECT region_id FROM affected_region)
SELECT T1.region_name ,  count(*) FROM region AS T1 JOIN affected_region AS T2 ON T1.region_id = T2.region_id GROUP BY T1.region_id
SELECT T1.region_name ,  count(*) FROM region AS T1 JOIN affected_region AS T2 ON T1.region_id = T2.region_id GROUP BY T1.region_id
SELECT T1.name ,  count(*) FROM storm AS T1 JOIN affected_region AS T2 ON T1.storm_id  =  T2.storm_id GROUP BY T1.storm_id
SELECT T1.name ,  count(*) FROM storm AS T1 JOIN affected_region AS T2 ON T1.storm_id  =  T2.storm_id GROUP BY T1.storm_id
SELECT name FROM storm WHERE storm_id NOT IN (SELECT storm_id FROM affected_region)
SELECT name FROM storm WHERE storm_id NOT IN (SELECT storm_id FROM affected_region)
SELECT T2.region_name FROM affected_region AS T1 JOIN region AS T2 ON T1.region_id  =  T2.region_id JOIN storm AS T3 ON T1.storm_id  =  T3.storm_id WHERE T3.number_deaths  >=  10
SELECT T2.region_name FROM affected_region AS T1 JOIN region AS T2 ON T1.region_id  =  T2.region_id JOIN storm AS T3 ON T1.storm_id  =  T3.storm_id WHERE T3.number_deaths  >=  10
SELECT T3.name FROM affected_region AS T1 JOIN region AS T2 ON T1.region_id  =  T2.region_id JOIN storm AS T3 ON T1.storm_id  =  T3.storm_id WHERE T2.region_name  =  'Denmark'
SELECT T3.name FROM affected_region AS T1 JOIN region AS T2 ON T1.region_id  =  T2.region_id JOIN storm AS T3 ON T1.storm_id  =  T3.storm_id WHERE T2.region_name  =  'Denmark'
SELECT T1.region_name FROM region AS T1 JOIN affected_region AS T2 ON T1.region_id = T2.region_id GROUP BY T1.region_id HAVING count(*)  >=  2
SELECT T1.region_name FROM region AS T1 JOIN affected_region AS T2 ON T1.region_id = T2.region_id GROUP BY T1.region_id HAVING count(*)  >=  2
SELECT count(*) FROM county
SELECT count(*) FROM county
SELECT County_name ,  Population FROM county
SELECT County_name ,  Population FROM county
SELECT avg(Population) FROM county
SELECT avg(Population) FROM county
SELECT max(Population) ,  min(Population) FROM county
SELECT max(Population) ,  min(Population) FROM county
SELECT DISTINCT District FROM election
SELECT DISTINCT District FROM election
SELECT Zip_code FROM county WHERE County_name  =  "Howard"
SELECT Zip_code FROM county WHERE County_name  =  "Howard"
SELECT Delegate FROM election WHERE District  =  1
SELECT Delegate FROM election WHERE District  =  1
SELECT Delegate ,  Committee FROM election
SELECT Delegate ,  Committee FROM election
SELECT Lieutenant_Governor ,  Comptroller FROM party WHERE Party  =  "Democratic"
SELECT Lieutenant_Governor ,  Comptroller FROM party WHERE Party  =  "Democratic"
SELECT DISTINCT YEAR FROM party WHERE Governor  =  "Eliot Spitzer"
SELECT DISTINCT YEAR FROM party WHERE Governor  =  "Eliot Spitzer"
SELECT T2.Delegate ,  T1.County_name FROM county AS T1 JOIN election AS T2 ON T1.County_id  =  T2.District
SELECT T2.Delegate ,  T1.County_name FROM county AS T1 JOIN election AS T2 ON T1.County_id  =  T2.District
SELECT T2.Delegate FROM county AS T1 JOIN election AS T2 ON T1.County_id  =  T2.District WHERE T1.Population  <  100000
SELECT T2.Delegate FROM county AS T1 JOIN election AS T2 ON T1.County_id  =  T2.District WHERE T1.Population  <  100000
SELECT T1.County_name FROM county AS T1 JOIN election AS T2 ON T1.County_id  =  T2.District WHERE T2.Committee  =  "Appropriations"
SELECT T1.County_name FROM county AS T1 JOIN election AS T2 ON T1.County_id  =  T2.District WHERE T2.Committee  =  "Appropriations"
SELECT T1.Delegate ,  T2.Party FROM election AS T1 JOIN party AS T2 ON T1.Party  =  T2.Party_ID
SELECT T1.Delegate ,  T2.Party FROM election AS T1 JOIN party AS T2 ON T1.Party  =  T2.Party_ID
SELECT T2.Governor FROM election AS T1 JOIN party AS T2 ON T1.Party  =  T2.Party_ID WHERE T1.District  =  1
SELECT T2.Governor FROM election AS T1 JOIN party AS T2 ON T1.Party  =  T2.Party_ID WHERE T1.District  =  1
SELECT T2.Comptroller FROM election AS T1 JOIN party AS T2 ON T1.Party  =  T2.Party_ID WHERE T1.District  =  1 OR T1.District  =  2
SELECT T2.Comptroller FROM election AS T1 JOIN party AS T2 ON T1.Party  =  T2.Party_ID WHERE T1.District  =  1 OR T1.District  =  2
SELECT T1.Committee FROM election AS T1 JOIN party AS T2 ON T1.Party  =  T2.Party_ID WHERE T2.Party  =  "Democratic"
SELECT T1.Committee FROM election AS T1 JOIN party AS T2 ON T1.Party  =  T2.Party_ID WHERE T2.Party  =  "Democratic"
SELECT T1.County_name ,  COUNT(*) FROM county AS T1 JOIN election AS T2 ON T1.County_id  =  T2.District GROUP BY T1.County_id
SELECT T1.County_name ,  COUNT(*) FROM county AS T1 JOIN election AS T2 ON T1.County_id  =  T2.District GROUP BY T1.County_id
SELECT T2.Party ,  COUNT(*) FROM election AS T1 JOIN party AS T2 ON T1.Party  =  T2.Party_ID GROUP BY T1.Party
SELECT T2.Party ,  COUNT(*) FROM election AS T1 JOIN party AS T2 ON T1.Party  =  T2.Party_ID GROUP BY T1.Party
SELECT County_name FROM county ORDER BY Population ASC
SELECT County_name FROM county ORDER BY Population ASC
SELECT County_name FROM county ORDER BY County_name DESC
SELECT County_name FROM county ORDER BY County_name DESC
SELECT County_name FROM county ORDER BY Population DESC LIMIT 1
SELECT County_name FROM county ORDER BY Population DESC LIMIT 1
SELECT County_name FROM county ORDER BY Population ASC LIMIT 3
SELECT County_name FROM county ORDER BY Population ASC LIMIT 3
SELECT T1.County_name FROM county AS T1 JOIN election AS T2 ON T1.County_id  =  T2.District GROUP BY T1.County_id HAVING COUNT(*)  >=  2
SELECT T1.County_name FROM county AS T1 JOIN election AS T2 ON T1.County_id  =  T2.District GROUP BY T1.County_id HAVING COUNT(*)  >=  2
SELECT Party FROM party GROUP BY Party HAVING COUNT(*)  >=  2
SELECT Party FROM party GROUP BY Party HAVING COUNT(*)  >=  2
SELECT T2.Party FROM election AS T1 JOIN party AS T2 ON T1.Party  =  T2.Party_ID GROUP BY T1.Party ORDER BY COUNT(*) DESC LIMIT 1
SELECT T2.Party FROM election AS T1 JOIN party AS T2 ON T1.Party  =  T2.Party_ID GROUP BY T1.Party ORDER BY COUNT(*) DESC LIMIT 1
SELECT Governor FROM party GROUP BY Governor ORDER BY COUNT(*) DESC LIMIT 1
SELECT Governor FROM party GROUP BY Governor ORDER BY COUNT(*) DESC LIMIT 1
SELECT Comptroller ,  COUNT(*) FROM party GROUP BY Comptroller ORDER BY COUNT(*) DESC LIMIT 1
SELECT Comptroller ,  COUNT(*) FROM party GROUP BY Comptroller ORDER BY COUNT(*) DESC LIMIT 1
SELECT count(*) FROM journalist
SELECT Name FROM journalist ORDER BY Years_working ASC
SELECT Nationality ,  Age FROM journalist
SELECT Name FROM journalist WHERE Nationality  =  "England" OR Nationality  =  "Wales"
SELECT Nationality FROM journalist ORDER BY Years_working DESC LIMIT 1
SELECT Nationality ,  COUNT(*) FROM journalist GROUP BY Nationality
SELECT Nationality FROM journalist GROUP BY Nationality ORDER BY COUNT(*) DESC LIMIT 1
SELECT Date ,  Name ,  venue FROM event ORDER BY Event_Attendance DESC
SELECT T3.Name ,  T2.Date FROM news_report AS T1 JOIN event AS T2 ON T1.Event_ID  =  T2.Event_ID JOIN journalist AS T3 ON T1.journalist_ID  =  T3.journalist_ID
SELECT T3.Name ,  T2.Name FROM news_report AS T1 JOIN event AS T2 ON T1.Event_ID  =  T2.Event_ID JOIN journalist AS T3 ON T1.journalist_ID  =  T3.journalist_ID ORDER BY T2.Event_Attendance ASC
SELECT T3.Name FROM news_report AS T1 JOIN event AS T2 ON T1.Event_ID  =  T2.Event_ID JOIN journalist AS T3 ON T1.journalist_ID  =  T3.journalist_ID GROUP BY T3.Name HAVING COUNT(*)  >  1
SELECT Name FROM journalist WHERE journalist_ID NOT IN (SELECT journalist_ID FROM news_report)
SELECT avg(Event_Attendance) ,  max(Event_Attendance) FROM event
SELECT venue ,  name FROM event ORDER BY Event_Attendance DESC LIMIT 2
SELECT ResName FROM Restaurant;
SELECT Address FROM Restaurant WHERE ResName = "Subway";
SELECT Rating FROM Restaurant WHERE ResName = "Subway";
SELECT ResTypeName FROM Restaurant_Type;
SELECT ResTypeDescription FROM Restaurant_Type WHERE ResTypeName = "Sandwich";
SELECT ResName , Rating FROM Restaurant ORDER BY Rating DESC LIMIT 1;
SELECT Age FROM Student WHERE Fname = "Linda" AND Lname = "Smith";
SELECT Sex FROM Student WHERE Fname = "Linda" AND Lname = "Smith";
SELECT Fname , Lname FROM Student WHERE Major  =  600;
SELECT city_code FROM Student WHERE Fname = "Linda" AND Lname = "Smith";
SELECT count(*) FROM Student WHERE Advisor =  1121;
SELECT Fname , Lname FROM Student WHERE Age  >  18 AND Major = 600;
SELECT Fname , Lname FROM Student WHERE Age  >  18 AND Major != 600 AND Sex = 'F';
SELECT actual_order_id FROM actual_orders WHERE order_status_code  =  'Success'
SELECT count(*) FROM customers
SELECT truck_details FROM trucks ORDER BY truck_licence_number
SELECT product_name FROM products ORDER BY product_price DESC LIMIT 1
SELECT customer_email ,  customer_name FROM customers WHERE payment_method  =  'Visa'
SELECT state_province_county FROM addresses WHERE address_id NOT IN (SELECT employee_address_id FROM Employees)
SELECT customer_name ,  customer_phone ,  customer_email FROM Customers ORDER BY date_became_customer
SELECT customer_name FROM Customers ORDER BY date_became_customer LIMIT 5
SELECT payment_method FROM Customers GROUP BY payment_method ORDER BY count(*) DESC LIMIT 1
SELECT route_name FROM Delivery_Routes ORDER BY route_name
SELECT count(*) FROM authors
SELECT count(*) FROM authors
SELECT count(*) FROM inst
SELECT count(*) FROM inst
SELECT count(*) FROM papers
SELECT count(*) FROM papers
SELECT title FROM papers WHERE title LIKE "%ML%"
SELECT title FROM papers WHERE title LIKE "%ML%"
SELECT title FROM papers WHERE title LIKE "%Database%"
SELECT title FROM papers WHERE title LIKE "%Database%"
SELECT fname FROM authors WHERE lname  =  "Ueno"
SELECT fname FROM authors WHERE lname  =  "Ueno"
SELECT lname FROM authors WHERE fname  =  "Amal"
SELECT lname FROM authors WHERE fname  =  "Amal"
SELECT fname FROM authors ORDER BY fname
SELECT fname FROM authors ORDER BY fname
SELECT lname FROM authors ORDER BY lname
SELECT lname FROM authors ORDER BY lname
SELECT fname ,  lname FROM authors ORDER BY lname
SELECT fname ,  lname FROM authors ORDER BY lname
SELECT first_name FROM actor GROUP BY first_name ORDER BY count(*) DESC LIMIT 1
SELECT first_name FROM actor GROUP BY first_name ORDER BY count(*) DESC LIMIT 1
SELECT district FROM address GROUP BY district HAVING count(*)  >=  2
SELECT district FROM address GROUP BY district HAVING count(*)  >=  2
SELECT phone ,  postal_code FROM address WHERE address  =  '1031 Daugavpils Parkway'
SELECT phone ,  postal_code FROM address WHERE address  =  '1031 Daugavpils Parkway'
SELECT T2.city ,  count(*) ,  T1.city_id FROM address AS T1 JOIN city AS T2 ON T1.city_id  =  T2.city_id GROUP BY T1.city_id ORDER BY count(*) DESC LIMIT 1
SELECT T2.city ,  count(*) ,  T1.city_id FROM address AS T1 JOIN city AS T2 ON T1.city_id  =  T2.city_id GROUP BY T1.city_id ORDER BY count(*) DESC LIMIT 1
SELECT T2.country FROM city AS T1 JOIN country AS T2 ON T1.country_id  =  T2.country_id GROUP BY T2.country_id HAVING count(*)  >=  3
SELECT T2.country FROM city AS T1 JOIN country AS T2 ON T1.country_id  =  T2.country_id GROUP BY T2.country_id HAVING count(*)  >=  3
SELECT payment_date FROM payment WHERE amount  >  10 UNION SELECT T1.payment_date FROM payment AS T1 JOIN staff AS T2 ON T1.staff_id  =  T2.staff_id WHERE T2.first_name  =  'Elsa'
SELECT payment_date FROM payment WHERE amount  >  10 UNION SELECT T1.payment_date FROM payment AS T1 JOIN staff AS T2 ON T1.staff_id  =  T2.staff_id WHERE T2.first_name  =  'Elsa'
SELECT title ,  rental_rate FROM film ORDER BY rental_rate DESC LIMIT 1
SELECT title ,  rental_rate FROM film ORDER BY rental_rate DESC LIMIT 1
SELECT T2.title ,  T2.film_id ,  T2.description FROM film_actor AS T1 JOIN film AS T2 ON T1.film_id  =  T2.film_id GROUP BY T2.film_id ORDER BY count(*) DESC LIMIT 1
SELECT T2.title ,  T2.film_id ,  T2.description FROM film_actor AS T1 JOIN film AS T2 ON T1.film_id  =  T2.film_id GROUP BY T2.film_id ORDER BY count(*) DESC LIMIT 1
SELECT T2.first_name ,  T2.last_name ,  T2.actor_id FROM film_actor AS T1 JOIN actor AS T2 ON T1.actor_id  =  T2.actor_id GROUP BY T2.actor_id ORDER BY count(*) DESC LIMIT 1
SELECT T2.first_name ,  T2.last_name ,  T2.actor_id FROM film_actor AS T1 JOIN actor AS T2 ON T1.actor_id  =  T2.actor_id GROUP BY T2.actor_id ORDER BY count(*) DESC LIMIT 1
SELECT T2.first_name ,  T2.last_name FROM film_actor AS T1 JOIN actor AS T2 ON T1.actor_id  =  T2.actor_id GROUP BY T2.actor_id HAVING count(*)  >  30
SELECT T2.first_name ,  T2.last_name FROM film_actor AS T1 JOIN actor AS T2 ON T1.actor_id  =  T2.actor_id GROUP BY T2.actor_id HAVING count(*)  >  30
SELECT store_id FROM inventory GROUP BY store_id ORDER BY count(*) DESC LIMIT 1
SELECT store_id FROM inventory GROUP BY store_id ORDER BY count(*) DESC LIMIT 1
SELECT T1.name FROM category AS T1 JOIN film_category AS T2 ON T1.category_id  =  T2.category_id JOIN film AS T3 ON T2.film_id  =  T3.film_id WHERE T3.title  =  'HUNGER ROOF'
SELECT T1.name FROM category AS T1 JOIN film_category AS T2 ON T1.category_id  =  T2.category_id JOIN film AS T3 ON T2.film_id  =  T3.film_id WHERE T3.title  =  'HUNGER ROOF'
SELECT T2.name ,  T1.category_id ,  count(*) FROM film_category AS T1 JOIN category AS T2 ON T1.category_id  =  T2.category_id GROUP BY T1.category_id
SELECT T2.name ,  T1.category_id ,  count(*) FROM film_category AS T1 JOIN category AS T2 ON T1.category_id  =  T2.category_id GROUP BY T1.category_id
SELECT T1.title ,  T1.film_id FROM film AS T1 JOIN inventory AS T2 ON T1.film_id  =  T2.film_id GROUP BY T1.film_id ORDER BY count(*) DESC LIMIT 1
SELECT T1.title ,  T1.film_id FROM film AS T1 JOIN inventory AS T2 ON T1.film_id  =  T2.film_id GROUP BY T1.film_id ORDER BY count(*) DESC LIMIT 1
SELECT T1.title ,  T2.inventory_id FROM film AS T1 JOIN inventory AS T2 ON T1.film_id  =  T2.film_id JOIN rental AS T3 ON T2.inventory_id  =  T3.inventory_id GROUP BY T2.inventory_id ORDER BY count(*) DESC LIMIT 1
SELECT T1.title ,  T2.inventory_id FROM film AS T1 JOIN inventory AS T2 ON T1.film_id  =  T2.film_id JOIN rental AS T3 ON T2.inventory_id  =  T3.inventory_id GROUP BY T2.inventory_id ORDER BY count(*) DESC LIMIT 1
SELECT title FROM film WHERE rating  =  'R'
SELECT title FROM film WHERE rating  =  'R'
SELECT T2.address FROM store AS T1 JOIN address AS T2 ON T1.address_id  =  T2.address_id WHERE store_id  =  1
SELECT T2.address FROM store AS T1 JOIN address AS T2 ON T1.address_id  =  T2.address_id WHERE store_id  =  1
SELECT T1.first_name ,  T1.last_name ,  T1.staff_id FROM staff AS T1 JOIN payment AS T2 ON T1.staff_id  =  T2.staff_id GROUP BY T1.staff_id ORDER BY count(*) ASC LIMIT 1
SELECT T1.first_name ,  T1.last_name ,  T1.staff_id FROM staff AS T1 JOIN payment AS T2 ON T1.staff_id  =  T2.staff_id GROUP BY T1.staff_id ORDER BY count(*) ASC LIMIT 1
SELECT T2.name FROM film AS T1 JOIN LANGUAGE AS T2 ON T1.language_id  =  T2.language_id WHERE T1.title  =  'AIRPORT POLLOCK'
SELECT T2.name FROM film AS T1 JOIN LANGUAGE AS T2 ON T1.language_id  =  T2.language_id WHERE T1.title  =  'AIRPORT POLLOCK'
SELECT count(*) FROM store
SELECT count(*) FROM store
SELECT title FROM film WHERE special_features LIKE '%Deleted Scenes%'
SELECT title FROM film WHERE special_features LIKE '%Deleted Scenes%'
SELECT payment_date FROM payment ORDER BY payment_date ASC LIMIT 1
SELECT payment_date FROM payment ORDER BY payment_date ASC LIMIT 1
SELECT T2.address ,  T1.email FROM customer AS T1 JOIN address AS T2 ON T2.address_id  =  T1.address_id WHERE T1.first_name  =  'LINDA'
SELECT T2.address ,  T1.email FROM customer AS T1 JOIN address AS T2 ON T2.address_id  =  T1.address_id WHERE T1.first_name  =  'LINDA'
SELECT T1.first_name ,  T1.last_name FROM customer AS T1 JOIN rental AS T2 ON T1.customer_id  =  T2.customer_id ORDER BY T2.rental_date ASC LIMIT 1
SELECT T1.first_name ,  T1.last_name FROM customer AS T1 JOIN rental AS T2 ON T1.customer_id  =  T2.customer_id ORDER BY T2.rental_date ASC LIMIT 1
SELECT DISTINCT T1.first_name ,  T1.last_name FROM staff AS T1 JOIN rental AS T2 ON T1.staff_id  =  T2.staff_id JOIN customer AS T3 ON T2.customer_id  =  T3.customer_id WHERE T3.first_name  =  'APRIL' AND T3.last_name  =  'BURNS'
SELECT DISTINCT T1.first_name ,  T1.last_name FROM staff AS T1 JOIN rental AS T2 ON T1.staff_id  =  T2.staff_id JOIN customer AS T3 ON T2.customer_id  =  T3.customer_id WHERE T3.first_name  =  'APRIL' AND T3.last_name  =  'BURNS'
SELECT store_id FROM customer GROUP BY store_id ORDER BY count(*) DESC LIMIT 1
SELECT store_id FROM customer GROUP BY store_id ORDER BY count(*) DESC LIMIT 1
SELECT amount FROM payment ORDER BY amount DESC LIMIT 1
SELECT amount FROM payment ORDER BY amount DESC LIMIT 1
SELECT T2.address FROM staff AS T1 JOIN address AS T2 ON T1.address_id  =  T2.address_id WHERE T1.first_name  =  'Elsa'
SELECT T2.address FROM staff AS T1 JOIN address AS T2 ON T1.address_id  =  T2.address_id WHERE T1.first_name  =  'Elsa'
SELECT first_name FROM customer WHERE customer_id NOT IN( SELECT customer_id FROM rental WHERE rental_date  >  '2005-08-23 02:06:01' )
SELECT first_name FROM customer WHERE customer_id NOT IN( SELECT customer_id FROM rental WHERE rental_date  >  '2005-08-23 02:06:01' )
SELECT count(*) FROM bank
SELECT count(*) FROM bank
SELECT avg(no_of_customers) FROM bank WHERE state  =  'Utah'
SELECT avg(no_of_customers) FROM bank WHERE state  =  'Utah'
SELECT avg(no_of_customers) FROM bank
SELECT avg(no_of_customers) FROM bank
SELECT city ,  state FROM bank WHERE bname  =  'morningside'
SELECT city ,  state FROM bank WHERE bname  =  'morningside'
SELECT bname FROM bank WHERE state  =  'New York'
SELECT bname FROM bank WHERE state  =  'New York'
SELECT cust_name FROM customer ORDER BY acc_bal
SELECT cust_name FROM customer ORDER BY acc_bal
SELECT state ,  acc_type ,  credit_score FROM customer WHERE no_of_loans  =  0
SELECT state ,  acc_type ,  credit_score FROM customer WHERE no_of_loans  =  0
SELECT cust_name ,  acc_bal FROM customer WHERE cust_name LIKE '%a%'
SELECT cust_name ,  acc_bal FROM customer WHERE cust_name LIKE '%a%'
SELECT bname FROM bank ORDER BY no_of_customers DESC LIMIT 1
SELECT bname FROM bank ORDER BY no_of_customers DESC LIMIT 1
SELECT cust_name FROM customer ORDER BY credit_score LIMIT 1
SELECT cust_name FROM customer ORDER BY credit_score LIMIT 1
SELECT cust_name ,  acc_type ,  acc_bal FROM customer ORDER BY credit_score DESC LIMIT 1
SELECT cust_name ,  acc_type ,  acc_bal FROM customer ORDER BY credit_score DESC LIMIT 1
SELECT T1.cust_name FROM customer AS T1 JOIN loan AS T2 ON T1.cust_id  =  T2.cust_id GROUP BY T1.cust_name HAVING count(*)  >  1
SELECT T1.cust_name FROM customer AS T1 JOIN loan AS T2 ON T1.cust_id  =  T2.cust_id GROUP BY T1.cust_name HAVING count(*)  >  1
SELECT DISTINCT T1.bname FROM bank AS T1 JOIN loan AS T2 ON T1.branch_id  =  T2.branch_id
SELECT DISTINCT T1.bname FROM bank AS T1 JOIN loan AS T2 ON T1.branch_id  =  T2.branch_id
SELECT DISTINCT T1.cust_name ,  T1.credit_score FROM customer AS T1 JOIN loan AS T2 ON T1.cust_id  =  T2.cust_id
SELECT DISTINCT T1.cust_name ,  T1.credit_score FROM customer AS T1 JOIN loan AS T2 ON T1.cust_id  =  T2.cust_id
SELECT T1.cust_name FROM customer AS T1 JOIN loan AS T2 ON T1.cust_id  =  T2.cust_id WHERE amount  >  3000
SELECT T1.cust_name FROM customer AS T1 JOIN loan AS T2 ON T1.cust_id  =  T2.cust_id WHERE amount  >  3000
SELECT T1.bname ,  T1.city FROM bank AS T1 JOIN loan AS T2 ON T1.branch_id  =  T2.branch_id WHERE T2.loan_type  =  'Business'
SELECT T1.bname ,  T1.city FROM bank AS T1 JOIN loan AS T2 ON T1.branch_id  =  T2.branch_id WHERE T2.loan_type  =  'Business'
SELECT T2.bname FROM loan AS T1 JOIN bank AS T2 ON T1.branch_id  =  T2.branch_id JOIN customer AS T3 ON T1.cust_id  =  T3.cust_id WHERE T3.credit_score  <  100
SELECT T2.bname FROM loan AS T1 JOIN bank AS T2 ON T1.branch_id  =  T2.branch_id JOIN customer AS T3 ON T1.cust_id  =  T3.cust_id WHERE T3.credit_score  <  100
SELECT date_of_notes FROM Assessment_Notes
SELECT count(*) FROM ADDRESSES WHERE zip_postcode  =  "197"
SELECT DISTINCT detention_type_code FROM Detention
SELECT date_incident_start ,  date_incident_end FROM Behavior_Incident WHERE incident_type_code  =  "NOISE"
SELECT cell_mobile_number ,  email_address FROM STUDENTS
SELECT email_address FROM Students WHERE first_name  =  "Emma" AND last_name  =  "Rohan"
SELECT gender FROM TEACHERS WHERE last_name  =  "Medhurst"
SELECT incident_type_description FROM Ref_Incident_Type WHERE incident_type_code  =  "VIOLENCE"
SELECT first_name FROM Teachers WHERE email_address LIKE '%man%'
SELECT city FROM Addresses ORDER BY city
SELECT first_name ,  last_name FROM Teachers ORDER BY last_name
SELECT T1.student_id ,  T2.first_name FROM Assessment_Notes AS T1 JOIN Students AS T2 ON T1.student_id  =  T2.student_id GROUP BY T1.student_id ORDER BY count(*) DESC LIMIT 1
SELECT T1.teacher_id ,  T2.first_name FROM Assessment_Notes AS T1 JOIN Teachers AS T2 ON T1.teacher_id  =  T2.teacher_id GROUP BY T1.teacher_id ORDER BY count(*) DESC LIMIT 3
SELECT T1.student_id ,  T2.last_name FROM Behavior_Incident AS T1 JOIN Students AS T2 ON T1.student_id  =  T2.student_id GROUP BY T1.student_id ORDER BY count(*) DESC LIMIT 1
SELECT T1.teacher_id ,  T2.last_name FROM Detention AS T1 JOIN Teachers AS T2 ON T1.teacher_id  =  T2.teacher_id WHERE T1.detention_type_code  =  "AFTER" GROUP BY T1.teacher_id ORDER BY count(*) DESC LIMIT 1
SELECT T1.incident_type_code ,  T2.incident_type_description FROM Behavior_Incident AS T1 JOIN Ref_Incident_Type AS T2 ON T1.incident_type_code  =  T2.incident_type_code GROUP BY T1.incident_type_code ORDER BY count(*) DESC LIMIT 1
SELECT T1.detention_type_code ,  T2.detention_type_description FROM Detention AS T1 JOIN Ref_Detention_Type AS T2 ON T1.detention_type_code  =  T2.detention_type_code GROUP BY T1.detention_type_code ORDER BY count(*) ASC LIMIT 1
SELECT T1.date_of_notes FROM Assessment_Notes AS T1 JOIN Students AS T2 ON T1.student_id  =  T2.student_id WHERE T2.first_name  =  "Fanny"
SELECT T1.date_incident_start ,  date_incident_end FROM Behavior_Incident AS T1 JOIN Students AS T2 ON T1.student_id  =  T2.student_id WHERE T2.last_name  =  "Fahey"
SELECT T1.datetime_detention_start ,  datetime_detention_end FROM Detention AS T1 JOIN Teachers AS T2 ON T1.teacher_id  =  T2.teacher_id WHERE T2.last_name  =  "Schultz"
SELECT T2.address_id ,  T1.zip_postcode FROM Addresses AS T1 JOIN Student_Addresses AS T2 ON T1.address_id  =  T2.address_id ORDER BY monthly_rental DESC LIMIT 1
SELECT T2.cell_mobile_number FROM Student_Addresses AS T1 JOIN Students AS T2 ON T1.student_id  =  T2.student_id ORDER BY T1.monthly_rental ASC LIMIT 1
SELECT T2.monthly_rental FROM Addresses AS T1 JOIN Student_Addresses AS T2 ON T1.address_id  =  T2.address_id WHERE T1.state_province_county  =  "Texas"
SELECT T1.line_1 ,  avg(T2.monthly_rental) FROM Addresses AS T1 JOIN Student_Addresses AS T2 ON T1.address_id  =  T2.address_id GROUP BY T2.address_id
SELECT T1.zip_postcode FROM Addresses AS T1 JOIN Teachers AS T2 ON T1.address_id  =  T2.address_id WHERE T2.first_name  =  "Lyla"
SELECT T2.email_address FROM Addresses AS T1 JOIN Teachers AS T2 ON T1.address_id  =  T2.address_id WHERE T1.zip_postcode  =  "918"
SELECT count(*) ,  T1.maintenance_contract_id FROM Maintenance_Contracts AS T1 JOIN Assets AS T2 ON T1.maintenance_contract_id  =  T2.maintenance_contract_id GROUP BY T1.maintenance_contract_id
SELECT count(*) ,  T1.company_id FROM Third_Party_Companies AS T1 JOIN Assets AS T2 ON T1.company_id  =  T2.supplier_company_id GROUP BY T1.company_id
SELECT T1.company_id ,  T1.company_name FROM Third_Party_Companies AS T1 JOIN Maintenance_Engineers AS T2 ON T1.company_id  =  T2.company_id GROUP BY T1.company_id HAVING count(*)  >=  2 UNION SELECT T3.company_id ,  T3.company_name FROM Third_Party_Companies AS T3 JOIN Maintenance_Contracts AS T4 ON T3.company_id  =  T4.maintenance_contract_company_id GROUP BY T3.company_id HAVING count(*)  >=  2
SELECT T1.part_name ,  T1.part_id FROM Parts AS T1 JOIN Part_Faults AS T2 ON T1.part_id  =  T2.part_id GROUP BY T1.part_id HAVING count(*)  >  2
SELECT T1.first_name ,  T1.last_name ,  T1.other_details ,  T3.skill_description FROM Maintenance_Engineers AS T1 JOIN Engineer_Skills AS T2 ON T1.engineer_id  =  T2.engineer_id JOIN Skills AS T3 ON T2.skill_id  =  T3.skill_id
SELECT T1.fault_short_name ,  T3.skill_description FROM Part_Faults AS T1 JOIN Skills_Required_To_Fix AS T2 ON T1.part_fault_id  =  T2.part_fault_id JOIN Skills AS T3 ON T2.skill_id  =  T3.skill_id
SELECT T1.part_name ,  count(*) FROM Parts AS T1 JOIN Asset_Parts AS T2 ON T1.part_id  =  T2.part_id GROUP BY T1.part_name
SELECT T1.fault_description ,  T2.fault_status FROM Fault_Log AS T1 JOIN Fault_Log_Parts AS T2 ON T1.fault_log_entry_id  =  T2.fault_log_entry_id
SELECT count(*) ,  T1.fault_log_entry_id FROM Fault_Log AS T1 JOIN Engineer_Visits AS T2 ON T1.fault_log_entry_id  =  T2.fault_log_entry_id GROUP BY T1.fault_log_entry_id ORDER BY count(*) DESC LIMIT 1
SELECT DISTINCT last_name FROM Maintenance_Engineers
SELECT DISTINCT fault_status FROM Fault_Log_Parts
SELECT first_name ,  last_name FROM Maintenance_Engineers WHERE engineer_id NOT IN (SELECT engineer_id FROM Engineer_Visits)
SELECT asset_id ,  asset_details ,  asset_make ,  asset_model FROM Assets
SELECT asset_acquired_date FROM Assets ORDER BY asset_acquired_date ASC LIMIT 1
SELECT T1.part_id ,  T1.part_name FROM Parts AS T1 JOIN Part_Faults AS T2 ON T1.part_id  =  T2.part_id JOIN Skills_Required_To_Fix AS T3 ON T2.part_fault_id  =  T3.part_fault_id GROUP BY T1.part_id ORDER BY count(*) DESC LIMIT 1
SELECT T1.part_name FROM Parts AS T1 JOIN Part_Faults AS T2 ON T1.part_id  =  T2.part_id GROUP BY T1.part_name ORDER BY count(*) ASC LIMIT 1
SELECT T1.staff_name ,  T3.first_name ,  T3.last_name FROM Staff AS T1 JOIN Engineer_Visits AS T2 ON T1.staff_id  =  T2.contact_staff_id JOIN Maintenance_Engineers AS T3 ON T2.engineer_id  =  T3.engineer_id
SELECT T1.fault_log_entry_id ,  T1.fault_description ,  T1.fault_log_entry_datetime FROM Fault_Log AS T1 JOIN Fault_Log_Parts AS T2 ON T1.fault_log_entry_id  =  T2.fault_log_entry_id GROUP BY T1.fault_log_entry_id ORDER BY count(*) DESC LIMIT 1
SELECT T1.skill_id ,  T1.skill_description FROM Skills AS T1 JOIN Skills_Required_To_Fix AS T2 ON T1.skill_id  =  T2.skill_id GROUP BY T1.skill_id ORDER BY count(*) DESC LIMIT 1
SELECT DISTINCT asset_model FROM Assets
SELECT asset_make ,  asset_model ,  asset_details FROM Assets ORDER BY asset_disposed_date ASC
SELECT part_id ,  chargeable_amount FROM Parts ORDER BY chargeable_amount ASC LIMIT 1
SELECT T1.company_name FROM Third_Party_Companies AS T1 JOIN Maintenance_Contracts AS T2 ON T1.company_id  =  T2.maintenance_contract_company_id ORDER BY T2.contract_start_date ASC LIMIT 1
SELECT gender FROM staff GROUP BY gender ORDER BY count(*) DESC LIMIT 1
SELECT T1.staff_name ,  count(*) FROM Staff AS T1 JOIN Engineer_Visits AS T2 ON T1.staff_id  =  T2.contact_staff_id GROUP BY T1.staff_name
SELECT local_authority ,  services FROM station
SELECT train_number ,  name FROM train ORDER BY TIME
SELECT TIME ,  train_number FROM train WHERE destination  =  'Chennai' ORDER BY TIME
SELECT train_number ,  TIME FROM train WHERE origin  =  'Chennai' AND destination  =  'Guruvayur'
SELECT origin ,  count(*) FROM train GROUP BY origin
SELECT min(low_temperature) ,  max(wind_speed_mph) FROM weekly_weather
SELECT origin FROM train GROUP BY origin HAVING count(*)  >  1
SELECT T3.EMP_FNAME ,  T3.EMP_LNAME FROM professor AS T1 JOIN department AS T2 ON T1.dept_code  =  T2.dept_code JOIN employee AS T3 ON T1.EMP_NUM  =  T3.EMP_NUM WHERE DEPT_NAME  =  "Biology"
SELECT T3.EMP_FNAME ,  T3.EMP_LNAME FROM professor AS T1 JOIN department AS T2 ON T1.dept_code  =  T2.dept_code JOIN employee AS T3 ON T1.EMP_NUM  =  T3.EMP_NUM WHERE DEPT_NAME  =  "Biology"
SELECT DISTINCT T1.EMP_FNAME ,  T1.EMP_DOB FROM employee AS T1 JOIN CLASS AS T2 ON T1.EMP_NUM  =  T2.PROF_NUM WHERE CRS_CODE  =  "ACCT-211"
SELECT DISTINCT T1.EMP_FNAME ,  T1.EMP_DOB FROM employee AS T1 JOIN CLASS AS T2 ON T1.EMP_NUM  =  T2.PROF_NUM WHERE CRS_CODE  =  "ACCT-211"
SELECT school_code FROM department WHERE dept_name  =  "Accounting"
SELECT school_code FROM department WHERE dept_name  =  "Accounting"
SELECT crs_credit ,  crs_description FROM course WHERE crs_code  =  'CIS-220'
SELECT crs_credit ,  crs_description FROM course WHERE crs_code  =  'CIS-220'
SELECT dept_address FROM department WHERE dept_name  =  'History'
SELECT dept_address FROM department WHERE dept_name  =  'History'
SELECT crs_credit ,  crs_description FROM course WHERE crs_code  =  'QM-261'
SELECT crs_credit ,  crs_description FROM course WHERE crs_code  =  'QM-261'
SELECT count(*) ,  crs_code FROM CLASS GROUP BY crs_code
SELECT count(*) ,  crs_code FROM CLASS GROUP BY crs_code
SELECT count(*) ,  class_room FROM CLASS GROUP BY class_room HAVING count(*)  >=  2
SELECT count(*) ,  class_room FROM CLASS GROUP BY class_room HAVING count(*)  >=  2
SELECT count(*) ,  dept_code FROM CLASS AS T1 JOIN course AS T2 ON T1.crs_code  =  T2.crs_code GROUP BY dept_code
SELECT count(*) ,  dept_code FROM CLASS AS T1 JOIN course AS T2 ON T1.crs_code  =  T2.crs_code GROUP BY dept_code
SELECT count(*) ,  T3.school_code FROM CLASS AS T1 JOIN course AS T2 ON T1.crs_code  =  T2.crs_code JOIN department AS T3 ON T2.dept_code  =  T3.dept_code GROUP BY T3.school_code
SELECT count(*) ,  T3.school_code FROM CLASS AS T1 JOIN course AS T2 ON T1.crs_code  =  T2.crs_code JOIN department AS T3 ON T2.dept_code  =  T3.dept_code GROUP BY T3.school_code
SELECT count(*) ,  T1.school_code FROM department AS T1 JOIN professor AS T2 ON T1.dept_code  =  T2.dept_code GROUP BY T1.school_code
SELECT count(*) ,  T1.school_code FROM department AS T1 JOIN professor AS T2 ON T1.dept_code  =  T2.dept_code GROUP BY T1.school_code
SELECT emp_jobcode ,  count(*) FROM employee GROUP BY emp_jobcode ORDER BY count(*) DESC LIMIT 1
SELECT emp_jobcode ,  count(*) FROM employee GROUP BY emp_jobcode ORDER BY count(*) DESC LIMIT 1
SELECT T1.school_code FROM department AS T1 JOIN professor AS T2 ON T1.dept_code  =  T2.dept_code GROUP BY T1.school_code ORDER BY count(*) LIMIT 1
SELECT T1.school_code FROM department AS T1 JOIN professor AS T2 ON T1.dept_code  =  T2.dept_code GROUP BY T1.school_code ORDER BY count(*) LIMIT 1
SELECT count(*) ,  dept_code FROM student GROUP BY dept_code
SELECT count(*) ,  dept_code FROM student GROUP BY dept_code
SELECT T3.stu_fname FROM CLASS AS T1 JOIN enroll AS T2 ON T1.class_code  =  T2.class_code JOIN student AS T3 ON T2.stu_num  =  T3.stu_num WHERE T1.crs_code  =  'ACCT-211'
SELECT T3.stu_fname FROM CLASS AS T1 JOIN enroll AS T2 ON T1.class_code  =  T2.class_code JOIN student AS T3 ON T2.stu_num  =  T3.stu_num WHERE T1.crs_code  =  'ACCT-211'
SELECT T3.stu_fname FROM CLASS AS T1 JOIN enroll AS T2 ON T1.class_code  =  T2.class_code JOIN student AS T3 ON T2.stu_num  =  T3.stu_num WHERE T1.crs_code  =  'ACCT-211' AND T2.enroll_grade  =  'C'
SELECT T3.stu_fname FROM CLASS AS T1 JOIN enroll AS T2 ON T1.class_code  =  T2.class_code JOIN student AS T3 ON T2.stu_num  =  T3.stu_num WHERE T1.crs_code  =  'ACCT-211' AND T2.enroll_grade  =  'C'
SELECT count(*) FROM employee
SELECT count(*) FROM employee
SELECT T4.dept_name FROM CLASS AS T1 JOIN enroll AS T2 ON T1.class_code  =  T2.class_code JOIN course AS T3 ON T1.crs_code  =  T3.crs_code JOIN department AS T4 ON T3.dept_code  =  T4.dept_code GROUP BY T3.dept_code ORDER BY count(*) DESC LIMIT 1
SELECT T4.dept_name FROM CLASS AS T1 JOIN enroll AS T2 ON T1.class_code  =  T2.class_code JOIN course AS T3 ON T1.crs_code  =  T3.crs_code JOIN department AS T4 ON T3.dept_code  =  T4.dept_code GROUP BY T3.dept_code ORDER BY count(*) DESC LIMIT 1
SELECT dept_name FROM department ORDER BY dept_name
SELECT dept_name FROM department ORDER BY dept_name
SELECT class_code FROM CLASS WHERE class_room  =  'KLR209'
SELECT class_code FROM CLASS WHERE class_room  =  'KLR209'
SELECT emp_fname FROM employee WHERE emp_jobcode  =  'PROF' ORDER BY emp_dob
SELECT emp_fname FROM employee WHERE emp_jobcode  =  'PROF' ORDER BY emp_dob
SELECT T2.emp_fname ,  T1.prof_office FROM professor AS T1 JOIN employee AS T2 ON T1.emp_num  =  T2.emp_num ORDER BY T2.emp_fname
SELECT T2.emp_fname ,  T1.prof_office FROM professor AS T1 JOIN employee AS T2 ON T1.emp_num  =  T2.emp_num ORDER BY T2.emp_fname
SELECT emp_fname ,  emp_lname FROM employee ORDER BY emp_dob LIMIT 1
SELECT emp_fname ,  emp_lname FROM employee ORDER BY emp_dob LIMIT 1
SELECT stu_fname ,  stu_lname ,  stu_gpa FROM student WHERE stu_gpa  >  3 ORDER BY stu_dob DESC LIMIT 1
SELECT stu_fname ,  stu_lname ,  stu_gpa FROM student WHERE stu_gpa  >  3 ORDER BY stu_dob DESC LIMIT 1
SELECT DISTINCT stu_fname FROM student AS T1 JOIN enroll AS T2 ON T1.stu_num  =  T2.stu_num WHERE enroll_grade  =  'C'
SELECT DISTINCT stu_fname FROM student AS T1 JOIN enroll AS T2 ON T1.stu_num  =  T2.stu_num WHERE enroll_grade  =  'C'
SELECT T2.dept_name FROM professor AS T1 JOIN department AS T2 ON T1.dept_code  =  T2.dept_code GROUP BY T1.dept_code ORDER BY count(*) LIMIT 1
SELECT T2.dept_name FROM professor AS T1 JOIN department AS T2 ON T1.dept_code  =  T2.dept_code GROUP BY T1.dept_code ORDER BY count(*) LIMIT 1
SELECT T1.emp_lname ,  T2.prof_office FROM employee AS T1 JOIN professor AS T2 ON T1.emp_num  =  T2.emp_num JOIN department AS T3 ON T2.dept_code  =  T3.dept_code WHERE T3.dept_name  =  'History'
SELECT T1.emp_lname ,  T2.prof_office FROM employee AS T1 JOIN professor AS T2 ON T1.emp_num  =  T2.emp_num JOIN department AS T3 ON T2.dept_code  =  T3.dept_code WHERE T3.dept_name  =  'History'
SELECT T3.dept_name  ,  T2.prof_office FROM employee AS T1 JOIN professor AS T2 ON T1.emp_num  =  T2.emp_num JOIN department AS T3 ON T2.dept_code  =  T3.dept_code WHERE T1.emp_lname  =  'Heffington'
SELECT T3.dept_name  ,  T2.prof_office FROM employee AS T1 JOIN professor AS T2 ON T1.emp_num  =  T2.emp_num JOIN department AS T3 ON T2.dept_code  =  T3.dept_code WHERE T1.emp_lname  =  'Heffington'
SELECT T1.emp_lname ,  T1.emp_hiredate FROM employee AS T1 JOIN professor AS T2 ON T1.emp_num  =  T2.emp_num WHERE T2.prof_office  =  'DRE 102'
SELECT T1.emp_lname ,  T1.emp_hiredate FROM employee AS T1 JOIN professor AS T2 ON T1.emp_num  =  T2.emp_num WHERE T2.prof_office  =  'DRE 102'
SELECT T1.crs_code FROM CLASS AS T1 JOIN enroll AS T2 ON T1.class_code  =  T2.class_code JOIN student AS T3 ON T3.stu_num  =  T2.stu_num WHERE T3.stu_lname  =  'Smithson'
SELECT T1.crs_code FROM CLASS AS T1 JOIN enroll AS T2 ON T1.class_code  =  T2.class_code JOIN student AS T3 ON T3.stu_num  =  T2.stu_num WHERE T3.stu_lname  =  'Smithson'
SELECT T4.crs_description ,  T4.crs_credit FROM CLASS AS T1 JOIN enroll AS T2 ON T1.class_code  =  T2.class_code JOIN student AS T3 ON T3.stu_num  =  T2.stu_num JOIN course AS T4 ON T4.crs_code  =  T1.crs_code WHERE T3.stu_lname  =  'Smithson'
SELECT T4.crs_description ,  T4.crs_credit FROM CLASS AS T1 JOIN enroll AS T2 ON T1.class_code  =  T2.class_code JOIN student AS T3 ON T3.stu_num  =  T2.stu_num JOIN course AS T4 ON T4.crs_code  =  T1.crs_code WHERE T3.stu_lname  =  'Smithson'
SELECT stu_gpa ,  stu_phone ,  stu_fname FROM student ORDER BY stu_gpa DESC LIMIT 5
SELECT stu_gpa ,  stu_phone ,  stu_fname FROM student ORDER BY stu_gpa DESC LIMIT 5
SELECT T2.dept_name FROM student AS T1 JOIN department AS T2 ON T1.dept_code  =  T2.dept_code ORDER BY stu_gpa LIMIT 1
SELECT T2.dept_name FROM student AS T1 JOIN department AS T2 ON T1.dept_code  =  T2.dept_code ORDER BY stu_gpa LIMIT 1
SELECT T2.dept_name ,  T2.dept_address FROM student AS T1 JOIN department AS T2 ON T1.dept_code  =  T2.dept_code GROUP BY T1.dept_code ORDER BY count(*) DESC LIMIT 1
SELECT T2.dept_name ,  T2.dept_address FROM student AS T1 JOIN department AS T2 ON T1.dept_code  =  T2.dept_code GROUP BY T1.dept_code ORDER BY count(*) DESC LIMIT 1
SELECT T2.dept_name ,  T2.dept_address ,  count(*) FROM student AS T1 JOIN department AS T2 ON T1.dept_code  =  T2.dept_code GROUP BY T1.dept_code ORDER BY count(*) DESC LIMIT 3
SELECT T2.dept_name ,  T2.dept_address ,  count(*) FROM student AS T1 JOIN department AS T2 ON T1.dept_code  =  T2.dept_code GROUP BY T1.dept_code ORDER BY count(*) DESC LIMIT 3
SELECT T2.emp_fname ,  T1.crs_code FROM CLASS AS T1 JOIN employee AS T2 ON T1.prof_num  =  T2.emp_num
SELECT T2.emp_fname ,  T1.crs_code FROM CLASS AS T1 JOIN employee AS T2 ON T1.prof_num  =  T2.emp_num
SELECT T2.emp_fname ,  T3.crs_description FROM CLASS AS T1 JOIN employee AS T2 ON T1.prof_num  =  T2.emp_num JOIN course AS T3 ON T1.crs_code  =  T3.crs_code
SELECT T2.emp_fname ,  T3.crs_description FROM CLASS AS T1 JOIN employee AS T2 ON T1.prof_num  =  T2.emp_num JOIN course AS T3 ON T1.crs_code  =  T3.crs_code
SELECT T2.emp_fname ,  T4.prof_office ,  T3.crs_description FROM CLASS AS T1 JOIN employee AS T2 ON T1.prof_num  =  T2.emp_num JOIN course AS T3 ON T1.crs_code  =  T3.crs_code JOIN professor AS T4 ON T2.emp_num  =  T4.emp_num
SELECT T2.emp_fname ,  T4.prof_office ,  T3.crs_description FROM CLASS AS T1 JOIN employee AS T2 ON T1.prof_num  =  T2.emp_num JOIN course AS T3 ON T1.crs_code  =  T3.crs_code JOIN professor AS T4 ON T2.emp_num  =  T4.emp_num
SELECT T2.emp_fname ,  T4.prof_office ,  T3.crs_description ,  T5.dept_name FROM CLASS AS T1 JOIN employee AS T2 ON T1.prof_num  =  T2.emp_num JOIN course AS T3 ON T1.crs_code  =  T3.crs_code JOIN professor AS T4 ON T2.emp_num  =  T4.emp_num JOIN department AS T5 ON T4.dept_code  =  T5.dept_code
SELECT T2.emp_fname ,  T4.prof_office ,  T3.crs_description ,  T5.dept_name FROM CLASS AS T1 JOIN employee AS T2 ON T1.prof_num  =  T2.emp_num JOIN course AS T3 ON T1.crs_code  =  T3.crs_code JOIN professor AS T4 ON T2.emp_num  =  T4.emp_num JOIN department AS T5 ON T4.dept_code  =  T5.dept_code
SELECT T1.stu_fname ,  T1.stu_lname ,  T4.crs_description FROM student AS T1 JOIN enroll AS T2 ON T1.stu_num  =  T2.stu_num JOIN CLASS AS T3 ON T2.class_code  =  T3.class_code JOIN course AS T4 ON T3.crs_code  =  T4.crs_code
SELECT T1.stu_fname ,  T1.stu_lname ,  T4.crs_description FROM student AS T1 JOIN enroll AS T2 ON T1.stu_num  =  T2.stu_num JOIN CLASS AS T3 ON T2.class_code  =  T3.class_code JOIN course AS T4 ON T3.crs_code  =  T4.crs_code
SELECT T1.stu_fname ,  T1.stu_lname FROM student AS T1 JOIN enroll AS T2 ON T1.stu_num  =  T2.stu_num WHERE T2.enroll_grade  =  'C' OR T2.enroll_grade  =  'A'
SELECT T1.stu_fname ,  T1.stu_lname FROM student AS T1 JOIN enroll AS T2 ON T1.stu_num  =  T2.stu_num WHERE T2.enroll_grade  =  'C' OR T2.enroll_grade  =  'A'
SELECT T2.emp_fname ,  T1.class_room FROM CLASS AS T1 JOIN employee AS T2 ON T1.prof_num  =  T2.emp_num JOIN professor AS T3 ON T2.emp_num  =  T3.emp_num JOIN department AS T4 ON T4.dept_code  =  T3.dept_code WHERE T4.dept_name  =  'Accounting'
SELECT T2.emp_fname ,  T1.class_room FROM CLASS AS T1 JOIN employee AS T2 ON T1.prof_num  =  T2.emp_num JOIN professor AS T3 ON T2.emp_num  =  T3.emp_num JOIN department AS T4 ON T4.dept_code  =  T3.dept_code WHERE T4.dept_name  =  'Accounting'
SELECT T1.stu_lname FROM student AS T1 JOIN enroll AS T2 ON T1.stu_num  =  T2.stu_num WHERE T2.enroll_grade  =  'A' AND T2.class_code  =  10018
SELECT T1.stu_lname FROM student AS T1 JOIN enroll AS T2 ON T1.stu_num  =  T2.stu_num WHERE T2.enroll_grade  =  'A' AND T2.class_code  =  10018
SELECT T2.emp_fname FROM CLASS AS T1 JOIN employee AS T2 ON T1.prof_num  =  T2.emp_num GROUP BY T1.prof_num HAVING count(*)  >  1
SELECT T2.emp_fname FROM CLASS AS T1 JOIN employee AS T2 ON T1.prof_num  =  T2.emp_num GROUP BY T1.prof_num HAVING count(*)  >  1
SELECT T1.stu_fname FROM student AS T1 JOIN enroll AS T2 ON T1.stu_num  =  T2.stu_num GROUP BY T2.stu_num HAVING count(*)  =  1
SELECT T1.stu_fname FROM student AS T1 JOIN enroll AS T2 ON T1.stu_num  =  T2.stu_num GROUP BY T2.stu_num HAVING count(*)  =  1
SELECT count(*) FROM club
SELECT count(*) FROM club
SELECT DISTINCT Region FROM club ORDER BY Region ASC
SELECT DISTINCT Region FROM club ORDER BY Region ASC
SELECT avg(Gold) FROM club_rank
SELECT avg(Gold) FROM club_rank
SELECT Competition_type ,  Country FROM competition
SELECT Competition_type ,  Country FROM competition
SELECT DISTINCT YEAR FROM competition WHERE Competition_type != "Tournament"
SELECT DISTINCT YEAR FROM competition WHERE Competition_type != "Tournament"
SELECT max(Silver) ,  min(Silver) FROM club_rank
SELECT max(Silver) ,  min(Silver) FROM club_rank
SELECT count(*) FROM club_rank WHERE Total  <  10
SELECT count(*) FROM club_rank WHERE Total  <  10
SELECT name FROM club ORDER BY Start_year ASC
SELECT name FROM club ORDER BY Start_year ASC
SELECT name FROM club ORDER BY name DESC
SELECT name FROM club ORDER BY name DESC
SELECT T1.name ,  T2.Player_id FROM club AS T1 JOIN player AS T2 ON T1.Club_ID  =  T2.Club_ID
SELECT T1.name ,  T2.Player_id FROM club AS T1 JOIN player AS T2 ON T1.Club_ID  =  T2.Club_ID
SELECT T1.name FROM club AS T1 JOIN player AS T2 ON T1.Club_ID  =  T2.Club_ID WHERE T2.Position  =  "Right Wing"
SELECT T1.name FROM club AS T1 JOIN player AS T2 ON T1.Club_ID  =  T2.Club_ID WHERE T2.Position  =  "Right Wing"
SELECT avg(T2.Points) FROM club AS T1 JOIN player AS T2 ON T1.Club_ID  =  T2.Club_ID WHERE T1.name  =  "AIB"
SELECT avg(T2.Points) FROM club AS T1 JOIN player AS T2 ON T1.Club_ID  =  T2.Club_ID WHERE T1.name  =  "AIB"
SELECT Competition_type ,  COUNT(*) FROM competition GROUP BY Competition_type
SELECT Competition_type ,  COUNT(*) FROM competition GROUP BY Competition_type
SELECT Competition_type FROM competition GROUP BY Competition_type ORDER BY COUNT(*) DESC LIMIT 1
SELECT Competition_type FROM competition GROUP BY Competition_type ORDER BY COUNT(*) DESC LIMIT 1
SELECT Competition_type FROM competition GROUP BY Competition_type HAVING COUNT(*)  <=  5
SELECT Competition_type FROM competition GROUP BY Competition_type HAVING COUNT(*)  <=  5
SELECT name FROM CLub WHERE Club_ID NOT IN (SELECT Club_ID FROM player)
SELECT name FROM CLub WHERE Club_ID NOT IN (SELECT Club_ID FROM player)
SELECT count(*) ,  POSITION FROM player WHERE points  <  30 GROUP BY POSITION
SELECT count(*) ,  POSITION FROM player WHERE points  <  30 GROUP BY POSITION
SELECT country FROM competition WHERE competition_type  =  'Tournament' GROUP BY country ORDER BY count(*) DESC LIMIT 1
SELECT country FROM competition WHERE competition_type  =  'Tournament' GROUP BY country ORDER BY count(*) DESC LIMIT 1
SELECT name ,  furniture_id FROM furniture ORDER BY market_rate DESC LIMIT 1
SELECT Num_of_Component ,  name FROM furniture WHERE Num_of_Component  >  10
SELECT name ,  Num_of_Component FROM furniture ORDER BY market_rate LIMIT 1
SELECT open_year ,  name FROM manufacturer ORDER BY num_of_shops DESC LIMIT 1
SELECT avg(Num_of_Factories) FROM manufacturer WHERE num_of_shops  >  20
SELECT name ,  manufacturer_id FROM manufacturer ORDER BY open_year
SELECT name ,  open_year FROM manufacturer WHERE num_of_shops  >  10 OR Num_of_Factories  <  10
SELECT max(num_of_shops) ,  avg(Num_of_Factories) FROM manufacturer WHERE open_year  <  1990
SELECT Market_Rate ,  name FROM furniture WHERE Furniture_ID NOT IN (SELECT Furniture_ID FROM furniture_manufacte)
SELECT T1.first_name ,  T2.department_name FROM employees AS T1 JOIN departments AS T2 ON T1.department_id  =  T2.department_id
SELECT T1.first_name ,  T2.department_name FROM employees AS T1 JOIN departments AS T2 ON T1.department_id  =  T2.department_id
SELECT first_name ,  last_name ,  salary FROM employees WHERE salary  <  6000
SELECT first_name ,  last_name ,  salary FROM employees WHERE salary  <  6000
SELECT first_name ,  department_id FROM employees WHERE last_name  =  'McEwen'
SELECT first_name ,  department_id FROM employees WHERE last_name  =  'McEwen'
SELECT phone_number FROM employees WHERE salary BETWEEN 8000 AND 12000
SELECT phone_number FROM employees WHERE salary BETWEEN 8000 AND 12000
SELECT first_name ,  last_name ,  salary FROM  employees WHERE commission_pct  =  "null"
SELECT first_name ,  last_name ,  salary FROM  employees WHERE commission_pct  =  "null"
SELECT job_id ,  hire_date FROM employees WHERE hire_date BETWEEN '2007-11-05' AND '2009-07-05'
SELECT job_id ,  hire_date FROM employees WHERE hire_date BETWEEN '2007-11-05' AND '2009-07-05'
SELECT first_name ,  last_name FROM employees WHERE department_id  =  70 OR department_id  =  90
SELECT first_name ,  last_name FROM employees WHERE department_id  =  70 OR department_id  =  90
SELECT salary ,  manager_id FROM employees WHERE manager_id != "null"
SELECT salary ,  manager_id FROM employees WHERE manager_id != "null"
SELECT job_title FROM jobs WHERE min_salary  >  9000
SELECT job_title FROM jobs WHERE min_salary  >  9000
SELECT country_id ,  COUNT(*) FROM locations GROUP BY country_id
SELECT country_id ,  COUNT(*) FROM locations GROUP BY country_id
SELECT employee_id FROM job_history GROUP BY employee_id HAVING COUNT(*)  >= 2
SELECT employee_id FROM job_history GROUP BY employee_id HAVING COUNT(*)  >= 2
SELECT T1.employee_id ,  T4.country_name FROM employees AS T1 JOIN departments AS T2 ON T1.department_id  =  T2.department_id JOIN locations AS T3 ON T2.location_id  =  T3.location_id JOIN countries AS T4 ON T3.country_id  =  T4.country_id
SELECT T1.employee_id ,  T4.country_name FROM employees AS T1 JOIN departments AS T2 ON T1.department_id  =  T2.department_id JOIN locations AS T3 ON T2.location_id  =  T3.location_id JOIN countries AS T4 ON T3.country_id  =  T4.country_id
SELECT T2.department_name ,  COUNT(*) FROM employees AS T1 JOIN departments AS T2 ON T1.department_id  =  T2.department_id GROUP BY T2.department_name
SELECT T2.department_name ,  COUNT(*) FROM employees AS T1 JOIN departments AS T2 ON T1.department_id  =  T2.department_id GROUP BY T2.department_name
SELECT job_title ,  AVG(salary) FROM employees AS T1 JOIN jobs AS T2 ON T1.job_id  =  T2.job_id GROUP BY T2.job_title
SELECT job_title ,  AVG(salary) FROM employees AS T1 JOIN jobs AS T2 ON T1.job_id  =  T2.job_id GROUP BY T2.job_title
SELECT DISTINCT T2.department_name FROM employees AS T1 JOIN departments AS T2 ON T1.department_id  =  T2.department_id
SELECT DISTINCT T2.department_name FROM employees AS T1 JOIN departments AS T2 ON T1.department_id  =  T2.department_id
SELECT employee_id FROM job_history GROUP BY employee_id HAVING COUNT(*)  >= 2
SELECT employee_id FROM job_history GROUP BY employee_id HAVING COUNT(*)  >= 2
SELECT T1.employee_id ,  T2.job_title FROM employees AS T1 JOIN jobs AS T2 ON T1.job_id  =  T2.job_id WHERE T1.department_id = 80
SELECT T1.employee_id ,  T2.job_title FROM employees AS T1 JOIN jobs AS T2 ON T1.job_id  =  T2.job_id WHERE T1.department_id = 80
SELECT T1.first_name ,  T1.job_id FROM employees AS T1 JOIN departments AS T2 ON T1.department_id  =  T2.department_id WHERE T2.department_name  =  'Finance'
SELECT T1.first_name ,  T1.job_id FROM employees AS T1 JOIN departments AS T2 ON T1.department_id  =  T2.department_id WHERE T2.department_name  =  'Finance'
SELECT T1.first_name ,  T1.last_name ,  T2.department_name ,  T3.city ,  T3.state_province FROM employees AS T1 JOIN departments AS T2 ON T1.department_id  =  T2.department_id JOIN locations AS T3 ON T2.location_id  =  T3.location_id
SELECT T1.first_name ,  T1.last_name ,  T2.department_name ,  T3.city ,  T3.state_province FROM employees AS T1 JOIN departments AS T2 ON T1.department_id  =  T2.department_id JOIN locations AS T3 ON T2.location_id  =  T3.location_id
SELECT T1.department_name ,  T2.city ,  T2.state_province FROM departments AS T1 JOIN locations AS T2 ON T2.location_id  =  T1.location_id
SELECT T1.department_name ,  T2.city ,  T2.state_province FROM departments AS T1 JOIN locations AS T2 ON T2.location_id  =  T1.location_id
SELECT T1.first_name ,  T1.last_name , T1.employee_id ,  T4.country_name FROM employees AS T1 JOIN departments AS T2 ON T1.department_id  =  T2.department_id JOIN locations AS T3 ON T2.location_id  =  T3.location_id JOIN countries AS T4 ON T3.country_id  =  T4.country_id
SELECT T1.first_name ,  T1.last_name , T1.employee_id ,  T4.country_name FROM employees AS T1 JOIN departments AS T2 ON T1.department_id  =  T2.department_id JOIN locations AS T3 ON T2.location_id  =  T3.location_id JOIN countries AS T4 ON T3.country_id  =  T4.country_id
SELECT department_name ,  COUNT(*) FROM employees AS T1 JOIN departments AS T2 ON T1.department_id  =  T2.department_id GROUP BY department_name
SELECT department_name ,  COUNT(*) FROM employees AS T1 JOIN departments AS T2 ON T1.department_id  =  T2.department_id GROUP BY department_name
SELECT first_name ,  last_name ,  salary FROM employees AS T1 JOIN departments AS T2 ON T1.department_id  =  T2.department_id JOIN  locations AS T3 ON T2.location_id  =  T3.location_id WHERE  T3.city  =  'London'
SELECT first_name ,  last_name ,  salary FROM employees AS T1 JOIN departments AS T2 ON T1.department_id  =  T2.department_id JOIN  locations AS T3 ON T2.location_id  =  T3.location_id WHERE  T3.city  =  'London'
SELECT song_name ,  releasedate FROM song ORDER BY releasedate DESC LIMIT 1
SELECT song_name ,  releasedate FROM song ORDER BY releasedate DESC LIMIT 1
SELECT f_id FROM files ORDER BY duration DESC LIMIT 1
SELECT f_id FROM files ORDER BY duration DESC LIMIT 1
SELECT song_name FROM song WHERE languages  =  "english"
SELECT song_name FROM song WHERE languages  =  "english"
SELECT f_id FROM files WHERE formats  =  "mp3"
SELECT f_id FROM files WHERE formats  =  "mp3"
SELECT DISTINCT T1.artist_name ,  T1.country FROM artist AS T1 JOIN song AS T2 ON T1.artist_name  =  T2.artist_name WHERE T2.rating  >  9
SELECT DISTINCT T1.artist_name ,  T1.country FROM artist AS T1 JOIN song AS T2 ON T1.artist_name  =  T2.artist_name WHERE T2.rating  >  9
SELECT DISTINCT T1.file_size ,  T1.formats FROM files AS T1 JOIN song AS T2 ON T1.f_id  =  T2.f_id WHERE T2.resolution  <  800
SELECT DISTINCT T1.file_size ,  T1.formats FROM files AS T1 JOIN song AS T2 ON T1.f_id  =  T2.f_id WHERE T2.resolution  <  800
SELECT T1.artist_name FROM song AS T1 JOIN files AS T2 ON T1.f_id  =  T2.f_id ORDER BY T2.duration LIMIT 1
SELECT T1.artist_name FROM song AS T1 JOIN files AS T2 ON T1.f_id  =  T2.f_id ORDER BY T2.duration LIMIT 1
SELECT T1.artist_name ,  T1.country FROM artist AS T1 JOIN song AS T2 ON T1.artist_name  =  T2.artist_name ORDER BY T2.rating DESC LIMIT 3
SELECT T1.artist_name ,  T1.country FROM artist AS T1 JOIN song AS T2 ON T1.artist_name  =  T2.artist_name ORDER BY T2.rating DESC LIMIT 3
SELECT count(*) FROM artist WHERE country  =  "Bangladesh"
SELECT count(*) FROM artist WHERE country  =  "Bangladesh"
SELECT avg(T2.rating) FROM artist AS T1 JOIN song AS T2 ON T1.artist_name  =  T2.artist_name WHERE T1.gender  =  "Female"
SELECT avg(T2.rating) FROM artist AS T1 JOIN song AS T2 ON T1.artist_name  =  T2.artist_name WHERE T1.gender  =  "Female"
SELECT formats FROM files GROUP BY formats ORDER BY COUNT (*) DESC LIMIT 1
SELECT formats FROM files GROUP BY formats ORDER BY COUNT (*) DESC LIMIT 1
SELECT T1.country FROM artist AS T1 JOIN song AS T2 ON T1.artist_name  =  T2.artist_name WHERE T1.gender  =  "Female" AND T2.languages  =  "bangla"
SELECT T1.country FROM artist AS T1 JOIN song AS T2 ON T1.artist_name  =  T2.artist_name WHERE T1.gender  =  "Female" AND T2.languages  =  "bangla"
SELECT count(*) ,  gender FROM artist GROUP BY gender
SELECT count(*) ,  gender FROM artist GROUP BY gender
SELECT T1.gender ,  T1.artist_name FROM artist AS T1 JOIN song AS T2 ON T1.artist_name  =  T2.artist_name ORDER BY T2.resolution LIMIT 1
SELECT T1.gender ,  T1.artist_name FROM artist AS T1 JOIN song AS T2 ON T1.artist_name  =  T2.artist_name ORDER BY T2.resolution LIMIT 1
SELECT count(*) ,  formats FROM files GROUP BY formats
SELECT count(*) ,  formats FROM files GROUP BY formats
SELECT g_name ,  rating FROM genre ORDER BY g_name
SELECT g_name ,  rating FROM genre ORDER BY g_name
SELECT song_name FROM song ORDER BY resolution
SELECT song_name FROM song ORDER BY resolution
SELECT languages FROM song GROUP BY languages ORDER BY count(*) DESC LIMIT 1
SELECT languages FROM song GROUP BY languages ORDER BY count(*) DESC LIMIT 1
SELECT artist_name FROM artist WHERE country  =  "UK" AND gender  =  "Male"
SELECT artist_name FROM artist WHERE country  =  "UK" AND gender  =  "Male"
SELECT song_name FROM song WHERE genre_is  =  "modern" OR languages  =  "english"
SELECT song_name FROM song WHERE genre_is  =  "modern" OR languages  =  "english"
SELECT avg(rating) ,  avg(resolution) FROM song WHERE languages  =  "bangla"
SELECT avg(rating) ,  avg(resolution) FROM song WHERE languages  =  "bangla"
SELECT T1.artist_name ,  count(*) FROM artist AS T1 JOIN song AS T2 ON T1.artist_name  =  T2.artist_name WHERE T2.languages  =  "english" GROUP BY T2.artist_name HAVING count(*)  >=  1
SELECT T1.artist_name ,  count(*) FROM artist AS T1 JOIN song AS T2 ON T1.artist_name  =  T2.artist_name WHERE T2.languages  =  "english" GROUP BY T2.artist_name HAVING count(*)  >=  1
SELECT T1.artist_name ,  T1.country FROM artist AS T1 JOIN song AS T2 ON T1.artist_name  =  T2.artist_name WHERE T2.resolution  >  900 GROUP BY T2.artist_name HAVING count(*)  >=  1
SELECT T1.artist_name ,  T1.country FROM artist AS T1 JOIN song AS T2 ON T1.artist_name  =  T2.artist_name WHERE T2.resolution  >  900 GROUP BY T2.artist_name HAVING count(*)  >=  1
SELECT T1.country FROM artist AS T1 JOIN song AS T2 ON T1.artist_name  =  T2.artist_name GROUP BY T2.artist_name ORDER BY count(*) LIMIT 1
SELECT T1.country FROM artist AS T1 JOIN song AS T2 ON T1.artist_name  =  T2.artist_name GROUP BY T2.artist_name ORDER BY count(*) LIMIT 1
SELECT f_id ,  genre_is ,  artist_name FROM song WHERE languages  =   "english" ORDER BY rating
SELECT f_id ,  genre_is ,  artist_name FROM song WHERE languages  =   "english" ORDER BY rating
SELECT T1.duration ,  T1.file_size ,  T1.formats FROM files AS T1 JOIN song AS T2 ON T1.f_id  =  T2.f_id WHERE T2.genre_is  =  "pop" ORDER BY T2.song_name
SELECT T1.duration ,  T1.file_size ,  T1.formats FROM files AS T1 JOIN song AS T2 ON T1.f_id  =  T2.f_id WHERE T2.genre_is  =  "pop" ORDER BY T2.song_name
SELECT T1.name_full ,  T1.college_id FROM college AS T1 JOIN player_college AS T2 ON T1.college_id  =  T2.college_id GROUP BY T1.college_id ORDER BY count(*) DESC LIMIT 1;
SELECT T1.name_full ,  T1.college_id FROM college AS T1 JOIN player_college AS T2 ON T1.college_id  =  T2.college_id GROUP BY T1.college_id ORDER BY count(*) DESC LIMIT 1;
SELECT name_first ,  name_last FROM player AS T1 JOIN all_star AS T2 ON T1.player_id  =  T2.player_id WHERE YEAR  =  1998
SELECT name_first ,  name_last FROM player AS T1 JOIN all_star AS T2 ON T1.player_id  =  T2.player_id WHERE YEAR  =  1998
SELECT T1.name_first , T1.name_last ,  T1.player_id ,   count(*) FROM player AS T1 JOIN all_star AS T2 ON T1.player_id  =  T2.player_id GROUP BY T1.player_id ORDER BY count(*) DESC LIMIT 1;
SELECT T1.name_first , T1.name_last ,  T1.player_id ,   count(*) FROM player AS T1 JOIN all_star AS T2 ON T1.player_id  =  T2.player_id GROUP BY T1.player_id ORDER BY count(*) DESC LIMIT 1;
SELECT yearid ,  count(*) FROM hall_of_fame GROUP BY yearid;
SELECT yearid ,  count(*) FROM hall_of_fame GROUP BY yearid;
SELECT YEAR ,  avg(attendance) FROM home_game GROUP BY YEAR;
SELECT YEAR ,  avg(attendance) FROM home_game GROUP BY YEAR;
SELECT T1.name_first ,  T1.name_last ,  T2.player_id FROM player AS T1 JOIN manager_award AS T2 ON T1.player_id  =  T2.player_id GROUP BY T2.player_id ORDER BY count(*) DESC LIMIT 1;
SELECT T1.name_first ,  T1.name_last ,  T2.player_id FROM player AS T1 JOIN manager_award AS T2 ON T1.player_id  =  T2.player_id GROUP BY T2.player_id ORDER BY count(*) DESC LIMIT 1;
SELECT T1.name_first ,  T1.name_last ,  T1.player_id FROM player AS T1 JOIN player_award AS T2 ON T1.player_id  =  T2.player_id GROUP BY T1.player_id ORDER BY count(*) DESC LIMIT 3;
SELECT T1.name_first ,  T1.name_last ,  T1.player_id FROM player AS T1 JOIN player_award AS T2 ON T1.player_id  =  T2.player_id GROUP BY T1.player_id ORDER BY count(*) DESC LIMIT 3;
SELECT birth_country FROM player GROUP BY birth_country ORDER BY count(*) ASC LIMIT 3;
SELECT birth_country FROM player GROUP BY birth_country ORDER BY count(*) ASC LIMIT 3;
SELECT name_first ,  name_last FROM player WHERE death_year = '';
SELECT name_first ,  name_last FROM player WHERE death_year = '';
SELECT T1.name ,  T1.team_id ,  max(T2.salary) FROM team AS T1 JOIN salary AS T2 ON T1.team_id  =  T2.team_id GROUP BY T1.team_id;
SELECT T1.name ,  T1.team_id ,  max(T2.salary) FROM team AS T1 JOIN salary AS T2 ON T1.team_id  =  T2.team_id GROUP BY T1.team_id;
SELECT name_first ,  name_last FROM player WHERE weight  >  220 OR height  <  75
SELECT name_first ,  name_last FROM player WHERE weight  >  220 OR height  <  75
SELECT T2.name ,  T1.team_id_winner FROM postseason AS T1 JOIN team AS T2 ON T1.team_id_winner  =  T2.team_id_br WHERE T1.year  =  2008 GROUP BY T1.team_id_winner ORDER BY count(*) DESC LIMIT 1;
SELECT T2.name ,  T1.team_id_winner FROM postseason AS T1 JOIN team AS T2 ON T1.team_id_winner  =  T2.team_id_br WHERE T1.year  =  2008 GROUP BY T1.team_id_winner ORDER BY count(*) DESC LIMIT 1;
SELECT count(*) ,  T1.year FROM postseason AS T1 JOIN team AS T2 ON T1.team_id_winner  =  T2.team_id_br WHERE T2.name  =  'Boston Red Stockings' GROUP BY T1.year
SELECT count(*) ,  T1.year FROM postseason AS T1 JOIN team AS T2 ON T1.team_id_winner  =  T2.team_id_br WHERE T2.name  =  'Boston Red Stockings' GROUP BY T1.year
SELECT salary FROM salary WHERE YEAR  =  2001 ORDER BY salary DESC LIMIT 3;
SELECT salary FROM salary WHERE YEAR  =  2001 ORDER BY salary DESC LIMIT 3;
SELECT salary FROM salary WHERE YEAR  =  2010 UNION SELECT salary FROM salary WHERE YEAR  =  2001
SELECT salary FROM salary WHERE YEAR  =  2010 UNION SELECT salary FROM salary WHERE YEAR  =  2001
SELECT yearid FROM hall_of_fame GROUP BY yearid ORDER BY count(*) ASC LIMIT 1;
SELECT yearid FROM hall_of_fame GROUP BY yearid ORDER BY count(*) ASC LIMIT 1;
SELECT T2.name FROM home_game AS T1 JOIN team AS T2 ON T1.team_id = T2.team_id_br WHERE T1.year = 1980 ORDER BY T1.attendance ASC LIMIT 1;
SELECT T2.name FROM home_game AS T1 JOIN team AS T2 ON T1.team_id = T2.team_id_br WHERE T1.year = 1980 ORDER BY T1.attendance ASC LIMIT 1;
SELECT state FROM park GROUP BY state HAVING count(*)  >  2;
SELECT state FROM park GROUP BY state HAVING count(*)  >  2;
SELECT T2.park_name FROM home_game AS T1 JOIN park AS T2 ON T1.park_id  =  T2.park_id WHERE T1.year = 2008 ORDER BY T1.attendance DESC LIMIT 1;
SELECT T2.park_name FROM home_game AS T1 JOIN park AS T2 ON T1.park_id  =  T2.park_id WHERE T1.year = 2008 ORDER BY T1.attendance DESC LIMIT 1;
SELECT count(*) FROM camera_lens WHERE focal_length_mm  >  15
SELECT brand ,  name FROM camera_lens ORDER BY max_aperture DESC
SELECT id ,  color ,  name FROM photos
SELECT avg(prominence) FROM mountain WHERE country  =  'Morocco'
SELECT name ,  height ,  prominence FROM mountain WHERE range != 'Aberdare Range'
SELECT T1.id ,  T1.name FROM mountain AS T1 JOIN photos AS T2 ON T1.id  =  T2.mountain_id WHERE T1.height  >  4000
SELECT T1.id ,  T1.name FROM mountain AS T1 JOIN photos AS T2 ON T1.id  =  T2.mountain_id GROUP BY T1.id HAVING count(*)  >=  2
SELECT T2.name FROM photos AS T1 JOIN camera_lens AS T2 ON T1.camera_lens_id  =  T2.id GROUP BY T2.id ORDER BY count(*) DESC LIMIT 1
SELECT T1.name FROM camera_lens AS T1 JOIN photos AS T2 ON T2.camera_lens_id  =  T1.id WHERE T1.brand  =  'Sigma' OR T1.brand  =  'Olympus'
SELECT name FROM camera_lens WHERE name LIKE "%Digital%"
SELECT T1.name ,  count(*) FROM camera_lens AS T1 JOIN photos AS T2 ON T1.id  =  T2.camera_lens_id GROUP BY T1.id ORDER BY count(*)
SELECT name FROM channel WHERE OWNER != 'CCTV'
SELECT name FROM channel WHERE OWNER != 'CCTV'
SELECT name FROM channel ORDER BY rating_in_percent DESC
SELECT name FROM channel ORDER BY rating_in_percent DESC
SELECT OWNER FROM channel ORDER BY rating_in_percent DESC LIMIT 1
SELECT OWNER FROM channel ORDER BY rating_in_percent DESC LIMIT 1
SELECT count(*) FROM program
SELECT count(*) FROM program
SELECT name FROM program ORDER BY launch
SELECT name FROM program ORDER BY launch
SELECT name ,  origin ,  OWNER FROM program
SELECT name ,  origin ,  OWNER FROM program
SELECT name FROM program ORDER BY launch DESC LIMIT 1
SELECT name FROM program ORDER BY launch DESC LIMIT 1
SELECT origin FROM program ORDER BY origin
SELECT origin FROM program ORDER BY origin
SELECT name FROM program WHERE origin != 'Beijing'
SELECT name FROM program WHERE origin != 'Beijing'
SELECT name FROM channel WHERE OWNER  =  'CCTV' OR OWNER  =  'HBS'
SELECT name FROM channel WHERE OWNER  =  'CCTV' OR OWNER  =  'HBS'
SELECT count(*) FROM COURSES
SELECT count(*) FROM COURSES
SELECT course_description FROM COURSES WHERE course_name  =  "database"
SELECT course_description FROM COURSES WHERE course_name  =  "database"
SELECT address_line_1 FROM Course_Authors_and_Tutors WHERE personal_name	 =  "Cathrine"
SELECT address_line_1 FROM Course_Authors_and_Tutors WHERE personal_name	 =  "Cathrine"
SELECT address_line_1 FROM Course_Authors_and_Tutors
SELECT address_line_1 FROM Course_Authors_and_Tutors
SELECT login_name ,  family_name FROM Course_Authors_and_Tutors
SELECT login_name ,  family_name FROM Course_Authors_and_Tutors
SELECT date_of_enrolment ,  date_of_completion FROM Student_Course_Enrolment
SELECT date_of_enrolment ,  date_of_completion FROM Student_Course_Enrolment
SELECT count(course_id) FROM Student_Course_Enrolment
SELECT count(course_id) FROM Student_Course_Enrolment
SELECT date_test_taken FROM Student_Tests_Taken WHERE test_result  =  "Pass"
SELECT date_test_taken FROM Student_Tests_Taken WHERE test_result  =  "Pass"
SELECT count(*) FROM Student_Tests_Taken WHERE test_result  =  "Fail"
SELECT count(*) FROM Student_Tests_Taken WHERE test_result  =  "Fail"
SELECT login_name FROM Students WHERE family_name  =  "Ward"
SELECT login_name FROM Students WHERE family_name  =  "Ward"
SELECT date_of_latest_logon FROM Students WHERE family_name  =  "Jaskolski" OR family_name  =  "Langosh"
SELECT date_of_latest_logon FROM Students WHERE family_name  =  "Jaskolski" OR family_name  =  "Langosh"
SELECT subject_name FROM SUBJECTS
SELECT subject_name FROM SUBJECTS
SELECT personal_name ,  family_name FROM Students ORDER BY family_name
SELECT personal_name ,  family_name FROM Students ORDER BY family_name
SELECT test_result ,  COUNT(*) FROM Student_Tests_Taken GROUP BY test_result ORDER BY COUNT(*) DESC
SELECT test_result ,  COUNT(*) FROM Student_Tests_Taken GROUP BY test_result ORDER BY COUNT(*) DESC
SELECT T1.login_name FROM Course_Authors_and_Tutors AS T1 JOIN Courses AS T2 ON T1.author_id  =  T2.author_id WHERE T2.course_name  =  "advanced database"
SELECT T1.login_name FROM Course_Authors_and_Tutors AS T1 JOIN Courses AS T2 ON T1.author_id  =  T2.author_id WHERE T2.course_name  =  "advanced database"
SELECT T1.address_line_1 FROM Course_Authors_and_Tutors AS T1 JOIN Courses AS T2 ON T1.author_id  =  T2.author_id WHERE T2.course_name  =  "operating system" OR T2.course_name  =  "data structure"
SELECT T1.address_line_1 FROM Course_Authors_and_Tutors AS T1 JOIN Courses AS T2 ON T1.author_id  =  T2.author_id WHERE T2.course_name  =  "operating system" OR T2.course_name  =  "data structure"
SELECT T1.personal_name ,  T1.family_name ,  T2.author_id FROM Course_Authors_and_Tutors AS T1 JOIN Courses AS T2 ON T1.author_id  =  T2.author_id GROUP BY T2.author_id ORDER BY COUNT(*) DESC LIMIT 1
SELECT T1.personal_name ,  T1.family_name ,  T2.author_id FROM Course_Authors_and_Tutors AS T1 JOIN Courses AS T2 ON T1.author_id  =  T2.author_id GROUP BY T2.author_id ORDER BY COUNT(*) DESC LIMIT 1
SELECT T1.address_line_1 ,  T2.author_id FROM Course_Authors_and_Tutors AS T1 JOIN Courses AS T2 ON T1.author_id  =  T2.author_id GROUP BY T2.author_id HAVING Count(*)  >=  2
SELECT T1.address_line_1 ,  T2.author_id FROM Course_Authors_and_Tutors AS T1 JOIN Courses AS T2 ON T1.author_id  =  T2.author_id GROUP BY T2.author_id HAVING Count(*)  >=  2
SELECT T2.course_name FROM Course_Authors_and_Tutors AS T1 JOIN Courses AS T2 ON T1.author_id  =  T2.author_id WHERE T1.personal_name  =  "Julio"
SELECT T2.course_name FROM Course_Authors_and_Tutors AS T1 JOIN Courses AS T2 ON T1.author_id  =  T2.author_id WHERE T1.personal_name  =  "Julio"
SELECT T1.course_name ,  T1.course_description FROM Courses AS T1 JOIN Subjects AS T2 ON T1.subject_id  =  T2.subject_id WHERE T2.subject_name  =  "Computer Science"
SELECT T1.course_name ,  T1.course_description FROM Courses AS T1 JOIN Subjects AS T2 ON T1.subject_id  =  T2.subject_id WHERE T2.subject_name  =  "Computer Science"
SELECT T1.subject_id ,  T2.subject_name ,  COUNT(*) FROM Courses AS T1 JOIN Subjects AS T2 ON T1.subject_id  =  T2.subject_id GROUP BY T1.subject_id
SELECT T1.subject_id ,  T2.subject_name ,  COUNT(*) FROM Courses AS T1 JOIN Subjects AS T2 ON T1.subject_id  =  T2.subject_id GROUP BY T1.subject_id
SELECT T1.subject_id ,  T2.subject_name ,  COUNT(*) FROM Courses AS T1 JOIN Subjects AS T2 ON T1.subject_id  =  T2.subject_id GROUP BY T1.subject_id ORDER BY COUNT(*) ASC
SELECT T1.subject_id ,  T2.subject_name ,  COUNT(*) FROM Courses AS T1 JOIN Subjects AS T2 ON T1.subject_id  =  T2.subject_id GROUP BY T1.subject_id ORDER BY COUNT(*) ASC
SELECT T2.date_of_enrolment FROM Courses AS T1 JOIN Student_Course_Enrolment AS T2 ON T1.course_id  =  T2.course_id WHERE T1.course_name  =  "Spanish"
SELECT T2.date_of_enrolment FROM Courses AS T1 JOIN Student_Course_Enrolment AS T2 ON T1.course_id  =  T2.course_id WHERE T1.course_name  =  "Spanish"
SELECT T1.course_name FROM Courses AS T1 JOIN Student_Course_Enrolment AS T2 ON T1.course_id  =  T2.course_id GROUP BY T1.course_name ORDER BY COUNT(*) DESC LIMIT 1
SELECT T1.course_name FROM Courses AS T1 JOIN Student_Course_Enrolment AS T2 ON T1.course_id  =  T2.course_id GROUP BY T1.course_name ORDER BY COUNT(*) DESC LIMIT 1
SELECT T1.course_name FROM Courses AS T1 JOIN Student_Course_Enrolment AS T2 ON T1.course_id  =  T2.course_id GROUP BY T1.course_name HAVING COUNT(*)  =  1
SELECT T1.course_name FROM Courses AS T1 JOIN Student_Course_Enrolment AS T2 ON T1.course_id  =  T2.course_id GROUP BY T1.course_name HAVING COUNT(*)  =  1
SELECT T1.course_description ,  T1.course_name FROM Courses AS T1 JOIN Student_Course_Enrolment AS T2 ON T1.course_id  =  T2.course_id GROUP BY T1.course_name HAVING COUNT(*)  >  2
SELECT T1.course_description ,  T1.course_name FROM Courses AS T1 JOIN Student_Course_Enrolment AS T2 ON T1.course_id  =  T2.course_id GROUP BY T1.course_name HAVING COUNT(*)  >  2
SELECT T1.course_name ,  COUNT(*) FROM Courses AS T1 JOIN Student_Course_Enrolment AS T2 ON T1.course_id  =  T2.course_id GROUP BY T1.course_name
SELECT T1.course_name ,  COUNT(*) FROM Courses AS T1 JOIN Student_Course_Enrolment AS T2 ON T1.course_id  =  T2.course_id GROUP BY T1.course_name
SELECT T1.date_of_enrolment FROM Student_Course_Enrolment AS T1 JOIN Student_Tests_Taken AS T2 ON T1.registration_id  =  T2.registration_id WHERE T2.test_result  =  "Pass"
SELECT T1.date_of_enrolment FROM Student_Course_Enrolment AS T1 JOIN Student_Tests_Taken AS T2 ON T1.registration_id  =  T2.registration_id WHERE T2.test_result  =  "Pass"
SELECT T1.date_of_completion FROM Student_Course_Enrolment AS T1 JOIN Student_Tests_Taken AS T2 ON T1.registration_id  =  T2.registration_id WHERE T2.test_result  =  "Fail"
SELECT T1.date_of_completion FROM Student_Course_Enrolment AS T1 JOIN Student_Tests_Taken AS T2 ON T1.registration_id  =  T2.registration_id WHERE T2.test_result  =  "Fail"
SELECT T1.date_of_enrolment ,  T1.date_of_completion FROM Student_Course_Enrolment AS T1 JOIN Students AS T2 ON T1.student_id  =  T2.student_id WHERE T2.personal_name  =  "Karson"
SELECT T1.date_of_enrolment ,  T1.date_of_completion FROM Student_Course_Enrolment AS T1 JOIN Students AS T2 ON T1.student_id  =  T2.student_id WHERE T2.personal_name  =  "Karson"
SELECT T1.date_of_enrolment ,  T1.date_of_completion FROM Student_Course_Enrolment AS T1 JOIN Students AS T2 ON T1.student_id  =  T2.student_id WHERE T2.family_name  =  "Zieme" AND T2.personal_name  =  "Bernie"
SELECT T1.date_of_enrolment ,  T1.date_of_completion FROM Student_Course_Enrolment AS T1 JOIN Students AS T2 ON T1.student_id  =  T2.student_id WHERE T2.family_name  =  "Zieme" AND T2.personal_name  =  "Bernie"
SELECT T1.student_id ,  T2.login_name FROM Student_Course_Enrolment AS T1 JOIN Students AS T2 ON T1.student_id  =  T2.student_id GROUP BY T1.student_id ORDER BY COUNT(*) DESC LIMIT 1
SELECT T1.student_id ,  T2.login_name FROM Student_Course_Enrolment AS T1 JOIN Students AS T2 ON T1.student_id  =  T2.student_id GROUP BY T1.student_id ORDER BY COUNT(*) DESC LIMIT 1
SELECT T1.student_id ,  T2.personal_name FROM Student_Course_Enrolment AS T1 JOIN Students AS T2 ON T1.student_id  =  T2.student_id GROUP BY T1.student_id HAVING COUNT(*)  >=  2
SELECT T1.student_id ,  T2.personal_name FROM Student_Course_Enrolment AS T1 JOIN Students AS T2 ON T1.student_id  =  T2.student_id GROUP BY T1.student_id HAVING COUNT(*)  >=  2
SELECT T1.student_id ,  T2.middle_name FROM Student_Course_Enrolment AS T1 JOIN Students AS T2 ON T1.student_id  =  T2.student_id GROUP BY T1.student_id HAVING COUNT(*)  <=  2
SELECT T1.student_id ,  T2.middle_name FROM Student_Course_Enrolment AS T1 JOIN Students AS T2 ON T1.student_id  =  T2.student_id GROUP BY T1.student_id HAVING COUNT(*)  <=  2
SELECT Payment_Method_Code ,  Date_Payment_Made ,  Amount_Payment FROM Payments ORDER BY Date_Payment_Made ASC
SELECT Payment_Method_Code ,  Date_Payment_Made ,  Amount_Payment FROM Payments ORDER BY Date_Payment_Made ASC
SELECT Amount_Settled ,  Amount_Claimed FROM Claims ORDER BY Amount_Claimed DESC LIMIT 1
SELECT Amount_Settled ,  Amount_Claimed FROM Claims ORDER BY Amount_Claimed DESC LIMIT 1
SELECT Amount_Settled ,  Amount_Claimed FROM Claims ORDER BY Amount_Settled ASC LIMIT 1
SELECT Amount_Settled ,  Amount_Claimed FROM Claims ORDER BY Amount_Settled ASC LIMIT 1
SELECT T1.Claim_id ,  count(*) FROM Claims AS T1 JOIN Settlements AS T2 ON T1.claim_id  =  T2.claim_id GROUP BY T1.claim_id
SELECT T1.Claim_id ,  count(*) FROM Claims AS T1 JOIN Settlements AS T2 ON T1.claim_id  =  T2.claim_id GROUP BY T1.claim_id
SELECT T1.claim_id ,  T1.date_claim_made ,  count(*) FROM Claims AS T1 JOIN Settlements AS T2 ON T1.claim_id  =  T2.claim_id GROUP BY T1.claim_id ORDER BY count(*) DESC LIMIT 1
SELECT T1.claim_id ,  T1.date_claim_made ,  count(*) FROM Claims AS T1 JOIN Settlements AS T2 ON T1.claim_id  =  T2.claim_id GROUP BY T1.claim_id ORDER BY count(*) DESC LIMIT 1
SELECT Date_Claim_Made FROM Claims ORDER BY Date_Claim_Made ASC LIMIT 1
SELECT Date_Claim_Made FROM Claims ORDER BY Date_Claim_Made ASC LIMIT 1
SELECT T1.customer_details ,  T1.customer_id FROM Customers AS T1 JOIN Customer_Policies AS T2 ON T1.Customer_id  =  T2.Customer_id GROUP BY T1.customer_id HAVING count(*)  >  1
SELECT T1.customer_details ,  T1.customer_id FROM Customers AS T1 JOIN Customer_Policies AS T2 ON T1.Customer_id  =  T2.Customer_id GROUP BY T1.customer_id HAVING count(*)  >  1
SELECT Date_Claim_Made ,  Date_Claim_Settled FROM Settlements
SELECT Date_Claim_Made ,  Date_Claim_Settled FROM Settlements
SELECT Payment_Method_Code FROM Payments GROUP BY Payment_Method_Code ORDER BY count(*) DESC LIMIT 1
SELECT Payment_Method_Code FROM Payments GROUP BY Payment_Method_Code ORDER BY count(*) DESC LIMIT 1
SELECT Payment_Method_Code FROM Payments GROUP BY Payment_Method_Code ORDER BY count(*) ASC LIMIT 1
SELECT Payment_Method_Code FROM Payments GROUP BY Payment_Method_Code ORDER BY count(*) ASC LIMIT 1
SELECT DISTINCT customer_details FROM Customers
SELECT DISTINCT customer_details FROM Customers
SELECT Policy_Type_Code FROM Customer_Policies GROUP BY Policy_Type_Code ORDER BY count(*) DESC LIMIT 1
SELECT Policy_Type_Code FROM Customer_Policies GROUP BY Policy_Type_Code ORDER BY count(*) DESC LIMIT 1
SELECT count(*) FROM Settlements
SELECT count(*) FROM Settlements
SELECT Payment_ID ,  Date_Payment_Made ,  Amount_Payment FROM Payments WHERE Payment_Method_Code  =  'Visa'
SELECT Payment_ID ,  Date_Payment_Made ,  Amount_Payment FROM Payments WHERE Payment_Method_Code  =  'Visa'
SELECT T1.claim_id ,  T1.date_claim_made ,  T1.Date_Claim_Settled FROM Claims AS T1 JOIN Settlements AS T2 ON T1.Claim_id  =  T2.Claim_id GROUP BY T1.claim_id HAVING count(*)  =  1
SELECT T1.claim_id ,  T1.date_claim_made ,  T1.Date_Claim_Settled FROM Claims AS T1 JOIN Settlements AS T2 ON T1.Claim_id  =  T2.Claim_id GROUP BY T1.claim_id HAVING count(*)  =  1
SELECT name FROM appointment AS T1 JOIN patient AS T2 ON T1.patient  =  T2.ssn
SELECT name FROM appointment AS T1 JOIN patient AS T2 ON T1.patient  =  T2.ssn
SELECT name ,  phone FROM appointment AS T1 JOIN patient AS T2 ON T1.patient  =  T2.ssn GROUP BY T1.patient HAVING count(*)  >  1
SELECT name ,  phone FROM appointment AS T1 JOIN patient AS T2 ON T1.patient  =  T2.ssn GROUP BY T1.patient HAVING count(*)  >  1
SELECT appointmentid FROM appointment ORDER BY START DESC LIMIT 1
SELECT appointmentid FROM appointment ORDER BY START DESC LIMIT 1
SELECT T2.name FROM appointment AS T1 JOIN physician AS T2 ON T1.Physician  =  T2.EmployeeID
SELECT T2.name FROM appointment AS T1 JOIN physician AS T2 ON T1.Physician  =  T2.EmployeeID
SELECT T1.name ,  T3.name FROM physician AS T1 JOIN affiliated_with AS T2 ON T1.EmployeeID  =  T2.physician JOIN department AS T3 ON T2.department  =  T3.DepartmentID WHERE T2.PrimaryAffiliation  =  1
SELECT T1.name ,  T3.name FROM physician AS T1 JOIN affiliated_with AS T2 ON T1.EmployeeID  =  T2.physician JOIN department AS T3 ON T2.department  =  T3.DepartmentID WHERE T2.PrimaryAffiliation  =  1
SELECT T1.name FROM patient AS T1 JOIN appointment AS T2 ON T1.ssn = T2.patient ORDER BY T2.start DESC LIMIT 1
SELECT T1.name FROM patient AS T1 JOIN appointment AS T2 ON T1.ssn = T2.patient ORDER BY T2.start DESC LIMIT 1
SELECT count(patient) FROM stay WHERE room  =  112
SELECT count(patient) FROM stay WHERE room  =  112
SELECT T4.name FROM stay AS T1 JOIN patient AS T2 ON T1.Patient  =  T2.SSN JOIN Prescribes AS T3 ON T3.Patient  =  T2.SSN JOIN Medication AS T4 ON T3.Medication  =  T4.Code WHERE room  =  111
SELECT T4.name FROM stay AS T1 JOIN patient AS T2 ON T1.Patient  =  T2.SSN JOIN Prescribes AS T3 ON T3.Patient  =  T2.SSN JOIN Medication AS T4 ON T3.Medication  =  T4.Code WHERE room  =  111
SELECT patient FROM stay WHERE room  =  111 ORDER BY staystart DESC LIMIT 1
SELECT patient FROM stay WHERE room  =  111 ORDER BY staystart DESC LIMIT 1
SELECT T1.name FROM nurse AS T1 JOIN appointment AS T2 ON T1.employeeid  =  T2.prepnurse GROUP BY T1.employeeid ORDER BY count(*) DESC LIMIT 1
SELECT T1.name FROM nurse AS T1 JOIN appointment AS T2 ON T1.employeeid  =  T2.prepnurse GROUP BY T1.employeeid ORDER BY count(*) DESC LIMIT 1
SELECT T1.name ,  count(*) FROM physician AS T1 JOIN patient AS T2 ON T1.employeeid  =  T2.PCP GROUP BY T1.employeeid
SELECT T1.name ,  count(*) FROM physician AS T1 JOIN patient AS T2 ON T1.employeeid  =  T2.PCP GROUP BY T1.employeeid
SELECT T1.name FROM physician AS T1 JOIN patient AS T2 ON T1.employeeid  =  T2.PCP GROUP BY T1.employeeid HAVING count(*)  >  1
SELECT T1.name FROM physician AS T1 JOIN patient AS T2 ON T1.employeeid  =  T2.PCP GROUP BY T1.employeeid HAVING count(*)  >  1
SELECT DISTINCT blockcode FROM room WHERE unavailable  =  0
SELECT DISTINCT blockcode FROM room WHERE unavailable  =  0
SELECT DISTINCT T1.name FROM physician AS T1 JOIN prescribes AS T2 ON T1.employeeid = T2.physician JOIN medication AS T3 ON T3.code = T2.medication WHERE T3.name  =  "Thesisin"
SELECT DISTINCT T1.name FROM physician AS T1 JOIN prescribes AS T2 ON T1.employeeid = T2.physician JOIN medication AS T3 ON T3.code = T2.medication WHERE T3.name  =  "Thesisin"
SELECT DISTINCT T1.name ,  T1.position FROM physician AS T1 JOIN prescribes AS T2 ON T1.employeeid = T2.physician JOIN medication AS T3 ON T3.code = T2.medication WHERE T3.Brand  =  "X"
SELECT DISTINCT T1.name ,  T1.position FROM physician AS T1 JOIN prescribes AS T2 ON T1.employeeid = T2.physician JOIN medication AS T3 ON T3.code = T2.medication WHERE T3.Brand  =  "X"
SELECT count(*) ,  T1.name FROM medication AS T1 JOIN prescribes AS T2 ON T1.code = T2.medication GROUP BY T1.brand
SELECT count(*) ,  T1.name FROM medication AS T1 JOIN prescribes AS T2 ON T1.code = T2.medication GROUP BY T1.brand
SELECT name FROM physician WHERE POSITION LIKE '%senior%'
SELECT name FROM physician WHERE POSITION LIKE '%senior%'
SELECT patient FROM undergoes ORDER BY dateundergoes LIMIT 1
SELECT patient FROM undergoes ORDER BY dateundergoes LIMIT 1
SELECT DISTINCT T2.name FROM undergoes AS T1 JOIN patient AS T2 ON T1.patient = T2.SSN JOIN stay AS T3 ON T1.Stay  =  T3.StayID WHERE T3.room  =  111
SELECT DISTINCT T2.name FROM undergoes AS T1 JOIN patient AS T2 ON T1.patient = T2.SSN JOIN stay AS T3 ON T1.Stay  =  T3.StayID WHERE T3.room  =  111
SELECT DISTINCT name FROM nurse ORDER BY name
SELECT DISTINCT name FROM nurse ORDER BY name
SELECT DISTINCT T2.name FROM undergoes AS T1 JOIN nurse AS T2 ON T1.AssistingNurse  =  T2.EmployeeID
SELECT DISTINCT T2.name FROM undergoes AS T1 JOIN nurse AS T2 ON T1.AssistingNurse  =  T2.EmployeeID
SELECT DISTINCT name FROM medication ORDER BY name
SELECT DISTINCT name FROM medication ORDER BY name
SELECT T1.name FROM physician AS T1 JOIN prescribes AS T2 ON T1.employeeid = T2.physician ORDER BY T2.dose DESC LIMIT 1
SELECT T1.name FROM physician AS T1 JOIN prescribes AS T2 ON T1.employeeid = T2.physician ORDER BY T2.dose DESC LIMIT 1
SELECT DISTINCT T2.name FROM affiliated_with AS T1 JOIN department AS T2 ON T1.department = T2.departmentid WHERE PrimaryAffiliation  =  1
SELECT DISTINCT T2.name FROM affiliated_with AS T1 JOIN department AS T2 ON T1.department = T2.departmentid WHERE PrimaryAffiliation  =  1
SELECT nurse FROM on_call WHERE blockfloor  =  1 AND blockcode  =  1
SELECT nurse FROM on_call WHERE blockfloor  =  1 AND blockcode  =  1
SELECT MAX(cost) ,  MIN(cost) ,  AVG(cost) FROM procedures
SELECT MAX(cost) ,  MIN(cost) ,  AVG(cost) FROM procedures
SELECT name ,  cost FROM procedures ORDER BY cost DESC
SELECT name ,  cost FROM procedures ORDER BY cost DESC
SELECT name FROM procedures ORDER BY cost LIMIT 3
SELECT name FROM procedures ORDER BY cost LIMIT 3
SELECT T1.name FROM physician AS T1 JOIN trained_in AS T2 ON T1.employeeid  =  T2.physician JOIN procedures AS T3 ON T3.code  =  T2.treatment WHERE T3.cost  >  5000
SELECT T1.name FROM physician AS T1 JOIN trained_in AS T2 ON T1.employeeid  =  T2.physician JOIN procedures AS T3 ON T3.code  =  T2.treatment WHERE T3.cost  >  5000
SELECT T1.name FROM physician AS T1 JOIN trained_in AS T2 ON T1.employeeid  =  T2.physician JOIN procedures AS T3 ON T3.code  =  T2.treatment ORDER BY T3.cost DESC LIMIT 1
SELECT T1.name FROM physician AS T1 JOIN trained_in AS T2 ON T1.employeeid  =  T2.physician JOIN procedures AS T3 ON T3.code  =  T2.treatment ORDER BY T3.cost DESC LIMIT 1
SELECT avg(T3.cost) FROM physician AS T1 JOIN trained_in AS T2 ON T1.employeeid  =  T2.physician JOIN procedures AS T3 ON T3.code  =  T2.treatment WHERE T1.name  =  "John Wen"
SELECT avg(T3.cost) FROM physician AS T1 JOIN trained_in AS T2 ON T1.employeeid  =  T2.physician JOIN procedures AS T3 ON T3.code  =  T2.treatment WHERE T1.name  =  "John Wen"
SELECT T3.name FROM physician AS T1 JOIN trained_in AS T2 ON T1.employeeid  =  T2.physician JOIN procedures AS T3 ON T3.code  =  T2.treatment WHERE T1.name  =  "John Wen"
SELECT T3.name FROM physician AS T1 JOIN trained_in AS T2 ON T1.employeeid  =  T2.physician JOIN procedures AS T3 ON T3.code  =  T2.treatment WHERE T1.name  =  "John Wen"
SELECT name FROM procedures WHERE cost  >  1000 UNION SELECT T3.name FROM physician AS T1 JOIN trained_in AS T2 ON T1.employeeid  =  T2.physician JOIN procedures AS T3 ON T3.code  =  T2.treatment WHERE T1.name  =  "John Wen"
SELECT name FROM procedures WHERE cost  >  1000 UNION SELECT T3.name FROM physician AS T1 JOIN trained_in AS T2 ON T1.employeeid  =  T2.physician JOIN procedures AS T3 ON T3.code  =  T2.treatment WHERE T1.name  =  "John Wen"
SELECT T1.name FROM physician AS T1 JOIN affiliated_with AS T2 ON T1.EmployeeID  =  T2.physician JOIN department AS T3 ON T2.department  =  T3.DepartmentID WHERE T3.name  =  'Surgery' OR T3.name  =  'Psychiatry'
SELECT T1.name FROM physician AS T1 JOIN affiliated_with AS T2 ON T1.EmployeeID  =  T2.physician JOIN department AS T3 ON T2.department  =  T3.DepartmentID WHERE T3.name  =  'Surgery' OR T3.name  =  'Psychiatry'
SELECT count(*) FROM appointment
SELECT count(*) FROM appointment
SELECT DISTINCT T1.name FROM nurse AS T1 JOIN on_call AS T2 ON T1.EmployeeID  =  T2.nurse
SELECT DISTINCT T1.name FROM nurse AS T1 JOIN on_call AS T2 ON T1.EmployeeID  =  T2.nurse
SELECT count(*) FROM ship
SELECT count(*) FROM ship
SELECT Name FROM ship ORDER BY Tonnage ASC
SELECT Name FROM ship ORDER BY Tonnage ASC
SELECT TYPE ,  Nationality FROM ship
SELECT TYPE ,  Nationality FROM ship
SELECT Name FROM ship WHERE Nationality != "United States"
SELECT Name FROM ship WHERE Nationality != "United States"
SELECT Name FROM ship WHERE Nationality  =  "United States" OR Nationality  =  "United Kingdom"
SELECT Name FROM ship WHERE Nationality  =  "United States" OR Nationality  =  "United Kingdom"
SELECT Name FROM ship ORDER BY Tonnage DESC LIMIT 1
SELECT Name FROM ship ORDER BY Tonnage DESC LIMIT 1
SELECT TYPE ,  COUNT(*) FROM ship GROUP BY TYPE
SELECT TYPE ,  COUNT(*) FROM ship GROUP BY TYPE
SELECT TYPE FROM ship GROUP BY TYPE ORDER BY COUNT(*) DESC LIMIT 1
SELECT TYPE FROM ship GROUP BY TYPE ORDER BY COUNT(*) DESC LIMIT 1
SELECT Nationality FROM ship GROUP BY Nationality HAVING COUNT(*)  >  2
SELECT Nationality FROM ship GROUP BY Nationality HAVING COUNT(*)  >  2
SELECT T1.Code ,  T1.Fate ,  T2.Name FROM mission AS T1 JOIN ship AS T2 ON T1.Ship_ID  =  T2.Ship_ID
SELECT T1.Code ,  T1.Fate ,  T2.Name FROM mission AS T1 JOIN ship AS T2 ON T1.Ship_ID  =  T2.Ship_ID
SELECT T2.Name FROM mission AS T1 JOIN ship AS T2 ON T1.Ship_ID  =  T2.Ship_ID WHERE T1.Launched_Year  >  1928
SELECT T2.Name FROM mission AS T1 JOIN ship AS T2 ON T1.Ship_ID  =  T2.Ship_ID WHERE T1.Launched_Year  >  1928
SELECT DISTINCT T1.Fate FROM mission AS T1 JOIN ship AS T2 ON T1.Ship_ID  =  T2.Ship_ID WHERE T2.Nationality  =  "United States"
SELECT DISTINCT T1.Fate FROM mission AS T1 JOIN ship AS T2 ON T1.Ship_ID  =  T2.Ship_ID WHERE T2.Nationality  =  "United States"
SELECT Name FROM ship WHERE Ship_ID NOT IN (SELECT Ship_ID FROM mission)
SELECT Name FROM ship WHERE Ship_ID NOT IN (SELECT Ship_ID FROM mission)
SELECT count(*) FROM list
SELECT count(*) FROM list
SELECT lastname FROM list WHERE classroom  =  111
SELECT lastname FROM list WHERE classroom  =  111
SELECT firstname FROM list WHERE classroom  =  108
SELECT firstname FROM list WHERE classroom  =  108
SELECT DISTINCT firstname FROM list WHERE classroom  =  107
SELECT DISTINCT firstname FROM list WHERE classroom  =  107
SELECT DISTINCT classroom ,  grade FROM list
SELECT DISTINCT classroom ,  grade FROM list
SELECT DISTINCT grade FROM list WHERE classroom  =  103
SELECT DISTINCT grade FROM list WHERE classroom  =  103
SELECT DISTINCT grade FROM list WHERE classroom  =  105
SELECT DISTINCT grade FROM list WHERE classroom  =  105
SELECT DISTINCT classroom FROM list WHERE grade  =  4
SELECT DISTINCT classroom FROM list WHERE grade  =  4
SELECT DISTINCT classroom FROM list WHERE grade  =  5
SELECT DISTINCT classroom FROM list WHERE grade  =  5
SELECT DISTINCT T2.lastname FROM list AS T1 JOIN teachers AS T2 ON T1.classroom  =  T2.classroom WHERE grade  =  5
SELECT DISTINCT T2.lastname FROM list AS T1 JOIN teachers AS T2 ON T1.classroom  =  T2.classroom WHERE grade  =  5
SELECT DISTINCT T2.firstname FROM list AS T1 JOIN teachers AS T2 ON T1.classroom  =  T2.classroom WHERE grade  =  1
SELECT DISTINCT T2.firstname FROM list AS T1 JOIN teachers AS T2 ON T1.classroom  =  T2.classroom WHERE grade  =  1
SELECT firstname FROM teachers WHERE classroom  =  110
SELECT firstname FROM teachers WHERE classroom  =  110
SELECT lastname FROM teachers WHERE classroom  =  109
SELECT lastname FROM teachers WHERE classroom  =  109
SELECT DISTINCT firstname ,  lastname FROM teachers
SELECT DISTINCT firstname ,  lastname FROM teachers
SELECT DISTINCT firstname ,  lastname FROM list
SELECT DISTINCT firstname ,  lastname FROM list
SELECT T1.firstname ,  T1.lastname FROM list AS T1 JOIN teachers AS T2 ON T1.classroom  =  T2.classroom WHERE T2.firstname  =  "OTHA" AND T2.lastname  =  "MOYER"
SELECT T1.firstname ,  T1.lastname FROM list AS T1 JOIN teachers AS T2 ON T1.classroom  =  T2.classroom WHERE T2.firstname  =  "OTHA" AND T2.lastname  =  "MOYER"
SELECT T1.firstname ,  T1.lastname FROM list AS T1 JOIN teachers AS T2 ON T1.classroom  =  T2.classroom WHERE T2.firstname  =  "MARROTTE" AND T2.lastname  =  "KIRK"
SELECT T1.firstname ,  T1.lastname FROM list AS T1 JOIN teachers AS T2 ON T1.classroom  =  T2.classroom WHERE T2.firstname  =  "MARROTTE" AND T2.lastname  =  "KIRK"
SELECT T2.firstname ,  T2.lastname FROM list AS T1 JOIN teachers AS T2 ON T1.classroom  =  T2.classroom WHERE T1.firstname  =  "EVELINA" AND T1.lastname  =  "BROMLEY"
SELECT T2.firstname ,  T2.lastname FROM list AS T1 JOIN teachers AS T2 ON T1.classroom  =  T2.classroom WHERE T1.firstname  =  "EVELINA" AND T1.lastname  =  "BROMLEY"
SELECT T2.lastname FROM list AS T1 JOIN teachers AS T2 ON T1.classroom  =  T2.classroom WHERE T1.firstname  =  "GELL" AND T1.lastname  =  "TAMI"
SELECT T2.lastname FROM list AS T1 JOIN teachers AS T2 ON T1.classroom  =  T2.classroom WHERE T1.firstname  =  "GELL" AND T1.lastname  =  "TAMI"
SELECT count(*) FROM list AS T1 JOIN teachers AS T2 ON T1.classroom  =  T2.classroom WHERE T2.firstname  =  "LORIA" AND T2.lastname  =  "ONDERSMA"
SELECT count(*) FROM list AS T1 JOIN teachers AS T2 ON T1.classroom  =  T2.classroom WHERE T2.firstname  =  "LORIA" AND T2.lastname  =  "ONDERSMA"
SELECT count(*) FROM list AS T1 JOIN teachers AS T2 ON T1.classroom  =  T2.classroom WHERE T2.firstname  =  "KAWA" AND T2.lastname  =  "GORDON"
SELECT count(*) FROM list AS T1 JOIN teachers AS T2 ON T1.classroom  =  T2.classroom WHERE T2.firstname  =  "KAWA" AND T2.lastname  =  "GORDON"
SELECT count(*) FROM list AS T1 JOIN teachers AS T2 ON T1.classroom  =  T2.classroom WHERE T2.firstname  =  "TARRING" AND T2.lastname  =  "LEIA"
SELECT count(*) FROM list AS T1 JOIN teachers AS T2 ON T1.classroom  =  T2.classroom WHERE T2.firstname  =  "TARRING" AND T2.lastname  =  "LEIA"
SELECT count(*) FROM list AS T1 JOIN teachers AS T2 ON T1.classroom  =  T2.classroom WHERE T1.firstname  =  "CHRISSY" AND T1.lastname  =  "NABOZNY"
SELECT count(*) FROM list AS T1 JOIN teachers AS T2 ON T1.classroom  =  T2.classroom WHERE T1.firstname  =  "CHRISSY" AND T1.lastname  =  "NABOZNY"
SELECT count(*) FROM list AS T1 JOIN teachers AS T2 ON T1.classroom  =  T2.classroom WHERE T1.firstname  =  "MADLOCK" AND T1.lastname  =  "RAY"
SELECT count(*) FROM list AS T1 JOIN teachers AS T2 ON T1.classroom  =  T2.classroom WHERE T1.firstname  =  "MADLOCK" AND T1.lastname  =  "RAY"
SELECT DISTINCT T1.lastname FROM list AS T1 JOIN teachers AS T2 ON T1.classroom  =  T2.classroom WHERE T1.grade  =  3 AND T2.firstname != "COVIN" AND T2.lastname != "JEROME"
SELECT DISTINCT T1.lastname FROM list AS T1 JOIN teachers AS T2 ON T1.classroom  =  T2.classroom WHERE T1.grade  =  3 AND T2.firstname != "COVIN" AND T2.lastname != "JEROME"
SELECT classroom FROM list GROUP BY classroom ORDER BY count(*) DESC LIMIT 1
SELECT classroom FROM list GROUP BY classroom ORDER BY count(*) DESC LIMIT 1
SELECT classroom ,  count(*) FROM list GROUP BY classroom
SELECT classroom ,  count(*) FROM list GROUP BY classroom
SELECT classroom ,  count(*) FROM list WHERE grade  =  "0" GROUP BY classroom
SELECT classroom ,  count(*) FROM list WHERE grade  =  "0" GROUP BY classroom
SELECT classroom ,  count(*) FROM list WHERE grade  =  "4" GROUP BY classroom
SELECT classroom ,  count(*) FROM list WHERE grade  =  "4" GROUP BY classroom
SELECT count(*) ,  classroom FROM list GROUP BY classroom
SELECT count(*) ,  classroom FROM list GROUP BY classroom
SELECT count(*) FROM company WHERE Headquarters  =  'USA'
SELECT Name FROM company ORDER BY Sales_in_Billion ASC
SELECT Headquarters ,  Industry FROM company
SELECT Name FROM company WHERE Industry  =  "Banking" OR Industry  =  "Retailing"
SELECT max(Market_Value_in_Billion) ,  min(Market_Value_in_Billion) FROM company
SELECT Headquarters FROM company ORDER BY Sales_in_Billion DESC LIMIT 1
SELECT Headquarters ,  COUNT(*) FROM company GROUP BY Headquarters
SELECT Headquarters FROM company GROUP BY Headquarters ORDER BY COUNT(*) DESC LIMIT 1
SELECT Headquarters FROM company GROUP BY Headquarters HAVING COUNT(*)  >=  2
SELECT T3.Name ,  T2.Name FROM employment AS T1 JOIN people AS T2 ON T1.People_ID  =  T2.People_ID JOIN company AS T3 ON T1.Company_ID  =  T3.Company_ID
SELECT T2.Name FROM employment AS T1 JOIN people AS T2 ON T1.People_ID  =  T2.People_ID JOIN company AS T3 ON T1.Company_ID  =  T3.Company_ID WHERE T3.Sales_in_Billion  >  200
SELECT T3.Name ,  COUNT(*) FROM employment AS T1 JOIN people AS T2 ON T1.People_ID  =  T2.People_ID JOIN company AS T3 ON T1.Company_ID  =  T3.Company_ID GROUP BY T3.Name
SELECT Name FROM people WHERE People_ID NOT IN (SELECT People_ID FROM employment)
SELECT name FROM company WHERE Sales_in_Billion  >  200 ORDER BY Sales_in_Billion ,  Profits_in_Billion DESC
SELECT count(*) FROM film
SELECT count(*) FROM film
SELECT DISTINCT Director FROM film
SELECT DISTINCT Director FROM film
SELECT avg(Gross_in_dollar) FROM film
SELECT avg(Gross_in_dollar) FROM film
SELECT Low_Estimate ,  High_Estimate FROM film_market_estimation
SELECT Low_Estimate ,  High_Estimate FROM film_market_estimation
SELECT TYPE FROM film_market_estimation WHERE YEAR  =  1995
SELECT TYPE FROM film_market_estimation WHERE YEAR  =  1995
SELECT max(Number_cities) ,  min(Number_cities) FROM market
SELECT max(Number_cities) ,  min(Number_cities) FROM market
SELECT count(*) FROM market WHERE Number_cities  <  300
SELECT count(*) FROM market WHERE Number_cities  <  300
SELECT Country FROM market ORDER BY Country ASC
SELECT Country FROM market ORDER BY Country ASC
SELECT Country FROM market ORDER BY Number_cities DESC
SELECT Country FROM market ORDER BY Number_cities DESC
SELECT T1.Title ,  T2.Type FROM film AS T1 JOIN film_market_estimation AS T2 ON T1.Film_ID  =  T2.Film_ID
SELECT T1.Title ,  T2.Type FROM film AS T1 JOIN film_market_estimation AS T2 ON T1.Film_ID  =  T2.Film_ID
SELECT DISTINCT T1.Director FROM film AS T1 JOIN film_market_estimation AS T2 ON T1.Film_ID  =  T2.Film_ID WHERE T2.Year  =  1995
SELECT DISTINCT T1.Director FROM film AS T1 JOIN film_market_estimation AS T2 ON T1.Film_ID  =  T2.Film_ID WHERE T2.Year  =  1995
SELECT T2.Country ,  T1.Year FROM film_market_estimation AS T1 JOIN market AS T2 ON T1.Market_ID  =  T2.Market_ID
SELECT T2.Country ,  T1.Year FROM film_market_estimation AS T1 JOIN market AS T2 ON T1.Market_ID  =  T2.Market_ID
SELECT T1.Year FROM film_market_estimation AS T1 JOIN market AS T2 ON T1.Market_ID  =  T2.Market_ID WHERE T2.Country  =  "Japan" ORDER BY T1.Year DESC
SELECT T1.Year FROM film_market_estimation AS T1 JOIN market AS T2 ON T1.Market_ID  =  T2.Market_ID WHERE T2.Country  =  "Japan" ORDER BY T1.Year DESC
SELECT Studio ,  COUNT(*) FROM film GROUP BY Studio
SELECT Studio ,  COUNT(*) FROM film GROUP BY Studio
SELECT Studio FROM film GROUP BY Studio HAVING COUNT(*)  >=  2
SELECT Studio FROM film GROUP BY Studio HAVING COUNT(*)  >=  2
SELECT title ,  Studio FROM film WHERE Studio LIKE "%Universal%"
SELECT title ,  Studio FROM film WHERE Studio LIKE "%Universal%"
SELECT count(*) FROM Ref_calendar
SELECT count(*) FROM Ref_calendar
SELECT calendar_date ,  day_Number FROM Ref_calendar
SELECT calendar_date ,  day_Number FROM Ref_calendar
SELECT count(*) FROM Ref_document_types
SELECT count(*) FROM Ref_document_types
SELECT document_type_code ,  document_type_name FROM Ref_document_types
SELECT document_type_code ,  document_type_name FROM Ref_document_types
SELECT document_type_name ,  document_type_description FROM Ref_document_types WHERE document_type_code  =  "RV"
SELECT document_type_name ,  document_type_description FROM Ref_document_types WHERE document_type_code  =  "RV"
SELECT document_type_code FROM Ref_document_types WHERE document_type_name  =  "Paper"
SELECT document_type_code FROM Ref_document_types WHERE document_type_name  =  "Paper"
SELECT count(*) FROM All_documents WHERE document_type_code  =  "CV" OR document_type_code  =  "BK"
SELECT count(*) FROM All_documents WHERE document_type_code  =  "CV" OR document_type_code  =  "BK"
SELECT date_stored FROM All_documents WHERE Document_name  =  "Marry CV"
SELECT date_stored FROM All_documents WHERE Document_name  =  "Marry CV"
SELECT T2.day_Number ,  T1.Date_Stored FROM All_documents AS T1 JOIN Ref_calendar AS T2 ON T1.date_stored  =  T2.calendar_date
SELECT T2.day_Number ,  T1.Date_Stored FROM All_documents AS T1 JOIN Ref_calendar AS T2 ON T1.date_stored  =  T2.calendar_date
SELECT T2.document_type_name FROM All_documents AS T1 JOIN Ref_document_types AS T2 ON T1.document_type_code  =  T2.document_type_code WHERE T1.document_name  =  "How to read a book"
SELECT T2.document_type_name FROM All_documents AS T1 JOIN Ref_document_types AS T2 ON T1.document_type_code  =  T2.document_type_code WHERE T1.document_name  =  "How to read a book"
SELECT count(*) FROM Ref_locations
SELECT count(*) FROM Ref_locations
SELECT location_code ,  location_name FROM Ref_locations
SELECT location_code ,  location_name FROM Ref_locations
SELECT location_name ,  location_description FROM Ref_locations WHERE location_code  =  "x"
SELECT location_name ,  location_description FROM Ref_locations WHERE location_code  =  "x"
SELECT location_code FROM Ref_locations WHERE location_name  =  "Canada"
SELECT location_code FROM Ref_locations WHERE location_name  =  "Canada"
SELECT count(*) FROM ROLES
SELECT count(*) FROM ROLES
SELECT role_code ,  role_name ,  role_description FROM ROLES
SELECT role_code ,  role_name ,  role_description FROM ROLES
SELECT role_name ,  role_description FROM ROLES WHERE role_code  =  "MG"
SELECT role_name ,  role_description FROM ROLES WHERE role_code  =  "MG"
SELECT role_description FROM ROLES WHERE role_name  =  "Proof Reader"
SELECT role_description FROM ROLES WHERE role_name  =  "Proof Reader"
SELECT count(*) FROM Employees
SELECT count(*) FROM Employees
SELECT employee_name ,  role_code ,  date_of_birth FROM Employees WHERE employee_Name  =  'Armani'
SELECT employee_name ,  role_code ,  date_of_birth FROM Employees WHERE employee_Name  =  'Armani'
SELECT employee_ID FROM Employees WHERE employee_name  =  "Ebba"
SELECT employee_ID FROM Employees WHERE employee_name  =  "Ebba"
SELECT employee_name FROM Employees WHERE role_code  =  "HR"
SELECT employee_name FROM Employees WHERE role_code  =  "HR"
SELECT role_code ,  count(*) FROM Employees GROUP BY role_code
SELECT role_code ,  count(*) FROM Employees GROUP BY role_code
SELECT role_code FROM Employees GROUP BY role_code ORDER BY count(*) DESC LIMIT 1
SELECT role_code FROM Employees GROUP BY role_code ORDER BY count(*) DESC LIMIT 1
SELECT role_code FROM Employees GROUP BY role_code HAVING count(*)  >=  3
SELECT role_code FROM Employees GROUP BY role_code HAVING count(*)  >=  3
SELECT role_code FROM Employees GROUP BY role_code ORDER BY count(*) ASC LIMIT 1
SELECT role_code FROM Employees GROUP BY role_code ORDER BY count(*) ASC LIMIT 1
SELECT T2.role_name ,  T2.role_description FROM Employees AS T1 JOIN ROLES AS T2 ON T1.role_code  =  T2.role_code WHERE T1.employee_name  =  "Ebba"
SELECT T2.role_name ,  T2.role_description FROM Employees AS T1 JOIN ROLES AS T2 ON T1.role_code  =  T2.role_code WHERE T1.employee_name  =  "Ebba"
SELECT T1.employee_name FROM Employees AS T1 JOIN ROLES AS T2 ON T1.role_code  =  T2.role_code WHERE T2.role_name  =  "Editor"
SELECT T1.employee_name FROM Employees AS T1 JOIN ROLES AS T2 ON T1.role_code  =  T2.role_code WHERE T2.role_name  =  "Editor"
SELECT T1.employee_id FROM Employees AS T1 JOIN ROLES AS T2 ON T1.role_code  =  T2.role_code WHERE T2.role_name  =  "Human Resource" OR T2.role_name  =  "Manager"
SELECT T1.employee_id FROM Employees AS T1 JOIN ROLES AS T2 ON T1.role_code  =  T2.role_code WHERE T2.role_name  =  "Human Resource" OR T2.role_name  =  "Manager"
SELECT DISTINCT location_code FROM Document_locations
SELECT DISTINCT location_code FROM Document_locations
SELECT T3.location_name FROM All_documents AS T1 JOIN Document_locations AS T2 ON T1.document_id  =  T2.document_id JOIN Ref_locations AS T3 ON T2.location_code  =  T3.location_code WHERE T1.document_name  =  "Robin CV"
SELECT T3.location_name FROM All_documents AS T1 JOIN Document_locations AS T2 ON T1.document_id  =  T2.document_id JOIN Ref_locations AS T3 ON T2.location_code  =  T3.location_code WHERE T1.document_name  =  "Robin CV"
SELECT location_code ,  date_in_location_from ,  date_in_locaton_to FROM Document_locations
SELECT location_code ,  date_in_location_from ,  date_in_locaton_to FROM Document_locations
SELECT location_code ,  count(*) FROM Document_locations GROUP BY location_code
SELECT location_code ,  count(*) FROM Document_locations GROUP BY location_code
SELECT location_code FROM Document_locations GROUP BY location_code ORDER BY count(*) DESC LIMIT 1
SELECT location_code FROM Document_locations GROUP BY location_code ORDER BY count(*) DESC LIMIT 1
SELECT location_code FROM Document_locations GROUP BY location_code HAVING count(*)  >=  3
SELECT location_code FROM Document_locations GROUP BY location_code HAVING count(*)  >=  3
SELECT T2.location_name ,  T1.location_code FROM Document_locations AS T1 JOIN Ref_locations AS T2 ON T1.location_code  =  T2.location_code GROUP BY T1.location_code ORDER BY count(*) ASC LIMIT 1
SELECT T2.location_name ,  T1.location_code FROM Document_locations AS T1 JOIN Ref_locations AS T2 ON T1.location_code  =  T2.location_code GROUP BY T1.location_code ORDER BY count(*) ASC LIMIT 1
SELECT T2.employee_name ,  T3.employee_name FROM Documents_to_be_destroyed AS T1 JOIN Employees AS T2 ON T1.Destruction_Authorised_by_Employee_ID = T2.employee_id JOIN Employees AS T3 ON T1.Destroyed_by_Employee_ID = T3.employee_id;
SELECT T2.employee_name ,  T3.employee_name FROM Documents_to_be_destroyed AS T1 JOIN Employees AS T2 ON T1.Destruction_Authorised_by_Employee_ID = T2.employee_id JOIN Employees AS T3 ON T1.Destroyed_by_Employee_ID = T3.employee_id;
SELECT Destruction_Authorised_by_Employee_ID ,  count(*) FROM Documents_to_be_destroyed GROUP BY Destruction_Authorised_by_Employee_ID
SELECT Destruction_Authorised_by_Employee_ID ,  count(*) FROM Documents_to_be_destroyed GROUP BY Destruction_Authorised_by_Employee_ID
SELECT Destroyed_by_Employee_ID ,  count(*) FROM Documents_to_be_destroyed GROUP BY Destroyed_by_Employee_ID
SELECT Destroyed_by_Employee_ID ,  count(*) FROM Documents_to_be_destroyed GROUP BY Destroyed_by_Employee_ID
SELECT DISTINCT Destruction_Authorised_by_Employee_ID FROM Documents_to_be_destroyed
SELECT DISTINCT Destruction_Authorised_by_Employee_ID FROM Documents_to_be_destroyed
SELECT DISTINCT Destroyed_by_Employee_ID FROM Documents_to_be_destroyed
SELECT DISTINCT Destroyed_by_Employee_ID FROM Documents_to_be_destroyed
SELECT count(*) FROM club
SELECT count(*) FROM club
SELECT clubname FROM club
SELECT clubname FROM club
SELECT count(*) FROM student
SELECT count(*) FROM student
SELECT DISTINCT fname FROM student
SELECT DISTINCT fname FROM student
SELECT clubdesc FROM club WHERE clubname  =  "Tennis Club"
SELECT clubdesc FROM club WHERE clubname  =  "Tennis Club"
SELECT clubdesc FROM club WHERE clubname  =  "Pen and Paper Gaming"
SELECT clubdesc FROM club WHERE clubname  =  "Pen and Paper Gaming"
SELECT clublocation FROM club WHERE clubname  =  "Tennis Club"
SELECT clublocation FROM club WHERE clubname  =  "Tennis Club"
SELECT clublocation FROM club WHERE clubname  =  "Pen and Paper Gaming"
SELECT clublocation FROM club WHERE clubname  =  "Pen and Paper Gaming"
SELECT clublocation FROM club WHERE clubname  =  "Hopkins Student Enterprises"
SELECT clublocation FROM club WHERE clubname  =  "Hopkins Student Enterprises"
SELECT clubname FROM club WHERE clublocation  =  "AKW"
SELECT clubname FROM club WHERE clublocation  =  "AKW"
SELECT count(*) FROM club WHERE clublocation  =  "HHH"
SELECT count(*) FROM club WHERE clublocation  =  "HHH"
SELECT T1.organisation_type ,  T1.organisation_id FROM Organisations AS T1 JOIN Research_Staff AS T2 ON T1.organisation_id  =  T2.employer_organisation_id GROUP BY T1.organisation_id ORDER BY count(*) DESC LIMIT 1
SELECT T1.organisation_type ,  T1.organisation_id FROM Organisations AS T1 JOIN Research_Staff AS T2 ON T1.organisation_id  =  T2.employer_organisation_id GROUP BY T1.organisation_id ORDER BY count(*) DESC LIMIT 1
SELECT T1.organisation_type FROM Organisations AS T1 JOIN Research_Staff AS T2 ON T1.organisation_id  =  T2.employer_organisation_id GROUP BY T1.organisation_type ORDER BY count(*) DESC LIMIT 1
SELECT T1.organisation_type FROM Organisations AS T1 JOIN Research_Staff AS T2 ON T1.organisation_id  =  T2.employer_organisation_id GROUP BY T1.organisation_type ORDER BY count(*) DESC LIMIT 1
SELECT T1.sent_date FROM documents AS T1 JOIN Grants AS T2 ON T1.grant_id  =  T2.grant_id JOIN Organisations AS T3 ON T2.organisation_id  =  T3.organisation_id JOIN organisation_Types AS T4 ON T3.organisation_type  =  T4.organisation_type WHERE T2.grant_amount  >  5000 AND T4.organisation_type_description  =  'Research'
SELECT T1.sent_date FROM documents AS T1 JOIN Grants AS T2 ON T1.grant_id  =  T2.grant_id JOIN Organisations AS T3 ON T2.organisation_id  =  T3.organisation_id JOIN organisation_Types AS T4 ON T3.organisation_type  =  T4.organisation_type WHERE T2.grant_amount  >  5000 AND T4.organisation_type_description  =  'Research'
SELECT T1.response_received_date FROM Documents AS T1 JOIN Document_Types AS T2 ON T1.document_type_code  =  T2.document_type_code JOIN Grants AS T3 ON T1.grant_id  =  T3.grant_id WHERE T2.document_description  =  'Regular' OR T3.grant_amount  >  100
SELECT T1.response_received_date FROM Documents AS T1 JOIN Document_Types AS T2 ON T1.document_type_code  =  T2.document_type_code JOIN Grants AS T3 ON T1.grant_id  =  T3.grant_id WHERE T2.document_description  =  'Regular' OR T3.grant_amount  >  100
SELECT T1.project_id ,  count(*) FROM Project_Staff AS T1 JOIN Projects AS T2 ON T1.project_id  =  T2.project_id GROUP BY T1.project_id ORDER BY count(*) ASC
SELECT T1.project_id ,  count(*) FROM Project_Staff AS T1 JOIN Projects AS T2 ON T1.project_id  =  T2.project_id GROUP BY T1.project_id ORDER BY count(*) ASC
SELECT role_description FROM Staff_Roles WHERE role_code  =  'researcher'
SELECT role_description FROM Staff_Roles WHERE role_code  =  'researcher'
SELECT date_from FROM Project_Staff ORDER BY date_from ASC LIMIT 1
SELECT date_from FROM Project_Staff ORDER BY date_from ASC LIMIT 1
SELECT T1.project_details ,  T1.project_id FROM Projects AS T1 JOIN Project_outcomes AS T2 ON T1.project_id  =  T2.project_id GROUP BY T1.project_id ORDER BY count(*) DESC LIMIT 1
SELECT T1.project_details ,  T1.project_id FROM Projects AS T1 JOIN Project_outcomes AS T2 ON T1.project_id  =  T2.project_id GROUP BY T1.project_id ORDER BY count(*) DESC LIMIT 1
SELECT T1.organisation_id ,  T1.organisation_type ,  T1.organisation_details FROM Organisations AS T1 JOIN Research_Staff AS T2 ON T1.organisation_id  =  T2.employer_organisation_id GROUP BY T1.organisation_id ORDER BY count(*) DESC LIMIT 1
SELECT T1.organisation_id ,  T1.organisation_type ,  T1.organisation_details FROM Organisations AS T1 JOIN Research_Staff AS T2 ON T1.organisation_id  =  T2.employer_organisation_id GROUP BY T1.organisation_id ORDER BY count(*) DESC LIMIT 1
SELECT T1.role_description ,  T2.staff_id FROM Staff_Roles AS T1 JOIN Project_Staff AS T2 ON T1.role_code  =  T2.role_code JOIN Project_outcomes AS T3 ON T2.project_id  =  T3.project_id GROUP BY T2.staff_id ORDER BY count(*) DESC LIMIT 1
SELECT T1.role_description ,  T2.staff_id FROM Staff_Roles AS T1 JOIN Project_Staff AS T2 ON T1.role_code  =  T2.role_code JOIN Project_outcomes AS T3 ON T2.project_id  =  T3.project_id GROUP BY T2.staff_id ORDER BY count(*) DESC LIMIT 1
SELECT document_type_code FROM Document_Types WHERE document_description LIKE 'Initial%'
SELECT document_type_code FROM Document_Types WHERE document_description LIKE 'Initial%'
SELECT grant_id ,  count(*) FROM Documents GROUP BY grant_id ORDER BY count(*) DESC LIMIT 1
SELECT grant_id ,  count(*) FROM Documents GROUP BY grant_id ORDER BY count(*) DESC LIMIT 1
SELECT T1.organisation_type_description FROM organisation_Types AS T1 JOIN Organisations AS T2 ON T1.organisation_type  =  T2.organisation_type WHERE T2.organisation_details  =  'quo'
SELECT T1.organisation_type_description FROM organisation_Types AS T1 JOIN Organisations AS T2 ON T1.organisation_type  =  T2.organisation_type WHERE T2.organisation_details  =  'quo'
SELECT organisation_details FROM Organisations AS T1 JOIN organisation_Types AS T2 ON T1.organisation_type  =  T2.organisation_type WHERE T2.organisation_type_description  =  'Sponsor' ORDER BY organisation_details
SELECT organisation_details FROM Organisations AS T1 JOIN organisation_Types AS T2 ON T1.organisation_type  =  T2.organisation_type WHERE T2.organisation_type_description  =  'Sponsor' ORDER BY organisation_details
SELECT date_to FROM Project_Staff ORDER BY date_to DESC LIMIT 1
SELECT date_to FROM Project_Staff ORDER BY date_to DESC LIMIT 1
SELECT T1.outcome_description FROM Research_outcomes AS T1 JOIN Project_outcomes AS T2 ON T1.outcome_code  =  T2.outcome_code JOIN Projects AS T3 ON T2.project_id  =  T3.project_id WHERE T3.project_details  =  'sint'
SELECT T1.outcome_description FROM Research_outcomes AS T1 JOIN Project_outcomes AS T2 ON T1.outcome_code  =  T2.outcome_code JOIN Projects AS T3 ON T2.project_id  =  T3.project_id WHERE T3.project_details  =  'sint'
SELECT T1.organisation_id ,  count(*) FROM Projects AS T1 JOIN Project_outcomes AS T2 ON T1.project_id  =  T2.project_id GROUP BY T1.organisation_id ORDER BY count(*) DESC LIMIT 1
SELECT T1.organisation_id ,  count(*) FROM Projects AS T1 JOIN Project_outcomes AS T2 ON T1.project_id  =  T2.project_id GROUP BY T1.organisation_id ORDER BY count(*) DESC LIMIT 1
SELECT staff_details FROM Research_Staff ORDER BY staff_details ASC
SELECT staff_details FROM Research_Staff ORDER BY staff_details ASC
SELECT count(*) FROM Tasks
SELECT count(*) FROM Tasks
SELECT count(*) ,  T1.project_details FROM Projects AS T1 JOIN Tasks AS T2 ON T1.project_id  =  T2.project_id GROUP BY T1.project_id
SELECT count(*) ,  T1.project_details FROM Projects AS T1 JOIN Tasks AS T2 ON T1.project_id  =  T2.project_id GROUP BY T1.project_id
SELECT T1.outcome_description FROM Research_outcomes AS T1 JOIN Project_outcomes AS T2 ON T1.outcome_code  =  T2.outcome_code
SELECT T1.outcome_description FROM Research_outcomes AS T1 JOIN Project_outcomes AS T2 ON T1.outcome_code  =  T2.outcome_code
SELECT role_code FROM Project_Staff GROUP BY role_code ORDER BY count(*) DESC LIMIT 1
SELECT role_code FROM Project_Staff GROUP BY role_code ORDER BY count(*) DESC LIMIT 1
SELECT count(T2.friend) FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name  =  T2.name WHERE T1.name  =  'Dan'
SELECT count(T2.friend) FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name  =  T2.name WHERE T1.name  =  'Dan'
SELECT count(*) FROM Person WHERE gender  =  'female'
SELECT count(*) FROM Person WHERE gender  =  'female'
SELECT avg(age) FROM Person
SELECT avg(age) FROM Person
SELECT age FROM Person WHERE job  =  'doctor' AND name  =  'Zach'
SELECT age FROM Person WHERE job  =  'doctor' AND name  =  'Zach'
SELECT name FROM Person WHERE age  <  30
SELECT name FROM Person WHERE age  <  30
SELECT count(*) FROM Person WHERE age  >  30 AND job  =  'engineer'
SELECT count(*) FROM Person WHERE age  >  30 AND job  =  'engineer'
SELECT count(*) ,  gender FROM Person WHERE age  <  40 GROUP BY gender
SELECT count(*) ,  gender FROM Person WHERE age  <  40 GROUP BY gender
SELECT name ,  job FROM Person ORDER BY name
SELECT name ,  job FROM Person ORDER BY name
SELECT name FROM Person ORDER BY age DESC
SELECT name FROM Person ORDER BY age DESC
SELECT name FROM Person WHERE gender  =  'male' ORDER BY age
SELECT name FROM Person WHERE gender  =  'male' ORDER BY age
SELECT DISTINCT T1.name ,  T1.age FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name  =  T2.name WHERE T2.friend  =  'Dan' OR T2.friend  =  'Alice'
SELECT DISTINCT T1.name ,  T1.age FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name  =  T2.name WHERE T2.friend  =  'Dan' OR T2.friend  =  'Alice'
SELECT name FROM PersonFriend GROUP BY name HAVING count(*)  =  1
SELECT name FROM PersonFriend GROUP BY name HAVING count(*)  =  1
SELECT T2.friend FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name  =  T2.name WHERE T1.name  =  'Bob'
SELECT T2.friend FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name  =  T2.name WHERE T1.name  =  'Bob'
SELECT T1.name FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name  =  T2.name WHERE T2.friend  =  'Bob'
SELECT T1.name FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name  =  T2.name WHERE T2.friend  =  'Bob'
SELECT T1.name FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name  =  T2.name WHERE T2.friend  =  'Zach' AND T1.gender  =  'female'
SELECT T1.name FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name  =  T2.name WHERE T2.friend  =  'Zach' AND T1.gender  =  'female'
SELECT T2.friend FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name  =  T2.friend WHERE T2.name  =  'Alice' AND T1.gender  =  'female'
SELECT T2.friend FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name  =  T2.friend WHERE T2.name  =  'Alice' AND T1.gender  =  'female'
SELECT T2.friend FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name  =  T2.friend WHERE T2.name  =  'Alice' AND T1.gender  =  'male' AND T1.job  =  'doctor'
SELECT T2.friend FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name  =  T2.friend WHERE T2.name  =  'Alice' AND T1.gender  =  'male' AND T1.job  =  'doctor'
SELECT T2.name FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name  =  T2.friend WHERE T1.city  =  'new york city'
SELECT T2.name FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name  =  T2.friend WHERE T1.city  =  'new york city'
SELECT DISTINCT T4.name FROM PersonFriend AS T1 JOIN Person AS T2 ON T1.name  =  T2.name JOIN PersonFriend AS T3 ON T1.friend  =  T3.name JOIN PersonFriend AS T4 ON T3.friend  =  T4.name WHERE T2.name  =  'Alice' AND T4.name != 'Alice'
SELECT DISTINCT T4.name FROM PersonFriend AS T1 JOIN Person AS T2 ON T1.name  =  T2.name JOIN PersonFriend AS T3 ON T1.friend  =  T3.name JOIN PersonFriend AS T4 ON T3.friend  =  T4.name WHERE T2.name  =  'Alice' AND T4.name != 'Alice'
SELECT count(*) FROM member
SELECT Name FROM member ORDER BY Name ASC
SELECT Name ,  Country FROM member
SELECT Name FROM member WHERE Country  =  "United States" OR Country  =  "Canada"
SELECT Country ,  COUNT(*) FROM member GROUP BY Country
SELECT Country FROM member GROUP BY Country ORDER BY COUNT(*) DESC LIMIT 1
SELECT Country FROM member GROUP BY Country HAVING COUNT(*)  >  2
SELECT Leader_Name ,  College_Location FROM college
SELECT T2.Name ,  T1.Name FROM college AS T1 JOIN member AS T2 ON T1.College_ID  =  T2.College_ID
SELECT T2.Name ,  T1.College_Location FROM college AS T1 JOIN member AS T2 ON T1.College_ID  =  T2.College_ID ORDER BY T2.Name ASC
SELECT DISTINCT T1.Leader_Name FROM college AS T1 JOIN member AS T2 ON T1.College_ID  =  T2.College_ID WHERE T2.Country  =  "Canada"
SELECT T1.Name ,  T2.Decoration_Theme FROM member AS T1 JOIN round AS T2 ON T1.Member_ID  =  T2.Member_ID
SELECT T1.Name FROM member AS T1 JOIN round AS T2 ON T1.Member_ID  =  T2.Member_ID WHERE T2.Rank_in_Round  >  3
SELECT T1.Name FROM member AS T1 JOIN round AS T2 ON T1.Member_ID  =  T2.Member_ID ORDER BY Rank_in_Round ASC
SELECT Name FROM member WHERE Member_ID NOT IN (SELECT Member_ID FROM round)
SELECT document_name ,  access_count FROM documents ORDER BY document_name
SELECT document_name ,  access_count FROM documents ORDER BY document_name
SELECT document_name ,  access_count FROM documents ORDER BY access_count DESC LIMIT 1
SELECT document_name ,  access_count FROM documents ORDER BY access_count DESC LIMIT 1
SELECT document_type_code FROM documents GROUP BY document_type_code HAVING count(*)  >  4
SELECT document_type_code FROM documents GROUP BY document_type_code HAVING count(*)  >  4
SELECT avg(access_count) FROM documents
SELECT avg(access_count) FROM documents
SELECT document_type_code FROM documents WHERE document_name  =  "David CV"
SELECT document_type_code FROM documents WHERE document_name  =  "David CV"
SELECT document_name FROM documents WHERE document_code NOT IN (SELECT document_code FROM document_sections)
SELECT document_name FROM documents WHERE document_code NOT IN (SELECT document_code FROM document_sections)
SELECT document_name FROM documents WHERE document_name LIKE "%CV%"
SELECT document_name FROM documents WHERE document_name LIKE "%CV%"
SELECT image_name ,  image_url FROM images ORDER BY image_name
SELECT image_name ,  image_url FROM images ORDER BY image_name
SELECT count(*) ,  role_code FROM users GROUP BY role_code
SELECT count(*) ,  role_code FROM users GROUP BY role_code
SELECT document_type_code FROM documents GROUP BY document_type_code HAVING count(*)  >  2
SELECT document_type_code FROM documents GROUP BY document_type_code HAVING count(*)  >  2
SELECT count(*) FROM Companies
SELECT count(*) FROM Companies
SELECT name FROM Companies ORDER BY Market_Value_billion DESC
SELECT name FROM Companies ORDER BY Market_Value_billion DESC
SELECT name FROM Companies WHERE Headquarters != 'USA'
SELECT name FROM Companies WHERE Headquarters != 'USA'
SELECT name ,  Assets_billion FROM Companies ORDER BY name ASC
SELECT name ,  Assets_billion FROM Companies ORDER BY name ASC
SELECT max(Sales_billion) ,  min(Sales_billion) FROM Companies WHERE Industry != "Banking"
SELECT max(Sales_billion) ,  min(Sales_billion) FROM Companies WHERE Industry != "Banking"
SELECT name FROM buildings ORDER BY Height DESC
SELECT name FROM buildings ORDER BY Height DESC
SELECT Stories FROM buildings ORDER BY Height DESC LIMIT 1
SELECT Stories FROM buildings ORDER BY Height DESC LIMIT 1
SELECT T3.name ,  T2.name FROM Office_locations AS T1 JOIN buildings AS T2 ON T1.building_id  =  T2.id JOIN Companies AS T3 ON T1.company_id  =  T3.id
SELECT T3.name ,  T2.name FROM Office_locations AS T1 JOIN buildings AS T2 ON T1.building_id  =  T2.id JOIN Companies AS T3 ON T1.company_id  =  T3.id
SELECT T2.name FROM Office_locations AS T1 JOIN buildings AS T2 ON T1.building_id  =  T2.id JOIN Companies AS T3 ON T1.company_id  =  T3.id GROUP BY T1.building_id HAVING COUNT(*)  >  1
SELECT T2.name FROM Office_locations AS T1 JOIN buildings AS T2 ON T1.building_id  =  T2.id JOIN Companies AS T3 ON T1.company_id  =  T3.id GROUP BY T1.building_id HAVING COUNT(*)  >  1
SELECT name FROM buildings WHERE Status  =  "on-hold" ORDER BY Stories ASC
SELECT name FROM buildings WHERE Status  =  "on-hold" ORDER BY Stories ASC
SELECT Industry ,  COUNT(*) FROM Companies GROUP BY Industry
SELECT Industry ,  COUNT(*) FROM Companies GROUP BY Industry
SELECT Industry FROM Companies GROUP BY Industry ORDER BY COUNT(*) DESC
SELECT Industry FROM Companies GROUP BY Industry ORDER BY COUNT(*) DESC
SELECT Industry FROM Companies GROUP BY Industry ORDER BY COUNT(*) DESC LIMIT 1
SELECT Industry FROM Companies GROUP BY Industry ORDER BY COUNT(*) DESC LIMIT 1
SELECT name FROM buildings WHERE id NOT IN (SELECT building_id FROM Office_locations)
SELECT name FROM buildings WHERE id NOT IN (SELECT building_id FROM Office_locations)
SELECT count(*) FROM Companies WHERE Industry  =  "Banking" OR Industry  =  "Conglomerate"
SELECT count(*) FROM Companies WHERE Industry  =  "Banking" OR Industry  =  "Conglomerate"
SELECT Headquarters FROM Companies GROUP BY Headquarters HAVING COUNT(*)  >  2
SELECT Headquarters FROM Companies GROUP BY Headquarters HAVING COUNT(*)  >  2
SELECT count(*) FROM Products
SELECT Product_Name FROM Products ORDER BY Product_Price ASC
SELECT Product_Name ,  Product_Type_Code FROM Products
SELECT Product_Price FROM Products WHERE Product_Name  =  "Dining" OR Product_Name  =  "Trading Policy"
SELECT Product_Name FROM Products ORDER BY Product_Price DESC LIMIT 1
SELECT Product_Type_Code ,  COUNT(*) FROM Products GROUP BY Product_Type_Code
SELECT Product_Type_Code FROM Products GROUP BY Product_Type_Code ORDER BY COUNT(*) DESC LIMIT 1
SELECT Product_Type_Code FROM Products GROUP BY Product_Type_Code HAVING COUNT(*)  >=  2
SELECT T1.Product_Name ,  COUNT(*) FROM Products AS T1 JOIN Products_in_Events AS T2 ON T1.Product_ID  =  T2.Product_ID GROUP BY T1.Product_Name
SELECT T1.Product_Name ,  COUNT(*) FROM Products AS T1 JOIN Products_in_Events AS T2 ON T1.Product_ID  =  T2.Product_ID GROUP BY T1.Product_Name ORDER BY COUNT(*) DESC
SELECT T1.Product_Name FROM Products AS T1 JOIN Products_in_Events AS T2 ON T1.Product_ID  =  T2.Product_ID GROUP BY T1.Product_Name HAVING COUNT(*)  >=  2
SELECT count(*) FROM artwork
SELECT Name FROM artwork ORDER BY Name ASC
SELECT Name FROM artwork WHERE TYPE != "Program Talent Show"
SELECT Festival_Name ,  LOCATION FROM festival_detail
SELECT Chair_Name FROM festival_detail ORDER BY YEAR ASC
SELECT LOCATION FROM festival_detail ORDER BY Num_of_Audience DESC LIMIT 1
SELECT Festival_Name FROM festival_detail WHERE YEAR  =  2007
SELECT avg(Num_of_Audience) FROM festival_detail
SELECT T2.Name ,  T3.Festival_Name FROM nomination AS T1 JOIN artwork AS T2 ON T1.Artwork_ID  =  T2.Artwork_ID JOIN festival_detail AS T3 ON T1.Festival_ID  =  T3.Festival_ID
SELECT DISTINCT T2.Type FROM nomination AS T1 JOIN artwork AS T2 ON T1.Artwork_ID  =  T2.Artwork_ID JOIN festival_detail AS T3 ON T1.Festival_ID  =  T3.Festival_ID WHERE T3.Year  =  2007
SELECT T2.Name FROM nomination AS T1 JOIN artwork AS T2 ON T1.Artwork_ID  =  T2.Artwork_ID JOIN festival_detail AS T3 ON T1.Festival_ID  =  T3.Festival_ID ORDER BY T3.Year
SELECT T3.Festival_Name FROM nomination AS T1 JOIN artwork AS T2 ON T1.Artwork_ID  =  T2.Artwork_ID JOIN festival_detail AS T3 ON T1.Festival_ID  =  T3.Festival_ID WHERE T2.Type  =  "Program Talent Show"
SELECT T1.Festival_ID ,  T3.Festival_Name FROM nomination AS T1 JOIN artwork AS T2 ON T1.Artwork_ID  =  T2.Artwork_ID JOIN festival_detail AS T3 ON T1.Festival_ID  =  T3.Festival_ID GROUP BY T1.Festival_ID HAVING COUNT(*)  >=  2
SELECT T1.Festival_ID ,  T3.Festival_Name ,  COUNT(*) FROM nomination AS T1 JOIN artwork AS T2 ON T1.Artwork_ID  =  T2.Artwork_ID JOIN festival_detail AS T3 ON T1.Festival_ID  =  T3.Festival_ID GROUP BY T1.Festival_ID
SELECT TYPE ,  COUNT(*) FROM artwork GROUP BY TYPE
SELECT TYPE FROM artwork GROUP BY TYPE ORDER BY COUNT(*) DESC LIMIT 1
SELECT YEAR FROM festival_detail GROUP BY YEAR HAVING COUNT(*)  >  1
SELECT Name FROM Artwork WHERE Artwork_ID NOT IN (SELECT Artwork_ID FROM nomination)
SELECT Num_of_Audience FROM festival_detail WHERE YEAR  =  2008 OR YEAR  =  2010
SELECT count(*) FROM premises
SELECT DISTINCT premises_type FROM premises
SELECT premises_type ,  premise_details FROM premises ORDER BY premises_type
SELECT premises_type ,  count(*) FROM premises GROUP BY premises_type
SELECT product_category ,  count(*) FROM mailshot_campaigns GROUP BY product_category
SELECT T1.customer_name ,  T1.customer_phone FROM customers AS T1 JOIN mailshot_customers AS T2 ON T1.customer_id  =  T2.customer_id WHERE T2.outcome_code  =  'No Response'
SELECT outcome_code ,  count(*) FROM mailshot_customers GROUP BY outcome_code
SELECT T2.customer_name FROM mailshot_customers AS T1 JOIN customers AS T2 ON T1.customer_id  =  T2.customer_id WHERE outcome_code  =  'Order' GROUP BY T1.customer_id HAVING count(*)  >=  2
SELECT T2.customer_name FROM mailshot_customers AS T1 JOIN customers AS T2 ON T1.customer_id  =  T2.customer_id GROUP BY T1.customer_id ORDER BY count(*) DESC LIMIT 1
SELECT T2.premises_type ,  T1.address_type_code FROM customer_addresses AS T1 JOIN premises AS T2 ON T1.premise_id  =  T2.premise_id
SELECT DISTINCT address_type_code FROM customer_addresses
SELECT order_shipping_charges ,  customer_id FROM customer_orders WHERE order_status_code  =  'Cancelled' OR order_status_code  =  'Paid'
SELECT T1.customer_name FROM customers AS T1 JOIN customer_orders AS T2 ON T1.customer_id  =  T2.customer_id WHERE shipping_method_code  =  'FedEx' AND order_status_code  =  'Paid'
SELECT count(*) FROM COURSE
SELECT count(*) FROM COURSE
SELECT count(*) FROM COURSE WHERE Credits  >  2
SELECT count(*) FROM COURSE WHERE Credits  >  2
SELECT CName FROM COURSE WHERE Credits  =  1
SELECT CName FROM COURSE WHERE Credits  =  1
SELECT CName FROM COURSE WHERE Days  =  "MTW"
SELECT CName FROM COURSE WHERE Days  =  "MTW"
SELECT count(*) FROM DEPARTMENT WHERE Division  =  "AS"
SELECT count(*) FROM DEPARTMENT WHERE Division  =  "AS"
SELECT DPhone FROM DEPARTMENT WHERE Room  =  268
SELECT DPhone FROM DEPARTMENT WHERE Room  =  268
SELECT max(gradepoint) ,  min(gradepoint) FROM GRADECONVERSION
SELECT max(gradepoint) ,  min(gradepoint) FROM GRADECONVERSION
SELECT DISTINCT Fname FROM STUDENT WHERE Fname LIKE '%a%'
SELECT DISTINCT Fname FROM STUDENT WHERE Fname LIKE '%a%'
SELECT Fname ,  Lname FROM FACULTY WHERE sex  =  "M" AND Building  =  "NEB"
SELECT Fname ,  Lname FROM FACULTY WHERE sex  =  "M" AND Building  =  "NEB"
SELECT Room FROM FACULTY WHERE Rank  =  "Professor" AND Building  =  "NEB"
SELECT Room FROM FACULTY WHERE Rank  =  "Professor" AND Building  =  "NEB"
SELECT DName FROM DEPARTMENT WHERE Building  =  "Mergenthaler"
SELECT DName FROM DEPARTMENT WHERE Building  =  "Mergenthaler"
SELECT CName FROM COURSE ORDER BY Credits
SELECT CName FROM COURSE ORDER BY Credits
SELECT Fname FROM STUDENT ORDER BY Age DESC
SELECT Fname FROM STUDENT ORDER BY Age DESC
SELECT LName FROM STUDENT WHERE Sex  =  "F" ORDER BY Age DESC
SELECT LName FROM STUDENT WHERE Sex  =  "F" ORDER BY Age DESC
SELECT Lname FROM FACULTY WHERE Building  =  "Barton" ORDER BY Lname
SELECT Lname FROM FACULTY WHERE Building  =  "Barton" ORDER BY Lname
SELECT Fname FROM FACULTY WHERE Rank  =  "Professor" ORDER BY Fname
SELECT Fname FROM FACULTY WHERE Rank  =  "Professor" ORDER BY Fname
SELECT T1.DName FROM DEPARTMENT AS T1 JOIN MINOR_IN AS T2 ON T1.DNO  =  T2.DNO GROUP BY T2.DNO ORDER BY count(*) DESC LIMIT 1
SELECT T1.DName FROM DEPARTMENT AS T1 JOIN MINOR_IN AS T2 ON T1.DNO  =  T2.DNO GROUP BY T2.DNO ORDER BY count(*) DESC LIMIT 1
SELECT T1.DName FROM DEPARTMENT AS T1 JOIN MEMBER_OF AS T2 ON T1.DNO  =  T2.DNO GROUP BY T2.DNO ORDER BY count(*) ASC LIMIT 1
SELECT T1.DName FROM DEPARTMENT AS T1 JOIN MEMBER_OF AS T2 ON T1.DNO  =  T2.DNO GROUP BY T2.DNO ORDER BY count(*) ASC LIMIT 1
SELECT T2.Fname ,  T2.Lname FROM COURSE AS T1 JOIN FACULTY AS T2 ON T1.Instructor  =  T2.FacID GROUP BY T1.Instructor ORDER BY count(*) DESC LIMIT 3
SELECT T2.Fname ,  T2.Lname FROM COURSE AS T1 JOIN FACULTY AS T2 ON T1.Instructor  =  T2.FacID GROUP BY T1.Instructor ORDER BY count(*) DESC LIMIT 3
SELECT T2.Building FROM COURSE AS T1 JOIN FACULTY AS T2 ON T1.Instructor  =  T2.FacID GROUP BY T1.Instructor ORDER BY count(*) DESC LIMIT 1
SELECT T2.Building FROM COURSE AS T1 JOIN FACULTY AS T2 ON T1.Instructor  =  T2.FacID GROUP BY T1.Instructor ORDER BY count(*) DESC LIMIT 1
SELECT T1.CName FROM COURSE AS T1 JOIN ENROLLED_IN AS T2 ON T1.CID  =  T2.CID GROUP BY T2.CID HAVING COUNT(*)  >=  5
SELECT T1.CName FROM COURSE AS T1 JOIN ENROLLED_IN AS T2 ON T1.CID  =  T2.CID GROUP BY T2.CID HAVING COUNT(*)  >=  5
SELECT T2.Fname ,  T2.Lname FROM COURSE AS T1 JOIN FACULTY AS T2 ON T1.Instructor  =  T2.FacID WHERE T1.CName  =  "COMPUTER LITERACY"
SELECT T2.Fname ,  T2.Lname FROM COURSE AS T1 JOIN FACULTY AS T2 ON T1.Instructor  =  T2.FacID WHERE T1.CName  =  "COMPUTER LITERACY"
SELECT T2.Dname ,  T2.Room FROM COURSE AS T1 JOIN DEPARTMENT AS T2 ON T1.DNO  =  T2.DNO WHERE T1.CName  =  "INTRODUCTION TO COMPUTER SCIENCE"
SELECT T2.Dname ,  T2.Room FROM COURSE AS T1 JOIN DEPARTMENT AS T2 ON T1.DNO  =  T2.DNO WHERE T1.CName  =  "INTRODUCTION TO COMPUTER SCIENCE"
SELECT T1.Fname ,  T1.Lname FROM FACULTY AS T1 JOIN MEMBER_OF AS T2 ON T1.FacID  =  T2.FacID WHERE T2.DNO  =  520
SELECT T1.Fname ,  T1.Lname FROM FACULTY AS T1 JOIN MEMBER_OF AS T2 ON T1.FacID  =  T2.FacID WHERE T2.DNO  =  520
SELECT T2.Fname ,  T2.Lname FROM MINOR_IN AS T1 JOIN STUDENT AS T2 ON T1.StuID  =  T2.StuID WHERE T1.DNO  =  140
SELECT T2.Fname ,  T2.Lname FROM MINOR_IN AS T1 JOIN STUDENT AS T2 ON T1.StuID  =  T2.StuID WHERE T1.DNO  =  140
SELECT T2.Lname FROM DEPARTMENT AS T1 JOIN FACULTY AS T2 ON T1.DNO  =  T3.DNO JOIN MEMBER_OF AS T3 ON T2.FacID  =  T3.FacID WHERE T1.DName  =  "Computer Science"
SELECT T2.Lname FROM DEPARTMENT AS T1 JOIN FACULTY AS T2 ON T1.DNO  =  T3.DNO JOIN MEMBER_OF AS T3 ON T2.FacID  =  T3.FacID WHERE T1.DName  =  "Computer Science"
SELECT CName FROM COURSE WHERE Credits  =  3 UNION SELECT CName FROM COURSE WHERE Credits  =  1 AND Hours  =  4
SELECT CName FROM COURSE WHERE Credits  =  3 UNION SELECT CName FROM COURSE WHERE Credits  =  1 AND Hours  =  4
SELECT DName FROM DEPARTMENT WHERE Division  =  "AS" UNION SELECT DName FROM DEPARTMENT WHERE Division  =  "EN" AND Building  =  "NEB"
SELECT DName FROM DEPARTMENT WHERE Division  =  "AS" UNION SELECT DName FROM DEPARTMENT WHERE Division  =  "EN" AND Building  =  "NEB"
SELECT Fname FROM STUDENT WHERE StuID NOT IN (SELECT StuID FROM ENROLLED_IN)
SELECT Fname FROM STUDENT WHERE StuID NOT IN (SELECT StuID FROM ENROLLED_IN)
SELECT product_id ,  product_type_code FROM products ORDER BY product_price LIMIT 1
SELECT product_id ,  product_type_code FROM products ORDER BY product_price LIMIT 1
SELECT T1.address_details FROM addresses AS T1 JOIN customer_addresses AS T2 ON T1.address_id  =  T2.address_id WHERE T2.customer_id  =  10
SELECT T1.address_details FROM addresses AS T1 JOIN customer_addresses AS T2 ON T1.address_id  =  T2.address_id WHERE T2.customer_id  =  10
SELECT T1.staff_id ,  T1.staff_gender FROM staff AS T1 JOIN staff_department_assignments AS T2 ON T1.staff_id  =  T2.staff_id WHERE T2.job_title_code  =  "Department Manager"
SELECT T1.staff_id ,  T1.staff_gender FROM staff AS T1 JOIN staff_department_assignments AS T2 ON T1.staff_id  =  T2.staff_id WHERE T2.job_title_code  =  "Department Manager"
SELECT payment_method_code ,  count(*) FROM customers GROUP BY payment_method_code
SELECT payment_method_code ,  count(*) FROM customers GROUP BY payment_method_code
SELECT product_id FROM order_items GROUP BY product_id ORDER BY count(*) DESC LIMIT 1
SELECT product_id FROM order_items GROUP BY product_id ORDER BY count(*) DESC LIMIT 1
SELECT T1.customer_name ,  T1.customer_phone ,  T1.customer_email FROM customers AS T1 JOIN customer_orders AS T2 ON T1.customer_id  =  T2.customer_id GROUP BY T2.customer_id ORDER BY count(*) DESC LIMIT 1
SELECT T1.customer_name ,  T1.customer_phone ,  T1.customer_email FROM customers AS T1 JOIN customer_orders AS T2 ON T1.customer_id  =  T2.customer_id GROUP BY T2.customer_id ORDER BY count(*) DESC LIMIT 1
SELECT count(*) FROM department_stores AS T1 JOIN department_store_chain AS T2 ON T1.dept_store_chain_id  =  T2.dept_store_chain_id WHERE T2.dept_store_chain_name  =  "South"
SELECT count(*) FROM department_stores AS T1 JOIN department_store_chain AS T2 ON T1.dept_store_chain_id  =  T2.dept_store_chain_id WHERE T2.dept_store_chain_name  =  "South"
SELECT T2.product_type_code ,  T2.product_name ,  T2.product_price FROM product_suppliers AS T1 JOIN products AS T2 ON T1.product_id  =  T2.product_id WHERE T1.supplier_id  =  3
SELECT T2.product_type_code ,  T2.product_name ,  T2.product_price FROM product_suppliers AS T1 JOIN products AS T2 ON T1.product_id  =  T2.product_id WHERE T1.supplier_id  =  3
SELECT dept_store_chain_id FROM department_stores GROUP BY dept_store_chain_id ORDER BY count(*) DESC LIMIT 2
SELECT dept_store_chain_id FROM department_stores GROUP BY dept_store_chain_id ORDER BY count(*) DESC LIMIT 2
SELECT product_name ,  product_id FROM products WHERE product_price BETWEEN 600 AND 700
SELECT product_name ,  product_id FROM products WHERE product_price BETWEEN 600 AND 700
SELECT customer_name ,  customer_id FROM customers WHERE customer_address LIKE "%TN%"
SELECT customer_name ,  customer_id FROM customers WHERE customer_address LIKE "%TN%"
SELECT T1.staff_name FROM staff AS T1 JOIN staff_department_assignments AS T2 ON T1.staff_id  =  T2.staff_id GROUP BY T2.staff_id HAVING COUNT (*)  >  1
SELECT T1.staff_name FROM staff AS T1 JOIN staff_department_assignments AS T2 ON T1.staff_id  =  T2.staff_id GROUP BY T2.staff_id HAVING COUNT (*)  >  1
SELECT T1.supplier_name ,  T1.supplier_phone FROM Suppliers AS T1 JOIN supplier_addresses AS T2 ON T1.supplier_id  =  T2.supplier_id JOIN addresses AS T3 ON T2.address_id  =  T3.address_id ORDER BY T3.address_details
SELECT T1.supplier_name ,  T1.supplier_phone FROM Suppliers AS T1 JOIN supplier_addresses AS T2 ON T1.supplier_id  =  T2.supplier_id JOIN addresses AS T3 ON T2.address_id  =  T3.address_id ORDER BY T3.address_details
SELECT product_id ,  product_name FROM products WHERE product_price  <  600 OR product_price  >  900
SELECT product_id ,  product_name FROM products WHERE product_price  <  600 OR product_price  >  900
SELECT max(customer_code) ,  min(customer_code) FROM Customers
SELECT max(customer_code) ,  min(customer_code) FROM Customers
SELECT DISTINCT T1.customer_name FROM customers AS T1 JOIN customer_orders AS T2 ON T1.customer_id  =  T2.customer_id JOIN order_items AS T3 ON T2.order_id  =  T3.order_id JOIN products AS T4 ON T3.product_id  =  T4.product_id WHERE T4.product_name  =  "keyboard"
SELECT DISTINCT T1.customer_name FROM customers AS T1 JOIN customer_orders AS T2 ON T1.customer_id  =  T2.customer_id JOIN order_items AS T3 ON T2.order_id  =  T3.order_id JOIN products AS T4 ON T3.product_id  =  T4.product_id WHERE T4.product_name  =  "keyboard"
SELECT DISTINCT T1.supplier_name ,  T1.supplier_phone FROM suppliers AS T1 JOIN product_suppliers AS T2 ON T1.supplier_id  =  T2.supplier_id JOIN products AS T3 ON T2.product_id  =  T3.product_id WHERE T3.product_name  =  "red jeans"
SELECT DISTINCT T1.supplier_name ,  T1.supplier_phone FROM suppliers AS T1 JOIN product_suppliers AS T2 ON T1.supplier_id  =  T2.supplier_id JOIN products AS T3 ON T2.product_id  =  T3.product_id WHERE T3.product_name  =  "red jeans"
SELECT order_id ,  customer_id FROM customer_orders WHERE order_status_code  =   "Cancelled" ORDER BY order_date
SELECT order_id ,  customer_id FROM customer_orders WHERE order_status_code  =   "Cancelled" ORDER BY order_date
SELECT customer_id ,  customer_name FROM customers WHERE customer_address LIKE "%WY%" AND payment_method_code != "Credit Card"
SELECT customer_id ,  customer_name FROM customers WHERE customer_address LIKE "%WY%" AND payment_method_code != "Credit Card"
SELECT avg(product_price) FROM products WHERE product_type_code  =  'Clothes'
SELECT avg(product_price) FROM products WHERE product_type_code  =  'Clothes'
SELECT product_name FROM products WHERE product_type_code  =  'Hardware' ORDER BY product_price DESC LIMIT 1
SELECT product_name FROM products WHERE product_type_code  =  'Hardware' ORDER BY product_price DESC LIMIT 1
SELECT count(*) FROM aircraft
SELECT count(*) FROM aircraft
SELECT Description FROM aircraft
SELECT Description FROM aircraft
SELECT avg(International_Passengers) FROM airport
SELECT avg(International_Passengers) FROM airport
SELECT International_Passengers ,  Domestic_Passengers FROM airport WHERE Airport_Name  =  "London Heathrow"
SELECT International_Passengers ,  Domestic_Passengers FROM airport WHERE Airport_Name  =  "London Heathrow"
SELECT max(Transit_Passengers) ,  min(Transit_Passengers) FROM airport
SELECT max(Transit_Passengers) ,  min(Transit_Passengers) FROM airport
SELECT Name FROM pilot WHERE Age  >=  25
SELECT Name FROM pilot WHERE Age  >=  25
SELECT Name FROM pilot ORDER BY Name ASC
SELECT Name FROM pilot ORDER BY Name ASC
SELECT Name FROM pilot WHERE Age  <=  30 ORDER BY Name DESC
SELECT Name FROM pilot WHERE Age  <=  30 ORDER BY Name DESC
SELECT T1.Aircraft FROM aircraft AS T1 JOIN airport_aircraft AS T2 ON T1.Aircraft_ID  =  T2.Aircraft_ID JOIN airport AS T3 ON T2.Airport_ID  =  T3.Airport_ID WHERE T3.Airport_Name  =  "London Gatwick"
SELECT T1.Aircraft FROM aircraft AS T1 JOIN airport_aircraft AS T2 ON T1.Aircraft_ID  =  T2.Aircraft_ID JOIN airport AS T3 ON T2.Airport_ID  =  T3.Airport_ID WHERE T3.Airport_Name  =  "London Gatwick"
SELECT T1.Aircraft ,  T1.Description FROM aircraft AS T1 JOIN airport_aircraft AS T2 ON T1.Aircraft_ID  =  T2.Aircraft_ID JOIN airport AS T3 ON T2.Airport_ID  =  T3.Airport_ID WHERE T3.Total_Passengers  >  10000000
SELECT T1.Aircraft ,  T1.Description FROM aircraft AS T1 JOIN airport_aircraft AS T2 ON T1.Aircraft_ID  =  T2.Aircraft_ID JOIN airport AS T3 ON T2.Airport_ID  =  T3.Airport_ID WHERE T3.Total_Passengers  >  10000000
SELECT avg(T3.Total_Passengers) FROM aircraft AS T1 JOIN airport_aircraft AS T2 ON T1.Aircraft_ID  =  T2.Aircraft_ID JOIN airport AS T3 ON T2.Airport_ID  =  T3.Airport_ID WHERE T1.Aircraft  =  "Robinson R-22"
SELECT avg(T3.Total_Passengers) FROM aircraft AS T1 JOIN airport_aircraft AS T2 ON T1.Aircraft_ID  =  T2.Aircraft_ID JOIN airport AS T3 ON T2.Airport_ID  =  T3.Airport_ID WHERE T1.Aircraft  =  "Robinson R-22"
SELECT T2.Location ,  T1.Aircraft FROM aircraft AS T1 JOIN MATCH AS T2 ON T1.Aircraft_ID  =  T2.Winning_Aircraft
SELECT T2.Location ,  T1.Aircraft FROM aircraft AS T1 JOIN MATCH AS T2 ON T1.Aircraft_ID  =  T2.Winning_Aircraft
SELECT T1.Aircraft FROM aircraft AS T1 JOIN MATCH AS T2 ON T1.Aircraft_ID  =  T2.Winning_Aircraft GROUP BY T2.Winning_Aircraft ORDER BY COUNT(*) DESC LIMIT 1
SELECT T1.Aircraft FROM aircraft AS T1 JOIN MATCH AS T2 ON T1.Aircraft_ID  =  T2.Winning_Aircraft GROUP BY T2.Winning_Aircraft ORDER BY COUNT(*) DESC LIMIT 1
SELECT T1.Aircraft ,  COUNT(*) FROM aircraft AS T1 JOIN MATCH AS T2 ON T1.Aircraft_ID  =  T2.Winning_Aircraft GROUP BY T2.Winning_Aircraft
SELECT T1.Aircraft ,  COUNT(*) FROM aircraft AS T1 JOIN MATCH AS T2 ON T1.Aircraft_ID  =  T2.Winning_Aircraft GROUP BY T2.Winning_Aircraft
SELECT Name FROM pilot ORDER BY Age DESC
SELECT Name FROM pilot ORDER BY Age DESC
SELECT T1.Aircraft FROM aircraft AS T1 JOIN MATCH AS T2 ON T1.Aircraft_ID  =  T2.Winning_Aircraft GROUP BY T2.Winning_Aircraft HAVING COUNT(*)  >=  2
SELECT T1.Aircraft FROM aircraft AS T1 JOIN MATCH AS T2 ON T1.Aircraft_ID  =  T2.Winning_Aircraft GROUP BY T2.Winning_Aircraft HAVING COUNT(*)  >=  2
SELECT T1.property_id ,  count(*) FROM properties AS T1 JOIN residents AS T2 ON T1.property_id  =  T2.property_id GROUP BY T1.property_id
SELECT DISTINCT T1.service_type_code FROM services AS T1 JOIN organizations AS T2 ON T1.organization_id  =  T2.organization_id WHERE T2.organization_details  =  'Denesik and Sons Party'
SELECT T1.resident_id ,  T1.other_details ,  count(*) FROM Residents AS T1 JOIN Residents_Services AS T2 ON T1.resident_id  =  T2.resident_id GROUP BY T1.resident_id ORDER BY count(*) DESC
SELECT T1.service_id ,  T1.service_details ,  count(*) FROM Services AS T1 JOIN Residents_Services AS T2 ON T1.service_id  =  T2.service_id GROUP BY T1.service_id ORDER BY count(*) DESC LIMIT 1
SELECT T1.thing_id ,  T1.type_of_Thing_Code ,  T2.organization_details FROM Things AS T1 JOIN Organizations AS T2 ON T1.organization_id  =  T2.organization_id
SELECT T1.customer_id ,  T1.customer_details FROM Customers AS T1 JOIN Customer_Events AS T2 ON T1.customer_id  =  T2.customer_id GROUP BY T1.customer_id HAVING count(*)  >=  3
SELECT T2.date_moved_in ,  T1.customer_id ,  T1.customer_details FROM Customers AS T1 JOIN Customer_Events AS T2 ON T1.customer_id  =  T2.customer_id
SELECT DISTINCT T2.thing_id ,  T2.Type_of_Thing_Code FROM Timed_Status_of_Things AS T1 JOIN Things AS T2 ON T1.thing_id  =  T2.thing_id WHERE T1.Status_of_Thing_Code  =  'Close' OR T1.Date_and_Date  <  '2017-06-19 02:59:21'
SELECT max(date_moved_in) FROM Residents
SELECT other_details FROM Residents WHERE other_details LIKE '%Miss%'
SELECT customer_event_id ,  date_moved_in ,  property_id FROM customer_events
SELECT count(*) FROM customers WHERE customer_id NOT IN ( SELECT customer_id FROM customer_events )
SELECT DISTINCT date_moved_in FROM residents
SELECT count(*) FROM school
SELECT count(*) FROM school
SELECT LOCATION FROM school ORDER BY Enrollment ASC
SELECT LOCATION FROM school ORDER BY Enrollment ASC
SELECT LOCATION FROM school ORDER BY Founded DESC
SELECT LOCATION FROM school ORDER BY Founded DESC
SELECT Enrollment FROM school WHERE Denomination != "Catholic"
SELECT Enrollment FROM school WHERE Denomination != "Catholic"
SELECT avg(Enrollment) FROM school
SELECT avg(Enrollment) FROM school
SELECT Team FROM player ORDER BY Team ASC
SELECT Team FROM player ORDER BY Team ASC
SELECT Team FROM player ORDER BY Age DESC LIMIT 1
SELECT Team FROM player ORDER BY Age DESC LIMIT 1
SELECT Team FROM player ORDER BY Age DESC LIMIT 5
SELECT Team FROM player ORDER BY Age DESC LIMIT 5
SELECT T1.Team ,  T2.Location FROM player AS T1 JOIN school AS T2 ON T1.School_ID  =  T2.School_ID
SELECT T1.Team ,  T2.Location FROM player AS T1 JOIN school AS T2 ON T1.School_ID  =  T2.School_ID
SELECT T2.Location FROM player AS T1 JOIN school AS T2 ON T1.School_ID  =  T2.School_ID GROUP BY T1.School_ID HAVING COUNT(*)  >  1
SELECT T2.Location FROM player AS T1 JOIN school AS T2 ON T1.School_ID  =  T2.School_ID GROUP BY T1.School_ID HAVING COUNT(*)  >  1
SELECT T2.Denomination FROM player AS T1 JOIN school AS T2 ON T1.School_ID  =  T2.School_ID GROUP BY T1.School_ID ORDER BY COUNT(*) DESC LIMIT 1
SELECT T2.Denomination FROM player AS T1 JOIN school AS T2 ON T1.School_ID  =  T2.School_ID GROUP BY T1.School_ID ORDER BY COUNT(*) DESC LIMIT 1
SELECT T1.Location ,  T2.Nickname FROM school AS T1 JOIN school_details AS T2 ON T1.School_ID  =  T2.School_ID
SELECT T1.Location ,  T2.Nickname FROM school AS T1 JOIN school_details AS T2 ON T1.School_ID  =  T2.School_ID
SELECT Denomination ,  COUNT(*) FROM school GROUP BY Denomination
SELECT Denomination ,  COUNT(*) FROM school GROUP BY Denomination
SELECT Denomination ,  COUNT(*) FROM school GROUP BY Denomination ORDER BY COUNT(*) DESC
SELECT Denomination ,  COUNT(*) FROM school GROUP BY Denomination ORDER BY COUNT(*) DESC
SELECT School_Colors FROM school ORDER BY Enrollment DESC LIMIT 1
SELECT School_Colors FROM school ORDER BY Enrollment DESC LIMIT 1
SELECT LOCATION FROM school WHERE School_ID NOT IN (SELECT School_ID FROM Player)
SELECT LOCATION FROM school WHERE School_ID NOT IN (SELECT School_ID FROM Player)
SELECT Nickname FROM school_details WHERE Division != "Division 1"
SELECT Nickname FROM school_details WHERE Division != "Division 1"
SELECT Denomination FROM school GROUP BY Denomination HAVING COUNT(*)  >  1
SELECT Denomination FROM school GROUP BY Denomination HAVING COUNT(*)  >  1
SELECT max_page_size FROM product GROUP BY max_page_size HAVING count(*)  >  3
SELECT max_page_size FROM product GROUP BY max_page_size HAVING count(*)  >  3
SELECT District_name ,  City_Population FROM district WHERE City_Population BETWEEN 200000 AND 2000000
SELECT District_name ,  City_Population FROM district WHERE City_Population BETWEEN 200000 AND 2000000
SELECT district_name FROM district WHERE city_area  >  10 OR City_Population  >  100000
SELECT district_name FROM district WHERE city_area  >  10 OR City_Population  >  100000
SELECT district_name FROM district ORDER BY city_population DESC LIMIT 1
SELECT district_name FROM district ORDER BY city_population DESC LIMIT 1
SELECT district_name FROM district ORDER BY city_area ASC LIMIT 1
SELECT district_name FROM district ORDER BY city_area ASC LIMIT 1
SELECT TYPE ,  count(*) FROM store GROUP BY TYPE
SELECT TYPE ,  count(*) FROM store GROUP BY TYPE
SELECT avg(pages_per_minute_color) FROM product
SELECT avg(pages_per_minute_color) FROM product
SELECT product FROM product WHERE max_page_size  =  "A4" AND pages_per_minute_color  <  5
SELECT product FROM product WHERE max_page_size  =  "A4" AND pages_per_minute_color  <  5
SELECT product FROM product WHERE max_page_size  =  "A4" OR pages_per_minute_color  <  5
SELECT product FROM product WHERE max_page_size  =  "A4" OR pages_per_minute_color  <  5
SELECT product FROM product WHERE product LIKE "%Scanner%"
SELECT product FROM product WHERE product LIKE "%Scanner%"
SELECT max_page_size FROM product GROUP BY max_page_size ORDER BY count(*) DESC LIMIT 1
SELECT max_page_size FROM product GROUP BY max_page_size ORDER BY count(*) DESC LIMIT 1
SELECT avg(enr) FROM College
SELECT avg(enr) FROM College
SELECT count(*) FROM College
SELECT count(*) FROM College
SELECT count(*) FROM Player WHERE HS  >  1000
SELECT count(*) FROM Player WHERE HS  >  1000
SELECT count(*) FROM College WHERE enr  >  15000
SELECT count(*) FROM College WHERE enr  >  15000
SELECT avg(HS) FROM Player
SELECT avg(HS) FROM Player
SELECT pName ,  HS FROM Player WHERE HS  <  1500
SELECT pName ,  HS FROM Player WHERE HS  <  1500
SELECT avg(HS) ,  max(HS) ,  min(HS) FROM Player
SELECT avg(HS) ,  max(HS) ,  min(HS) FROM Player
SELECT avg(enr) FROM College WHERE state  =  'FL'
SELECT avg(enr) FROM College WHERE state  =  'FL'
SELECT pName FROM Player WHERE HS BETWEEN 500 AND 1500
SELECT pName FROM Player WHERE HS BETWEEN 500 AND 1500
SELECT DISTINCT pName FROM Player WHERE pName LIKE '%a%'
SELECT DISTINCT pName FROM Player WHERE pName LIKE '%a%'
SELECT cName ,  enr FROM College WHERE enr  >  10000 AND state = "LA"
SELECT cName ,  enr FROM College WHERE enr  >  10000 AND state = "LA"
SELECT cName FROM College WHERE enr  >  18000 ORDER BY cName
SELECT cName FROM College WHERE enr  >  18000 ORDER BY cName
SELECT pName FROM Player WHERE yCard  =  'yes' ORDER BY HS DESC
SELECT pName FROM Player WHERE yCard  =  'yes' ORDER BY HS DESC
SELECT pPos FROM tryout GROUP BY pPos ORDER BY count(*) DESC LIMIT 1
SELECT pPos FROM tryout GROUP BY pPos ORDER BY count(*) DESC LIMIT 1
SELECT cName FROM college ORDER BY enr DESC LIMIT 3
SELECT cName FROM college ORDER BY enr DESC LIMIT 3
SELECT DISTINCT state FROM college AS T1 JOIN tryout AS T2 ON T1.cName  =  T2.cName
SELECT DISTINCT state FROM college AS T1 JOIN tryout AS T2 ON T1.cName  =  T2.cName
SELECT DISTINCT T1.state FROM college AS T1 JOIN tryout AS T2 ON T1.cName  =  T2.cName WHERE T2.decision  =  'yes'
SELECT DISTINCT T1.state FROM college AS T1 JOIN tryout AS T2 ON T1.cName  =  T2.cName WHERE T2.decision  =  'yes'
SELECT T1.pName FROM player AS T1 JOIN tryout AS T2 ON T1.pID  =  T2.pID ORDER BY T1.pName
SELECT T1.pName FROM player AS T1 JOIN tryout AS T2 ON T1.pID  =  T2.pID ORDER BY T1.pName
SELECT T1.pName ,  T1.HS FROM player AS T1 JOIN tryout AS T2 ON T1.pID  =  T2.pID WHERE T2.decision  =  'yes'
SELECT T1.pName ,  T1.HS FROM player AS T1 JOIN tryout AS T2 ON T1.pID  =  T2.pID WHERE T2.decision  =  'yes'
SELECT T1.state FROM college AS T1 JOIN tryout AS T2 ON T1.cName  =  T2.cName WHERE T2.pPos  =  'striker'
SELECT T1.state FROM college AS T1 JOIN tryout AS T2 ON T1.cName  =  T2.cName WHERE T2.pPos  =  'striker'
SELECT T1.pName FROM player AS T1 JOIN tryout AS T2 ON T1.pID  =  T2.pID WHERE T2.decision  =  'yes' AND T2.pPos  =  'striker'
SELECT T1.pName FROM player AS T1 JOIN tryout AS T2 ON T1.pID  =  T2.pID WHERE T2.decision  =  'yes' AND T2.pPos  =  'striker'
SELECT T1.state FROM college AS T1 JOIN tryout AS T2 ON T1.cName  =  T2.cName JOIN player AS T3 ON T2.pID  =  T3.pID WHERE T3.pName  =  'Charles'
SELECT T1.state FROM college AS T1 JOIN tryout AS T2 ON T1.cName  =  T2.cName JOIN player AS T3 ON T2.pID  =  T3.pID WHERE T3.pName  =  'Charles'
SELECT avg(T1.HS) ,  max(T1.HS) FROM player AS T1 JOIN tryout AS T2 ON T1.pID  =  T2.pID WHERE T2.decision  =  'yes'
SELECT avg(T1.HS) ,  max(T1.HS) FROM player AS T1 JOIN tryout AS T2 ON T1.pID  =  T2.pID WHERE T2.decision  =  'yes'
SELECT avg(T1.HS) FROM player AS T1 JOIN tryout AS T2 ON T1.pID  =  T2.pID WHERE T2.decision  =  'no'
SELECT avg(T1.HS) FROM player AS T1 JOIN tryout AS T2 ON T1.pID  =  T2.pID WHERE T2.decision  =  'no'
SELECT DISTINCT T1.state ,  T1.enr FROM college AS T1 JOIN tryout AS T2 ON T1.cName  =  T2.cName WHERE T2.decision  =  'yes'
SELECT DISTINCT T1.state ,  T1.enr FROM college AS T1 JOIN tryout AS T2 ON T1.cName  =  T2.cName WHERE T2.decision  =  'yes'
SELECT cName FROM College WHERE enr  <  13000 AND state = "AZ" UNION SELECT cName FROM College WHERE enr  >  15000 AND state = "LA"
SELECT cName FROM College WHERE enr  <  13000 AND state = "AZ" UNION SELECT cName FROM College WHERE enr  >  15000 AND state = "LA"
SELECT count(*) FROM device
SELECT count(*) FROM device
SELECT Carrier FROM device ORDER BY Carrier ASC
SELECT Carrier FROM device ORDER BY Carrier ASC
SELECT Carrier FROM device WHERE Software_Platform != 'Android'
SELECT Carrier FROM device WHERE Software_Platform != 'Android'
SELECT Shop_Name FROM shop ORDER BY Open_Year ASC
SELECT Shop_Name FROM shop ORDER BY Open_Year ASC
SELECT avg(Quantity) FROM stock
SELECT avg(Quantity) FROM stock
SELECT Shop_Name ,  LOCATION FROM shop ORDER BY Shop_Name ASC
SELECT Shop_Name ,  LOCATION FROM shop ORDER BY Shop_Name ASC
SELECT Open_Date ,  Open_Year FROM shop WHERE Shop_Name  =  "Apple"
SELECT Open_Date ,  Open_Year FROM shop WHERE Shop_Name  =  "Apple"
SELECT Shop_Name FROM shop ORDER BY Open_Year DESC LIMIT 1
SELECT Shop_Name FROM shop ORDER BY Open_Year DESC LIMIT 1
SELECT T3.Shop_Name ,  T2.Carrier FROM stock AS T1 JOIN device AS T2 ON T1.Device_ID  =  T2.Device_ID JOIN shop AS T3 ON T1.Shop_ID  =  T3.Shop_ID
SELECT T3.Shop_Name ,  T2.Carrier FROM stock AS T1 JOIN device AS T2 ON T1.Device_ID  =  T2.Device_ID JOIN shop AS T3 ON T1.Shop_ID  =  T3.Shop_ID
SELECT T2.Shop_Name FROM stock AS T1 JOIN shop AS T2 ON T1.Shop_ID  =  T2.Shop_ID GROUP BY T1.Shop_ID HAVING COUNT(*)  >  1
SELECT T2.Shop_Name FROM stock AS T1 JOIN shop AS T2 ON T1.Shop_ID  =  T2.Shop_ID GROUP BY T1.Shop_ID HAVING COUNT(*)  >  1
SELECT T2.Shop_Name FROM stock AS T1 JOIN shop AS T2 ON T1.Shop_ID  =  T2.Shop_ID GROUP BY T1.Shop_ID ORDER BY COUNT(*) DESC LIMIT 1
SELECT T2.Shop_Name FROM stock AS T1 JOIN shop AS T2 ON T1.Shop_ID  =  T2.Shop_ID GROUP BY T1.Shop_ID ORDER BY COUNT(*) DESC LIMIT 1
SELECT Software_Platform ,  COUNT(*) FROM device GROUP BY Software_Platform
SELECT Software_Platform ,  COUNT(*) FROM device GROUP BY Software_Platform
SELECT Software_Platform FROM device GROUP BY Software_Platform ORDER BY COUNT(*) DESC
SELECT Software_Platform FROM device GROUP BY Software_Platform ORDER BY COUNT(*) DESC
SELECT Software_Platform FROM device GROUP BY Software_Platform ORDER BY COUNT(*) DESC LIMIT 1
SELECT Software_Platform FROM device GROUP BY Software_Platform ORDER BY COUNT(*) DESC LIMIT 1
SELECT Shop_Name FROM shop WHERE Shop_ID NOT IN (SELECT Shop_ID FROM stock)
SELECT Shop_Name FROM shop WHERE Shop_ID NOT IN (SELECT Shop_ID FROM stock)
SELECT Carrier FROM device WHERE Device_ID NOT IN (SELECT Device_ID FROM stock)
SELECT Carrier FROM device WHERE Device_ID NOT IN (SELECT Device_ID FROM stock)
SELECT T2.Carrier FROM stock AS T1 JOIN device AS T2 ON T1.Device_ID  =  T2.Device_ID GROUP BY T1.Device_ID HAVING COUNT(*)  >  1
SELECT T2.Carrier FROM stock AS T1 JOIN device AS T2 ON T1.Device_ID  =  T2.Device_ID GROUP BY T1.Device_ID HAVING COUNT(*)  >  1
SELECT count(*) FROM BOOKINGS
SELECT count(*) FROM BOOKINGS
SELECT Order_Date FROM BOOKINGS
SELECT Order_Date FROM BOOKINGS
SELECT Planned_Delivery_Date ,  Actual_Delivery_Date FROM BOOKINGS
SELECT Planned_Delivery_Date ,  Actual_Delivery_Date FROM BOOKINGS
SELECT count(*) FROM CUSTOMERS
SELECT count(*) FROM CUSTOMERS
SELECT Customer_Phone ,  Customer_Email_Address FROM CUSTOMERS WHERE Customer_Name  =  "Harold"
SELECT Customer_Phone ,  Customer_Email_Address FROM CUSTOMERS WHERE Customer_Name  =  "Harold"
SELECT Store_Name FROM Drama_Workshop_Groups
SELECT Store_Name FROM Drama_Workshop_Groups
SELECT DISTINCT payment_method_code FROM INVOICES
SELECT DISTINCT payment_method_code FROM INVOICES
SELECT Marketing_Region_Descriptrion FROM Marketing_Regions WHERE Marketing_Region_Name  =  "China"
SELECT Marketing_Region_Descriptrion FROM Marketing_Regions WHERE Marketing_Region_Name  =  "China"
SELECT Product_Name FROM PRODUCTS ORDER BY Product_Price DESC LIMIT 1
SELECT Product_Name FROM PRODUCTS ORDER BY Product_Price DESC LIMIT 1
SELECT Product_Name FROM Products ORDER BY Product_Price ASC
SELECT Product_Name FROM Products ORDER BY Product_Price ASC
SELECT Customer_Phone FROM PERFORMERS WHERE Customer_Name  =  "Ashley"
SELECT Customer_Phone FROM PERFORMERS WHERE Customer_Name  =  "Ashley"
SELECT payment_method_code ,  count(*) FROM INVOICES GROUP BY payment_method_code
SELECT payment_method_code ,  count(*) FROM INVOICES GROUP BY payment_method_code
SELECT payment_method_code FROM INVOICES GROUP BY payment_method_code ORDER BY count(*) DESC LIMIT 1
SELECT payment_method_code FROM INVOICES GROUP BY payment_method_code ORDER BY count(*) DESC LIMIT 1
SELECT T1.City_Town FROM Addresses AS T1 JOIN Stores AS T2 ON T1.Address_ID  =  T2.Address_ID WHERE T2.Store_Name  =  "FJA Filming"
SELECT T1.City_Town FROM Addresses AS T1 JOIN Stores AS T2 ON T1.Address_ID  =  T2.Address_ID WHERE T2.Store_Name  =  "FJA Filming"
SELECT T1.State_County FROM Addresses AS T1 JOIN Stores AS T2 ON T1.Address_ID  =  T2.Address_ID WHERE T2.Marketing_Region_Code  =  "CA"
SELECT T1.State_County FROM Addresses AS T1 JOIN Stores AS T2 ON T1.Address_ID  =  T2.Address_ID WHERE T2.Marketing_Region_Code  =  "CA"
SELECT T1.Marketing_Region_Name FROM Marketing_Regions AS T1 JOIN Stores AS T2 ON T1.Marketing_Region_Code  =  T2.Marketing_Region_Code WHERE T2.Store_Name  =  "Rob Dinning"
SELECT T1.Marketing_Region_Name FROM Marketing_Regions AS T1 JOIN Stores AS T2 ON T1.Marketing_Region_Code  =  T2.Marketing_Region_Code WHERE T2.Store_Name  =  "Rob Dinning"
SELECT T1.Service_Type_Description FROM Ref_Service_Types AS T1 JOIN Services AS T2 ON T1.Service_Type_Code  =  T2.Service_Type_Code WHERE T2.Product_Price  >  100
SELECT T1.Service_Type_Description FROM Ref_Service_Types AS T1 JOIN Services AS T2 ON T1.Service_Type_Code  =  T2.Service_Type_Code WHERE T2.Product_Price  >  100
SELECT T1.Service_Type_Description ,  T2.Service_Type_Code ,  COUNT(*) FROM Ref_Service_Types AS T1 JOIN Services AS T2 ON T1.Service_Type_Code  =  T2.Service_Type_Code GROUP BY T2.Service_Type_Code
SELECT T1.Service_Type_Description ,  T2.Service_Type_Code ,  COUNT(*) FROM Ref_Service_Types AS T1 JOIN Services AS T2 ON T1.Service_Type_Code  =  T2.Service_Type_Code GROUP BY T2.Service_Type_Code
SELECT T1.Service_Type_Description , T1.Service_Type_Code FROM Ref_Service_Types AS T1 JOIN Services AS T2 ON T1.Service_Type_Code  =  T2.Service_Type_Code GROUP BY T1.Service_Type_Code ORDER BY COUNT(*) DESC LIMIT 1
SELECT T1.Service_Type_Description , T1.Service_Type_Code FROM Ref_Service_Types AS T1 JOIN Services AS T2 ON T1.Service_Type_Code  =  T2.Service_Type_Code GROUP BY T1.Service_Type_Code ORDER BY COUNT(*) DESC LIMIT 1
SELECT T1.Store_Phone ,  T1.Store_Email_Address FROM Drama_Workshop_Groups AS T1 JOIN Services AS T2 ON T1.Workshop_Group_ID  =  T2.Workshop_Group_ID
SELECT T1.Store_Phone ,  T1.Store_Email_Address FROM Drama_Workshop_Groups AS T1 JOIN Services AS T2 ON T1.Workshop_Group_ID  =  T2.Workshop_Group_ID
SELECT T1.Store_Phone ,  T1.Store_Email_Address FROM Drama_Workshop_Groups AS T1 JOIN Services AS T2 ON T1.Workshop_Group_ID  =  T2.Workshop_Group_ID WHERE T2.Product_Name  =  "film"
SELECT T1.Store_Phone ,  T1.Store_Email_Address FROM Drama_Workshop_Groups AS T1 JOIN Services AS T2 ON T1.Workshop_Group_ID  =  T2.Workshop_Group_ID WHERE T2.Product_Name  =  "film"
SELECT T1.Actual_Delivery_Date FROM Customer_Orders AS T1 JOIN ORDER_ITEMS AS T2 ON T1.Order_ID  =  T2.Order_ID WHERE T2.Order_Quantity  =  1
SELECT T1.Actual_Delivery_Date FROM Customer_Orders AS T1 JOIN ORDER_ITEMS AS T2 ON T1.Order_ID  =  T2.Order_ID WHERE T2.Order_Quantity  =  1
SELECT T1.Order_Date FROM Customer_Orders AS T1 JOIN ORDER_ITEMS AS T2 ON T1.Order_ID  =  T2.Order_ID JOIN Products AS T3 ON T2.Product_ID  =  T3.Product_ID WHERE T3.Product_price  >  1000
SELECT T1.Order_Date FROM Customer_Orders AS T1 JOIN ORDER_ITEMS AS T2 ON T1.Order_ID  =  T2.Order_ID JOIN Products AS T3 ON T2.Product_ID  =  T3.Product_ID WHERE T3.Product_price  >  1000
SELECT T2.Store_Name FROM Addresses AS T1 JOIN Drama_Workshop_Groups AS T2 ON T1.Address_ID  =  T2.Address_ID WHERE T1.City_Town  =  "Feliciaberg"
SELECT T2.Store_Name FROM Addresses AS T1 JOIN Drama_Workshop_Groups AS T2 ON T1.Address_ID  =  T2.Address_ID WHERE T1.City_Town  =  "Feliciaberg"
SELECT T2.Store_Email_Address FROM Addresses AS T1 JOIN Drama_Workshop_Groups AS T2 ON T1.Address_ID  =  T2.Address_ID WHERE T1.State_County  =  "Alaska"
SELECT T2.Store_Email_Address FROM Addresses AS T1 JOIN Drama_Workshop_Groups AS T2 ON T1.Address_ID  =  T2.Address_ID WHERE T1.State_County  =  "Alaska"
SELECT T1.City_Town ,  count(*) FROM Addresses AS T1 JOIN Drama_Workshop_Groups AS T2 ON T1.Address_ID  =  T2.Address_ID GROUP BY T1.City_Town
SELECT T1.City_Town ,  count(*) FROM Addresses AS T1 JOIN Drama_Workshop_Groups AS T2 ON T1.Address_ID  =  T2.Address_ID GROUP BY T1.City_Town
SELECT Marketing_Region_Code FROM Drama_Workshop_Groups GROUP BY Marketing_Region_Code ORDER BY count(*) DESC LIMIT 1
SELECT Marketing_Region_Code FROM Drama_Workshop_Groups GROUP BY Marketing_Region_Code ORDER BY count(*) DESC LIMIT 1
SELECT Status_Code FROM BOOKINGS GROUP BY Status_Code ORDER BY count(*) DESC LIMIT 1
SELECT Status_Code FROM BOOKINGS GROUP BY Status_Code ORDER BY count(*) DESC LIMIT 1
SELECT T2.Store_Name FROM Bookings AS T1 JOIN Drama_Workshop_Groups AS T2 ON T1.Workshop_Group_ID  =  T2.Workshop_Group_ID WHERE T1.Status_Code  =  "stop"
SELECT T2.Store_Name FROM Bookings AS T1 JOIN Drama_Workshop_Groups AS T2 ON T1.Workshop_Group_ID  =  T2.Workshop_Group_ID WHERE T1.Status_Code  =  "stop"
SELECT Product_ID FROM INVOICES GROUP BY Product_ID ORDER BY COUNT(*) DESC LIMIT 1
SELECT Product_ID FROM INVOICES GROUP BY Product_ID ORDER BY COUNT(*) DESC LIMIT 1
SELECT DISTINCT T1.stageposition FROM Performance AS T1 JOIN Band AS T2 ON T1.bandmate  =  T2.id WHERE Firstname  =  "Solveig"
SELECT DISTINCT T1.stageposition FROM Performance AS T1 JOIN Band AS T2 ON T1.bandmate  =  T2.id WHERE Firstname  =  "Solveig"
SELECT T3.Title FROM Performance AS T1 JOIN Band AS T2 ON T1.bandmate  =  T2.id JOIN Songs AS T3 ON T3.SongId  =  T1.SongId WHERE T2.Lastname  =  "Heilo"
SELECT T3.Title FROM Performance AS T1 JOIN Band AS T2 ON T1.bandmate  =  T2.id JOIN Songs AS T3 ON T3.SongId  =  T1.SongId WHERE T2.Lastname  =  "Heilo"
SELECT count(*) FROM performance AS T1 JOIN band AS T2 ON T1.bandmate  =  T2.id JOIN songs AS T3 ON T3.songid  =  T1.songid WHERE T3.Title  =  "Flash"
SELECT count(*) FROM performance AS T1 JOIN band AS T2 ON T1.bandmate  =  T2.id JOIN songs AS T3 ON T3.songid  =  T1.songid WHERE T3.Title  =  "Flash"
SELECT T3.Title FROM Performance AS T1 JOIN Band AS T2 ON T1.bandmate  =  T2.id JOIN Songs AS T3 ON T3.SongId  =  T1.SongId WHERE T2.firstname  =  "Marianne"
SELECT T3.Title FROM Performance AS T1 JOIN Band AS T2 ON T1.bandmate  =  T2.id JOIN Songs AS T3 ON T3.SongId  =  T1.SongId WHERE T2.firstname  =  "Marianne"
SELECT T2.firstname ,  T2.lastname FROM Performance AS T1 JOIN Band AS T2 ON T1.bandmate  =  T2.id JOIN Songs AS T3 ON T3.SongId  =  T1.SongId WHERE T3.Title  =  "Badlands"
SELECT T2.firstname ,  T2.lastname FROM Performance AS T1 JOIN Band AS T2 ON T1.bandmate  =  T2.id JOIN Songs AS T3 ON T3.SongId  =  T1.SongId WHERE T3.Title  =  "Badlands"
SELECT T2.firstname ,  T2.lastname FROM Performance AS T1 JOIN Band AS T2 ON T1.bandmate  =  T2.id JOIN Songs AS T3 ON T3.SongId  =  T1.SongId WHERE T3.Title  =  "Badlands" AND T1.StagePosition  =  "back"
SELECT T2.firstname ,  T2.lastname FROM Performance AS T1 JOIN Band AS T2 ON T1.bandmate  =  T2.id JOIN Songs AS T3 ON T3.SongId  =  T1.SongId WHERE T3.Title  =  "Badlands" AND T1.StagePosition  =  "back"
SELECT T2.lastname FROM Performance AS T1 JOIN Band AS T2 ON T1.bandmate  =  T2.id WHERE stageposition  =  "back" GROUP BY lastname ORDER BY count(*) DESC LIMIT 1
SELECT T2.lastname FROM Performance AS T1 JOIN Band AS T2 ON T1.bandmate  =  T2.id WHERE stageposition  =  "back" GROUP BY lastname ORDER BY count(*) DESC LIMIT 1
SELECT title FROM songs WHERE title LIKE '% the %'
SELECT title FROM songs WHERE title LIKE '% the %'
SELECT count(*) FROM instruments WHERE instrument  =  "drums"
SELECT count(*) FROM instruments WHERE instrument  =  "drums"
SELECT instrument FROM instruments AS T1 JOIN songs AS T2 ON T1.songid  =  T2.songid WHERE title  =  "Le Pop"
SELECT instrument FROM instruments AS T1 JOIN songs AS T2 ON T1.songid  =  T2.songid WHERE title  =  "Le Pop"
SELECT instrument FROM instruments AS T1 JOIN Band AS T2 ON T1.bandmateid  =  T2.id WHERE T2.lastname  =  "Heilo"
SELECT instrument FROM instruments AS T1 JOIN Band AS T2 ON T1.bandmateid  =  T2.id WHERE T2.lastname  =  "Heilo"
SELECT TYPE FROM vocals AS T1 JOIN band AS T2 ON T1.bandmate  =  T2.id WHERE lastname  =  "Heilo" GROUP BY TYPE ORDER BY count(*) DESC LIMIT 1
SELECT TYPE FROM vocals AS T1 JOIN band AS T2 ON T1.bandmate  =  T2.id WHERE lastname  =  "Heilo" GROUP BY TYPE ORDER BY count(*) DESC LIMIT 1
SELECT TYPE FROM vocals AS T1 JOIN songs AS T2 ON T1.songid  =  T2.songid WHERE title  =  "Le Pop"
SELECT TYPE FROM vocals AS T1 JOIN songs AS T2 ON T1.songid  =  T2.songid WHERE title  =  "Le Pop"
SELECT count(*) FROM vocals AS T1 JOIN songs AS T2 ON T1.songid  =  T2.songid WHERE title  =  "Demon Kitty Rag"
SELECT count(*) FROM vocals AS T1 JOIN songs AS T2 ON T1.songid  =  T2.songid WHERE title  =  "Demon Kitty Rag"
SELECT TYPE FROM vocals AS T1 JOIN songs AS T2 ON T1.songid  =  T2.songid JOIN band AS T3 ON T1.bandmate  =  T3.id WHERE T3.firstname  =  "Solveig" AND T2.title  =  "A Bar In Amsterdam"
SELECT TYPE FROM vocals AS T1 JOIN songs AS T2 ON T1.songid  =  T2.songid JOIN band AS T3 ON T1.bandmate  =  T3.id WHERE T3.firstname  =  "Solveig" AND T2.title  =  "A Bar In Amsterdam"
SELECT T2.firstname ,  T2.lastname FROM Performance AS T1 JOIN Band AS T2 ON T1.bandmate  =  T2.id JOIN Songs AS T3 ON T3.SongId  =  T1.SongId WHERE T3.Title  =  "Le Pop"
SELECT T2.firstname ,  T2.lastname FROM Performance AS T1 JOIN Band AS T2 ON T1.bandmate  =  T2.id JOIN Songs AS T3 ON T3.SongId  =  T1.SongId WHERE T3.Title  =  "Le Pop"
SELECT TYPE FROM vocals AS T1 JOIN songs AS T2 ON T1.songid  =  T2.songid WHERE title  =  "Badlands"
SELECT TYPE FROM vocals AS T1 JOIN songs AS T2 ON T1.songid  =  T2.songid WHERE title  =  "Badlands"
SELECT count(*) FROM vocals AS T1 JOIN songs AS T2 ON T1.songid  =  T2.songid WHERE title  =  "Le Pop"
SELECT count(*) FROM vocals AS T1 JOIN songs AS T2 ON T1.songid  =  T2.songid WHERE title  =  "Le Pop"
SELECT TYPE FROM vocals AS T1 JOIN band AS T2 ON T1.bandmate  =  T2.id WHERE firstname  =  "Solveig" GROUP BY TYPE ORDER BY count(*) DESC LIMIT 1
SELECT TYPE FROM vocals AS T1 JOIN band AS T2 ON T1.bandmate  =  T2.id WHERE firstname  =  "Solveig" GROUP BY TYPE ORDER BY count(*) DESC LIMIT 1
SELECT TYPE FROM vocals AS T1 JOIN songs AS T2 ON T1.songid  =  T2.songid JOIN band AS T3 ON T1.bandmate  =  T3.id WHERE T3.lastname  =  "Heilo" AND T2.title  =  "Der Kapitan"
SELECT TYPE FROM vocals AS T1 JOIN songs AS T2 ON T1.songid  =  T2.songid JOIN band AS T3 ON T1.bandmate  =  T3.id WHERE T3.lastname  =  "Heilo" AND T2.title  =  "Der Kapitan"
SELECT TYPE FROM vocals AS T1 JOIN band AS T2 ON T1.bandmate  =  T2.id WHERE firstname  =  "Marianne" GROUP BY TYPE ORDER BY count(*) DESC LIMIT 1
SELECT TYPE FROM vocals AS T1 JOIN band AS T2 ON T1.bandmate  =  T2.id WHERE firstname  =  "Marianne" GROUP BY TYPE ORDER BY count(*) DESC LIMIT 1
SELECT T2.firstname ,  T2.lastname FROM Performance AS T1 JOIN Band AS T2 ON T1.bandmate  =  T2.id JOIN Songs AS T3 ON T3.SongId  =  T1.SongId WHERE T3.Title  =  "Der Kapitan" AND T1.StagePosition  =  "back"
SELECT T2.firstname ,  T2.lastname FROM Performance AS T1 JOIN Band AS T2 ON T1.bandmate  =  T2.id JOIN Songs AS T3 ON T3.SongId  =  T1.SongId WHERE T3.Title  =  "Der Kapitan" AND T1.StagePosition  =  "back"
SELECT T3.title FROM albums AS T1 JOIN tracklists AS T2 ON T1.aid  =  T2.albumid JOIN songs AS T3 ON T2.songid  =  T3.songid WHERE T1.title  =  "A Kiss Before You Go: Live in Hamburg"
SELECT T3.title FROM albums AS T1 JOIN tracklists AS T2 ON T1.aid  =  T2.albumid JOIN songs AS T3 ON T2.songid  =  T3.songid WHERE T1.title  =  "A Kiss Before You Go: Live in Hamburg"
SELECT founder FROM manufacturers WHERE name  =  'Sony'
SELECT founder FROM manufacturers WHERE name  =  'Sony'
SELECT headquarter FROM manufacturers WHERE founder  =  'James'
SELECT headquarter FROM manufacturers WHERE founder  =  'James'
SELECT name ,  headquarter FROM manufacturers ORDER BY revenue DESC
SELECT name ,  headquarter FROM manufacturers ORDER BY revenue DESC
SELECT count(*) FROM manufacturers WHERE founder  =  'Andy'
SELECT count(*) FROM manufacturers WHERE founder  =  'Andy'
SELECT DISTINCT headquarter FROM manufacturers
SELECT DISTINCT headquarter FROM manufacturers
SELECT count(*) FROM manufacturers WHERE headquarter  =  'Tokyo' OR headquarter  =  'Beijing'
SELECT count(*) FROM manufacturers WHERE headquarter  =  'Tokyo' OR headquarter  =  'Beijing'
SELECT name FROM manufacturers WHERE revenue BETWEEN 100 AND 150
SELECT name FROM manufacturers WHERE revenue BETWEEN 100 AND 150
SELECT name ,  headquarter ,  founder FROM manufacturers ORDER BY revenue DESC LIMIT 1
SELECT name ,  headquarter ,  founder FROM manufacturers ORDER BY revenue DESC LIMIT 1
SELECT name ,  headquarter ,  revenue FROM manufacturers ORDER BY revenue DESC
SELECT name ,  headquarter ,  revenue FROM manufacturers ORDER BY revenue DESC
SELECT count(*) ,  T2.name FROM products AS T1 JOIN manufacturers AS T2 ON T1.Manufacturer  =  T2.code GROUP BY T2.name
SELECT count(*) ,  T2.name FROM products AS T1 JOIN manufacturers AS T2 ON T1.Manufacturer  =  T2.code GROUP BY T2.name
SELECT Name FROM Products
SELECT Name FROM Products
SELECT name ,  price FROM products
SELECT name ,  price FROM products
SELECT name FROM products WHERE price  <=  200
SELECT name FROM products WHERE price  <=  200
SELECT avg(price) FROM products
SELECT avg(price) FROM products
SELECT avg(price) FROM products WHERE Manufacturer  =  2
SELECT avg(price) FROM products WHERE Manufacturer  =  2
SELECT count(*) FROM products WHERE price >= 180
SELECT count(*) FROM products WHERE price >= 180
SELECT name ,  price FROM products WHERE price  >=  180 ORDER BY price DESC ,  name ASC
SELECT name ,  price FROM products WHERE price  >=  180 ORDER BY price DESC ,  name ASC
SELECT name ,  price FROM Products ORDER BY price ASC LIMIT 1
SELECT name ,  price FROM Products ORDER BY price ASC LIMIT 1
SELECT problem_log_id FROM problem_log ORDER BY log_entry_date DESC LIMIT 1
SELECT problem_log_id FROM problem_log ORDER BY log_entry_date DESC LIMIT 1
SELECT problem_log_id ,  problem_id FROM problem_log ORDER BY log_entry_date LIMIT 1
SELECT problem_log_id ,  problem_id FROM problem_log ORDER BY log_entry_date LIMIT 1
SELECT problem_log_id ,  log_entry_date FROM problem_log WHERE problem_id = 10
SELECT problem_log_id ,  log_entry_date FROM problem_log WHERE problem_id = 10
SELECT problem_log_id ,  log_entry_description FROM problem_log
SELECT problem_log_id ,  log_entry_description FROM problem_log
SELECT DISTINCT staff_first_name ,  staff_last_name FROM staff AS T1 JOIN problem_log AS T2 ON T1.staff_id = T2.assigned_to_staff_id WHERE T2.problem_id = 1
SELECT DISTINCT staff_first_name ,  staff_last_name FROM staff AS T1 JOIN problem_log AS T2 ON T1.staff_id = T2.assigned_to_staff_id WHERE T2.problem_id = 1
SELECT DISTINCT T2.problem_id ,  T2.problem_log_id FROM staff AS T1 JOIN problem_log AS T2 ON T1.staff_id = T2.assigned_to_staff_id WHERE T1.staff_first_name = "Rylan" AND T1.staff_last_name = "Homenick"
SELECT DISTINCT T2.problem_id ,  T2.problem_log_id FROM staff AS T1 JOIN problem_log AS T2 ON T1.staff_id = T2.assigned_to_staff_id WHERE T1.staff_first_name = "Rylan" AND T1.staff_last_name = "Homenick"
SELECT count(*) FROM product AS T1 JOIN problems AS T2 ON T1.product_id = T2.product_id WHERE T1.product_name = "voluptatem"
SELECT count(*) FROM product AS T1 JOIN problems AS T2 ON T1.product_id = T2.product_id WHERE T1.product_name = "voluptatem"
SELECT count(*) ,  T1.product_name FROM product AS T1 JOIN problems AS T2 ON T1.product_id = T2.product_id GROUP BY T1.product_name ORDER BY count(*) DESC LIMIT 1
SELECT count(*) ,  T1.product_name FROM product AS T1 JOIN problems AS T2 ON T1.product_id = T2.product_id GROUP BY T1.product_name ORDER BY count(*) DESC LIMIT 1
SELECT T1.problem_description FROM problems AS T1 JOIN staff AS T2 ON T1.reported_by_staff_id = T2.staff_id WHERE T2.staff_first_name = "Christop"
SELECT T1.problem_description FROM problems AS T1 JOIN staff AS T2 ON T1.reported_by_staff_id = T2.staff_id WHERE T2.staff_first_name = "Christop"
SELECT T1.problem_id FROM problems AS T1 JOIN staff AS T2 ON T1.reported_by_staff_id = T2.staff_id WHERE T2.staff_last_name = "Bosco"
SELECT T1.problem_id FROM problems AS T1 JOIN staff AS T2 ON T1.reported_by_staff_id = T2.staff_id WHERE T2.staff_last_name = "Bosco"
SELECT problem_id FROM problems WHERE date_problem_reported > "1978-06-26"
SELECT problem_id FROM problems WHERE date_problem_reported > "1978-06-26"
SELECT problem_id FROM problems WHERE date_problem_reported < "1978-06-26"
SELECT problem_id FROM problems WHERE date_problem_reported < "1978-06-26"
SELECT count(*) ,  T2.product_id FROM problems AS T1 JOIN product AS T2 ON T1.product_id = T2.product_id GROUP BY T2.product_id
SELECT count(*) ,  T2.product_id FROM problems AS T1 JOIN product AS T2 ON T1.product_id = T2.product_id GROUP BY T2.product_id
SELECT count(*) ,  T2.product_id FROM problems AS T1 JOIN product AS T2 ON T1.product_id = T2.product_id WHERE T1.date_problem_reported > "1986-11-13" GROUP BY T2.product_id
SELECT count(*) ,  T2.product_id FROM problems AS T1 JOIN product AS T2 ON T1.product_id = T2.product_id WHERE T1.date_problem_reported > "1986-11-13" GROUP BY T2.product_id
SELECT DISTINCT product_name FROM product ORDER BY product_name
SELECT DISTINCT product_name FROM product ORDER BY product_name
SELECT product_id FROM problems AS T1 JOIN staff AS T2 ON T1.reported_by_staff_id = T2.staff_id WHERE T2.staff_first_name = "Dameon" AND T2.staff_last_name = "Frami" UNION SELECT product_id FROM problems AS T1 JOIN staff AS T2 ON T1.reported_by_staff_id = T2.staff_id WHERE T2.staff_first_name = "Jolie" AND T2.staff_last_name = "Weber"
SELECT product_id FROM problems AS T1 JOIN staff AS T2 ON T1.reported_by_staff_id = T2.staff_id WHERE T2.staff_first_name = "Dameon" AND T2.staff_last_name = "Frami" UNION SELECT product_id FROM problems AS T1 JOIN staff AS T2 ON T1.reported_by_staff_id = T2.staff_id WHERE T2.staff_first_name = "Jolie" AND T2.staff_last_name = "Weber"
SELECT T2.product_name FROM problems AS T1 JOIN product AS T2 ON T1.product_id = T2.product_id GROUP BY T2.product_name ORDER BY count(*) DESC LIMIT 3
SELECT T2.product_name FROM problems AS T1 JOIN product AS T2 ON T1.product_id = T2.product_id GROUP BY T2.product_name ORDER BY count(*) DESC LIMIT 3
SELECT T1.problem_id FROM problems AS T1 JOIN product AS T2 ON T1.product_id = T2.product_id WHERE T2.product_name = "voluptatem" AND T1.date_problem_reported > "1995"
SELECT T1.problem_id FROM problems AS T1 JOIN product AS T2 ON T1.product_id = T2.product_id WHERE T2.product_name = "voluptatem" AND T1.date_problem_reported > "1995"
SELECT name ,  address_road ,  city FROM branch ORDER BY open_year
SELECT name ,  address_road ,  city FROM branch ORDER BY open_year
SELECT name FROM branch ORDER BY membership_amount DESC LIMIT 3
SELECT name FROM branch ORDER BY membership_amount DESC LIMIT 3
SELECT DISTINCT city FROM branch WHERE membership_amount  >=  100
SELECT DISTINCT city FROM branch WHERE membership_amount  >=  100
SELECT open_year FROM branch GROUP BY open_year HAVING count(*)  >=  2
SELECT open_year FROM branch GROUP BY open_year HAVING count(*)  >=  2
SELECT min(membership_amount) ,  max(membership_amount) FROM branch WHERE open_year  =  2011 OR city  =  'London'
SELECT min(membership_amount) ,  max(membership_amount) FROM branch WHERE open_year  =  2011 OR city  =  'London'
SELECT city ,  count(*) FROM branch WHERE open_year  <  2010 GROUP BY city
SELECT city ,  count(*) FROM branch WHERE open_year  <  2010 GROUP BY city
SELECT card_number ,  name ,  hometown FROM member ORDER BY LEVEL DESC
SELECT card_number ,  name ,  hometown FROM member ORDER BY LEVEL DESC
SELECT LEVEL FROM member GROUP BY LEVEL ORDER BY count(*) DESC LIMIT 1
SELECT LEVEL FROM member GROUP BY LEVEL ORDER BY count(*) DESC LIMIT 1
SELECT T3.name ,  T2.name FROM membership_register_branch AS T1 JOIN branch AS T2 ON T1.branch_id  =  T2.branch_id JOIN member AS T3 ON T1.member_id  =  T3.member_id ORDER BY T1.register_year
SELECT T3.name ,  T2.name FROM membership_register_branch AS T1 JOIN branch AS T2 ON T1.branch_id  =  T2.branch_id JOIN member AS T3 ON T1.member_id  =  T3.member_id ORDER BY T1.register_year
SELECT T2.name ,  count(*) FROM membership_register_branch AS T1 JOIN branch AS T2 ON T1.branch_id  =  T2.branch_id WHERE T1.register_year  >  2015 GROUP BY T2.branch_id
SELECT T2.name ,  count(*) FROM membership_register_branch AS T1 JOIN branch AS T2 ON T1.branch_id  =  T2.branch_id WHERE T1.register_year  >  2015 GROUP BY T2.branch_id
SELECT T2.name ,  T2.open_year FROM membership_register_branch AS T1 JOIN branch AS T2 ON T1.branch_id  =  T2.branch_id WHERE T1.register_year  =  2016 GROUP BY T2.branch_id ORDER BY count(*) DESC LIMIT 1
SELECT T2.name ,  T2.open_year FROM membership_register_branch AS T1 JOIN branch AS T2 ON T1.branch_id  =  T2.branch_id WHERE T1.register_year  =  2016 GROUP BY T2.branch_id ORDER BY count(*) DESC LIMIT 1
SELECT T2.name ,  T2.hometown FROM membership_register_branch AS T1 JOIN member AS T2 ON T1.member_id  =  T2.member_id WHERE T1.register_year  =  2016
SELECT T2.name ,  T2.hometown FROM membership_register_branch AS T1 JOIN member AS T2 ON T1.member_id  =  T2.member_id WHERE T1.register_year  =  2016
SELECT city FROM branch WHERE open_year  =  2001 AND membership_amount  >  100
SELECT city FROM branch WHERE open_year  =  2001 AND membership_amount  >  100
SELECT card_number FROM member WHERE Hometown LIKE "%Kentucky%"
SELECT card_number FROM member WHERE Hometown LIKE "%Kentucky%"
SELECT count(*) FROM STUDENT
SELECT count(*) FROM STUDENT
SELECT count(*) FROM VOTING_RECORD
SELECT count(*) FROM VOTING_RECORD
SELECT max(Age) FROM STUDENT
SELECT max(Age) FROM STUDENT
SELECT LName FROM STUDENT WHERE Major  =  50
SELECT LName FROM STUDENT WHERE Major  =  50
SELECT Fname FROM STUDENT WHERE Age  >  22
SELECT Fname FROM STUDENT WHERE Age  >  22
SELECT Major FROM STUDENT WHERE Sex  =  "M"
SELECT Major FROM STUDENT WHERE Sex  =  "M"
SELECT avg(Age) FROM STUDENT WHERE Sex  =  "F"
SELECT avg(Age) FROM STUDENT WHERE Sex  =  "F"
SELECT max(Age) ,  min(Age) FROM STUDENT WHERE Major  =  600
SELECT max(Age) ,  min(Age) FROM STUDENT WHERE Major  =  600
SELECT Advisor FROM STUDENT WHERE city_code  =  "BAL"
SELECT Advisor FROM STUDENT WHERE city_code  =  "BAL"
SELECT DISTINCT Secretary_Vote FROM VOTING_RECORD WHERE ELECTION_CYCLE  =  "Fall"
SELECT DISTINCT Secretary_Vote FROM VOTING_RECORD WHERE ELECTION_CYCLE  =  "Fall"
SELECT DISTINCT PRESIDENT_Vote FROM VOTING_RECORD WHERE Registration_Date  =  "08/30/2015"
SELECT DISTINCT PRESIDENT_Vote FROM VOTING_RECORD WHERE Registration_Date  =  "08/30/2015"
SELECT DISTINCT Registration_Date ,  Election_Cycle FROM VOTING_RECORD
SELECT DISTINCT Registration_Date ,  Election_Cycle FROM VOTING_RECORD
SELECT DISTINCT President_Vote ,  VICE_President_Vote FROM VOTING_RECORD
SELECT DISTINCT President_Vote ,  VICE_President_Vote FROM VOTING_RECORD
SELECT DISTINCT T1.LName FROM STUDENT AS T1 JOIN VOTING_RECORD AS T2 ON T1.StuID  =  T2.CLASS_President_VOTE
SELECT DISTINCT T1.LName FROM STUDENT AS T1 JOIN VOTING_RECORD AS T2 ON T1.StuID  =  T2.CLASS_President_VOTE
SELECT DISTINCT T1.Fname FROM STUDENT AS T1 JOIN VOTING_RECORD AS T2 ON T1.StuID  =  T2.CLASS_Senator_VOTE
SELECT DISTINCT T1.Fname FROM STUDENT AS T1 JOIN VOTING_RECORD AS T2 ON T1.StuID  =  T2.CLASS_Senator_VOTE
SELECT DISTINCT T1.Age FROM STUDENT AS T1 JOIN VOTING_RECORD AS T2 ON T1.StuID  =  T2.Secretary_Vote WHERE T2.Election_Cycle  =  "Fall"
SELECT DISTINCT T1.Age FROM STUDENT AS T1 JOIN VOTING_RECORD AS T2 ON T1.StuID  =  T2.Secretary_Vote WHERE T2.Election_Cycle  =  "Fall"
SELECT DISTINCT T1.Advisor FROM STUDENT AS T1 JOIN VOTING_RECORD AS T2 ON T1.StuID  =  T2.Treasurer_Vote WHERE T2.Election_Cycle  =  "Spring"
SELECT DISTINCT T1.Advisor FROM STUDENT AS T1 JOIN VOTING_RECORD AS T2 ON T1.StuID  =  T2.Treasurer_Vote WHERE T2.Election_Cycle  =  "Spring"
SELECT DISTINCT T1.Major FROM STUDENT AS T1 JOIN VOTING_RECORD AS T2 ON T1.StuID  =  T2.Treasurer_Vote
SELECT DISTINCT T1.Major FROM STUDENT AS T1 JOIN VOTING_RECORD AS T2 ON T1.StuID  =  T2.Treasurer_Vote
SELECT DISTINCT T1.Fname ,  T1.LName FROM STUDENT AS T1 JOIN VOTING_RECORD AS T2 ON T1.StuID  =  T2.President_VOTE WHERE T1.sex  =  "F"
SELECT DISTINCT T1.Fname ,  T1.LName FROM STUDENT AS T1 JOIN VOTING_RECORD AS T2 ON T1.StuID  =  T2.President_VOTE WHERE T1.sex  =  "F"
SELECT DISTINCT T1.Fname ,  T1.LName FROM STUDENT AS T1 JOIN VOTING_RECORD AS T2 ON T1.StuID  =  T2.VICE_President_VOTE WHERE T1.age  =  18
SELECT DISTINCT T1.Fname ,  T1.LName FROM STUDENT AS T1 JOIN VOTING_RECORD AS T2 ON T1.StuID  =  T2.VICE_President_VOTE WHERE T1.age  =  18
SELECT Advisor ,  count(*) FROM STUDENT GROUP BY Advisor
SELECT Advisor ,  count(*) FROM STUDENT GROUP BY Advisor
SELECT Advisor FROM STUDENT GROUP BY Advisor HAVING COUNT(*)  >  2
SELECT Advisor FROM STUDENT GROUP BY Advisor HAVING COUNT(*)  >  2
SELECT Major FROM STUDENT GROUP BY Major HAVING COUNT(*)  <  3
SELECT Major FROM STUDENT GROUP BY Major HAVING COUNT(*)  <  3
SELECT Election_Cycle ,  count(*) FROM VOTING_RECORD GROUP BY Election_Cycle
SELECT Election_Cycle ,  count(*) FROM VOTING_RECORD GROUP BY Election_Cycle
SELECT Major FROM STUDENT GROUP BY major ORDER BY count(*) DESC LIMIT 1
SELECT Major FROM STUDENT GROUP BY major ORDER BY count(*) DESC LIMIT 1
SELECT Major FROM STUDENT WHERE Sex  =  "F" GROUP BY major ORDER BY count(*) DESC LIMIT 1
SELECT Major FROM STUDENT WHERE Sex  =  "F" GROUP BY major ORDER BY count(*) DESC LIMIT 1
SELECT Advisor FROM STUDENT GROUP BY Advisor HAVING count(*)  >  2
SELECT Advisor FROM STUDENT GROUP BY Advisor HAVING count(*)  >  2
SELECT count(*) FROM products
SELECT count(*) FROM products
SELECT count(*) FROM ref_colors
SELECT count(*) FROM ref_colors
SELECT count(*) FROM CHARACTERISTICS
SELECT count(*) FROM CHARACTERISTICS
SELECT product_name ,  typical_buying_price FROM products
SELECT product_name ,  typical_buying_price FROM products
SELECT color_description FROM ref_colors
SELECT color_description FROM ref_colors
SELECT DISTINCT characteristic_name FROM CHARACTERISTICS
SELECT DISTINCT characteristic_name FROM CHARACTERISTICS
SELECT product_name FROM products WHERE product_category_code  =  "Spices"
SELECT product_name FROM products WHERE product_category_code  =  "Spices"
SELECT T1.product_name ,  T2.color_description ,  T1.product_description FROM products AS T1 JOIN Ref_colors AS T2 ON T1.color_code  =  T2.color_code WHERE product_category_code  =  "Herbs"
SELECT T1.product_name ,  T2.color_description ,  T1.product_description FROM products AS T1 JOIN Ref_colors AS T2 ON T1.color_code  =  T2.color_code WHERE product_category_code  =  "Herbs"
SELECT count(*) FROM products WHERE product_category_code  =  "Seeds"
SELECT count(*) FROM products WHERE product_category_code  =  "Seeds"
SELECT product_category_code ,  typical_buying_price FROM products WHERE product_name  =  "cumin"
SELECT product_category_code ,  typical_buying_price FROM products WHERE product_name  =  "cumin"
SELECT product_category_code FROM products WHERE product_name  =  "flax"
SELECT product_category_code FROM products WHERE product_name  =  "flax"
SELECT T1.product_name FROM products AS T1 JOIN ref_colors AS T2 ON T1.color_code  =  T2.color_code WHERE T2.color_description  =  'yellow'
SELECT T1.product_name FROM products AS T1 JOIN ref_colors AS T2 ON T1.color_code  =  T2.color_code WHERE T2.color_description  =  'yellow'
SELECT unit_of_measure FROM ref_product_categories WHERE product_category_code  =  "Herbs"
SELECT unit_of_measure FROM ref_product_categories WHERE product_category_code  =  "Herbs"
SELECT product_category_description FROM ref_product_categories WHERE product_category_code  =  "Spices"
SELECT product_category_description FROM ref_product_categories WHERE product_category_code  =  "Spices"
SELECT product_category_description ,  unit_of_measure FROM ref_product_categories WHERE product_category_code  =  "Herbs"
SELECT product_category_description ,  unit_of_measure FROM ref_product_categories WHERE product_category_code  =  "Herbs"
SELECT count(*) FROM event
SELECT name FROM event ORDER BY YEAR DESC
SELECT name FROM event ORDER BY YEAR DESC LIMIT 1
SELECT count(*) FROM stadium
SELECT name FROM stadium ORDER BY capacity DESC LIMIT 1
SELECT country FROM stadium GROUP BY country ORDER BY count(*) DESC LIMIT 1
SELECT country FROM stadium GROUP BY country HAVING count(*)  <=  3
SELECT country ,  count(*) FROM stadium GROUP BY country
SELECT count(*) FROM stadium WHERE country != 'Russia'
SELECT name FROM swimmer ORDER BY meter_100
SELECT nationality ,  count(*) FROM swimmer GROUP BY nationality HAVING count(*)  >  1
SELECT meter_200 ,  meter_300 FROM swimmer WHERE nationality  =  'Australia'
SELECT name FROM stadium WHERE id NOT IN (SELECT stadium_id FROM event)
SELECT name FROM swimmer WHERE id NOT IN (SELECT swimmer_id FROM record)
SELECT avg(capacity) FROM stadium WHERE opening_year  =  2005
SELECT count(*) FROM railway
SELECT Builder FROM railway ORDER BY Builder ASC
SELECT Wheels ,  LOCATION FROM railway
SELECT max(LEVEL) FROM manager WHERE Country != "Australia	"
SELECT avg(Age) FROM manager
SELECT Name FROM manager ORDER BY LEVEL ASC
SELECT Name ,  Arrival FROM train
SELECT Name FROM manager ORDER BY Age DESC LIMIT 1
SELECT T2.Name ,  T1.Location FROM railway AS T1 JOIN train AS T2 ON T1.Railway_ID  =  T2.Railway_ID
SELECT T1.Builder FROM railway AS T1 JOIN train AS T2 ON T1.Railway_ID  =  T2.Railway_ID WHERE T2.Name  =  "Andaman Exp"
SELECT T2.Railway_ID ,  T1.Location FROM railway AS T1 JOIN train AS T2 ON T1.Railway_ID  =  T2.Railway_ID GROUP BY T2.Railway_ID HAVING COUNT(*)  >  1
SELECT Builder ,  COUNT(*) FROM railway GROUP BY Builder
SELECT Builder FROM railway GROUP BY Builder ORDER BY COUNT(*) DESC LIMIT 1
SELECT LOCATION ,  COUNT(*) FROM railway GROUP BY LOCATION
SELECT LOCATION FROM railway GROUP BY LOCATION HAVING COUNT(*)  >  1
SELECT ObjectNumber FROM railway WHERE Railway_ID NOT IN (SELECT Railway_ID FROM train)
SELECT DISTINCT Country FROM manager
SELECT Working_year_starts FROM manager ORDER BY LEVEL DESC
SELECT Country FROM manager WHERE Age  >  50 OR Age  <  46
SELECT count(*) FROM addresses WHERE country  =  'USA'
SELECT DISTINCT city FROM addresses
SELECT state_province_county ,  count(*) FROM addresses GROUP BY state_province_county
SELECT product_type_code FROM products GROUP BY product_type_code HAVING count(*)  >=  2
SELECT customer_name ,  customer_phone ,  payment_method_code FROM customers ORDER BY customer_number DESC
SELECT T2.customer_name ,  T3.city ,  T1.date_from ,  T1.date_to FROM customer_address_history AS T1 JOIN customers AS T2 ON T1.customer_id  =  T2.customer_id JOIN addresses AS T3 ON T1.address_id  =  T3.address_id
SELECT T1.customer_name FROM customers AS T1 JOIN customer_orders AS T2 ON T1.customer_id  =  T2.customer_id WHERE T1.payment_method_code  =  'Credit Card' GROUP BY T1.customer_id HAVING count(*)  >  2
SELECT product_type_code ,  product_name FROM products WHERE product_price  >  1000 OR product_price  <  500
SELECT dorm_name FROM dorm WHERE gender  =  'F'
SELECT dorm_name FROM dorm WHERE gender  =  'F'
SELECT dorm_name FROM dorm WHERE student_capacity  >  300
SELECT dorm_name FROM dorm WHERE student_capacity  >  300
SELECT count(*) FROM student WHERE sex  =  'F' AND age  <  25
SELECT count(*) FROM student WHERE sex  =  'F' AND age  <  25
SELECT fname FROM student WHERE age  >  20
SELECT fname FROM student WHERE age  >  20
SELECT count(*) FROM dorm
SELECT count(*) FROM dorm
SELECT count(*) FROM dorm_amenity
SELECT count(*) FROM dorm_amenity
SELECT count(*) FROM student
SELECT count(*) FROM student
SELECT student_capacity ,  gender FROM dorm WHERE dorm_name LIKE '%Donor%'
SELECT student_capacity ,  gender FROM dorm WHERE dorm_name LIKE '%Donor%'
SELECT dorm_name ,  gender FROM dorm WHERE student_capacity  >  300 OR student_capacity  <  100
SELECT dorm_name ,  gender FROM dorm WHERE student_capacity  >  300 OR student_capacity  <  100
SELECT lname FROM student WHERE sex  =  'F' AND city_code  =  'BAL' UNION SELECT lname FROM student WHERE sex  =  'M' AND age  <  20
SELECT lname FROM student WHERE sex  =  'F' AND city_code  =  'BAL' UNION SELECT lname FROM student WHERE sex  =  'M' AND age  <  20
SELECT dorm_name FROM dorm ORDER BY student_capacity DESC LIMIT 1
SELECT dorm_name FROM dorm ORDER BY student_capacity DESC LIMIT 1
SELECT amenity_name FROM dorm_amenity ORDER BY amenity_name
SELECT amenity_name FROM dorm_amenity ORDER BY amenity_name
SELECT fname ,  lname FROM student WHERE city_code != 'HKG' ORDER BY age
SELECT fname ,  lname FROM student WHERE city_code != 'HKG' ORDER BY age
SELECT T1.amenity_name FROM dorm_amenity AS T1 JOIN has_amenity AS T2 ON T2.amenid  =  T1.amenid JOIN dorm AS T3 ON T2.dormid  =  T3.dormid WHERE T3.dorm_name  =  'Anonymous Donor Hall' ORDER BY T1.amenity_name
SELECT T1.amenity_name FROM dorm_amenity AS T1 JOIN has_amenity AS T2 ON T2.amenid  =  T1.amenid JOIN dorm AS T3 ON T2.dormid  =  T3.dormid WHERE T3.dorm_name  =  'Anonymous Donor Hall' ORDER BY T1.amenity_name
SELECT count(*) ,  major FROM student GROUP BY major
SELECT count(*) ,  major FROM student GROUP BY major
SELECT count(*) ,  city_code FROM student GROUP BY city_code HAVING count(*)  >  1
SELECT count(*) ,  city_code FROM student GROUP BY city_code HAVING count(*)  >  1
SELECT avg(T1.age) ,  T3.dorm_name FROM student AS T1 JOIN lives_in AS T2 ON T1.stuid  =  T2.stuid JOIN dorm AS T3 ON T3.dormid  =  T2.dormid GROUP BY T3.dorm_name
SELECT avg(T1.age) ,  T3.dorm_name FROM student AS T1 JOIN lives_in AS T2 ON T1.stuid  =  T2.stuid JOIN dorm AS T3 ON T3.dormid  =  T2.dormid GROUP BY T3.dorm_name
SELECT count(*) ,  T1.dormid FROM dorm AS T1 JOIN has_amenity AS T2 ON T1.dormid  =  T2.dormid WHERE T1.student_capacity  >  100 GROUP BY T1.dormid
SELECT count(*) ,  T1.dormid FROM dorm AS T1 JOIN has_amenity AS T2 ON T1.dormid  =  T2.dormid WHERE T1.student_capacity  >  100 GROUP BY T1.dormid
SELECT count(*) ,  T3.dorm_name FROM student AS T1 JOIN lives_in AS T2 ON T1.stuid  =  T2.stuid JOIN dorm AS T3 ON T3.dormid  =  T2.dormid WHERE T1.age  >  20 GROUP BY T3.dorm_name
SELECT count(*) ,  T3.dorm_name FROM student AS T1 JOIN lives_in AS T2 ON T1.stuid  =  T2.stuid JOIN dorm AS T3 ON T3.dormid  =  T2.dormid WHERE T1.age  >  20 GROUP BY T3.dorm_name
SELECT T1.fname FROM student AS T1 JOIN lives_in AS T2 ON T1.stuid  =  T2.stuid JOIN dorm AS T3 ON T3.dormid  =  T2.dormid WHERE T3.dorm_name  =  'Smith Hall'
SELECT T1.fname FROM student AS T1 JOIN lives_in AS T2 ON T1.stuid  =  T2.stuid JOIN dorm AS T3 ON T3.dormid  =  T2.dormid WHERE T3.dorm_name  =  'Smith Hall'
SELECT T3.amenity_name FROM dorm AS T1 JOIN has_amenity AS T2 ON T1.dormid  =  T2.dormid JOIN dorm_amenity AS T3 ON T2.amenid  =  T3.amenid WHERE T1.dorm_name  =  'Smith Hall'
SELECT T3.amenity_name FROM dorm AS T1 JOIN has_amenity AS T2 ON T1.dormid  =  T2.dormid JOIN dorm_amenity AS T3 ON T2.amenid  =  T3.amenid WHERE T1.dorm_name  =  'Smith Hall'
SELECT T3.amenity_name FROM dorm AS T1 JOIN has_amenity AS T2 ON T1.dormid  =  T2.dormid JOIN dorm_amenity AS T3 ON T2.amenid  =  T3.amenid WHERE T1.dorm_name  =  'Smith Hall' ORDER BY T3.amenity_name
SELECT T3.amenity_name FROM dorm AS T1 JOIN has_amenity AS T2 ON T1.dormid  =  T2.dormid JOIN dorm_amenity AS T3 ON T2.amenid  =  T3.amenid WHERE T1.dorm_name  =  'Smith Hall' ORDER BY T3.amenity_name
SELECT T1.amenity_name FROM dorm_amenity AS T1 JOIN has_amenity AS T2 ON T1.amenid  =  T2.amenid GROUP BY T2.amenid ORDER BY count(*) DESC LIMIT 1
SELECT T1.amenity_name FROM dorm_amenity AS T1 JOIN has_amenity AS T2 ON T1.amenid  =  T2.amenid GROUP BY T2.amenid ORDER BY count(*) DESC LIMIT 1
SELECT T1.dorm_name ,  T1.student_capacity FROM dorm AS T1 JOIN has_amenity AS T2 ON T1.dormid  =  T2.dormid JOIN dorm_amenity AS T3 ON T2.amenid  =  T3.amenid GROUP BY T2.dormid ORDER BY count(*) LIMIT 1
SELECT T1.dorm_name ,  T1.student_capacity FROM dorm AS T1 JOIN has_amenity AS T2 ON T1.dormid  =  T2.dormid JOIN dorm_amenity AS T3 ON T2.amenid  =  T3.amenid GROUP BY T2.dormid ORDER BY count(*) LIMIT 1
SELECT T3.amenity_name FROM dorm AS T1 JOIN has_amenity AS T2 ON T1.dormid  =  T2.dormid JOIN dorm_amenity AS T3 ON T2.amenid  =  T3.amenid JOIN lives_in AS T4 ON T4.dormid  =  T1.dormid JOIN student AS T5 ON T5.stuid  =  T4.stuid WHERE T5.lname  =  'Smith'
SELECT T3.amenity_name FROM dorm AS T1 JOIN has_amenity AS T2 ON T1.dormid  =  T2.dormid JOIN dorm_amenity AS T3 ON T2.amenid  =  T3.amenid JOIN lives_in AS T4 ON T4.dormid  =  T1.dormid JOIN student AS T5 ON T5.stuid  =  T4.stuid WHERE T5.lname  =  'Smith'
SELECT count(*) FROM customers
SELECT count(*) FROM customers
SELECT email_address ,  phone_number FROM customers ORDER BY email_address ,  phone_number
SELECT email_address ,  phone_number FROM customers ORDER BY email_address ,  phone_number
SELECT email_address ,  phone_number FROM customers WHERE customer_id NOT IN (SELECT customer_id FROM complaints)
SELECT email_address ,  phone_number FROM customers WHERE customer_id NOT IN (SELECT customer_id FROM complaints)
SELECT product_description FROM products WHERE product_name  =  "Chocolate"
SELECT product_description FROM products WHERE product_name  =  "Chocolate"
SELECT product_name ,  product_category_code FROM products ORDER BY product_price DESC LIMIT 1
SELECT product_name ,  product_category_code FROM products ORDER BY product_price DESC LIMIT 1
SELECT product_price FROM products WHERE product_id NOT IN (SELECT product_id FROM complaints)
SELECT product_price FROM products WHERE product_id NOT IN (SELECT product_id FROM complaints)
SELECT complaint_status_code FROM complaints GROUP BY complaint_status_code HAVING count(*)  >  3
SELECT complaint_status_code FROM complaints GROUP BY complaint_status_code HAVING count(*)  >  3
SELECT last_name FROM staff WHERE email_address LIKE "%wrau%"
SELECT last_name FROM staff WHERE email_address LIKE "%wrau%"
SELECT complaint_status_code ,  count(*) FROM complaints WHERE complaint_type_code  =  "Product Failure" GROUP BY complaint_status_code
SELECT complaint_status_code ,  count(*) FROM complaints WHERE complaint_type_code  =  "Product Failure" GROUP BY complaint_status_code
SELECT count(*) FROM submission
SELECT count(*) FROM submission
SELECT Author FROM submission ORDER BY Scores ASC
SELECT Author FROM submission ORDER BY Scores ASC
SELECT Author ,  College FROM submission
SELECT Author ,  College FROM submission
SELECT Author FROM submission WHERE College  =  "Florida" OR College  =  "Temple"
SELECT Author FROM submission WHERE College  =  "Florida" OR College  =  "Temple"
SELECT Author FROM submission ORDER BY Scores DESC LIMIT 1
SELECT Author FROM submission ORDER BY Scores DESC LIMIT 1
SELECT College ,  COUNT(*) FROM submission GROUP BY College
SELECT College ,  COUNT(*) FROM submission GROUP BY College
SELECT T2.Author ,  T1.Result FROM acceptance AS T1 JOIN submission AS T2 ON T1.Submission_ID  =  T2.Submission_ID
SELECT T2.Author ,  T1.Result FROM acceptance AS T1 JOIN submission AS T2 ON T1.Submission_ID  =  T2.Submission_ID
SELECT T1.Result FROM acceptance AS T1 JOIN submission AS T2 ON T1.Submission_ID  =  T2.Submission_ID ORDER BY T2.Scores DESC LIMIT 1
SELECT T1.Result FROM acceptance AS T1 JOIN submission AS T2 ON T1.Submission_ID  =  T2.Submission_ID ORDER BY T2.Scores DESC LIMIT 1
SELECT Date ,  Venue FROM workshop ORDER BY Venue
SELECT Date ,  Venue FROM workshop ORDER BY Venue
SELECT Author FROM submission WHERE Submission_ID NOT IN (SELECT Submission_ID FROM acceptance)
SELECT Author FROM submission WHERE Submission_ID NOT IN (SELECT Submission_ID FROM acceptance)
SELECT count(*) FROM INVESTORS
SELECT Investor_details FROM INVESTORS
SELECT DISTINCT lot_details FROM LOTS
SELECT max(amount_of_transaction) FROM TRANSACTIONS
SELECT date_of_transaction ,  share_count FROM TRANSACTIONS
SELECT transaction_id FROM TRANSACTIONS WHERE transaction_type_code  =  'PUR'
SELECT date_of_transaction FROM TRANSACTIONS WHERE transaction_type_code  =  "SALE"
SELECT avg(amount_of_transaction) FROM TRANSACTIONS WHERE transaction_type_code  =  "SALE"
SELECT transaction_type_description FROM Ref_Transaction_Types WHERE transaction_type_code	  =  "PUR"
SELECT max(share_count) FROM TRANSACTIONS WHERE amount_of_transaction  <  10000
SELECT date_of_transaction FROM TRANSACTIONS WHERE share_count  >  100 OR amount_of_transaction  >  1000
SELECT T1.transaction_type_description ,  T2.date_of_transaction FROM Ref_Transaction_Types AS T1 JOIN TRANSACTIONS AS T2 ON T1.transaction_type_code  =  T2.transaction_type_code WHERE T2.share_count  <  10
SELECT T1.Investor_details FROM  INVESTORS AS T1 JOIN TRANSACTIONS AS T2 ON T1.investor_id  =  T2.investor_id WHERE T2.share_count  >  100
SELECT lot_details ,  investor_id FROM LOTS
SELECT T2.lot_details FROM INVESTORS AS T1 JOIN LOTS AS T2 ON  T1.investor_id  =  T2.investor_id WHERE T1.Investor_details  =  "l"
SELECT T1.purchase_details FROM PURCHASES AS T1 JOIN TRANSACTIONS AS T2 ON T1.purchase_transaction_id  =  T2.transaction_id WHERE T2.amount_of_transaction  >  10000
SELECT T1.sales_details ,  T2.date_of_transaction FROM SALES AS T1 JOIN TRANSACTIONS AS T2 ON T1.sales_transaction_id  =  T2.transaction_id WHERE T2.amount_of_transaction  <  3000
SELECT T1.lot_details FROM LOTS AS T1 JOIN TRANSACTIONS_LOTS AS T2 ON T1.lot_id  =  T2.transaction_id JOIN TRANSACTIONS AS T3 ON T2.transaction_id  =  T3.transaction_id WHERE T3.share_count  <  50
SELECT T1.lot_details FROM LOTS AS T1 JOIN TRANSACTIONS_LOTS AS T2 ON  T1.lot_id  =  T2.transaction_id JOIN TRANSACTIONS AS T3 ON T2.transaction_id  =  T3.transaction_id WHERE T3.share_count  >  100 AND T3.transaction_type_code  =  "PUR"
SELECT T2.lot_id ,  avg(amount_of_transaction) FROM TRANSACTIONS AS T1 JOIN Transactions_Lots AS T2 ON T1.transaction_id  =  T2.transaction_id GROUP BY T2.lot_id
SELECT investor_id ,  COUNT(*) FROM TRANSACTIONS WHERE transaction_type_code  =  "SALE" GROUP BY investor_id
SELECT investor_id ,  COUNT(*) FROM TRANSACTIONS GROUP BY investor_id
SELECT transaction_type_code FROM TRANSACTIONS GROUP BY transaction_type_code ORDER BY COUNT(*) ASC LIMIT 1
SELECT transaction_type_code FROM TRANSACTIONS GROUP BY transaction_type_code ORDER BY COUNT(*) DESC LIMIT 1
SELECT T1.transaction_type_description FROM Ref_Transaction_Types AS T1 JOIN TRANSACTIONS AS T2 ON T1.transaction_type_code  =  T2.transaction_type_code GROUP BY T1.transaction_type_code ORDER BY COUNT(*) DESC LIMIT 1
SELECT T2.investor_id ,  T1.Investor_details FROM INVESTORS AS T1 JOIN TRANSACTIONS AS T2 ON T1.investor_id  =  T2.investor_id GROUP BY T2.investor_id ORDER BY COUNT(*) DESC LIMIT 1
SELECT T2.investor_id ,  T1.Investor_details FROM INVESTORS AS T1 JOIN TRANSACTIONS AS T2 ON T1.investor_id  =  T2.investor_id GROUP BY T2.investor_id ORDER BY COUNT(*) DESC LIMIT 3
SELECT T2.investor_id FROM INVESTORS AS T1 JOIN TRANSACTIONS AS T2 ON T1.investor_id  =  T2.investor_id GROUP BY T2.investor_id HAVING COUNT(*)  >=  2
SELECT T2.investor_id ,  T1.Investor_details FROM INVESTORS AS T1 JOIN TRANSACTIONS AS T2 ON T1.investor_id  =  T2.investor_id WHERE T2.transaction_type_code  =  "SALE" GROUP BY T2.investor_id HAVING COUNT(*)  >=  2
SELECT date_of_transaction FROM TRANSACTIONS WHERE share_count  >=  100 OR amount_of_transaction  >=  100
SELECT count(*) FROM HOTELS
SELECT count(*) FROM HOTELS
SELECT DISTINCT Location_Name FROM LOCATIONS
SELECT DISTINCT Location_Name FROM LOCATIONS
SELECT Name ,  Other_Details FROM Staff
SELECT Name ,  Other_Details FROM Staff
SELECT Tourist_Details FROM VISITORS
SELECT Tourist_Details FROM VISITORS
SELECT Address FROM LOCATIONS WHERE Location_Name  =  "UK Gallery"
SELECT Address FROM LOCATIONS WHERE Location_Name  =  "UK Gallery"
SELECT Other_Details FROM LOCATIONS WHERE Location_Name  =  "UK Gallery"
SELECT Other_Details FROM LOCATIONS WHERE Location_Name  =  "UK Gallery"
SELECT Location_Name FROM LOCATIONS WHERE Location_Name LIKE "%film%"
SELECT Location_Name FROM LOCATIONS WHERE Location_Name LIKE "%film%"
SELECT DISTINCT Visit_Date FROM VISITS
SELECT DISTINCT Visit_Date FROM VISITS
SELECT Name FROM TOURIST_ATTRACTIONS WHERE How_to_Get_There  =  "bus"
SELECT Name FROM TOURIST_ATTRACTIONS WHERE How_to_Get_There  =  "bus"
SELECT Name ,  Opening_Hours FROM TOURIST_ATTRACTIONS WHERE How_to_Get_There  =  "bus" OR How_to_Get_There  =  "walk"
SELECT Name ,  Opening_Hours FROM TOURIST_ATTRACTIONS WHERE How_to_Get_There  =  "bus" OR How_to_Get_There  =  "walk"
SELECT T2.star_rating_description FROM HOTELS AS T1 JOIN Ref_Hotel_Star_Ratings AS T2 ON T1.star_rating_code  =  T2.star_rating_code WHERE T1.price_range  >  10000
SELECT T2.star_rating_description FROM HOTELS AS T1 JOIN Ref_Hotel_Star_Ratings AS T2 ON T1.star_rating_code  =  T2.star_rating_code WHERE T1.price_range  >  10000
SELECT T1.Museum_Details ,  T2.Opening_Hours FROM MUSEUMS AS T1 JOIN TOURIST_ATTRACTIONS AS T2 ON T1.Museum_ID  =  T2.Tourist_Attraction_ID
SELECT T1.Museum_Details ,  T2.Opening_Hours FROM MUSEUMS AS T1 JOIN TOURIST_ATTRACTIONS AS T2 ON T1.Museum_ID  =  T2.Tourist_Attraction_ID
SELECT T2.Name FROM PHOTOS AS T1 JOIN TOURIST_ATTRACTIONS AS T2 ON T1.Tourist_Attraction_ID  =  T2.Tourist_Attraction_ID WHERE T1.Name  =  "game1"
SELECT T2.Name FROM PHOTOS AS T1 JOIN TOURIST_ATTRACTIONS AS T2 ON T1.Tourist_Attraction_ID  =  T2.Tourist_Attraction_ID WHERE T1.Name  =  "game1"
SELECT T1.Name ,  T1.Description FROM PHOTOS AS T1 JOIN TOURIST_ATTRACTIONS AS T2 ON T1.Tourist_Attraction_ID  =  T2.Tourist_Attraction_ID WHERE T2.Name  =  "film festival"
SELECT T1.Name ,  T1.Description FROM PHOTOS AS T1 JOIN TOURIST_ATTRACTIONS AS T2 ON T1.Tourist_Attraction_ID  =  T2.Tourist_Attraction_ID WHERE T2.Name  =  "film festival"
SELECT T1.Shop_Details FROM SHOPS AS T1 JOIN TOURIST_ATTRACTIONS AS T2 ON T1.Shop_ID  =  T2.Tourist_Attraction_ID WHERE T2.How_to_Get_There  =  "walk"
SELECT T1.Shop_Details FROM SHOPS AS T1 JOIN TOURIST_ATTRACTIONS AS T2 ON T1.Shop_ID  =  T2.Tourist_Attraction_ID WHERE T2.How_to_Get_There  =  "walk"
SELECT T1.Name FROM STAFF AS T1 JOIN TOURIST_ATTRACTIONS AS T2 ON T1.Tourist_Attraction_ID  =  T2.Tourist_Attraction_ID WHERE T2.Name  =  "US museum"
SELECT T1.Name FROM STAFF AS T1 JOIN TOURIST_ATTRACTIONS AS T2 ON T1.Tourist_Attraction_ID  =  T2.Tourist_Attraction_ID WHERE T2.Name  =  "US museum"
SELECT T1.Market_Details FROM Street_Markets AS T1 JOIN TOURIST_ATTRACTIONS AS T2 ON T1.Market_ID  =  T2.Tourist_Attraction_ID WHERE T2.How_to_Get_There  =  "walk" OR  T2.How_to_Get_There  =  "bus"
SELECT T1.Market_Details FROM Street_Markets AS T1 JOIN TOURIST_ATTRACTIONS AS T2 ON T1.Market_ID  =  T2.Tourist_Attraction_ID WHERE T2.How_to_Get_There  =  "walk" OR  T2.How_to_Get_There  =  "bus"
SELECT T2.Visit_Date ,  T2.Visit_Details FROM VISITORS AS T1 JOIN VISITS AS T2 ON T1.Tourist_ID  =  T2.Tourist_ID WHERE T1.Tourist_Details  =  "Vincent"
SELECT T2.Visit_Date ,  T2.Visit_Details FROM VISITORS AS T1 JOIN VISITS AS T2 ON T1.Tourist_ID  =  T2.Tourist_ID WHERE T1.Tourist_Details  =  "Vincent"
SELECT T1.Name FROM Tourist_Attractions AS T1 JOIN VISITS AS T2 ON T1.Tourist_Attraction_ID  =  T2.Tourist_Attraction_ID JOIN VISITORS AS T3 ON T2.Tourist_ID  =  T3.Tourist_ID WHERE T3.Tourist_Details  =  "Vincent"
SELECT T1.Name FROM Tourist_Attractions AS T1 JOIN VISITS AS T2 ON T1.Tourist_Attraction_ID  =  T2.Tourist_Attraction_ID JOIN VISITORS AS T3 ON T2.Tourist_ID  =  T3.Tourist_ID WHERE T3.Tourist_Details  =  "Vincent"
SELECT hotel_id ,  star_rating_code FROM HOTELS ORDER BY price_range ASC
SELECT hotel_id ,  star_rating_code FROM HOTELS ORDER BY price_range ASC
SELECT How_to_Get_There FROM Tourist_Attractions GROUP BY How_to_Get_There ORDER BY COUNT(*) DESC LIMIT 1
SELECT How_to_Get_There FROM Tourist_Attractions GROUP BY How_to_Get_There ORDER BY COUNT(*) DESC LIMIT 1
SELECT T1.Attraction_Type_Description ,  T2.Attraction_Type_Code FROM Ref_Attraction_Types AS T1 JOIN Tourist_Attractions AS T2 ON T1.Attraction_Type_Code  =  T2.Attraction_Type_Code GROUP BY T2.Attraction_Type_Code ORDER BY COUNT(*) DESC LIMIT 1
SELECT T1.Attraction_Type_Description ,  T2.Attraction_Type_Code FROM Ref_Attraction_Types AS T1 JOIN Tourist_Attractions AS T2 ON T1.Attraction_Type_Code  =  T2.Attraction_Type_Code GROUP BY T2.Attraction_Type_Code ORDER BY COUNT(*) DESC LIMIT 1
SELECT How_to_Get_There ,  COUNT(*) FROM Tourist_Attractions GROUP BY How_to_Get_There
SELECT How_to_Get_There ,  COUNT(*) FROM Tourist_Attractions GROUP BY How_to_Get_There
SELECT T1.Name ,  T2.Tourist_Attraction_ID ,   COUNT(*) FROM Tourist_Attractions AS T1 JOIN VISITS AS T2 ON T1.Tourist_Attraction_ID  =  T2.Tourist_Attraction_ID GROUP BY T2.Tourist_Attraction_ID
SELECT T1.Name ,  T2.Tourist_Attraction_ID ,   COUNT(*) FROM Tourist_Attractions AS T1 JOIN VISITS AS T2 ON T1.Tourist_Attraction_ID  =  T2.Tourist_Attraction_ID GROUP BY T2.Tourist_Attraction_ID
SELECT T1.Name ,  T2.Tourist_Attraction_ID FROM Tourist_Attractions AS T1 JOIN VISITS AS T2 ON T1.Tourist_Attraction_ID  =  T2.Tourist_Attraction_ID GROUP BY T2.Tourist_Attraction_ID HAVING count(*)  >=  2
SELECT T1.Name ,  T2.Tourist_Attraction_ID FROM Tourist_Attractions AS T1 JOIN VISITS AS T2 ON T1.Tourist_Attraction_ID  =  T2.Tourist_Attraction_ID GROUP BY T2.Tourist_Attraction_ID HAVING count(*)  >=  2
SELECT T1.Name ,  T1.Tourist_Attraction_ID FROM Tourist_Attractions AS T1 JOIN VISITS AS T2 ON T1.Tourist_Attraction_ID  =  T2.Tourist_Attraction_ID GROUP BY T2.Tourist_Attraction_ID HAVING count(*)  <=  1
SELECT T1.Name ,  T1.Tourist_Attraction_ID FROM Tourist_Attractions AS T1 JOIN VISITS AS T2 ON T1.Tourist_Attraction_ID  =  T2.Tourist_Attraction_ID GROUP BY T2.Tourist_Attraction_ID HAVING count(*)  <=  1
SELECT T2.Name FROM Locations AS T1 JOIN Tourist_Attractions AS T2 ON T1.Location_ID  =  T2.Location_ID WHERE T1.Address  =  "660 Shea Crescent" OR T2.How_to_Get_There  =  "walk"
SELECT T2.Name FROM Locations AS T1 JOIN Tourist_Attractions AS T2 ON T1.Location_ID  =  T2.Location_ID WHERE T1.Address  =  "660 Shea Crescent" OR T2.How_to_Get_There  =  "walk"
SELECT T1.Name FROM Tourist_Attractions AS T1 JOIN Tourist_Attraction_Features AS T2 ON T1.tourist_attraction_id  =  T2.tourist_attraction_id JOIN Features AS T3 ON T2.Feature_ID  =  T3.Feature_ID WHERE T3.feature_Details  =  'park' UNION SELECT T1.Name FROM Tourist_Attractions AS T1 JOIN Tourist_Attraction_Features AS T2 ON T1.tourist_attraction_id  =  T2.tourist_attraction_id JOIN Features AS T3 ON T2.Feature_ID  =  T3.Feature_ID WHERE T3.feature_Details  =  'shopping'
SELECT T1.Name FROM Tourist_Attractions AS T1 JOIN Tourist_Attraction_Features AS T2 ON T1.tourist_attraction_id  =  T2.tourist_attraction_id JOIN Features AS T3 ON T2.Feature_ID  =  T3.Feature_ID WHERE T3.feature_Details  =  'park' UNION SELECT T1.Name FROM Tourist_Attractions AS T1 JOIN Tourist_Attraction_Features AS T2 ON T1.tourist_attraction_id  =  T2.tourist_attraction_id JOIN Features AS T3 ON T2.Feature_ID  =  T3.Feature_ID WHERE T3.feature_Details  =  'shopping'
SELECT T2.Name FROM Locations AS T1 JOIN Tourist_Attractions AS T2 ON T1.Location_ID  =  T2.Location_ID WHERE T1.Address  =  "254 Ottilie Junction" OR T2.How_to_Get_There  =  "bus"
SELECT T2.Name FROM Locations AS T1 JOIN Tourist_Attractions AS T2 ON T1.Location_ID  =  T2.Location_ID WHERE T1.Address  =  "254 Ottilie Junction" OR T2.How_to_Get_There  =  "bus"
SELECT count(*) FROM Video_games
SELECT count(*) FROM Video_games
SELECT DISTINCT gtype FROM Video_games
SELECT DISTINCT gtype FROM Video_games
SELECT gname ,  gtype FROM Video_games ORDER BY gname
SELECT gname ,  gtype FROM Video_games ORDER BY gname
SELECT gname FROM Video_games WHERE gtype  =  "Collectible card game"
SELECT gname FROM Video_games WHERE gtype  =  "Collectible card game"
SELECT gtype FROM Video_games WHERE gname  =  "Call of Destiny"
SELECT gtype FROM Video_games WHERE gname  =  "Call of Destiny"
SELECT count(*) FROM Video_games WHERE gtype  =  "Massively multiplayer online game"
SELECT count(*) FROM Video_games WHERE gtype  =  "Massively multiplayer online game"
SELECT gtype ,  count(*) FROM Video_games GROUP BY gtype
SELECT gtype ,  count(*) FROM Video_games GROUP BY gtype
SELECT gtype FROM Video_games GROUP BY gtype ORDER BY count(*) LIMIT 1
SELECT gtype FROM Video_games GROUP BY gtype ORDER BY count(*) LIMIT 1
SELECT StuID FROM Student WHERE city_code  =  "CHI"
SELECT StuID FROM Student WHERE city_code  =  "CHI"
SELECT StuID FROM Student WHERE Advisor  =  1121
SELECT StuID FROM Student WHERE Advisor  =  1121
SELECT Fname FROM Student WHERE Major  =  600
SELECT Fname FROM Student WHERE Major  =  600
SELECT advisor FROM Student GROUP BY advisor HAVING count(*)  >=  2
SELECT advisor FROM Student GROUP BY advisor HAVING count(*)  >=  2
SELECT StuID FROM Sportsinfo WHERE onscholarship  =  'Y'
SELECT StuID FROM Sportsinfo WHERE onscholarship  =  'Y'
SELECT T2.Lname FROM Sportsinfo AS T1 JOIN Student AS T2 ON T1.StuID  =  T2.StuID WHERE T1.onscholarship  =  'Y'
SELECT T2.Lname FROM Sportsinfo AS T1 JOIN Student AS T2 ON T1.StuID  =  T2.StuID WHERE T1.onscholarship  =  'Y'
SELECT sportname ,  count(*) FROM Sportsinfo GROUP BY sportname
SELECT sportname ,  count(*) FROM Sportsinfo GROUP BY sportname
SELECT sportname FROM Sportsinfo WHERE onscholarship  =  'Y' GROUP BY sportname ORDER BY count(*) DESC LIMIT 1
SELECT sportname FROM Sportsinfo WHERE onscholarship  =  'Y' GROUP BY sportname ORDER BY count(*) DESC LIMIT 1
SELECT Gname FROM Plays_games AS T1 JOIN Video_games AS T2 ON T1.gameid  =  T2.gameid JOIN Student AS T3 ON T3.Stuid  =  T1.Stuid WHERE T3.Lname  =  "Smith" AND T3.Fname  =  "Linda"
SELECT Gname FROM Plays_games AS T1 JOIN Video_games AS T2 ON T1.gameid  =  T2.gameid JOIN Student AS T3 ON T3.Stuid  =  T1.Stuid WHERE T3.Lname  =  "Smith" AND T3.Fname  =  "Linda"
SELECT T2.lname ,  T2.fname FROM SportsInfo AS T1 JOIN Student AS T2 ON T1.StuID  =  T2.StuID WHERE T1.SportName  =  "Football" OR T1.SportName  =  "Lacrosse"
SELECT T2.lname ,  T2.fname FROM SportsInfo AS T1 JOIN Student AS T2 ON T1.StuID  =  T2.StuID WHERE T1.SportName  =  "Football" OR T1.SportName  =  "Lacrosse"
SELECT customer_name FROM customers
SELECT customer_name FROM customers
SELECT count(*) FROM customers
SELECT count(*) FROM customers
SELECT customer_name FROM customers WHERE payment_method  =  "Cash"
SELECT customer_name FROM customers WHERE payment_method  =  "Cash"
SELECT date_became_customer FROM customers WHERE customer_id BETWEEN 10 AND 20
SELECT date_became_customer FROM customers WHERE customer_id BETWEEN 10 AND 20
SELECT payment_method FROM customers GROUP BY payment_method ORDER BY count(*) DESC LIMIT 1
SELECT payment_method FROM customers GROUP BY payment_method ORDER BY count(*) DESC LIMIT 1
SELECT DISTINCT payment_method FROM customers
SELECT DISTINCT payment_method FROM customers
SELECT DISTINCT product_details FROM products
SELECT DISTINCT product_details FROM products
SELECT customer_name FROM customers WHERE customer_name LIKE "%Alex%"
SELECT customer_name FROM customers WHERE customer_name LIKE "%Alex%"
SELECT product_details FROM products WHERE product_details LIKE "%Latte%" OR product_details LIKE "%Americano%"
SELECT product_details FROM products WHERE product_details LIKE "%Latte%" OR product_details LIKE "%Americano%"
SELECT DISTINCT city FROM addresses
SELECT DISTINCT city FROM addresses
SELECT city FROM addresses WHERE zip_postcode  =  255
SELECT city FROM addresses WHERE zip_postcode  =  255
SELECT state_province_county ,  country FROM addresses WHERE zip_postcode LIKE "4%"
SELECT state_province_county ,  country FROM addresses WHERE zip_postcode LIKE "4%"
SELECT count(*) FROM customer_orders WHERE order_details  =  "Second time"
SELECT count(*) FROM customer_orders WHERE order_details  =  "Second time"
SELECT address_content FROM addresses WHERE city  =  "East Julianaside" AND state_province_county  =  "Texas" UNION SELECT address_content FROM addresses WHERE city  =  "Gleasonmouth" AND state_province_county  =  "Arizona"
SELECT address_content FROM addresses WHERE city  =  "East Julianaside" AND state_province_county  =  "Texas" UNION SELECT address_content FROM addresses WHERE city  =  "Gleasonmouth" AND state_province_county  =  "Arizona"
SELECT customer_name FROM customers WHERE payment_method != 'Cash'
SELECT customer_name FROM customers WHERE payment_method != 'Cash'
SELECT count(*) FROM artist
SELECT count(*) FROM artist
SELECT Age FROM artist
SELECT Age FROM artist
SELECT avg(Age) FROM artist
SELECT avg(Age) FROM artist
SELECT Famous_Title FROM artist WHERE Artist  =  "Triumfall"
SELECT Famous_Title FROM artist WHERE Artist  =  "Triumfall"
SELECT distinct(Famous_Release_date) FROM artist
SELECT distinct(Famous_Release_date) FROM artist
SELECT Date_of_ceremony ,  RESULT FROM music_festival
SELECT Date_of_ceremony ,  RESULT FROM music_festival
SELECT Category FROM music_festival WHERE RESULT  =  "Awarded"
SELECT Category FROM music_festival WHERE RESULT  =  "Awarded"
SELECT max(Weeks_on_Top) ,  min(Weeks_on_Top) FROM volume
SELECT max(Weeks_on_Top) ,  min(Weeks_on_Top) FROM volume
SELECT Song FROM volume WHERE Weeks_on_Top  >  1
SELECT Song FROM volume WHERE Weeks_on_Top  >  1
SELECT Song FROM volume ORDER BY Song
SELECT Song FROM volume ORDER BY Song
SELECT T1.Date_of_ceremony FROM music_festival AS T1 JOIN volume AS T2 ON T1.Volume  =  T2.Volume_ID WHERE T2.Weeks_on_Top  >  2
SELECT T1.Date_of_ceremony FROM music_festival AS T1 JOIN volume AS T2 ON T1.Volume  =  T2.Volume_ID WHERE T2.Weeks_on_Top  >  2
SELECT T2.Song FROM music_festival AS T1 JOIN volume AS T2 ON T1.Volume  =  T2.Volume_ID WHERE T1.Result  =  "Nominated"
SELECT T2.Song FROM music_festival AS T1 JOIN volume AS T2 ON T1.Volume  =  T2.Volume_ID WHERE T1.Result  =  "Nominated"
SELECT T2.Issue_Date FROM artist AS T1 JOIN volume AS T2 ON T1.Artist_ID  =  T2.Artist_ID WHERE T1.Artist  =  "Gorgoroth"
SELECT T2.Issue_Date FROM artist AS T1 JOIN volume AS T2 ON T1.Artist_ID  =  T2.Artist_ID WHERE T1.Artist  =  "Gorgoroth"
SELECT T2.Song FROM artist AS T1 JOIN volume AS T2 ON T1.Artist_ID  =  T2.Artist_ID WHERE T1.age  >=  32
SELECT T2.Song FROM artist AS T1 JOIN volume AS T2 ON T1.Artist_ID  =  T2.Artist_ID WHERE T1.age  >=  32
SELECT avg(T2.Weeks_on_Top) FROM artist AS T1 JOIN volume AS T2 ON T1.Artist_ID  =  T2.Artist_ID WHERE T1.age  <=  25
SELECT avg(T2.Weeks_on_Top) FROM artist AS T1 JOIN volume AS T2 ON T1.Artist_ID  =  T2.Artist_ID WHERE T1.age  <=  25
SELECT T1.Famous_Title FROM artist AS T1 JOIN volume AS T2 ON T1.Artist_ID  =  T2.Artist_ID WHERE T2.Weeks_on_Top  >  2
SELECT T1.Famous_Title FROM artist AS T1 JOIN volume AS T2 ON T1.Artist_ID  =  T2.Artist_ID WHERE T2.Weeks_on_Top  >  2
SELECT Famous_Title ,  Age FROM artist ORDER BY Age DESC
SELECT Famous_Title ,  Age FROM artist ORDER BY Age DESC
SELECT Famous_Release_date FROM artist ORDER BY Age DESC LIMIT 1
SELECT Famous_Release_date FROM artist ORDER BY Age DESC LIMIT 1
SELECT Category ,  COUNT(*) FROM music_festival GROUP BY Category
SELECT Category ,  COUNT(*) FROM music_festival GROUP BY Category
SELECT RESULT FROM music_festival GROUP BY RESULT ORDER BY COUNT(*) DESC LIMIT 1
SELECT RESULT FROM music_festival GROUP BY RESULT ORDER BY COUNT(*) DESC LIMIT 1
SELECT Category FROM music_festival GROUP BY Category HAVING COUNT(*)  >  1
SELECT Category FROM music_festival GROUP BY Category HAVING COUNT(*)  >  1
SELECT Song FROM volume ORDER BY Weeks_on_Top DESC LIMIT 1
SELECT Song FROM volume ORDER BY Weeks_on_Top DESC LIMIT 1
SELECT Famous_Title FROM artist WHERE Artist_ID NOT IN(SELECT Artist_ID FROM volume)
SELECT Famous_Title FROM artist WHERE Artist_ID NOT IN(SELECT Artist_ID FROM volume)
SELECT Date_of_ceremony FROM music_festival WHERE Category  =  "Best Song" AND RESULT  =  "Awarded"
SELECT Date_of_ceremony FROM music_festival WHERE Category  =  "Best Song" AND RESULT  =  "Awarded"
SELECT Issue_Date FROM volume ORDER BY Weeks_on_Top ASC LIMIT 1
SELECT Issue_Date FROM volume ORDER BY Weeks_on_Top ASC LIMIT 1
SELECT RESULT ,  COUNT(*) FROM music_festival GROUP BY RESULT ORDER BY COUNT(*) DESC
SELECT RESULT ,  COUNT(*) FROM music_festival GROUP BY RESULT ORDER BY COUNT(*) DESC
SELECT Issue_Date FROM artist AS T1 JOIN volume AS T2 ON T1.Artist_ID  =  T2.Artist_ID WHERE T1.age  <=  23
SELECT Issue_Date FROM artist AS T1 JOIN volume AS T2 ON T1.Artist_ID  =  T2.Artist_ID WHERE T1.age  <=  23
SELECT count(*) FROM roller_coaster
SELECT Name FROM roller_coaster ORDER BY LENGTH ASC
SELECT LENGTH ,  Height FROM roller_coaster
SELECT Name FROM country WHERE Languages != "German"
SELECT Status FROM roller_coaster WHERE LENGTH  >  3300 OR Height  >  100
SELECT Speed FROM roller_coaster ORDER BY LENGTH DESC LIMIT 1
SELECT Status ,  COUNT(*) FROM roller_coaster GROUP BY Status
SELECT Status FROM roller_coaster GROUP BY Status ORDER BY COUNT(*) DESC LIMIT 1
SELECT Status FROM roller_coaster GROUP BY Status HAVING COUNT(*)  >  2
SELECT Park FROM roller_coaster ORDER BY Speed DESC LIMIT 1
SELECT T2.Name ,  T1.Name FROM country AS T1 JOIN roller_coaster AS T2 ON T1.Country_ID  =  T2.Country_ID
SELECT T1.Name FROM country AS T1 JOIN roller_coaster AS T2 ON T1.Country_ID  =  T2.Country_ID GROUP BY T1.Name HAVING COUNT(*)  >  1
SELECT T1.Name ,  T1.population FROM country AS T1 JOIN roller_coaster AS T2 ON T1.Country_ID  =  T2.Country_ID ORDER BY T2.Height DESC LIMIT 1
SELECT count(*) ,  rank FROM captain GROUP BY rank
SELECT count(*) ,  rank FROM captain GROUP BY rank
SELECT count(*) ,  rank FROM captain WHERE age  <  50 GROUP BY rank
SELECT count(*) ,  rank FROM captain WHERE age  <  50 GROUP BY rank
SELECT name FROM captain ORDER BY age DESC
SELECT name FROM captain ORDER BY age DESC
SELECT name ,  CLASS ,  rank FROM captain
SELECT name ,  CLASS ,  rank FROM captain
SELECT rank FROM captain GROUP BY rank ORDER BY count(*) DESC LIMIT 1
SELECT rank FROM captain GROUP BY rank ORDER BY count(*) DESC LIMIT 1
SELECT CLASS FROM captain GROUP BY CLASS HAVING count(*)  >  2
SELECT CLASS FROM captain GROUP BY CLASS HAVING count(*)  >  2
SELECT name FROM captain WHERE rank  =  'Midshipman' OR rank  =  'Lieutenant'
SELECT name FROM captain WHERE rank  =  'Midshipman' OR rank  =  'Lieutenant'
SELECT name FROM captain ORDER BY age LIMIT 1
SELECT name FROM captain ORDER BY age LIMIT 1
SELECT count(*) FROM ship
SELECT count(*) FROM ship
SELECT name ,  TYPE ,  flag FROM ship ORDER BY built_year DESC LIMIT 1
SELECT name ,  TYPE ,  flag FROM ship ORDER BY built_year DESC LIMIT 1
SELECT count(*) ,  flag FROM ship GROUP BY flag
SELECT count(*) ,  flag FROM ship GROUP BY flag
SELECT flag FROM ship GROUP BY flag ORDER BY count(*) DESC LIMIT 1
SELECT flag FROM ship GROUP BY flag ORDER BY count(*) DESC LIMIT 1
SELECT name FROM ship ORDER BY built_year ,  CLASS
SELECT name FROM ship ORDER BY built_year ,  CLASS
SELECT built_year FROM ship GROUP BY built_year ORDER BY count(*) DESC LIMIT 1
SELECT built_year FROM ship GROUP BY built_year ORDER BY count(*) DESC LIMIT 1
SELECT name ,  CLASS FROM ship WHERE ship_id NOT IN (SELECT ship_id FROM captain)
SELECT name ,  CLASS FROM ship WHERE ship_id NOT IN (SELECT ship_id FROM captain)
SELECT host_city FROM hosting_city ORDER BY YEAR DESC LIMIT 1
SELECT host_city FROM hosting_city ORDER BY YEAR DESC LIMIT 1
SELECT match_id FROM MATCH WHERE competition = "1994 FIFA World Cup qualification"
SELECT match_id FROM MATCH WHERE competition = "1994 FIFA World Cup qualification"
SELECT T1.city FROM city AS T1 JOIN hosting_city AS T2 ON T1.city_id = T2.host_city WHERE T2.year  >  2010
SELECT T1.city FROM city AS T1 JOIN hosting_city AS T2 ON T1.city_id = T2.host_city WHERE T2.year  >  2010
SELECT T1.city FROM city AS T1 JOIN hosting_city AS T2 ON T1.city_id  =  T2.host_city GROUP BY T2.host_city ORDER BY count(*) DESC LIMIT 1
SELECT T1.city FROM city AS T1 JOIN hosting_city AS T2 ON T1.city_id  =  T2.host_city GROUP BY T2.host_city ORDER BY count(*) DESC LIMIT 1
SELECT T3.venue FROM city AS T1 JOIN hosting_city AS T2 ON T1.city_id = T2.host_city JOIN MATCH AS T3 ON T2.match_id = T3.match_id WHERE T1.city = "Nanjing ( Jiangsu )" AND T3.competition = "1994 FIFA World Cup qualification"
SELECT T3.venue FROM city AS T1 JOIN hosting_city AS T2 ON T1.city_id = T2.host_city JOIN MATCH AS T3 ON T2.match_id = T3.match_id WHERE T1.city = "Nanjing ( Jiangsu )" AND T3.competition = "1994 FIFA World Cup qualification"
SELECT T2.Jan FROM city AS T1 JOIN temperature AS T2 ON T1.city_id = T2.city_id WHERE T1.city = "Shanghai"
SELECT T2.Jan FROM city AS T1 JOIN temperature AS T2 ON T1.city_id = T2.city_id WHERE T1.city = "Shanghai"
SELECT T2.year FROM city AS T1 JOIN hosting_city AS T2 ON T1.city_id  =  T2.host_city WHERE T1.city  =  "Taizhou ( Zhejiang )"
SELECT T2.year FROM city AS T1 JOIN hosting_city AS T2 ON T1.city_id  =  T2.host_city WHERE T1.city  =  "Taizhou ( Zhejiang )"
SELECT city FROM city ORDER BY regional_population DESC LIMIT 3
SELECT city FROM city ORDER BY regional_population DESC LIMIT 3
SELECT city ,  GDP FROM city ORDER BY GDP LIMIT 1
SELECT city ,  GDP FROM city ORDER BY GDP LIMIT 1
SELECT T1.city FROM city AS T1 JOIN temperature AS T2 ON T1.city_id  =  T2.city_id ORDER BY T2.Feb DESC LIMIT 1
SELECT T1.city FROM city AS T1 JOIN temperature AS T2 ON T1.city_id  =  T2.city_id ORDER BY T2.Feb DESC LIMIT 1
SELECT T1.city FROM city AS T1 JOIN temperature AS T2 ON T1.city_id  =  T2.city_id WHERE T2.Mar  <  T2.Jul OR T2.Mar  >  T2.Oct
SELECT T1.city FROM city AS T1 JOIN temperature AS T2 ON T1.city_id  =  T2.city_id WHERE T2.Mar  <  T2.Jul OR T2.Mar  >  T2.Oct
SELECT T1.city FROM city AS T1 JOIN temperature AS T2 ON T1.city_id  =  T2.city_id WHERE T2.Feb  >  T2.Jun UNION SELECT T3.city FROM city AS T3 JOIN hosting_city AS T4 ON T3.city_id  =  T4.host_city
SELECT T1.city FROM city AS T1 JOIN temperature AS T2 ON T1.city_id  =  T2.city_id WHERE T2.Feb  >  T2.Jun UNION SELECT T3.city FROM city AS T3 JOIN hosting_city AS T4 ON T3.city_id  =  T4.host_city
SELECT city FROM city WHERE regional_population  >  10000000
SELECT city FROM city WHERE regional_population  >  10000000
SELECT city FROM city WHERE regional_population  >  10000000 UNION SELECT city FROM city WHERE regional_population  <  5000000
SELECT city FROM city WHERE regional_population  >  10000000 UNION SELECT city FROM city WHERE regional_population  <  5000000
SELECT count(*) ,  Competition FROM MATCH GROUP BY Competition
SELECT count(*) ,  Competition FROM MATCH GROUP BY Competition
SELECT venue FROM MATCH ORDER BY date DESC
SELECT venue FROM MATCH ORDER BY date DESC
SELECT gdp FROM city ORDER BY Regional_Population DESC LIMIT 1
SELECT gdp FROM city ORDER BY Regional_Population DESC LIMIT 1
SELECT individual_first_name ,  individual_middle_name ,  individual_last_name FROM individuals ORDER BY individual_last_name
SELECT individual_first_name ,  individual_middle_name ,  individual_last_name FROM individuals ORDER BY individual_last_name
SELECT DISTINCT form_type_code FROM forms
SELECT DISTINCT form_type_code FROM forms
SELECT organization_name FROM organizations ORDER BY date_formed ASC
SELECT organization_name FROM organizations ORDER BY date_formed ASC
SELECT organization_name FROM organizations ORDER BY date_formed DESC LIMIT 1
SELECT organization_name FROM organizations ORDER BY date_formed DESC LIMIT 1
SELECT count(*) FROM services
SELECT count(*) FROM services
SELECT count(*) FROM addresses WHERE state_province_county  =  "Colorado"
SELECT count(*) FROM addresses WHERE state_province_county  =  "Colorado"
SELECT payment_method_code FROM parties GROUP BY payment_method_code HAVING count(*)  >  3
SELECT payment_method_code FROM parties GROUP BY payment_method_code HAVING count(*)  >  3
SELECT organization_name FROM organizations WHERE organization_name LIKE "%Party%"
SELECT organization_name FROM organizations WHERE organization_name LIKE "%Party%"
SELECT state_province_county FROM addresses WHERE line_1_number_building LIKE "%6862 Kaitlyn Knolls%"
SELECT state_province_county FROM addresses WHERE line_1_number_building LIKE "%6862 Kaitlyn Knolls%"
SELECT count(*) FROM driver
SELECT name ,  home_city ,  age FROM driver
SELECT party ,  count(*) FROM driver GROUP BY party
SELECT name FROM driver ORDER BY age DESC
SELECT DISTINCT home_city FROM driver
SELECT home_city FROM driver GROUP BY home_city ORDER BY count(*) DESC LIMIT 1
SELECT party FROM driver WHERE home_city  =  'Hartford' AND age  >  40
SELECT home_city FROM driver WHERE age  >  40 GROUP BY home_city HAVING count(*)  >=  2
SELECT name FROM driver WHERE driver_id NOT IN (SELECT driver_id FROM school_bus)
SELECT TYPE FROM school GROUP BY TYPE HAVING count(*)  =  2
SELECT T2.school ,  T3.name FROM school_bus AS T1 JOIN school AS T2 ON T1.school_id  =  T2.school_id JOIN driver AS T3 ON T1.driver_id  =  T3.driver_id
SELECT max(years_working) ,  min(years_working) ,  avg(years_working) FROM school_bus
SELECT school ,  TYPE FROM school WHERE school_id NOT IN (SELECT school_id FROM school_bus)
SELECT T2.type ,  count(*) FROM school_bus AS T1 JOIN school AS T2 ON T1.school_id  =  T2.school_id GROUP BY T2.type
SELECT count(*) FROM driver WHERE home_city  =  'Hartford' OR age  <  40
SELECT name FROM driver WHERE home_city  =  'Hartford' AND age  <  40
SELECT count(*) FROM flight WHERE velocity  >  200
SELECT vehicle_flight_number ,  date ,  pilot FROM flight ORDER BY altitude ASC
SELECT id ,  country ,  city ,  name FROM airport ORDER BY name
SELECT max(group_equity_shareholding) FROM operate_company
SELECT avg(velocity) FROM flight WHERE pilot  =  'Thompson'
SELECT name FROM airport WHERE country != 'Iceland'
SELECT T1.id ,  T1.name ,  T1.IATA FROM airport AS T1 JOIN flight AS T2 ON T1.id  =  T2.airport_id GROUP BY T2.id ORDER BY count(*) DESC LIMIT 1
SELECT DISTINCT T2.pilot FROM airport AS T1 JOIN flight AS T2 ON T1.id  =  T2.airport_id WHERE T1.country  =  'United States' OR T1.name  =  'Billund Airport'
SELECT TYPE ,  count(*) FROM operate_company GROUP BY TYPE ORDER BY count(*) DESC LIMIT 1
SELECT name FROM airport WHERE name LIKE '%international%'
SELECT count(*) ,  country FROM airport GROUP BY country
SELECT country FROM airport GROUP BY country HAVING count(*)  >  2
SELECT pilot FROM flight GROUP BY pilot ORDER BY count(*) DESC LIMIT 1
SELECT count(*) FROM Accounts
SELECT count(*) FROM Accounts
SELECT account_id ,  account_details FROM Accounts
SELECT account_id ,  account_details FROM Accounts
SELECT count(*) FROM Statements
SELECT count(*) FROM Statements
SELECT STATEMENT_ID ,  statement_details FROM Statements
SELECT STATEMENT_ID ,  statement_details FROM Statements
SELECT T1.statement_id ,  T2.statement_details ,  T1.account_details FROM Accounts AS T1 JOIN Statements AS T2 ON T1.statement_id  =  T2.statement_id
SELECT T1.statement_id ,  T2.statement_details ,  T1.account_details FROM Accounts AS T1 JOIN Statements AS T2 ON T1.statement_id  =  T2.statement_id
SELECT STATEMENT_ID ,  count(*) FROM Accounts GROUP BY STATEMENT_ID
SELECT STATEMENT_ID ,  count(*) FROM Accounts GROUP BY STATEMENT_ID
SELECT T1.statement_id ,  T2.statement_details FROM Accounts AS T1 JOIN Statements AS T2 ON T1.statement_id  =  T2.statement_id GROUP BY T1.statement_id ORDER BY count(*) DESC LIMIT 1
SELECT T1.statement_id ,  T2.statement_details FROM Accounts AS T1 JOIN Statements AS T2 ON T1.statement_id  =  T2.statement_id GROUP BY T1.statement_id ORDER BY count(*) DESC LIMIT 1
SELECT count(*) FROM Documents
SELECT count(*) FROM Documents
SELECT document_type_code ,  document_name ,  document_description FROM Documents WHERE document_name  =  'Noel CV' OR document_name  =  'King Book'
SELECT document_type_code ,  document_name ,  document_description FROM Documents WHERE document_name  =  'Noel CV' OR document_name  =  'King Book'
SELECT document_id ,  document_name FROM Documents
SELECT document_id ,  document_name FROM Documents
SELECT document_name ,  document_id FROM Documents WHERE document_type_code  =  "BK"
SELECT document_name ,  document_id FROM Documents WHERE document_type_code  =  "BK"
SELECT count(*) ,  project_id FROM Documents WHERE document_type_code  =  "BK" GROUP BY project_id
SELECT count(*) ,  project_id FROM Documents WHERE document_type_code  =  "BK" GROUP BY project_id
SELECT document_name ,  document_date FROM Documents AS T1 JOIN projects AS T2 ON T1.project_id  =  T2.project_id WHERE T2.project_details  =  'Graph Database project'
SELECT document_name ,  document_date FROM Documents AS T1 JOIN projects AS T2 ON T1.project_id  =  T2.project_id WHERE T2.project_details  =  'Graph Database project'
SELECT project_id ,  count(*) FROM Documents GROUP BY project_id
SELECT project_id ,  count(*) FROM Documents GROUP BY project_id
SELECT project_id FROM Documents GROUP BY project_id ORDER BY count(*) ASC LIMIT 1
SELECT project_id FROM Documents GROUP BY project_id ORDER BY count(*) ASC LIMIT 1
SELECT project_id FROM Documents GROUP BY project_id HAVING count(*)  >=  2
SELECT project_id FROM Documents GROUP BY project_id HAVING count(*)  >=  2
SELECT document_type_code ,  count(*) FROM Documents GROUP BY document_type_code
SELECT document_type_code ,  count(*) FROM Documents GROUP BY document_type_code
SELECT document_type_code FROM Documents GROUP BY document_type_code ORDER BY count(*) DESC LIMIT 1
SELECT document_type_code FROM Documents GROUP BY document_type_code ORDER BY count(*) DESC LIMIT 1
SELECT document_type_code FROM Documents GROUP BY document_type_code HAVING count(*)  <  3
SELECT document_type_code FROM Documents GROUP BY document_type_code HAVING count(*)  <  3
SELECT T1.statement_details ,  T2.document_name FROM Statements AS T1 JOIN Documents AS T2 ON T1.statement_id  =  T2.document_id WHERE T1.statement_details  =  'Private Project'
SELECT T1.statement_details ,  T2.document_name FROM Statements AS T1 JOIN Documents AS T2 ON T1.statement_id  =  T2.document_id WHERE T1.statement_details  =  'Private Project'
SELECT document_type_code ,  document_type_name ,  document_type_description FROM Ref_document_types
SELECT document_type_code ,  document_type_name ,  document_type_description FROM Ref_document_types
SELECT document_type_description FROM Ref_document_types WHERE document_type_name  =  "Film"
SELECT document_type_description FROM Ref_document_types WHERE document_type_name  =  "Film"
SELECT T1.document_type_name ,  T1.document_type_description ,  T2.Document_date FROM Ref_document_types AS T1 JOIN Documents AS T2 ON T1.document_type_code  =  T2.document_type_code
SELECT T1.document_type_name ,  T1.document_type_description ,  T2.Document_date FROM Ref_document_types AS T1 JOIN Documents AS T2 ON T1.document_type_code  =  T2.document_type_code
SELECT count(*) FROM Projects
SELECT count(*) FROM Projects
SELECT project_id ,  project_details FROM Projects
SELECT project_id ,  project_details FROM Projects
SELECT T1.project_id ,  T1.project_details FROM Projects AS T1 JOIN Documents AS T2 ON T1.project_id  =  T2.project_id GROUP BY T1.project_id HAVING count(*)  >  2
SELECT T1.project_id ,  T1.project_details FROM Projects AS T1 JOIN Documents AS T2 ON T1.project_id  =  T2.project_id GROUP BY T1.project_id HAVING count(*)  >  2
SELECT T1.project_details FROM Projects AS T1 JOIN Documents AS T2 ON T1.project_id  =  T2.project_id WHERE T2.document_name  =  "King Book"
SELECT T1.project_details FROM Projects AS T1 JOIN Documents AS T2 ON T1.project_id  =  T2.project_id WHERE T2.document_name  =  "King Book"
SELECT count(*) FROM Ref_budget_codes
SELECT count(*) FROM Ref_budget_codes
SELECT budget_type_code ,  budget_type_description FROM Ref_budget_codes
SELECT budget_type_code ,  budget_type_description FROM Ref_budget_codes
SELECT budget_type_description FROM Ref_budget_codes WHERE budget_type_code  =  "ORG"
SELECT budget_type_description FROM Ref_budget_codes WHERE budget_type_code  =  "ORG"
SELECT count(*) FROM Documents_with_expenses
SELECT count(*) FROM Documents_with_expenses
SELECT document_id FROM Documents_with_expenses WHERE budget_type_code  =  'SF'
SELECT document_id FROM Documents_with_expenses WHERE budget_type_code  =  'SF'
SELECT T2.budget_type_code ,  T2.budget_type_description ,  T1.document_id FROM Documents_with_expenses AS T1 JOIN Ref_budget_codes AS T2 ON T1.budget_type_code  =  T2.budget_type_code
SELECT T2.budget_type_code ,  T2.budget_type_description ,  T1.document_id FROM Documents_with_expenses AS T1 JOIN Ref_budget_codes AS T2 ON T1.budget_type_code  =  T2.budget_type_code
SELECT T1.document_id FROM Documents_with_expenses AS T1 JOIN Ref_Budget_Codes AS T2 ON T1.Budget_Type_code  =  T2.Budget_Type_code WHERE T2.budget_type_Description  =  "Government"
SELECT T1.document_id FROM Documents_with_expenses AS T1 JOIN Ref_Budget_Codes AS T2 ON T1.Budget_Type_code  =  T2.Budget_Type_code WHERE T2.budget_type_Description  =  "Government"
SELECT budget_type_code ,  count(*) FROM Documents_with_expenses GROUP BY budget_type_code
SELECT budget_type_code ,  count(*) FROM Documents_with_expenses GROUP BY budget_type_code
SELECT budget_type_code FROM Documents_with_expenses GROUP BY budget_type_code ORDER BY count(*) DESC LIMIT 1
SELECT budget_type_code FROM Documents_with_expenses GROUP BY budget_type_code ORDER BY count(*) DESC LIMIT 1
SELECT count(*) FROM scientists
SELECT count(*) FROM scientists
SELECT name FROM projects ORDER BY hours DESC LIMIT 1
SELECT name FROM projects ORDER BY hours DESC LIMIT 1
SELECT name FROM projects WHERE hours BETWEEN 100 AND 300
SELECT name FROM projects WHERE hours BETWEEN 100 AND 300
SELECT name FROM scientists ORDER BY name
SELECT name FROM scientists ORDER BY name
SELECT count(*) ,  T1.name FROM projects AS T1 JOIN assignedto AS T2 ON T1.code  =  T2.project GROUP BY T1.name
SELECT count(*) ,  T1.name FROM projects AS T1 JOIN assignedto AS T2 ON T1.code  =  T2.project GROUP BY T1.name
SELECT count(*) ,  T1.name FROM projects AS T1 JOIN assignedto AS T2 ON T1.code  =  T2.project WHERE T1.hours  >  300 GROUP BY T1.name
SELECT count(*) ,  T1.name FROM projects AS T1 JOIN assignedto AS T2 ON T1.code  =  T2.project WHERE T1.hours  >  300 GROUP BY T1.name
SELECT count(*) ,  T1.name FROM scientists AS T1 JOIN assignedto AS T2 ON T1.ssn  =  T2.scientist GROUP BY T1.name
SELECT count(*) ,  T1.name FROM scientists AS T1 JOIN assignedto AS T2 ON T1.ssn  =  T2.scientist GROUP BY T1.name
SELECT T2.name FROM assignedto AS T1 JOIN scientists AS T2 ON T1.scientist  =  T2.ssn
SELECT T2.name FROM assignedto AS T1 JOIN scientists AS T2 ON T1.scientist  =  T2.ssn
SELECT Name FROM Projects WHERE Code NOT IN (SELECT Project FROM AssignedTo)
SELECT Name FROM Projects WHERE Code NOT IN (SELECT Project FROM AssignedTo)
SELECT Name FROM scientists WHERE ssn NOT IN (SELECT scientist FROM AssignedTo)
SELECT Name FROM scientists WHERE ssn NOT IN (SELECT scientist FROM AssignedTo)
SELECT count(*) FROM scientists WHERE ssn NOT IN (SELECT scientist FROM AssignedTo)
SELECT count(*) FROM scientists WHERE ssn NOT IN (SELECT scientist FROM AssignedTo)
SELECT T1.Name ,  T3.Name ,  T3.Hours FROM Scientists AS T1 JOIN AssignedTo AS T2 ON T1.SSN = T2.Scientist JOIN Projects AS T3 ON T2.Project = T3.Code ORDER BY T3.Name ,  T1.Name
SELECT T1.Name ,  T3.Name ,  T3.Hours FROM Scientists AS T1 JOIN AssignedTo AS T2 ON T1.SSN = T2.Scientist JOIN Projects AS T3 ON T2.Project = T3.Code ORDER BY T3.Name ,  T1.Name
SELECT Name FROM WINE ORDER BY Score LIMIT 1
SELECT Name FROM WINE ORDER BY Score LIMIT 1
SELECT Winery FROM WINE ORDER BY SCORE LIMIT 1
SELECT Winery FROM WINE ORDER BY SCORE LIMIT 1
SELECT Name FROM WINE WHERE YEAR  =  "2008"
SELECT Name FROM WINE WHERE YEAR  =  "2008"
SELECT Grape ,  Appelation FROM WINE
SELECT Grape ,  Appelation FROM WINE
SELECT Name ,  Score FROM WINE
SELECT Name ,  Score FROM WINE
SELECT Area ,  County FROM APPELLATIONS
SELECT Area ,  County FROM APPELLATIONS
SELECT Price FROM WINE WHERE YEAR  <  2010
SELECT Price FROM WINE WHERE YEAR  <  2010
SELECT Name FROM WINE WHERE score  >  90
SELECT Name FROM WINE WHERE score  >  90
SELECT DISTINCT T2.Name FROM GRAPES AS T1 JOIN WINE AS T2 ON T1.Grape  =  T2.Grape WHERE T1.Color  =  "Red"
SELECT DISTINCT T2.Name FROM GRAPES AS T1 JOIN WINE AS T2 ON T1.Grape  =  T2.Grape WHERE T1.Color  =  "Red"
SELECT DISTINCT T2.Name FROM APPELLATIONs AS T1 JOIN WINE AS T2 ON T1.Appelation  =  T2.Appelation WHERE T1.Area  =  "North Coast"
SELECT DISTINCT T2.Name FROM APPELLATIONs AS T1 JOIN WINE AS T2 ON T1.Appelation  =  T2.Appelation WHERE T1.Area  =  "North Coast"
SELECT count(*) FROM APPELLATIONS WHERE County  =  "Napa"
SELECT count(*) FROM APPELLATIONS WHERE County  =  "Napa"
SELECT T2.Name ,   T2.Score FROM GRAPES AS T1 JOIN WINE AS T2 ON T1.Grape  =  T2.Grape WHERE T1.Color  =  "White"
SELECT T2.Name ,   T2.Score FROM GRAPES AS T1 JOIN WINE AS T2 ON T1.Grape  =  T2.Grape WHERE T1.Color  =  "White"
SELECT DISTINCT T1.Grape FROM GRAPES AS T1 JOIN WINE AS T2 ON T1.Grape  =  T2.Grape WHERE T1.Color  =  "White" AND T2.score  >  90
SELECT DISTINCT T1.Grape FROM GRAPES AS T1 JOIN WINE AS T2 ON T1.Grape  =  T2.Grape WHERE T1.Color  =  "White" AND T2.score  >  90
SELECT T2.Name FROM Grapes AS T1 JOIN WINE AS T2 ON T1.Grape  =  T2.Grape WHERE T1.Color  =  "Red" AND T2.price  >  50
SELECT T2.Name FROM Grapes AS T1 JOIN WINE AS T2 ON T1.Grape  =  T2.Grape WHERE T1.Color  =  "Red" AND T2.price  >  50
SELECT T2.Name FROM APPELLATIONS AS T1 JOIN WINE AS T2 ON T1.Appelation  =  T2.Appelation WHERE T1.County  =  "Monterey" AND T2.price  <  50
SELECT T2.Name FROM APPELLATIONS AS T1 JOIN WINE AS T2 ON T1.Appelation  =  T2.Appelation WHERE T1.County  =  "Monterey" AND T2.price  <  50
SELECT count(*) ,  Grape FROM WINE GROUP BY Grape
SELECT count(*) ,  Grape FROM WINE GROUP BY Grape
SELECT avg(Price) ,  YEAR FROM WINE GROUP BY YEAR
SELECT avg(Price) ,  YEAR FROM WINE GROUP BY YEAR
SELECT DISTINCT Name FROM WINE ORDER BY Name
SELECT DISTINCT Name FROM WINE ORDER BY Name
SELECT DISTINCT Name FROM WINE WHERE YEAR  <  2000 OR YEAR  >  2010
SELECT DISTINCT Name FROM WINE WHERE YEAR  <  2000 OR YEAR  >  2010
SELECT DISTINCT Winery FROM WINE WHERE Price BETWEEN 50 AND 100
SELECT DISTINCT Winery FROM WINE WHERE Price BETWEEN 50 AND 100
SELECT Winery FROM WINE GROUP BY Winery HAVING count(*)  >=  4
SELECT Winery FROM WINE GROUP BY Winery HAVING count(*)  >=  4
SELECT T1.County FROM APPELLATIONS AS T1 JOIN WINE AS T2 ON T1.Appelation  =  T2.Appelation GROUP BY T2.Appelation HAVING count(*)  <=  3
SELECT T1.County FROM APPELLATIONS AS T1 JOIN WINE AS T2 ON T1.Appelation  =  T2.Appelation GROUP BY T2.Appelation HAVING count(*)  <=  3
SELECT T2.Winery FROM GRAPES AS T1 JOIN WINE AS T2 ON T1.GRAPE  =  T2.GRAPE WHERE T1.Color  =  "White" GROUP BY T2.Winery ORDER BY count(*) DESC LIMIT 3
SELECT T2.Winery FROM GRAPES AS T1 JOIN WINE AS T2 ON T1.GRAPE  =  T2.GRAPE WHERE T1.Color  =  "White" GROUP BY T2.Winery ORDER BY count(*) DESC LIMIT 3
SELECT Grape ,  Winery ,  YEAR FROM WINE WHERE Price  >   100 ORDER BY YEAR
SELECT Grape ,  Winery ,  YEAR FROM WINE WHERE Price  >   100 ORDER BY YEAR
SELECT Grape ,  Appelation ,  Name FROM WINE WHERE Score  >  93 ORDER BY Name
SELECT Grape ,  Appelation ,  Name FROM WINE WHERE Score  >  93 ORDER BY Name
SELECT T1.County FROM APPELLATIONS AS T1 JOIN WINE AS T2 ON T1.Appelation  =  T2.Appelation WHERE T2.Score  >  90 GROUP BY T1.County ORDER BY count(*) DESC LIMIT 1
SELECT T1.County FROM APPELLATIONS AS T1 JOIN WINE AS T2 ON T1.Appelation  =  T2.Appelation WHERE T2.Score  >  90 GROUP BY T1.County ORDER BY count(*) DESC LIMIT 1
SELECT count(*) FROM station
SELECT name ,  LOCATION ,  number_of_platforms FROM station
SELECT DISTINCT LOCATION FROM station
SELECT name ,  total_passengers FROM station WHERE LOCATION != 'London'
SELECT name ,  main_services FROM station ORDER BY total_passengers DESC LIMIT 3
SELECT DISTINCT LOCATION FROM station WHERE number_of_platforms  >=  15 AND total_passengers  >  25
SELECT LOCATION FROM station GROUP BY LOCATION ORDER BY count(*) DESC LIMIT 1
SELECT name ,  TIME ,  service FROM train
SELECT count(*) FROM train
SELECT name ,  service FROM train ORDER BY TIME
SELECT T2.name ,  T3.name FROM train_station AS T1 JOIN station AS T2 ON T1.station_id  =  T2.station_id JOIN train AS T3 ON T3.train_id  =  T1.train_id
SELECT T3.name ,  T3.time FROM train_station AS T1 JOIN station AS T2 ON T1.station_id  =  T2.station_id JOIN train AS T3 ON T3.train_id  =  T1.train_id WHERE T2.location  =  'London' ORDER BY T3.time DESC
SELECT T2.name FROM train_station AS T1 JOIN station AS T2 ON T1.station_id  =  T2.station_id GROUP BY T1.station_id ORDER BY count(*) DESC LIMIT 1
SELECT T2.name FROM train_station AS T1 JOIN station AS T2 ON T1.station_id  =  T2.station_id GROUP BY T1.station_id HAVING count(*)  >=  2
SELECT LOCATION FROM station GROUP BY LOCATION HAVING count(*)  =  1
SELECT name FROM station WHERE station_id NOT IN (SELECT station_id FROM train_station)
SELECT name ,  LOCATION FROM station ORDER BY Annual_entry_exit ,  Annual_interchanges
SELECT vehicle_id FROM Vehicles;
SELECT vehicle_id FROM Vehicles;
SELECT count(*) FROM Vehicles;
SELECT count(*) FROM Vehicles;
SELECT vehicle_details FROM Vehicles WHERE vehicle_id = 1;
SELECT vehicle_details FROM Vehicles WHERE vehicle_id = 1;
SELECT first_name ,  middle_name ,  last_name FROM Staff;
SELECT first_name ,  middle_name ,  last_name FROM Staff;
SELECT date_of_birth FROM Staff WHERE first_name = "Janessa" AND last_name = "Sawayn";
SELECT date_of_birth FROM Staff WHERE first_name = "Janessa" AND last_name = "Sawayn";
SELECT date_joined_staff FROM Staff WHERE first_name = "Janessa" AND last_name = "Sawayn";
SELECT date_joined_staff FROM Staff WHERE first_name = "Janessa" AND last_name = "Sawayn";
SELECT date_left_staff FROM Staff WHERE first_name = "Janessa" AND last_name = "Sawayn";
SELECT date_left_staff FROM Staff WHERE first_name = "Janessa" AND last_name = "Sawayn";
SELECT count(*) FROM Staff WHERE first_name = "Ludie";
SELECT count(*) FROM Staff WHERE first_name = "Ludie";
SELECT nickname FROM Staff WHERE first_name = "Janessa" AND last_name = "Sawayn";
SELECT nickname FROM Staff WHERE first_name = "Janessa" AND last_name = "Sawayn";
SELECT count(*) FROM Staff;
SELECT count(*) FROM Staff;
SELECT T1.city FROM Addresses AS T1 JOIN Staff AS T2 ON T1.address_id = T2.staff_address_id WHERE T2.first_name = "Janessa" AND T2.last_name = "Sawayn";
SELECT T1.city FROM Addresses AS T1 JOIN Staff AS T2 ON T1.address_id = T2.staff_address_id WHERE T2.first_name = "Janessa" AND T2.last_name = "Sawayn";
SELECT T1.country ,  T1.state_province_county FROM Addresses AS T1 JOIN Staff AS T2 ON T1.address_id = T2.staff_address_id WHERE T2.first_name = "Janessa" AND T2.last_name = "Sawayn";
SELECT T1.country ,  T1.state_province_county FROM Addresses AS T1 JOIN Staff AS T2 ON T1.address_id = T2.staff_address_id WHERE T2.first_name = "Janessa" AND T2.last_name = "Sawayn";
SELECT T1.zip_postcode FROM Addresses AS T1 JOIN Staff AS T2 ON T1.address_id = T2.staff_address_id WHERE T2.first_name = "Janessa" AND T2.last_name = "Sawayn";
SELECT T1.zip_postcode FROM Addresses AS T1 JOIN Staff AS T2 ON T1.address_id = T2.staff_address_id WHERE T2.first_name = "Janessa" AND T2.last_name = "Sawayn";
SELECT count(*) FROM Addresses WHERE state_province_county = "Georgia";
SELECT count(*) FROM Addresses WHERE state_province_county = "Georgia";
SELECT T2.first_name ,  T2.last_name FROM Addresses AS T1 JOIN Staff AS T2 ON T1.address_id = T2.staff_address_id WHERE T1.city = "Damianfort";
SELECT T2.first_name ,  T2.last_name FROM Addresses AS T1 JOIN Staff AS T2 ON T1.address_id = T2.staff_address_id WHERE T1.city = "Damianfort";
SELECT T1.city ,  count(*) FROM Addresses AS T1 JOIN Staff AS T2 ON T1.address_id = T2.staff_address_id GROUP BY T1.city ORDER BY count(*) DESC LIMIT 1;
SELECT T1.city ,  count(*) FROM Addresses AS T1 JOIN Staff AS T2 ON T1.address_id = T2.staff_address_id GROUP BY T1.city ORDER BY count(*) DESC LIMIT 1;
SELECT first_name ,  last_name FROM Customers;
SELECT first_name ,  last_name FROM Customers;
SELECT email_address ,  date_of_birth FROM Customers WHERE first_name = "Carole"
SELECT email_address ,  date_of_birth FROM Customers WHERE first_name = "Carole"
SELECT phone_number ,  email_address FROM Customers WHERE amount_outstanding  >  2000;
SELECT phone_number ,  email_address FROM Customers WHERE amount_outstanding  >  2000;
SELECT customer_status_code ,  cell_mobile_phone_number ,  email_address FROM Customers WHERE first_name = "Marina" OR last_name  =  "Kohler"
SELECT customer_status_code ,  cell_mobile_phone_number ,  email_address FROM Customers WHERE first_name = "Marina" OR last_name  =  "Kohler"
SELECT date_of_birth FROM Customers WHERE customer_status_code  =  'Good Customer'
SELECT date_of_birth FROM Customers WHERE customer_status_code  =  'Good Customer'
SELECT date_became_customer FROM Customers WHERE first_name = "Carole" AND last_name = "Bernhard";
SELECT date_became_customer FROM Customers WHERE first_name = "Carole" AND last_name = "Bernhard";
SELECT count(*) FROM Customers;
SELECT count(*) FROM Customers;
SELECT customer_status_code , count(*) FROM Customers GROUP BY customer_status_code;
SELECT customer_status_code , count(*) FROM Customers GROUP BY customer_status_code;
SELECT customer_status_code FROM Customers GROUP BY customer_status_code ORDER BY count(*) ASC LIMIT 1;
SELECT customer_status_code FROM Customers GROUP BY customer_status_code ORDER BY count(*) ASC LIMIT 1;
SELECT count(*) FROM Lessons AS T1 JOIN Customers AS T2 ON T1.customer_id  = T2.customer_id WHERE T2.first_name = "Rylan" AND T2.last_name = "Goodwin" AND T1.lesson_status_code = "Completed";
SELECT count(*) FROM Lessons AS T1 JOIN Customers AS T2 ON T1.customer_id  = T2.customer_id WHERE T2.first_name = "Rylan" AND T2.last_name = "Goodwin" AND T1.lesson_status_code = "Completed";
SELECT first_name ,  last_name FROM Customers WHERE amount_outstanding BETWEEN 1000 AND 3000;
SELECT first_name ,  last_name FROM Customers WHERE amount_outstanding BETWEEN 1000 AND 3000;
SELECT T1.first_name ,  T1.last_name FROM Customers AS T1 JOIN Addresses AS T2 ON T1.customer_address_id = T2.address_id WHERE T2.city = "Lockmanfurt";
SELECT T1.first_name ,  T1.last_name FROM Customers AS T1 JOIN Addresses AS T2 ON T1.customer_address_id = T2.address_id WHERE T2.city = "Lockmanfurt";
SELECT T2.country FROM Customers AS T1 JOIN Addresses AS T2 ON T1.customer_address_id = T2.address_id WHERE T1.first_name = "Carole" AND T1.last_name = "Bernhard"
SELECT T2.country FROM Customers AS T1 JOIN Addresses AS T2 ON T1.customer_address_id = T2.address_id WHERE T1.first_name = "Carole" AND T1.last_name = "Bernhard"
SELECT T2.zip_postcode FROM Customers AS T1 JOIN Addresses AS T2 ON T1.customer_address_id = T2.address_id WHERE T1.first_name = "Carole" AND T1.last_name = "Bernhard"
SELECT T2.zip_postcode FROM Customers AS T1 JOIN Addresses AS T2 ON T1.customer_address_id = T2.address_id WHERE T1.first_name = "Carole" AND T1.last_name = "Bernhard"
SELECT T2.city FROM Customers AS T1 JOIN Addresses AS T2 ON T1.customer_address_id = T2.address_id GROUP BY T2.city ORDER BY count(*) DESC LIMIT 1;
SELECT T2.city FROM Customers AS T1 JOIN Addresses AS T2 ON T1.customer_address_id = T2.address_id GROUP BY T2.city ORDER BY count(*) DESC LIMIT 1;
SELECT count(*) FROM Customers WHERE customer_id NOT IN ( SELECT customer_id FROM Customer_Payments );
SELECT count(*) FROM Customers WHERE customer_id NOT IN ( SELECT customer_id FROM Customer_Payments );
SELECT T2.first_name ,  T2.last_name FROM Customer_Payments AS T1 JOIN Customers AS T2 ON T1.customer_id = T2.customer_id GROUP BY T1.customer_id HAVING count(*)  >  2;
SELECT T2.first_name ,  T2.last_name FROM Customer_Payments AS T1 JOIN Customers AS T2 ON T1.customer_id = T2.customer_id GROUP BY T1.customer_id HAVING count(*)  >  2;
SELECT payment_method_code ,  count(*) FROM Customer_Payments GROUP BY payment_method_code;
SELECT payment_method_code ,  count(*) FROM Customer_Payments GROUP BY payment_method_code;
SELECT count(*) FROM Lessons WHERE lesson_status_code = "Cancelled";
SELECT count(*) FROM Lessons WHERE lesson_status_code = "Cancelled";
SELECT T1.lesson_id FROM Lessons AS T1 JOIN Staff AS T2 ON T1.staff_id = T2.staff_id WHERE T2.first_name = "Janessa" AND T2.last_name = "Sawayn" AND nickname LIKE "%s%";
SELECT T1.lesson_id FROM Lessons AS T1 JOIN Staff AS T2 ON T1.staff_id = T2.staff_id WHERE T2.first_name = "Janessa" AND T2.last_name = "Sawayn" AND nickname LIKE "%s%";
SELECT avg(price) FROM Lessons AS T1 JOIN Staff AS T2 ON T1.staff_id = T2.staff_id WHERE T2.first_name = "Janessa" AND T2.last_name = "Sawayn";
SELECT avg(price) FROM Lessons AS T1 JOIN Staff AS T2 ON T1.staff_id = T2.staff_id WHERE T2.first_name = "Janessa" AND T2.last_name = "Sawayn";
SELECT count(*) FROM Lessons AS T1 JOIN Customers AS T2 ON T1.customer_id  = T2.customer_id WHERE T2.first_name = "Ray"
SELECT count(*) FROM Lessons AS T1 JOIN Customers AS T2 ON T1.customer_id  = T2.customer_id WHERE T2.first_name = "Ray"
SELECT T1.vehicle_id ,  T1.vehicle_details FROM Vehicles AS T1 JOIN Lessons AS T2 ON T1.vehicle_id  =  T2.vehicle_id GROUP BY T1.vehicle_id ORDER BY count(*) DESC LIMIT 1
SELECT count(*) FROM Faculty
SELECT count(*) FROM Faculty
SELECT DISTINCT rank FROM Faculty
SELECT DISTINCT rank FROM Faculty
SELECT DISTINCT building FROM Faculty
SELECT DISTINCT building FROM Faculty
SELECT rank ,  Fname ,  Lname FROM Faculty
SELECT rank ,  Fname ,  Lname FROM Faculty
SELECT Fname ,  Lname ,  phone FROM Faculty WHERE Sex  =  'F'
SELECT Fname ,  Lname ,  phone FROM Faculty WHERE Sex  =  'F'
SELECT FacID FROM Faculty WHERE Sex  =  'M'
SELECT FacID FROM Faculty WHERE Sex  =  'M'
SELECT count(*) FROM Faculty WHERE Sex  =  'F' AND Rank  =  "Professor"
SELECT count(*) FROM Faculty WHERE Sex  =  'F' AND Rank  =  "Professor"
SELECT phone ,  room ,  building FROM Faculty WHERE Fname  =  "Jerry" AND Lname  =  "Prince"
SELECT phone ,  room ,  building FROM Faculty WHERE Fname  =  "Jerry" AND Lname  =  "Prince"
SELECT count(*) FROM Faculty WHERE Rank  =  "Professor" AND building  =  "NEB"
SELECT count(*) FROM Faculty WHERE Rank  =  "Professor" AND building  =  "NEB"
SELECT fname ,  lname FROM Faculty WHERE Rank  =  "Instructor"
SELECT fname ,  lname FROM Faculty WHERE Rank  =  "Instructor"
SELECT building ,  count(*) FROM Faculty GROUP BY building
SELECT building ,  count(*) FROM Faculty GROUP BY building
SELECT building FROM Faculty WHERE rank  =  "Professor" GROUP BY building HAVING count(*)  >=  10
SELECT building FROM Faculty WHERE rank  =  "Professor" GROUP BY building HAVING count(*)  >=  10
SELECT rank ,  count(*) FROM Faculty GROUP BY rank
SELECT rank ,  count(*) FROM Faculty GROUP BY rank
SELECT sex ,  count(*) FROM Faculty WHERE rank  =  "AsstProf" GROUP BY sex
SELECT sex ,  count(*) FROM Faculty WHERE rank  =  "AsstProf" GROUP BY sex
SELECT T1.fname ,  T1.lname FROM Faculty AS T1 JOIN Student AS T2 ON T1.FacID  =  T2.advisor WHERE T2.fname  =  "Linda" AND T2.lname  =  "Smith"
SELECT T1.fname ,  T1.lname FROM Faculty AS T1 JOIN Student AS T2 ON T1.FacID  =  T2.advisor WHERE T2.fname  =  "Linda" AND T2.lname  =  "Smith"
SELECT T2.StuID FROM Faculty AS T1 JOIN Student AS T2 ON T1.FacID  =  T2.advisor WHERE T1.rank  =  "Professor"
SELECT T2.StuID FROM Faculty AS T1 JOIN Student AS T2 ON T1.FacID  =  T2.advisor WHERE T1.rank  =  "Professor"
SELECT T2.fname ,  T2.lname FROM Faculty AS T1 JOIN Student AS T2 ON T1.FacID  =  T2.advisor WHERE T1.fname  =  "Michael" AND T1.lname  =  "Goodrich"
SELECT T2.fname ,  T2.lname FROM Faculty AS T1 JOIN Student AS T2 ON T1.FacID  =  T2.advisor WHERE T1.fname  =  "Michael" AND T1.lname  =  "Goodrich"
SELECT T1.FacID ,  count(*) FROM Faculty AS T1 JOIN Student AS T2 ON T1.FacID  =  T2.advisor GROUP BY T1.FacID
SELECT T1.FacID ,  count(*) FROM Faculty AS T1 JOIN Student AS T2 ON T1.FacID  =  T2.advisor GROUP BY T1.FacID
SELECT T1.rank ,  count(*) FROM Faculty AS T1 JOIN Student AS T2 ON T1.FacID  =  T2.advisor GROUP BY T1.rank
SELECT T1.rank ,  count(*) FROM Faculty AS T1 JOIN Student AS T2 ON T1.FacID  =  T2.advisor GROUP BY T1.rank
SELECT T1.fname ,  T1.lname FROM Faculty AS T1 JOIN Student AS T2 ON T1.FacID  =  T2.advisor GROUP BY T1.FacID ORDER BY count(*) DESC LIMIT 1
SELECT T1.fname ,  T1.lname FROM Faculty AS T1 JOIN Student AS T2 ON T1.FacID  =  T2.advisor GROUP BY T1.FacID ORDER BY count(*) DESC LIMIT 1
SELECT T1.FacID FROM Faculty AS T1 JOIN Student AS T2 ON T1.FacID  =  T2.advisor GROUP BY T1.FacID HAVING count(*)  >=  2
SELECT T1.FacID FROM Faculty AS T1 JOIN Student AS T2 ON T1.FacID  =  T2.advisor GROUP BY T1.FacID HAVING count(*)  >=  2
SELECT activity_name FROM Activity
SELECT activity_name FROM Activity
SELECT count(*) FROM Activity
SELECT count(*) FROM Activity
SELECT T3.activity_name FROM Faculty AS T1 JOIN Faculty_participates_in AS T2 ON T1.facID  =  T2.facID JOIN Activity AS T3 ON T3.actid  =  T2.actid WHERE T1.fname  =  "Mark" AND T1.lname  =  "Giuliano"
SELECT T3.activity_name FROM Faculty AS T1 JOIN Faculty_participates_in AS T2 ON T1.facID  =  T2.facID JOIN Activity AS T3 ON T3.actid  =  T2.actid WHERE T1.fname  =  "Mark" AND T1.lname  =  "Giuliano"
SELECT  T1.fname ,  T1.lname ,  count(*) ,  T1.FacID FROM Faculty AS T1 JOIN Faculty_participates_in AS T2 ON T1.facID  =  T2.facID GROUP BY T1.FacID
SELECT  T1.fname ,  T1.lname ,  count(*) ,  T1.FacID FROM Faculty AS T1 JOIN Faculty_participates_in AS T2 ON T1.facID  =  T2.facID GROUP BY T1.FacID
SELECT T1.activity_name ,  count(*) FROM Activity AS T1 JOIN Faculty_participates_in AS T2 ON T1.actID  =  T2.actID GROUP BY T1.actID
SELECT T1.activity_name ,  count(*) FROM Activity AS T1 JOIN Faculty_participates_in AS T2 ON T1.actID  =  T2.actID GROUP BY T1.actID
SELECT  T1.fname ,  T1.lname FROM Faculty AS T1 JOIN Faculty_participates_in AS T2 ON T1.facID  =  T2.facID GROUP BY T1.FacID ORDER BY count(*) DESC LIMIT 1
SELECT  T1.fname ,  T1.lname FROM Faculty AS T1 JOIN Faculty_participates_in AS T2 ON T1.facID  =  T2.facID GROUP BY T1.FacID ORDER BY count(*) DESC LIMIT 1
SELECT T1.activity_name FROM Activity AS T1 JOIN Faculty_participates_in AS T2 ON T1.actID  =  T2.actID GROUP BY T1.actID ORDER BY count(*) DESC LIMIT 1
SELECT T1.activity_name FROM Activity AS T1 JOIN Faculty_participates_in AS T2 ON T1.actID  =  T2.actID GROUP BY T1.actID ORDER BY count(*) DESC LIMIT 1
SELECT T1.fname ,  T1.lname FROM Student AS T1 JOIN Participates_in AS T2 ON T1.StuID  =  T2.StuID GROUP BY T1.StuID ORDER BY count(*) DESC LIMIT 1
SELECT T1.fname ,  T1.lname FROM Student AS T1 JOIN Participates_in AS T2 ON T1.StuID  =  T2.StuID GROUP BY T1.StuID ORDER BY count(*) DESC LIMIT 1
SELECT T1.activity_name FROM Activity AS T1 JOIN Participates_in AS T2 ON T1.actID  =  T2.actID GROUP BY T1.actID ORDER BY count(*) DESC LIMIT 1
SELECT T1.activity_name FROM Activity AS T1 JOIN Participates_in AS T2 ON T1.actID  =  T2.actID GROUP BY T1.actID ORDER BY count(*) DESC LIMIT 1
SELECT name FROM airports WHERE city  =  'Goroka'
SELECT name FROM airports WHERE city  =  'Goroka'
SELECT name ,  city ,  country ,  elevation FROM airports WHERE city  =  'New York'
SELECT name ,  city ,  country ,  elevation FROM airports WHERE city  =  'New York'
SELECT name FROM airports WHERE country  =  'Cuba' OR country  =  'Argentina'
SELECT name FROM airports WHERE country  =  'Cuba' OR country  =  'Argentina'
SELECT country FROM airlines WHERE name LIKE 'Orbit%'
SELECT country FROM airlines WHERE name LIKE 'Orbit%'
SELECT name FROM airports WHERE elevation BETWEEN -50 AND 50
SELECT name FROM airports WHERE elevation BETWEEN -50 AND 50
SELECT country FROM airports ORDER BY elevation DESC LIMIT 1
SELECT country FROM airports ORDER BY elevation DESC LIMIT 1
SELECT name ,  city ,  country FROM airports ORDER BY elevation LIMIT 1
SELECT name ,  city ,  country FROM airports ORDER BY elevation LIMIT 1
SELECT name ,  city ,  country FROM airports ORDER BY elevation DESC LIMIT 1
SELECT name ,  city ,  country FROM airports ORDER BY elevation DESC LIMIT 1
SELECT T1.name ,  T1.city ,  T2.dst_apid FROM airports AS T1 JOIN routes AS T2 ON T1.apid  =  T2.dst_apid GROUP BY T2.dst_apid ORDER BY count(*) DESC LIMIT 1
SELECT T1.name ,  T1.city ,  T2.dst_apid FROM airports AS T1 JOIN routes AS T2 ON T1.apid  =  T2.dst_apid GROUP BY T2.dst_apid ORDER BY count(*) DESC LIMIT 1
SELECT T1.name ,  T2.alid FROM airlines AS T1 JOIN routes AS T2 ON T1.alid  =  T2.alid GROUP BY T2.alid ORDER BY count(*) DESC LIMIT 10
SELECT T1.name ,  T2.alid FROM airlines AS T1 JOIN routes AS T2 ON T1.alid  =  T2.alid GROUP BY T2.alid ORDER BY count(*) DESC LIMIT 10
SELECT T1.name ,  T1.city ,  T2.src_apid FROM airports AS T1 JOIN routes AS T2 ON T1.apid  =  T2.src_apid GROUP BY T2.src_apid ORDER BY count(*) DESC LIMIT 1
SELECT T1.name ,  T1.city ,  T2.src_apid FROM airports AS T1 JOIN routes AS T2 ON T1.apid  =  T2.src_apid GROUP BY T2.src_apid ORDER BY count(*) DESC LIMIT 1
SELECT country FROM airlines GROUP BY country ORDER BY count(*) DESC LIMIT 1
SELECT country FROM airlines GROUP BY country ORDER BY count(*) DESC LIMIT 1
SELECT country FROM airlines WHERE active  =  'Y' GROUP BY country ORDER BY count(*) DESC LIMIT 1
SELECT country FROM airlines WHERE active  =  'Y' GROUP BY country ORDER BY count(*) DESC LIMIT 1
SELECT count(*) ,  country FROM airports GROUP BY country ORDER BY count(*) DESC
SELECT count(*) ,  country FROM airports GROUP BY country ORDER BY count(*) DESC
SELECT count(*) ,  city FROM airports WHERE country  =  'United States' GROUP BY city ORDER BY count(*) DESC
SELECT count(*) ,  city FROM airports WHERE country  =  'United States' GROUP BY city ORDER BY count(*) DESC
SELECT city FROM airports WHERE country  =  'United States' GROUP BY city HAVING count(*)  >  3
SELECT city FROM airports WHERE country  =  'United States' GROUP BY city HAVING count(*)  >  3
SELECT city ,  count(*) FROM airports GROUP BY city HAVING count(*)  >  1
SELECT city ,  count(*) FROM airports GROUP BY city HAVING count(*)  >  1
SELECT city FROM airports GROUP BY city HAVING count(*)  >  2 ORDER BY count(*)
SELECT city FROM airports GROUP BY city HAVING count(*)  >  2 ORDER BY count(*)
SELECT count(*) ,  T1.name FROM airports AS T1 JOIN routes AS T2 ON T1.apid  =  T2.src_apid GROUP BY T1.name
SELECT count(*) ,  T1.name FROM airports AS T1 JOIN routes AS T2 ON T1.apid  =  T2.src_apid GROUP BY T1.name
SELECT count(*) ,  T1.name FROM airports AS T1 JOIN routes AS T2 ON T1.apid  =  T2.src_apid GROUP BY T1.name ORDER BY count(*) DESC
SELECT count(*) ,  T1.name FROM airports AS T1 JOIN routes AS T2 ON T1.apid  =  T2.src_apid GROUP BY T1.name ORDER BY count(*) DESC
SELECT avg(elevation) ,  country FROM airports GROUP BY country
SELECT avg(elevation) ,  country FROM airports GROUP BY country
SELECT city FROM airports GROUP BY city HAVING count(*)  =  2
SELECT city FROM airports GROUP BY city HAVING count(*)  =  2
SELECT T1.name FROM airlines AS T1 JOIN routes AS T2 ON T1.alid  =  T2.alid GROUP BY T1.name ORDER BY count(*) DESC LIMIT 1
SELECT T1.name FROM airlines AS T1 JOIN routes AS T2 ON T1.alid  =  T2.alid GROUP BY T1.name ORDER BY count(*) DESC LIMIT 1
SELECT T1.name FROM airports AS T1 JOIN routes AS T2 ON T1.apid  =  T2.src_apid WHERE T1.country  =  'China' GROUP BY T1.name ORDER BY count(*) DESC LIMIT 1
SELECT T1.name FROM airports AS T1 JOIN routes AS T2 ON T1.apid  =  T2.src_apid WHERE T1.country  =  'China' GROUP BY T1.name ORDER BY count(*) DESC LIMIT 1
SELECT T1.name FROM airports AS T1 JOIN routes AS T2 ON T1.apid  =  T2.dst_apid WHERE T1.country  =  'China' GROUP BY T1.name ORDER BY count(*) DESC LIMIT 1
SELECT T1.name FROM airports AS T1 JOIN routes AS T2 ON T1.apid  =  T2.dst_apid WHERE T1.country  =  'China' GROUP BY T1.name ORDER BY count(*) DESC LIMIT 1
SELECT order_id FROM orders ORDER BY date_order_placed DESC LIMIT 1
SELECT order_id FROM orders ORDER BY date_order_placed DESC LIMIT 1
SELECT order_id ,  customer_id FROM orders ORDER BY date_order_placed LIMIT 1
SELECT order_id ,  customer_id FROM orders ORDER BY date_order_placed LIMIT 1
SELECT order_id FROM shipments WHERE shipment_tracking_number = "3452"
SELECT order_id FROM shipments WHERE shipment_tracking_number = "3452"
SELECT order_item_id FROM order_items WHERE product_id = 11
SELECT order_item_id FROM order_items WHERE product_id = 11
SELECT DISTINCT T1.customer_name FROM customers AS T1 JOIN orders AS T2 ON T1.customer_id = T2.customer_id WHERE T2.order_status = "Packing"
SELECT DISTINCT T1.customer_name FROM customers AS T1 JOIN orders AS T2 ON T1.customer_id = T2.customer_id WHERE T2.order_status = "Packing"
SELECT DISTINCT T1.customer_details FROM customers AS T1 JOIN orders AS T2 ON T1.customer_id = T2.customer_id WHERE T2.order_status = "On Road"
SELECT DISTINCT T1.customer_details FROM customers AS T1 JOIN orders AS T2 ON T1.customer_id = T2.customer_id WHERE T2.order_status = "On Road"
SELECT T2.order_id ,  T2.order_status FROM customers AS T1 JOIN orders AS T2 ON T1.customer_id = T2.customer_id WHERE T1.customer_name = "Jeramie"
SELECT T2.order_id ,  T2.order_status FROM customers AS T1 JOIN orders AS T2 ON T1.customer_id = T2.customer_id WHERE T1.customer_name = "Jeramie"
SELECT T2.date_order_placed FROM customers AS T1 JOIN orders AS T2 ON T1.customer_id = T2.customer_id WHERE T1.customer_name = "Jeramie"
SELECT T2.date_order_placed FROM customers AS T1 JOIN orders AS T2 ON T1.customer_id = T2.customer_id WHERE T1.customer_name = "Jeramie"
SELECT T1.customer_name FROM customers AS T1 JOIN orders AS T2 ON T1.customer_id = T2.customer_id WHERE T2.date_order_placed >= "2009-01-01" AND T2.date_order_placed <= "2010-01-01"
SELECT T1.customer_name FROM customers AS T1 JOIN orders AS T2 ON T1.customer_id = T2.customer_id WHERE T2.date_order_placed >= "2009-01-01" AND T2.date_order_placed <= "2010-01-01"
SELECT DISTINCT T2.product_id FROM orders AS T1 JOIN order_items AS T2 ON T1.order_id = T2.order_id WHERE T1.date_order_placed >= "1975-01-01" AND T1.date_order_placed <= "1976-01-01"
SELECT DISTINCT T2.product_id FROM orders AS T1 JOIN order_items AS T2 ON T1.order_id = T2.order_id WHERE T1.date_order_placed >= "1975-01-01" AND T1.date_order_placed <= "1976-01-01"
SELECT T1.date_order_placed FROM orders AS T1 JOIN shipments AS T2 ON T1.order_id = T2.order_id WHERE T2.shipment_tracking_number = 3452
SELECT T1.date_order_placed FROM orders AS T1 JOIN shipments AS T2 ON T1.order_id = T2.order_id WHERE T2.shipment_tracking_number = 3452
SELECT T1.date_order_placed FROM orders AS T1 JOIN shipments AS T2 ON T1.order_id = T2.order_id WHERE T2.invoice_number = 10
SELECT T1.date_order_placed FROM orders AS T1 JOIN shipments AS T2 ON T1.order_id = T2.order_id WHERE T2.invoice_number = 10
SELECT order_id FROM shipments WHERE shipment_date > "2000-01-01"
SELECT order_id FROM shipments WHERE shipment_date > "2000-01-01"
SELECT DISTINCT product_name FROM products ORDER BY product_name
SELECT DISTINCT product_name FROM products ORDER BY product_name
SELECT T1.order_id FROM orders AS T1 JOIN order_items AS T2 ON T1.order_id = T2.order_id GROUP BY T1.order_id ORDER BY count(*) DESC LIMIT 1
SELECT T1.order_id FROM orders AS T1 JOIN order_items AS T2 ON T1.order_id = T2.order_id GROUP BY T1.order_id ORDER BY count(*) DESC LIMIT 1
SELECT invoice_number FROM invoices WHERE invoice_date < "1989-09-03" OR invoice_date > "2007-12-25"
SELECT invoice_number FROM invoices WHERE invoice_date < "1989-09-03" OR invoice_date > "2007-12-25"
SELECT DISTINCT invoice_details FROM invoices WHERE invoice_date < "1989-09-03" OR invoice_date > "2007-12-25"
SELECT DISTINCT invoice_details FROM invoices WHERE invoice_date < "1989-09-03" OR invoice_date > "2007-12-25"
SELECT T2.customer_name ,  count(*) FROM orders AS T1 JOIN customers AS T2 ON T1.customer_id = T2.customer_id GROUP BY T2.customer_id HAVING count(*)  >=  2
SELECT T2.customer_name ,  count(*) FROM orders AS T1 JOIN customers AS T2 ON T1.customer_id = T2.customer_id GROUP BY T2.customer_id HAVING count(*)  >=  2
SELECT T2.customer_name FROM orders AS T1 JOIN customers AS T2 ON T1.customer_id = T2.customer_id GROUP BY T2.customer_id HAVING count(*)  <=  2
SELECT T2.customer_name FROM orders AS T1 JOIN customers AS T2 ON T1.customer_id = T2.customer_id GROUP BY T2.customer_id HAVING count(*)  <=  2
SELECT count(*) FROM architect WHERE gender  =  'female'
SELECT name ,  nationality ,  id FROM architect WHERE gender  =  'male' ORDER BY name
SELECT max(T1.length_meters) ,  T2.name FROM bridge AS T1 JOIN architect AS T2 ON T1.architect_id  =  T2.id
SELECT avg(length_feet) FROM bridge
SELECT name ,  built_year FROM mill WHERE TYPE  =  'Grondzeiler'
SELECT name FROM mill WHERE LOCATION != 'Donceel'
SELECT T1.id ,  T1.name FROM architect AS T1 JOIN bridge AS T2 ON T1.id  =  T2.architect_id GROUP BY T1.id HAVING count(*)  >=  3
SELECT T1.id ,  T1.name ,  T1.nationality FROM architect AS T1 JOIN mill AS T2 ON T1.id  =  T2.architect_id GROUP BY T1.id ORDER BY count(*) DESC LIMIT 1
SELECT T1.id ,  T1.name ,  T1.gender FROM architect AS T1 JOIN bridge AS T2 ON T1.id  =  T2.architect_id GROUP BY T1.id HAVING count(*)  =  2 UNION SELECT T1.id ,  T1.name ,  T1.gender FROM architect AS T1 JOIN mill AS T2 ON T1.id  =  T2.architect_id GROUP BY T1.id HAVING count(*)  =  1
SELECT LOCATION FROM bridge WHERE name  =  'Kolob Arch' OR name  =  'Rainbow Bridge'
SELECT name FROM mill WHERE name LIKE '%Moulin%'
SELECT TYPE ,  count(*) FROM mill GROUP BY TYPE ORDER BY count(*) DESC LIMIT 1
SELECT count(*) FROM book_club
SELECT count(*) FROM book_club
SELECT book_title ,  author_or_editor FROM book_club WHERE YEAR  >  1989
SELECT book_title ,  author_or_editor FROM book_club WHERE YEAR  >  1989
SELECT DISTINCT publisher FROM book_club
SELECT DISTINCT publisher FROM book_club
SELECT YEAR ,  book_title ,  publisher FROM book_club ORDER BY YEAR DESC
SELECT YEAR ,  book_title ,  publisher FROM book_club ORDER BY YEAR DESC
SELECT publisher ,  count(*) FROM book_club GROUP BY publisher
SELECT publisher ,  count(*) FROM book_club GROUP BY publisher
SELECT publisher FROM book_club GROUP BY publisher ORDER BY count(*) DESC LIMIT 1
SELECT publisher FROM book_club GROUP BY publisher ORDER BY count(*) DESC LIMIT 1
SELECT category ,  count(*) FROM book_club GROUP BY category
SELECT category ,  count(*) FROM book_club GROUP BY category
SELECT category FROM book_club WHERE YEAR  >  1989 GROUP BY category HAVING count(*)  >=  2
SELECT category FROM book_club WHERE YEAR  >  1989 GROUP BY category HAVING count(*)  >=  2
SELECT title ,  YEAR ,  director FROM movie ORDER BY budget_million
SELECT title ,  YEAR ,  director FROM movie ORDER BY budget_million
SELECT title ,  director FROM movie WHERE YEAR  <=  2000 ORDER BY gross_worldwide DESC LIMIT 1
SELECT title ,  director FROM movie WHERE YEAR  <=  2000 ORDER BY gross_worldwide DESC LIMIT 1
SELECT director FROM movie WHERE YEAR  =  1999 OR YEAR  =  2000
SELECT director FROM movie WHERE YEAR  =  1999 OR YEAR  =  2000
SELECT avg(budget_million) ,  max(budget_million) ,  min(budget_million) FROM movie WHERE YEAR  <  2000
SELECT avg(budget_million) ,  max(budget_million) ,  min(budget_million) FROM movie WHERE YEAR  <  2000
SELECT T1.company_name FROM culture_company AS T1 JOIN book_club AS T2 ON T1.book_club_id  =  T2.book_club_id WHERE T2.publisher  =  'Alyson'
SELECT T1.company_name FROM culture_company AS T1 JOIN book_club AS T2 ON T1.book_club_id  =  T2.book_club_id WHERE T2.publisher  =  'Alyson'
SELECT T1.title ,  T3.book_title FROM movie AS T1 JOIN culture_company AS T2 ON T1.movie_id  =  T2.movie_id JOIN book_club AS T3 ON T3.book_club_id  =  T2.book_club_id WHERE T2.incorporated_in  =  'China'
SELECT T1.title ,  T3.book_title FROM movie AS T1 JOIN culture_company AS T2 ON T1.movie_id  =  T2.movie_id JOIN book_club AS T3 ON T3.book_club_id  =  T2.book_club_id WHERE T2.incorporated_in  =  'China'
SELECT T2.company_name FROM movie AS T1 JOIN culture_company AS T2 ON T1.movie_id  =  T2.movie_id WHERE T1.year  =  1999
SELECT T2.company_name FROM movie AS T1 JOIN culture_company AS T2 ON T1.movie_id  =  T2.movie_id WHERE T1.year  =  1999
SELECT area FROM state WHERE state_name  =  "new mexico";
SELECT area FROM state WHERE state_name  =  "new mexico";
SELECT area FROM state WHERE state_name  =  "new mexico";
SELECT area FROM state WHERE state_name  =  "new mexico";
SELECT area FROM state WHERE state_name  =  "new mexico";
SELECT area FROM state WHERE state_name  =  "new mexico";
SELECT population FROM state WHERE state_name  =  "california";
SELECT population FROM state WHERE state_name  =  "california";
SELECT population FROM state WHERE state_name  =  "california";
SELECT population FROM state WHERE state_name  =  "california";
SELECT population FROM state WHERE state_name  =  "california";
SELECT population FROM state WHERE state_name  =  "california";
SELECT population FROM state WHERE state_name  =  "california";
SELECT population FROM state WHERE state_name  =  "california";
SELECT population FROM state WHERE state_name  =  "california";
SELECT population FROM state WHERE state_name  =  "california";
SELECT population FROM state WHERE state_name  =  "california";
SELECT population FROM state WHERE state_name  =  "california";
SELECT city_name FROM city WHERE state_name  =  "texas";
SELECT city_name FROM city WHERE state_name  =  "texas";
SELECT city_name FROM city WHERE state_name  =  "texas";
SELECT city_name FROM city WHERE state_name  =  "texas";
SELECT city_name FROM city WHERE state_name  =  "texas";
SELECT city_name FROM city WHERE state_name  =  "texas";
SELECT area FROM state WHERE capital  =  "albany";
SELECT lake_name FROM lake WHERE state_name  =  "california";
SELECT lake_name FROM lake WHERE area  >  750 AND state_name  =  "michigan";
SELECT traverse FROM river WHERE river_name  =  "ohio";
SELECT traverse FROM river WHERE river_name  =  "ohio";
SELECT traverse FROM river WHERE river_name  =  "ohio";
SELECT traverse FROM river WHERE river_name  =  "ohio";
SELECT traverse FROM river WHERE river_name  =  "ohio";
SELECT traverse FROM river WHERE river_name  =  "ohio";
SELECT traverse FROM river WHERE river_name  =  "ohio";
SELECT traverse FROM river WHERE river_name  =  "ohio";
SELECT traverse FROM river WHERE river_name  =  "ohio";
SELECT traverse FROM river WHERE river_name  =  "ohio";
SELECT traverse FROM river WHERE river_name  =  "ohio";
SELECT traverse FROM river WHERE river_name  =  "ohio";
SELECT traverse FROM river WHERE river_name  =  "ohio";
SELECT traverse FROM river WHERE river_name  =  "ohio";
SELECT traverse FROM river WHERE river_name  =  "ohio";
SELECT traverse FROM river WHERE river_name  =  "ohio";
SELECT lowest_elevation FROM highlow WHERE state_name  =  "pennsylvania";
SELECT highest_point  ,  state_name FROM highlow WHERE lowest_elevation  =  0;
SELECT COUNT ( river_name ) FROM river WHERE traverse  =  "idaho";
SELECT COUNT ( river_name ) FROM river WHERE traverse  =  "idaho";
SELECT COUNT ( river_name ) FROM river WHERE traverse  =  "idaho";
SELECT COUNT ( river_name ) FROM river WHERE traverse  =  "idaho";
SELECT COUNT ( river_name ) FROM river WHERE traverse  =  "idaho";
SELECT COUNT ( river_name ) FROM river WHERE traverse  =  "idaho";
SELECT COUNT ( river_name ) FROM river WHERE traverse  =  "idaho";
SELECT border FROM border_info WHERE state_name  =  "kentucky";
SELECT border FROM border_info WHERE state_name  =  "kentucky";
SELECT border FROM border_info WHERE state_name  =  "kentucky";
SELECT border FROM border_info WHERE state_name  =  "kentucky";
SELECT border FROM border_info WHERE state_name  =  "kentucky";
SELECT border FROM border_info WHERE state_name  =  "kentucky";
SELECT border FROM border_info WHERE state_name  =  "kentucky";
SELECT border FROM border_info WHERE state_name  =  "kentucky";
SELECT border FROM border_info WHERE state_name  =  "kentucky";
SELECT border FROM border_info WHERE state_name  =  "kentucky";
SELECT border FROM border_info WHERE state_name  =  "kentucky";
SELECT border FROM border_info WHERE state_name  =  "kentucky";
SELECT border FROM border_info WHERE state_name  =  "kentucky";
SELECT river_name FROM river WHERE traverse  =  "illinois";
SELECT river_name FROM river WHERE traverse  =  "illinois";
SELECT river_name FROM river WHERE traverse  =  "illinois";
SELECT river_name FROM river WHERE traverse  =  "illinois";
SELECT river_name FROM river WHERE traverse  =  "illinois";
SELECT river_name FROM river WHERE traverse  =  "illinois";
SELECT river_name FROM river WHERE traverse  =  "illinois";
SELECT river_name FROM river WHERE traverse  =  "illinois";
SELECT river_name FROM river WHERE traverse  =  "illinois";
SELECT river_name FROM river WHERE traverse  =  "illinois";
SELECT river_name FROM river WHERE traverse  =  "illinois";
SELECT river_name FROM river WHERE traverse  =  "illinois";
SELECT river_name FROM river WHERE traverse  =  "illinois";
SELECT river_name FROM river WHERE traverse  =  "illinois";
SELECT river_name FROM river WHERE traverse  =  "illinois";
SELECT river_name FROM river WHERE traverse  =  "illinois";
SELECT state_name FROM city WHERE city_name  =  "springfield";
SELECT state_name FROM city WHERE city_name  =  "springfield";
SELECT state_name FROM city WHERE city_name  =  "springfield";
SELECT state_name FROM city WHERE city_name  =  "springfield";
SELECT state_name FROM city WHERE city_name  =  "springfield";
SELECT state_name FROM city WHERE city_name  =  "springfield";
SELECT state_name FROM city WHERE city_name  =  "springfield";
SELECT state_name FROM city WHERE city_name  =  "springfield";
SELECT state_name FROM city WHERE city_name  =  "springfield";
SELECT state_name FROM city WHERE city_name  =  "springfield";
SELECT state_name FROM city WHERE city_name  =  "springfield";
SELECT state_name FROM city WHERE city_name  =  "springfield";
SELECT state_name FROM city WHERE city_name  =  "springfield";
SELECT population FROM city WHERE city_name  =  "boulder";
SELECT population FROM city WHERE city_name  =  "boulder";
SELECT population FROM city WHERE city_name  =  "boulder";
SELECT population FROM city WHERE city_name  =  "boulder";
SELECT population FROM city WHERE city_name  =  "boulder";
SELECT population FROM city WHERE city_name  =  "boulder";
SELECT population FROM city WHERE city_name  =  "boulder";
SELECT population FROM city WHERE city_name  =  "boulder";
SELECT population FROM city WHERE city_name  =  "boulder";
SELECT population FROM city WHERE city_name  =  "boulder";
SELECT population FROM city WHERE city_name  =  "boulder";
SELECT population FROM city WHERE city_name  =  "boulder";
SELECT population FROM city WHERE city_name  =  "boulder";
SELECT highest_elevation FROM highlow WHERE state_name  =  "delaware";
SELECT highest_elevation FROM highlow WHERE state_name  =  "delaware";
SELECT highest_elevation FROM highlow WHERE state_name  =  "delaware";
SELECT highest_elevation FROM highlow WHERE state_name  =  "delaware";
SELECT highest_elevation FROM highlow WHERE state_name  =  "delaware";
SELECT highest_point FROM highlow WHERE state_name  =  "texas";
SELECT highest_point FROM highlow WHERE state_name  =  "texas";
SELECT highest_point FROM highlow WHERE state_name  =  "texas";
SELECT highest_point FROM highlow WHERE state_name  =  "texas";
SELECT highest_point FROM highlow WHERE state_name  =  "texas";
SELECT highest_elevation FROM highlow WHERE highest_point  =  "guadalupe peak";
SELECT highest_elevation FROM highlow WHERE highest_point  =  "guadalupe peak";
SELECT highest_elevation FROM highlow WHERE highest_point  =  "guadalupe peak";
SELECT LENGTH FROM river WHERE river_name  =  "rio grande";
SELECT LENGTH FROM river WHERE river_name  =  "rio grande";
SELECT LENGTH FROM river WHERE river_name  =  "rio grande";
SELECT LENGTH FROM river WHERE river_name  =  "rio grande";
SELECT LENGTH FROM river WHERE river_name  =  "rio grande";
SELECT LENGTH FROM river WHERE river_name  =  "rio grande";
SELECT COUNT ( capital ) FROM state WHERE state_name  =  "rhode island";
SELECT COUNT ( city_name ) FROM city WHERE population  >  150000;
SELECT COUNT ( river_name ) FROM river WHERE river_name  =  "colorado";
SELECT COUNT ( river_name ) FROM river WHERE river_name  =  "colorado";
SELECT population FROM city WHERE city_name  =  "seattle" AND state_name  =  "washington";
SELECT population FROM city WHERE city_name  =  "seattle" AND state_name  =  "washington";
SELECT COUNT ( border ) FROM border_info WHERE state_name  =  "kentucky";
SELECT COUNT ( border ) FROM border_info WHERE state_name  =  "kentucky";
SELECT COUNT ( border ) FROM border_info WHERE state_name  =  "kentucky";
SELECT COUNT ( border ) FROM border_info WHERE state_name  =  "kentucky";
SELECT COUNT ( border ) FROM border_info WHERE state_name  =  "kentucky";
SELECT river_name FROM river WHERE LENGTH  >  750 AND traverse  =  "illinois";
SELECT river_name FROM river WHERE LENGTH  >  750 AND traverse  =  "illinois";
SELECT river_name FROM river WHERE LENGTH  >  750 AND traverse  =  "illinois";
SELECT river_name FROM river WHERE LENGTH  >  750 AND traverse  =  "illinois";
SELECT capital FROM state WHERE state_name  =  "texas";
SELECT capital FROM state WHERE state_name  =  "texas";
SELECT capital FROM state WHERE state_name  =  "texas";
SELECT capital FROM state WHERE state_name  =  "texas";
SELECT capital FROM state WHERE state_name  =  "texas";
SELECT capital FROM state WHERE state_name  =  "texas";
SELECT city_name FROM city WHERE population  >  150000 AND state_name  =  "kansas";
SELECT city_name FROM city WHERE population  >  150000 AND state_name  =  "kansas";
SELECT city_name FROM city WHERE population  >  150000 AND state_name  =  "kansas";
SELECT city_name FROM city WHERE population  >  150000 AND state_name  =  "kansas";
SELECT city_name FROM city WHERE population  >  150000 AND state_name  =  "kansas";
SELECT city_name FROM city WHERE population  >  150000 AND state_name  =  "kansas";
SELECT city_name FROM city WHERE population  >  150000 AND state_name  =  "kansas";
SELECT city_name FROM city WHERE population  >  150000;
SELECT city_name FROM city WHERE population  >  150000;
SELECT city_name FROM city WHERE population  >  150000;
SELECT population FROM city WHERE population  >  150000 AND state_name  =  "wisconsin";
SELECT population FROM city WHERE population  >  150000 AND state_name  =  "wisconsin";
SELECT population FROM city WHERE population  >  150000 AND state_name  =  "wisconsin";
SELECT density FROM state WHERE state_name  =  "wyoming";
SELECT density FROM state WHERE state_name  =  "wyoming";
SELECT density FROM state WHERE state_name  =  "wyoming";
SELECT lowest_point FROM highlow WHERE state_name  =  "iowa";
SELECT lowest_point FROM highlow WHERE state_name  =  "iowa";
SELECT lowest_point FROM highlow WHERE state_name  =  "iowa";
SELECT lowest_point FROM highlow WHERE state_name  =  "iowa";
SELECT lowest_point FROM highlow WHERE state_name  =  "iowa";
SELECT lowest_point FROM highlow WHERE state_name  =  "iowa";
SELECT traverse FROM river WHERE LENGTH  >  750;
SELECT state_name FROM mountain WHERE mountain_name  =  "whitney";
SELECT state_name FROM mountain WHERE mountain_name  =  "whitney";
SELECT state_name FROM mountain WHERE mountain_name  =  "whitney";
SELECT state_name FROM mountain WHERE mountain_name  =  "whitney";
SELECT state_name FROM city WHERE city_name  =  "austin" AND population  >  150000;
SELECT state_name FROM state WHERE capital  =  "salem";
SELECT state_name FROM state WHERE capital  =  "salem";
SELECT state_name FROM state WHERE capital  =  "salem";
SELECT state_name FROM state WHERE capital  =  "salem";
SELECT COUNT ( state_name ) FROM city WHERE city_name  =  "springfield";
SELECT COUNT ( state_name ) FROM city WHERE city_name  =  "springfield";
SELECT COUNT ( state_name ) FROM city WHERE city_name  =  "springfield";
SELECT COUNT ( state_name ) FROM city WHERE city_name  =  "springfield";
SELECT COUNT ( city_name ) FROM city WHERE population  >  150000 AND state_name  =  "texas";
SELECT COUNT ( city_name ) FROM city WHERE population  >  150000 AND state_name  =  "texas";
SELECT COUNT ( city_name ) FROM city WHERE population  >  150000 AND state_name  =  "texas";
SELECT COUNT ( traverse ) FROM river WHERE river_name  =  "missouri";
SELECT COUNT ( traverse ) FROM river WHERE river_name  =  "missouri";
SELECT COUNT ( traverse ) FROM river WHERE river_name  =  "missouri";
SELECT lake_name FROM lake WHERE area  >  750;
SELECT lake_name FROM lake WHERE area  >  750;
SELECT COUNT ( river_name ) FROM river WHERE LENGTH  >  750 AND traverse  =  "ohio";
SELECT mountain_altitude FROM mountain WHERE mountain_name  =  "mckinley";
SELECT mountain_name FROM mountain WHERE state_name  =  "alaska";
SELECT COUNT ( traverse ) FROM river WHERE LENGTH  >  750;
SELECT state_name FROM state WHERE state_name NOT IN ( SELECT traverse FROM river );
SELECT COUNT ( city_name ) FROM city WHERE state_name  =  "texas";
SELECT COUNT ( city_name ) FROM city WHERE state_name  =  "texas";
SELECT country_name FROM state WHERE state_name  =  "massachusetts";
SELECT COUNT ( city_name ) FROM city WHERE city_name  =  "austin";
SELECT LENGTH FROM river WHERE river_name  =  "colorado" AND traverse  =  "texas";
SELECT density FROM state WHERE capital  =  "austin";
SELECT lowest_elevation FROM highlow WHERE lowest_point  =  "death valley";
SELECT DISTINCT paperid FROM paper WHERE title  =  "machine networks for one shot learning";
SELECT DISTINCT paperid FROM paper WHERE title  =  "machine networks for one shot learning";
SELECT DISTINCT paperid FROM paper WHERE YEAR  =  2014;
SELECT DISTINCT paperid FROM paper WHERE YEAR  =  2014;
SELECT DISTINCT venueid FROM paper WHERE YEAR  =  2013;
SELECT DISTINCT journalid FROM paper WHERE YEAR  =  2011 GROUP BY journalid;
SELECT DISTINCT journalid FROM paper WHERE YEAR  =  2011 GROUP BY journalid;
SELECT DISTINCT paperid  ,  title FROM paper WHERE title LIKE "the effects of juicing for cancer patients" AND YEAR  >  2006;
SELECT DISTINCT venueid FROM venue WHERE venuename  =  "Neuroscience";
SELECT DISTINCT venueid FROM paper WHERE title  =  "Fracture of acrylic bone cement";
SELECT DISTINCT title  ,  YEAR FROM paper WHERE title  =  "A Switching Architecture For ISDN";
SELECT user_id FROM USER WHERE name  =  "Michelle";
SELECT state FROM business WHERE name  =  "Whataburger";
SELECT city FROM business WHERE name  =  "Taj Mahal";
SELECT text FROM review WHERE rating  <  1;
SELECT full_address FROM business WHERE city  =  "Los Angeles" AND name  =  "Walmart";
SELECT name FROM business WHERE rating  <  2 AND state  =  "Texas";
SELECT business_id FROM business WHERE city  =  "Los Angeles" AND name  =  "Apple Store";
SELECT review_count FROM business WHERE name  =  "Acacia Cafe";
SELECT AVG ( rating ) FROM review WHERE YEAR  =  2014;
SELECT homepage FROM journal WHERE name  =  "PVLDB";
SELECT abstract FROM publication WHERE title  =  "Making database systems usable";
SELECT YEAR FROM publication WHERE title  =  "Making database systems usable";
SELECT YEAR FROM publication WHERE title  =  "Making database systems usable";
SELECT title FROM publication WHERE YEAR  >  2000;
SELECT homepage FROM conference WHERE name  =  "VLDB";
SELECT name FROM organization WHERE continent  =  "North America";
SELECT homepage FROM organization WHERE name  =  "University of Michigan";
SELECT reference_num FROM publication WHERE title  =  "Making database systems usable";
SELECT reference_num FROM publication WHERE title  =  "Making database systems usable";
SELECT citation_num FROM publication WHERE title  =  "Making database systems usable";
SELECT citation_num FROM publication WHERE title  =  "Making database systems usable";
SELECT title FROM publication WHERE citation_num  >  200;
SELECT title FROM publication WHERE citation_num  >  200 AND YEAR  >  2000;
SELECT title FROM publication WHERE YEAR  >  2000 ORDER BY citation_num DESC LIMIT 1;
SELECT release_year FROM movie WHERE title  =  "The Imitation Game";
SELECT release_year FROM movie WHERE title  =  "The Imitation Game";
SELECT birth_year FROM actor WHERE name  =  "Benedict Cumberbatch";
SELECT birth_year FROM actor WHERE name  =  "Benedict Cumberbatch";
SELECT nationality FROM actor WHERE name  =  "Christoph Waltz";
SELECT nationality FROM actor WHERE name  =  "Christoph Waltz";
SELECT title FROM movie WHERE release_year  =  2015;
SELECT name FROM actor WHERE birth_city  =  "Tehran";
SELECT name FROM actor WHERE birth_city  =  "Tehran";
SELECT name FROM actor WHERE birth_city  =  "Tehran";
SELECT name FROM actor WHERE nationality  =  "Afghanistan";
SELECT name FROM actor WHERE nationality  =  "Afghanistan";
SELECT name FROM actor WHERE nationality  =  "Afghanistan";
SELECT name FROM actor WHERE birth_year  =  1984;
SELECT birth_year FROM actor WHERE name  =  "actor_name0";
SELECT birth_year FROM actor WHERE name  =  "actor_name0";
SELECT birth_city FROM director WHERE name  =  "director_name0";
SELECT birth_city FROM director WHERE name  =  "director_name0";
SELECT nationality FROM director WHERE name  =  "director_name0";
SELECT budget FROM movie WHERE title  =  "Finding Nemo";
SELECT budget FROM movie WHERE release_year  =  2007 AND title  =  "Juno";
SELECT name FROM actor WHERE birth_city  =  "Austin" AND birth_year  >  1980;
SELECT name FROM actor WHERE birth_city  =  "Austin" AND birth_year  >  1980;
SELECT name FROM actor WHERE birth_city  =  "Austin" AND birth_year  >  1980;
SELECT name FROM actor WHERE birth_city  =  "New York City" AND birth_year  =  1984;
SELECT name FROM actor WHERE birth_city  =  "Austin" AND gender  =  "female";
SELECT name FROM actor WHERE birth_year  >  1980 AND nationality  =  "Italy";
SELECT name FROM actor WHERE birth_city  =  "New York City" AND birth_year  >  1980 AND gender  =  "female";
SELECT name FROM director WHERE nationality  =  "Afghanistan";

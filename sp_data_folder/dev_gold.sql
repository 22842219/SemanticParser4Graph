SELECT count(*) FROM singer
SELECT count(*) FROM singer
SELECT name ,  country ,  age FROM singer ORDER BY age DESC
SELECT name ,  country ,  age FROM singer ORDER BY age DESC
SELECT avg(age) ,  min(age) ,  max(age) FROM singer WHERE country  =  'France'
SELECT avg(age) ,  min(age) ,  max(age) FROM singer WHERE country  =  'France'
SELECT song_name ,  song_release_year FROM singer ORDER BY age LIMIT 1
SELECT song_name ,  song_release_year FROM singer ORDER BY age LIMIT 1
SELECT DISTINCT country FROM singer WHERE age  >  20
SELECT DISTINCT country FROM singer WHERE age  >  20
SELECT country ,  count(*) FROM singer GROUP BY country
SELECT country ,  count(*) FROM singer GROUP BY country
SELECT LOCATION ,  name FROM stadium WHERE capacity BETWEEN 5000 AND 10000
SELECT LOCATION ,  name FROM stadium WHERE capacity BETWEEN 5000 AND 10000
select avg(capacity) ,  max(capacity) from stadium
SELECT name ,  capacity FROM stadium ORDER BY average DESC LIMIT 1
SELECT name ,  capacity FROM stadium ORDER BY average DESC LIMIT 1
SELECT T2.name ,  count(*) FROM concert AS T1 JOIN stadium AS T2 ON T1.stadium_id  =  T2.stadium_id GROUP BY T1.stadium_id
SELECT T2.name ,  count(*) FROM concert AS T1 JOIN stadium AS T2 ON T1.stadium_id  =  T2.stadium_id GROUP BY T1.stadium_id
SELECT T2.name ,  T2.capacity FROM concert AS T1 JOIN stadium AS T2 ON T1.stadium_id  =  T2.stadium_id WHERE T1.year  >=  2014 GROUP BY T2.stadium_id ORDER BY count(*) DESC LIMIT 1
SELECT T2.concert_name ,  T2.theme ,  count(*) FROM singer_in_concert AS T1 JOIN concert AS T2 ON T1.concert_id  =  T2.concert_id GROUP BY T2.concert_id
SELECT T2.name ,  count(*) FROM singer_in_concert AS T1 JOIN singer AS T2 ON T1.singer_id  =  T2.singer_id GROUP BY T2.singer_id
SELECT T2.name ,  count(*) FROM singer_in_concert AS T1 JOIN singer AS T2 ON T1.singer_id  =  T2.singer_id GROUP BY T2.singer_id
SELECT T2.name FROM singer_in_concert AS T1 JOIN singer AS T2 ON T1.singer_id  =  T2.singer_id JOIN concert AS T3 ON T1.concert_id  =  T3.concert_id WHERE T3.year  =  2014
SELECT T2.name FROM singer_in_concert AS T1 JOIN singer AS T2 ON T1.singer_id  =  T2.singer_id JOIN concert AS T3 ON T1.concert_id  =  T3.concert_id WHERE T3.year  =  2014
SELECT name ,  country FROM singer WHERE song_name LIKE '%Hey%'
SELECT name ,  country FROM singer WHERE song_name LIKE '%Hey%'
SELECT count(*) FROM pets WHERE weight  >  10
SELECT count(*) FROM pets WHERE weight  >  10
SELECT weight FROM pets ORDER BY pet_age LIMIT 1
SELECT weight FROM pets ORDER BY pet_age LIMIT 1
SELECT count(*) FROM student AS T1 JOIN has_pet AS T2 ON T1.stuid  =  T2.stuid WHERE T1.age  >  20
SELECT count(*) FROM student AS T1 JOIN has_pet AS T2 ON T1.stuid  =  T2.stuid WHERE T1.age  >  20
SELECT count(DISTINCT pettype) FROM pets
SELECT count(DISTINCT pettype) FROM pets
SELECT DISTINCT T1.Fname FROM student AS T1 JOIN has_pet AS T2 ON T1.stuid  =  T2.stuid JOIN pets AS T3 ON T3.petid  =  T2.petid WHERE T3.pettype  =  'cat' OR T3.pettype  =  'dog'
SELECT DISTINCT T1.Fname FROM student AS T1 JOIN has_pet AS T2 ON T1.stuid  =  T2.stuid JOIN pets AS T3 ON T3.petid  =  T2.petid WHERE T3.pettype  =  'cat' OR T3.pettype  =  'dog'
SELECT major ,  age FROM student WHERE stuid NOT IN (SELECT T1.stuid FROM student AS T1 JOIN has_pet AS T2 ON T1.stuid  =  T2.stuid JOIN pets AS T3 ON T3.petid  =  T2.petid WHERE T3.pettype  =  'cat')
SELECT major ,  age FROM student WHERE stuid NOT IN (SELECT T1.stuid FROM student AS T1 JOIN has_pet AS T2 ON T1.stuid  =  T2.stuid JOIN pets AS T3 ON T3.petid  =  T2.petid WHERE T3.pettype  =  'cat')
SELECT pettype ,  weight FROM pets ORDER BY pet_age LIMIT 1
SELECT pettype ,  weight FROM pets ORDER BY pet_age LIMIT 1
SELECT petid ,  weight FROM pets WHERE pet_age  >  1
SELECT petid ,  weight FROM pets WHERE pet_age  >  1
SELECT DISTINCT T1.fname ,  T1.age FROM student AS T1 JOIN has_pet AS T2 ON T1.stuid  =  T2.stuid
SELECT DISTINCT T1.fname ,  T1.age FROM student AS T1 JOIN has_pet AS T2 ON T1.stuid  =  T2.stuid
SELECT T2.petid FROM student AS T1 JOIN has_pet AS T2 ON T1.stuid  =  T2.stuid WHERE T1.Lname  =  'Smith'
SELECT T2.petid FROM student AS T1 JOIN has_pet AS T2 ON T1.stuid  =  T2.stuid WHERE T1.Lname  =  'Smith'
SELECT count(*) ,  T1.stuid FROM student AS T1 JOIN has_pet AS T2 ON T1.stuid  =  T2.stuid GROUP BY T1.stuid
SELECT T1.fname ,  T1.sex FROM student AS T1 JOIN has_pet AS T2 ON T1.stuid  =  T2.stuid GROUP BY T1.stuid HAVING count(*)  >  1
SELECT T1.fname ,  T1.sex FROM student AS T1 JOIN has_pet AS T2 ON T1.stuid  =  T2.stuid GROUP BY T1.stuid HAVING count(*)  >  1
SELECT T1.lname FROM student AS T1 JOIN has_pet AS T2 ON T1.stuid  =  T2.stuid JOIN pets AS T3 ON T3.petid  =  T2.petid WHERE T3.pet_age  =  3 AND T3.pettype  =  'cat'
SELECT T1.lname FROM student AS T1 JOIN has_pet AS T2 ON T1.stuid  =  T2.stuid JOIN pets AS T3 ON T3.petid  =  T2.petid WHERE T3.pet_age  =  3 AND T3.pettype  =  'cat'
SELECT count(*) FROM CONTINENTS;
SELECT count(*) FROM CONTINENTS;
SELECT T1.ContId ,  T1.Continent ,  count(*) FROM CONTINENTS AS T1 JOIN COUNTRIES AS T2 ON T1.ContId  =  T2.Continent GROUP BY T1.ContId;
SELECT T1.ContId ,  T1.Continent ,  count(*) FROM CONTINENTS AS T1 JOIN COUNTRIES AS T2 ON T1.ContId  =  T2.Continent GROUP BY T1.ContId;
SELECT count(*) FROM COUNTRIES;
SELECT count(*) FROM COUNTRIES;
SELECT T1.FullName ,  T1.Id ,  count(*) FROM CAR_MAKERS AS T1 JOIN MODEL_LIST AS T2 ON T1.Id  =  T2.Maker GROUP BY T1.Id;
SELECT T1.FullName ,  T1.Id ,  count(*) FROM CAR_MAKERS AS T1 JOIN MODEL_LIST AS T2 ON T1.Id  =  T2.Maker GROUP BY T1.Id;
SELECT T1.Model FROM CAR_NAMES AS T1 JOIN CARS_DATA AS T2 ON T1.MakeId  =  T2.Id ORDER BY T2.horsepower ASC LIMIT 1;
SELECT T1.Model FROM CAR_NAMES AS T1 JOIN CARS_DATA AS T2 ON T1.MakeId  =  T2.Id ORDER BY T2.horsepower ASC LIMIT 1;
SELECT DISTINCT T1.Maker FROM CAR_MAKERS AS T1 JOIN MODEL_LIST AS T2 ON T1.Id  =  T2.Maker JOIN CAR_NAMES AS T3 ON T2.model  =  T3.model JOIN CARS_DATA AS T4 ON T3.MakeId  =  T4.id WHERE T4.year  =  '1970';
SELECT DISTINCT T1.Maker FROM CAR_MAKERS AS T1 JOIN MODEL_LIST AS T2 ON T1.Id  =  T2.Maker JOIN CAR_NAMES AS T3 ON T2.model  =  T3.model JOIN CARS_DATA AS T4 ON T3.MakeId  =  T4.id WHERE T4.year  =  '1970';
SELECT DISTINCT T1.model FROM MODEL_LIST AS T1 JOIN CAR_NAMES AS T2 ON T1.model  =  T2.model JOIN CARS_DATA AS T3 ON T2.MakeId  =  T3.id WHERE T3.year  >  1980;
SELECT DISTINCT T1.model FROM MODEL_LIST AS T1 JOIN CAR_NAMES AS T2 ON T1.model  =  T2.model JOIN CARS_DATA AS T3 ON T2.MakeId  =  T3.id WHERE T3.year  >  1980;
SELECT T1.Continent ,  count(*) FROM CONTINENTS AS T1 JOIN COUNTRIES AS T2 ON T1.ContId  =  T2.continent JOIN car_makers AS T3 ON T2.CountryId  =  T3.Country GROUP BY T1.Continent;
SELECT T1.Continent ,  count(*) FROM CONTINENTS AS T1 JOIN COUNTRIES AS T2 ON T1.ContId  =  T2.continent JOIN car_makers AS T3 ON T2.CountryId  =  T3.Country GROUP BY T1.Continent;
SELECT T2.CountryName FROM CAR_MAKERS AS T1 JOIN COUNTRIES AS T2 ON T1.Country  =  T2.CountryId GROUP BY T1.Country ORDER BY Count(*) DESC LIMIT 1;
SELECT T2.CountryName FROM CAR_MAKERS AS T1 JOIN COUNTRIES AS T2 ON T1.Country  =  T2.CountryId GROUP BY T1.Country ORDER BY Count(*) DESC LIMIT 1;
SELECT Count(*) ,  T2.FullName ,  T2.id FROM MODEL_LIST AS T1 JOIN CAR_MAKERS AS T2 ON T1.Maker  =  T2.Id GROUP BY T2.id;
SELECT T1.Accelerate FROM CARS_DATA AS T1 JOIN CAR_NAMES AS T2 ON T1.Id  =  T2.MakeId WHERE T2.Make  =  'amc hornet sportabout (sw)';
SELECT T1.Accelerate FROM CARS_DATA AS T1 JOIN CAR_NAMES AS T2 ON T1.Id  =  T2.MakeId WHERE T2.Make  =  'amc hornet sportabout (sw)';
select min(weight) from cars_data where cylinders  =  8 and year  =  1974
select min(weight) from cars_data where cylinders  =  8 and year  =  1974
SELECT Maker ,  Model FROM MODEL_LIST;
SELECT Maker ,  Model FROM MODEL_LIST;
SELECT T1.CountryName ,  T1.CountryId FROM COUNTRIES AS T1 JOIN CAR_MAKERS AS T2 ON T1.CountryId  =  T2.Country GROUP BY T1.CountryId HAVING count(*)  >=  1;
SELECT T1.CountryName ,  T1.CountryId FROM COUNTRIES AS T1 JOIN CAR_MAKERS AS T2 ON T1.CountryId  =  T2.Country GROUP BY T1.CountryId HAVING count(*)  >=  1;
SELECT T1.CountryName FROM COUNTRIES AS T1 JOIN CONTINENTS AS T2 ON T1.Continent  =  T2.ContId JOIN CAR_MAKERS AS T3 ON T1.CountryId  =  T3.Country WHERE T2.Continent  =  'europe' GROUP BY T1.CountryName HAVING count(*)  >=  3;
SELECT T1.CountryName FROM COUNTRIES AS T1 JOIN CONTINENTS AS T2 ON T1.Continent  =  T2.ContId JOIN CAR_MAKERS AS T3 ON T1.CountryId  =  T3.Country WHERE T2.Continent  =  'europe' GROUP BY T1.CountryName HAVING count(*)  >=  3;
SELECT T2.horsepower ,  T1.Make FROM CAR_NAMES AS T1 JOIN CARS_DATA AS T2 ON T1.MakeId  =  T2.Id WHERE T2.cylinders  =  3 ORDER BY T2.horsepower DESC LIMIT 1;
SELECT T2.horsepower ,  T1.Make FROM CAR_NAMES AS T1 JOIN CARS_DATA AS T2 ON T1.MakeId  =  T2.Id WHERE T2.cylinders  =  3 ORDER BY T2.horsepower DESC LIMIT 1;
SELECT T1.Model FROM CAR_NAMES AS T1 JOIN CARS_DATA AS T2 ON T1.MakeId  =  T2.Id ORDER BY T2.mpg DESC LIMIT 1;
SELECT avg(T2.edispl) FROM CAR_NAMES AS T1 JOIN CARS_DATA AS T2 ON T1.MakeId  =  T2.Id WHERE T1.Model  =  'volvo';
SELECT avg(T2.edispl) FROM CAR_NAMES AS T1 JOIN CARS_DATA AS T2 ON T1.MakeId  =  T2.Id WHERE T1.Model  =  'volvo';
SELECT Model FROM CAR_NAMES GROUP BY Model ORDER BY count(*) DESC LIMIT 1;
SELECT Model FROM CAR_NAMES GROUP BY Model ORDER BY count(*) DESC LIMIT 1;
SELECT count(*) FROM CARS_DATA WHERE Cylinders  >  4;
SELECT count(*) FROM CARS_DATA WHERE Cylinders  >  4;
SELECT count(*) FROM CARS_DATA WHERE YEAR  =  1980;
SELECT count(*) FROM CARS_DATA WHERE YEAR  =  1980;
SELECT count(*) FROM CAR_MAKERS AS T1 JOIN MODEL_LIST AS T2 ON T1.Id  =  T2.Maker WHERE T1.FullName  =  'American Motor Company';
SELECT count(*) FROM CAR_MAKERS AS T1 JOIN MODEL_LIST AS T2 ON T1.Id  =  T2.Maker WHERE T1.FullName  =  'American Motor Company';
SELECT T1.FullName ,  T1.Id FROM CAR_MAKERS AS T1 JOIN MODEL_LIST AS T2 ON T1.Id  =  T2.Maker GROUP BY T1.Id HAVING count(*)  >  3;
SELECT T1.FullName ,  T1.Id FROM CAR_MAKERS AS T1 JOIN MODEL_LIST AS T2 ON T1.Id  =  T2.Maker GROUP BY T1.Id HAVING count(*)  >  3;
SELECT DISTINCT T2.Model FROM CAR_NAMES AS T1 JOIN MODEL_LIST AS T2 ON T1.Model  =  T2.Model JOIN CAR_MAKERS AS T3 ON T2.Maker  =  T3.Id JOIN CARS_DATA AS T4 ON T1.MakeId  =  T4.Id WHERE T3.FullName  =  'General Motors' OR T4.weight  >  3500;
SELECT DISTINCT T2.Model FROM CAR_NAMES AS T1 JOIN MODEL_LIST AS T2 ON T1.Model  =  T2.Model JOIN CAR_MAKERS AS T3 ON T2.Maker  =  T3.Id JOIN CARS_DATA AS T4 ON T1.MakeId  =  T4.Id WHERE T3.FullName  =  'General Motors' OR T4.weight  >  3500;
select distinct year from cars_data where weight between 3000 and 4000;
select distinct year from cars_data where weight between 3000 and 4000;
SELECT T1.cylinders FROM CARS_DATA AS T1 JOIN CAR_NAMES AS T2 ON T1.Id  =  T2.MakeId WHERE T2.Model  =  'volvo' ORDER BY T1.accelerate ASC LIMIT 1;
SELECT T1.cylinders FROM CARS_DATA AS T1 JOIN CAR_NAMES AS T2 ON T1.Id  =  T2.MakeId WHERE T2.Model  =  'volvo' ORDER BY T1.accelerate ASC LIMIT 1;
SELECT COUNT(*) FROM CARS_DATA WHERE Cylinders  >  6;
SELECT COUNT(*) FROM CARS_DATA WHERE Cylinders  >  6;
SELECT T1.Model FROM CAR_NAMES AS T1 JOIN CARS_DATA AS T2 ON T1.MakeId  =  T2.Id WHERE T2.Cylinders  =  4 ORDER BY T2.horsepower DESC LIMIT 1;
SELECT T1.Model FROM CAR_NAMES AS T1 JOIN CARS_DATA AS T2 ON T1.MakeId  =  T2.Id WHERE T2.Cylinders  =  4 ORDER BY T2.horsepower DESC LIMIT 1;
select max(mpg) from cars_data where cylinders  =  8 or year  <  1980
select max(mpg) from cars_data where cylinders  =  8 or year  <  1980
SELECT DISTINCT T1.model FROM MODEL_LIST AS T1 JOIN CAR_NAMES AS T2 ON T1.Model  =  T2.Model JOIN CARS_DATA AS T3 ON T2.MakeId  =  T3.Id JOIN CAR_MAKERS AS T4 ON T1.Maker  =  T4.Id WHERE T3.weight  <  3500 AND T4.FullName != 'Ford Motor Company';
SELECT DISTINCT T1.model FROM MODEL_LIST AS T1 JOIN CAR_NAMES AS T2 ON T1.Model  =  T2.Model JOIN CARS_DATA AS T3 ON T2.MakeId  =  T3.Id JOIN CAR_MAKERS AS T4 ON T1.Maker  =  T4.Id WHERE T3.weight  <  3500 AND T4.FullName != 'Ford Motor Company';
SELECT Country FROM AIRLINES WHERE Airline  =  "JetBlue Airways"
SELECT Country FROM AIRLINES WHERE Airline  =  "JetBlue Airways"
SELECT Abbreviation FROM AIRLINES WHERE Airline  =  "JetBlue Airways"
SELECT Abbreviation FROM AIRLINES WHERE Airline  =  "JetBlue Airways"
SELECT Airline ,  Abbreviation FROM AIRLINES WHERE Country  =  "USA"
SELECT Airline ,  Abbreviation FROM AIRLINES WHERE Country  =  "USA"
SELECT AirportCode ,  AirportName FROM AIRPORTS WHERE city  =  "Anthony"
SELECT AirportCode ,  AirportName FROM AIRPORTS WHERE city  =  "Anthony"
SELECT count(*) FROM AIRLINES
SELECT count(*) FROM AIRLINES
SELECT count(*) FROM AIRPORTS
SELECT count(*) FROM AIRPORTS
SELECT Airline FROM AIRLINES WHERE Abbreviation  =  "UAL"
SELECT Airline FROM AIRLINES WHERE Abbreviation  =  "UAL"
SELECT count(*) FROM AIRLINES WHERE Country  =  "USA"
SELECT count(*) FROM AIRLINES WHERE Country  =  "USA"
SELECT City ,  Country FROM AIRPORTS WHERE AirportName  =  "Alton"
SELECT City ,  Country FROM AIRPORTS WHERE AirportName  =  "Alton"
SELECT AirportName FROM AIRPORTS WHERE AirportCode  =  "AKO"
SELECT AirportName FROM AIRPORTS WHERE AirportCode  =  "AKO"
SELECT AirportName FROM AIRPORTS WHERE City = "Aberdeen"
SELECT AirportName FROM AIRPORTS WHERE City = "Aberdeen"
SELECT count(*) FROM FLIGHTS WHERE SourceAirport  =  "APG"
SELECT count(*) FROM FLIGHTS WHERE SourceAirport  =  "APG"
SELECT count(*) FROM FLIGHTS WHERE DestAirport  =  "ATO"
SELECT count(*) FROM FLIGHTS WHERE DestAirport  =  "ATO"
SELECT count(*) FROM FLIGHTS AS T1 JOIN AIRPORTS AS T2 ON T1.SourceAirport  =  T2.AirportCode WHERE T2.City  =  "Aberdeen"
SELECT count(*) FROM FLIGHTS AS T1 JOIN AIRPORTS AS T2 ON T1.SourceAirport  =  T2.AirportCode WHERE T2.City  =  "Aberdeen"
SELECT count(*) FROM FLIGHTS AS T1 JOIN AIRPORTS AS T2 ON T1.DestAirport  =  T2.AirportCode WHERE T2.City  =  "Aberdeen"
SELECT count(*) FROM FLIGHTS AS T1 JOIN AIRPORTS AS T2 ON T1.DestAirport  =  T2.AirportCode WHERE T2.City  =  "Aberdeen"
SELECT count(*) FROM FLIGHTS AS T1 JOIN AIRPORTS AS T2 ON T1.DestAirport  =  T2.AirportCode JOIN AIRPORTS AS T3 ON T1.SourceAirport  =  T3.AirportCode WHERE T2.City  =  "Ashley" AND T3.City  =  "Aberdeen"
SELECT count(*) FROM FLIGHTS AS T1 JOIN AIRPORTS AS T2 ON T1.DestAirport  =  T2.AirportCode JOIN AIRPORTS AS T3 ON T1.SourceAirport  =  T3.AirportCode WHERE T2.City  =  "Ashley" AND T3.City  =  "Aberdeen"
SELECT count(*) FROM AIRLINES AS T1 JOIN FLIGHTS AS T2 ON T2.Airline  =  T1.uid WHERE T1.Airline  =  "United Airlines" AND T2.DestAirport  =  "ASY"
SELECT count(*) FROM AIRLINES AS T1 JOIN FLIGHTS AS T2 ON T2.Airline  =  T1.uid WHERE T1.Airline  =  "United Airlines" AND T2.DestAirport  =  "ASY"
SELECT count(*) FROM AIRLINES AS T1 JOIN FLIGHTS AS T2 ON T2.Airline  =  T1.uid WHERE T1.Airline  =  "United Airlines" AND T2.SourceAirport  =  "AHD"
SELECT count(*) FROM AIRLINES AS T1 JOIN FLIGHTS AS T2 ON T2.Airline  =  T1.uid WHERE T1.Airline  =  "United Airlines" AND T2.SourceAirport  =  "AHD"
SELECT count(*) FROM FLIGHTS AS T1 JOIN AIRPORTS AS T2 ON T1.DestAirport  =  T2.AirportCode JOIN AIRLINES AS T3 ON T3.uid  =  T1.Airline WHERE T2.City  =  "Aberdeen" AND T3.Airline  =  "United Airlines"
SELECT count(*) FROM FLIGHTS AS T1 JOIN AIRPORTS AS T2 ON T1.DestAirport  =  T2.AirportCode JOIN AIRLINES AS T3 ON T3.uid  =  T1.Airline WHERE T2.City  =  "Aberdeen" AND T3.Airline  =  "United Airlines"
SELECT T1.City FROM AIRPORTS AS T1 JOIN FLIGHTS AS T2 ON T1.AirportCode  =  T2.DestAirport GROUP BY T1.City ORDER BY count(*) DESC LIMIT 1
SELECT T1.City FROM AIRPORTS AS T1 JOIN FLIGHTS AS T2 ON T1.AirportCode  =  T2.DestAirport GROUP BY T1.City ORDER BY count(*) DESC LIMIT 1
SELECT T1.City FROM AIRPORTS AS T1 JOIN FLIGHTS AS T2 ON T1.AirportCode  =  T2.SourceAirport GROUP BY T1.City ORDER BY count(*) DESC LIMIT 1
SELECT T1.City FROM AIRPORTS AS T1 JOIN FLIGHTS AS T2 ON T1.AirportCode  =  T2.SourceAirport GROUP BY T1.City ORDER BY count(*) DESC LIMIT 1
SELECT T1.Airline FROM AIRLINES AS T1 JOIN FLIGHTS AS T2 ON T1.uid  =  T2.Airline GROUP BY T1.Airline ORDER BY count(*) DESC LIMIT 1
SELECT T1.Airline FROM AIRLINES AS T1 JOIN FLIGHTS AS T2 ON T1.uid  =  T2.Airline GROUP BY T1.Airline ORDER BY count(*) DESC LIMIT 1
SELECT T1.Abbreviation ,  T1.Country FROM AIRLINES AS T1 JOIN FLIGHTS AS T2 ON T1.uid  =  T2.Airline GROUP BY T1.Airline ORDER BY count(*) LIMIT 1
SELECT T1.Abbreviation ,  T1.Country FROM AIRLINES AS T1 JOIN FLIGHTS AS T2 ON T1.uid  =  T2.Airline GROUP BY T1.Airline ORDER BY count(*) LIMIT 1
SELECT T1.Airline FROM AIRLINES AS T1 JOIN FLIGHTS AS T2 ON T1.uid  =  T2.Airline WHERE T2.SourceAirport  =  "AHD"
SELECT T1.Airline FROM AIRLINES AS T1 JOIN FLIGHTS AS T2 ON T1.uid  =  T2.Airline WHERE T2.SourceAirport  =  "AHD"
SELECT T1.Airline FROM AIRLINES AS T1 JOIN FLIGHTS AS T2 ON T1.uid  =  T2.Airline WHERE T2.DestAirport  =  "AHD"
SELECT T1.Airline FROM AIRLINES AS T1 JOIN FLIGHTS AS T2 ON T1.uid  =  T2.Airline WHERE T2.DestAirport  =  "AHD"
SELECT T1.Airline FROM AIRLINES AS T1 JOIN FLIGHTS AS T2 ON T1.uid  =  T2.Airline GROUP BY T1.Airline HAVING count(*)  >  10
SELECT T1.Airline FROM AIRLINES AS T1 JOIN FLIGHTS AS T2 ON T1.uid  =  T2.Airline GROUP BY T1.Airline HAVING count(*)  >  10
SELECT T1.Airline FROM AIRLINES AS T1 JOIN FLIGHTS AS T2 ON T1.uid  =  T2.Airline GROUP BY T1.Airline HAVING count(*)  <  200
SELECT T1.Airline FROM AIRLINES AS T1 JOIN FLIGHTS AS T2 ON T1.uid  =  T2.Airline GROUP BY T1.Airline HAVING count(*)  <  200
SELECT T1.FlightNo FROM FLIGHTS AS T1 JOIN AIRLINES AS T2 ON T2.uid  =  T1.Airline WHERE T2.Airline  =  "United Airlines"
SELECT T1.FlightNo FROM FLIGHTS AS T1 JOIN AIRLINES AS T2 ON T2.uid  =  T1.Airline WHERE T2.Airline  =  "United Airlines"
SELECT FlightNo FROM FLIGHTS WHERE SourceAirport  =  "APG"
SELECT FlightNo FROM FLIGHTS WHERE SourceAirport  =  "APG"
SELECT FlightNo FROM FLIGHTS WHERE DestAirport  =  "APG"
SELECT FlightNo FROM FLIGHTS WHERE DestAirport  =  "APG"
SELECT T1.FlightNo FROM FLIGHTS AS T1 JOIN AIRPORTS AS T2 ON T1.SourceAirport   =  T2.AirportCode WHERE T2.City  =  "Aberdeen"
SELECT T1.FlightNo FROM FLIGHTS AS T1 JOIN AIRPORTS AS T2 ON T1.SourceAirport   =  T2.AirportCode WHERE T2.City  =  "Aberdeen"
SELECT T1.FlightNo FROM FLIGHTS AS T1 JOIN AIRPORTS AS T2 ON T1.DestAirport   =  T2.AirportCode WHERE T2.City  =  "Aberdeen"
SELECT T1.FlightNo FROM FLIGHTS AS T1 JOIN AIRPORTS AS T2 ON T1.DestAirport   =  T2.AirportCode WHERE T2.City  =  "Aberdeen"
SELECT count(*) FROM Flights AS T1 JOIN Airports AS T2 ON T1.DestAirport  =  T2.AirportCode WHERE T2.city  =  "Aberdeen" OR T2.city  =  "Abilene"
SELECT count(*) FROM Flights AS T1 JOIN Airports AS T2 ON T1.DestAirport  =  T2.AirportCode WHERE T2.city  =  "Aberdeen" OR T2.city  =  "Abilene"
SELECT AirportName FROM Airports WHERE AirportCode NOT IN (SELECT SourceAirport FROM Flights UNION SELECT DestAirport FROM Flights)
SELECT AirportName FROM Airports WHERE AirportCode NOT IN (SELECT SourceAirport FROM Flights UNION SELECT DestAirport FROM Flights)
SELECT count(*) FROM employee
SELECT count(*) FROM employee
SELECT name FROM employee ORDER BY age
SELECT name FROM employee ORDER BY age
SELECT count(*) ,  city FROM employee GROUP BY city
SELECT count(*) ,  city FROM employee GROUP BY city
SELECT city FROM employee WHERE age  <  30 GROUP BY city HAVING count(*)  >  1
SELECT city FROM employee WHERE age  <  30 GROUP BY city HAVING count(*)  >  1
SELECT count(*) ,  LOCATION FROM shop GROUP BY LOCATION
SELECT count(*) ,  LOCATION FROM shop GROUP BY LOCATION
SELECT manager_name ,  district FROM shop ORDER BY number_products DESC LIMIT 1
SELECT manager_name ,  district FROM shop ORDER BY number_products DESC LIMIT 1
SELECT min(Number_products) ,  max(Number_products) FROM shop
SELECT min(Number_products) ,  max(Number_products) FROM shop
SELECT name ,  LOCATION ,  district FROM shop ORDER BY number_products DESC
SELECT name ,  LOCATION ,  district FROM shop ORDER BY number_products DESC
SELECT count(DISTINCT LOCATION) FROM shop
SELECT count(DISTINCT LOCATION) FROM shop
SELECT count(*) FROM Documents
SELECT count(*) FROM Documents
SELECT document_id ,  document_name ,  document_description FROM Documents
SELECT document_id ,  document_name ,  document_description FROM Documents
SELECT document_name ,  template_id FROM Documents WHERE Document_Description LIKE "%w%"
SELECT document_name ,  template_id FROM Documents WHERE Document_Description LIKE "%w%"
SELECT document_id ,  template_id ,  Document_Description FROM Documents WHERE document_name  =  "Robbin CV"
SELECT document_id ,  template_id ,  Document_Description FROM Documents WHERE document_name  =  "Robbin CV"
SELECT count(DISTINCT template_id) FROM Documents
SELECT count(DISTINCT template_id) FROM Documents
SELECT count(*) FROM Documents AS T1 JOIN Templates AS T2 ON T1.Template_ID  =  T2.Template_ID WHERE T2.Template_Type_Code  =  'PPT'
SELECT count(*) FROM Documents AS T1 JOIN Templates AS T2 ON T1.Template_ID  =  T2.Template_ID WHERE T2.Template_Type_Code  =  'PPT'
SELECT template_id ,  count(*) FROM Documents GROUP BY template_id
SELECT template_id ,  count(*) FROM Documents GROUP BY template_id
SELECT T1.template_id ,  T2.Template_Type_Code FROM Documents AS T1 JOIN Templates AS T2 ON T1.template_id  =  T2.template_id GROUP BY T1.template_id ORDER BY count(*) DESC LIMIT 1
SELECT T1.template_id ,  T2.Template_Type_Code FROM Documents AS T1 JOIN Templates AS T2 ON T1.template_id  =  T2.template_id GROUP BY T1.template_id ORDER BY count(*) DESC LIMIT 1
SELECT template_id FROM Documents GROUP BY template_id HAVING count(*)  >  1
SELECT template_id FROM Documents GROUP BY template_id HAVING count(*)  >  1
SELECT count(*) FROM Templates
SELECT count(*) FROM Templates
SELECT template_id ,  version_number ,  template_type_code FROM Templates
SELECT template_id ,  version_number ,  template_type_code FROM Templates
SELECT DISTINCT template_type_code FROM Templates
SELECT DISTINCT template_type_code FROM Templates
SELECT template_id FROM Templates WHERE template_type_code  =  "PP" OR template_type_code  =  "PPT"
SELECT template_id FROM Templates WHERE template_type_code  =  "PP" OR template_type_code  =  "PPT"
SELECT count(*) FROM Templates WHERE template_type_code  =  "CV"
SELECT count(*) FROM Templates WHERE template_type_code  =  "CV"
SELECT version_number ,  template_type_code FROM Templates WHERE version_number  >  5
SELECT version_number ,  template_type_code FROM Templates WHERE version_number  >  5
SELECT template_type_code ,  count(*) FROM Templates GROUP BY template_type_code
SELECT template_type_code ,  count(*) FROM Templates GROUP BY template_type_code
SELECT template_type_code FROM Templates GROUP BY template_type_code ORDER BY count(*) DESC LIMIT 1
SELECT template_type_code FROM Templates GROUP BY template_type_code ORDER BY count(*) DESC LIMIT 1
SELECT template_type_code FROM Templates GROUP BY template_type_code HAVING count(*)  <  3
SELECT template_type_code FROM Templates GROUP BY template_type_code HAVING count(*)  <  3
SELECT T1.template_type_code FROM Templates AS T1 JOIN Documents AS T2 ON T1.template_id  =  T2.template_id WHERE T2.document_name  =  "Data base"
SELECT T1.template_type_code FROM Templates AS T1 JOIN Documents AS T2 ON T1.template_id  =  T2.template_id WHERE T2.document_name  =  "Data base"
SELECT T2.document_name FROM Templates AS T1 JOIN Documents AS T2 ON T1.template_id  =  T2.template_id WHERE T1.template_type_code  =  "BK"
SELECT T2.document_name FROM Templates AS T1 JOIN Documents AS T2 ON T1.template_id  =  T2.template_id WHERE T1.template_type_code  =  "BK"
SELECT T1.template_type_code ,  count(*) FROM Templates AS T1 JOIN Documents AS T2 ON T1.template_id  =  T2.template_id GROUP BY T1.template_type_code
SELECT T1.template_type_code ,  count(*) FROM Templates AS T1 JOIN Documents AS T2 ON T1.template_id  =  T2.template_id GROUP BY T1.template_type_code
SELECT T1.template_type_code FROM Templates AS T1 JOIN Documents AS T2 ON T1.template_id  =  T2.template_id GROUP BY T1.template_type_code ORDER BY count(*) DESC LIMIT 1
SELECT T1.template_type_code FROM Templates AS T1 JOIN Documents AS T2 ON T1.template_id  =  T2.template_id GROUP BY T1.template_type_code ORDER BY count(*) DESC LIMIT 1
SELECT template_type_code ,  template_type_description FROM Ref_template_types
SELECT template_type_code ,  template_type_description FROM Ref_template_types
SELECT template_type_description FROM Ref_template_types WHERE template_type_code  =  "AD"
SELECT template_type_description FROM Ref_template_types WHERE template_type_code  =  "AD"
SELECT template_type_code FROM Ref_template_types WHERE template_type_description  =  "Book"
SELECT template_type_code FROM Ref_template_types WHERE template_type_description  =  "Book"
SELECT DISTINCT T1.template_type_description FROM Ref_template_types AS T1 JOIN Templates AS T2 ON T1.template_type_code  = T2.template_type_code JOIN Documents AS T3 ON T2.Template_ID  =  T3.template_ID
SELECT DISTINCT T1.template_type_description FROM Ref_template_types AS T1 JOIN Templates AS T2 ON T1.template_type_code  = T2.template_type_code JOIN Documents AS T3 ON T2.Template_ID  =  T3.template_ID
SELECT T2.template_id FROM Ref_template_types AS T1 JOIN Templates AS T2 ON T1.template_type_code  = T2.template_type_code WHERE T1.template_type_description  =  "Presentation"
SELECT T2.template_id FROM Ref_template_types AS T1 JOIN Templates AS T2 ON T1.template_type_code  = T2.template_type_code WHERE T1.template_type_description  =  "Presentation"
SELECT count(*) FROM Paragraphs
SELECT count(*) FROM Paragraphs
SELECT count(*) FROM Paragraphs AS T1 JOIN Documents AS T2 ON T1.document_ID  =  T2.document_ID WHERE T2.document_name  =  'Summer Show'
SELECT count(*) FROM Paragraphs AS T1 JOIN Documents AS T2 ON T1.document_ID  =  T2.document_ID WHERE T2.document_name  =  'Summer Show'
SELECT T1.paragraph_id ,   T1.paragraph_text FROM Paragraphs AS T1 JOIN Documents AS T2 ON T1.document_id  =  T2.document_id WHERE T2.Document_Name  =  'Welcome to NY'
SELECT T1.paragraph_id ,   T1.paragraph_text FROM Paragraphs AS T1 JOIN Documents AS T2 ON T1.document_id  =  T2.document_id WHERE T2.Document_Name  =  'Welcome to NY'
SELECT T1.paragraph_text FROM Paragraphs AS T1 JOIN Documents AS T2 ON T1.document_id  =  T2.document_id WHERE T2.document_name  =  "Customer reviews"
SELECT T1.paragraph_text FROM Paragraphs AS T1 JOIN Documents AS T2 ON T1.document_id  =  T2.document_id WHERE T2.document_name  =  "Customer reviews"
SELECT T1.document_id ,  T2.document_name ,  count(*) FROM Paragraphs AS T1 JOIN Documents AS T2 ON T1.document_id  =  T2.document_id GROUP BY T1.document_id
SELECT T1.document_id ,  T2.document_name ,  count(*) FROM Paragraphs AS T1 JOIN Documents AS T2 ON T1.document_id  =  T2.document_id GROUP BY T1.document_id
SELECT document_id FROM Paragraphs GROUP BY document_id HAVING count(*)  >=  2
SELECT document_id FROM Paragraphs GROUP BY document_id HAVING count(*)  >=  2
SELECT T1.document_id ,  T2.document_name FROM Paragraphs AS T1 JOIN Documents AS T2 ON T1.document_id  =  T2.document_id GROUP BY T1.document_id ORDER BY count(*) DESC LIMIT 1
SELECT T1.document_id ,  T2.document_name FROM Paragraphs AS T1 JOIN Documents AS T2 ON T1.document_id  =  T2.document_id GROUP BY T1.document_id ORDER BY count(*) DESC LIMIT 1
SELECT document_id FROM Paragraphs GROUP BY document_id ORDER BY count(*) ASC LIMIT 1
SELECT document_id FROM Paragraphs GROUP BY document_id ORDER BY count(*) ASC LIMIT 1
SELECT count(*) FROM teacher
SELECT count(*) FROM teacher
SELECT Name FROM teacher ORDER BY Age ASC
SELECT Name FROM teacher ORDER BY Age ASC
SELECT Age ,  Hometown FROM teacher
SELECT Age ,  Hometown FROM teacher
select name from teacher where hometown != "little lever urban district"
select name from teacher where hometown != "little lever urban district"
SELECT Name FROM teacher WHERE Age  =  32 OR Age  =  33
SELECT Name FROM teacher WHERE Age  =  32 OR Age  =  33
SELECT Hometown FROM teacher ORDER BY Age ASC LIMIT 1
SELECT Hometown FROM teacher ORDER BY Age ASC LIMIT 1
SELECT Hometown ,  COUNT(*) FROM teacher GROUP BY Hometown
SELECT Hometown ,  COUNT(*) FROM teacher GROUP BY Hometown
SELECT Hometown FROM teacher GROUP BY Hometown HAVING COUNT(*)  >=  2
SELECT Hometown FROM teacher GROUP BY Hometown HAVING COUNT(*)  >=  2
SELECT T3.Name ,  T2.Course FROM course_arrange AS T1 JOIN course AS T2 ON T1.Course_ID  =  T2.Course_ID JOIN teacher AS T3 ON T1.Teacher_ID  =  T3.Teacher_ID
SELECT T3.Name ,  T2.Course FROM course_arrange AS T1 JOIN course AS T2 ON T1.Course_ID  =  T2.Course_ID JOIN teacher AS T3 ON T1.Teacher_ID  =  T3.Teacher_ID
SELECT T3.Name ,  T2.Course FROM course_arrange AS T1 JOIN course AS T2 ON T1.Course_ID  =  T2.Course_ID JOIN teacher AS T3 ON T1.Teacher_ID  =  T3.Teacher_ID ORDER BY T3.Name
SELECT T3.Name ,  T2.Course FROM course_arrange AS T1 JOIN course AS T2 ON T1.Course_ID  =  T2.Course_ID JOIN teacher AS T3 ON T1.Teacher_ID  =  T3.Teacher_ID ORDER BY T3.Name
SELECT T3.Name FROM course_arrange AS T1 JOIN course AS T2 ON T1.Course_ID  =  T2.Course_ID JOIN teacher AS T3 ON T1.Teacher_ID  =  T3.Teacher_ID WHERE T2.Course  =  "Math"
SELECT T3.Name FROM course_arrange AS T1 JOIN course AS T2 ON T1.Course_ID  =  T2.Course_ID JOIN teacher AS T3 ON T1.Teacher_ID  =  T3.Teacher_ID WHERE T2.Course  =  "Math"
SELECT T2.Name ,  COUNT(*) FROM course_arrange AS T1 JOIN teacher AS T2 ON T1.Teacher_ID  =  T2.Teacher_ID GROUP BY T2.Name
SELECT T2.Name ,  COUNT(*) FROM course_arrange AS T1 JOIN teacher AS T2 ON T1.Teacher_ID  =  T2.Teacher_ID GROUP BY T2.Name
SELECT T2.Name FROM course_arrange AS T1 JOIN teacher AS T2 ON T1.Teacher_ID  =  T2.Teacher_ID GROUP BY T2.Name HAVING COUNT(*)  >=  2
SELECT T2.Name FROM course_arrange AS T1 JOIN teacher AS T2 ON T1.Teacher_ID  =  T2.Teacher_ID GROUP BY T2.Name HAVING COUNT(*)  >=  2
SELECT Name FROM teacher WHERE Teacher_id NOT IN (SELECT Teacher_id FROM course_arrange)
SELECT Name FROM teacher WHERE Teacher_id NOT IN (SELECT Teacher_id FROM course_arrange)
SELECT count(*) FROM visitor WHERE age  <  30
SELECT name FROM visitor WHERE Level_of_membership  >  4 ORDER BY Level_of_membership DESC
SELECT avg(age) FROM visitor WHERE Level_of_membership  <=  4
SELECT name ,  Level_of_membership FROM visitor WHERE Level_of_membership  >  4 ORDER BY age DESC
SELECT museum_id ,  name FROM museum ORDER BY num_of_staff DESC LIMIT 1
SELECT Num_of_Staff ,  Open_Year FROM museum WHERE name  =  'Plaza Museum'
SELECT first_name ,  birth_date FROM players WHERE country_code  =  'USA'
SELECT first_name ,  birth_date FROM players WHERE country_code  =  'USA'
SELECT tourney_name FROM matches GROUP BY tourney_name HAVING count(*)  >  10
SELECT tourney_name FROM matches GROUP BY tourney_name HAVING count(*)  >  10
SELECT first_name ,  country_code FROM players ORDER BY birth_date LIMIT 1
SELECT first_name ,  country_code FROM players ORDER BY birth_date LIMIT 1
SELECT first_name ,  last_name FROM players ORDER BY birth_date
SELECT first_name ,  last_name FROM players ORDER BY birth_date
SELECT first_name ,  last_name FROM players WHERE hand  =  'L' ORDER BY birth_date
SELECT first_name ,  last_name FROM players WHERE hand  =  'L' ORDER BY birth_date
SELECT T1.country_code ,  T1.first_name FROM players AS T1 JOIN rankings AS T2 ON T1.player_id  =  T2.player_id ORDER BY T2.tours DESC LIMIT 1
SELECT T1.country_code ,  T1.first_name FROM players AS T1 JOIN rankings AS T2 ON T1.player_id  =  T2.player_id ORDER BY T2.tours DESC LIMIT 1
SELECT YEAR FROM matches GROUP BY YEAR ORDER BY count(*) DESC LIMIT 1
SELECT YEAR FROM matches GROUP BY YEAR ORDER BY count(*) DESC LIMIT 1
SELECT winner_name ,  winner_rank_points FROM matches GROUP BY winner_name ORDER BY count(*) DESC LIMIT 1
SELECT winner_name ,  winner_rank_points FROM matches GROUP BY winner_name ORDER BY count(*) DESC LIMIT 1
SELECT winner_name FROM matches WHERE tourney_name  =  'Australian Open' ORDER BY winner_rank_points DESC LIMIT 1
SELECT winner_name FROM matches WHERE tourney_name  =  'Australian Open' ORDER BY winner_rank_points DESC LIMIT 1
SELECT winner_name ,  loser_name FROM matches ORDER BY minutes DESC LIMIT 1
SELECT winner_name ,  loser_name FROM matches ORDER BY minutes DESC LIMIT 1
SELECT avg(ranking) ,  T1.first_name FROM players AS T1 JOIN rankings AS T2 ON T1.player_id  =  T2.player_id GROUP BY T1.first_name
SELECT avg(ranking) ,  T1.first_name FROM players AS T1 JOIN rankings AS T2 ON T1.player_id  =  T2.player_id GROUP BY T1.first_name
SELECT count(*) ,  country_code FROM players GROUP BY country_code
SELECT count(*) ,  country_code FROM players GROUP BY country_code
SELECT country_code FROM players GROUP BY country_code ORDER BY count(*) DESC LIMIT 1
SELECT country_code FROM players GROUP BY country_code ORDER BY count(*) DESC LIMIT 1
SELECT country_code FROM players GROUP BY country_code HAVING count(*)  >  50
SELECT country_code FROM players GROUP BY country_code HAVING count(*)  >  50
SELECT count(*) ,  YEAR FROM matches GROUP BY YEAR
SELECT count(*) ,  YEAR FROM matches GROUP BY YEAR
SELECT T1.first_name ,  T1.country_code ,  T1.birth_date FROM players AS T1 JOIN matches AS T2 ON T1.player_id  =  T2.winner_id ORDER BY T2.winner_rank_points DESC LIMIT 1
SELECT T1.first_name ,  T1.country_code ,  T1.birth_date FROM players AS T1 JOIN matches AS T2 ON T1.player_id  =  T2.winner_id ORDER BY T2.winner_rank_points DESC LIMIT 1
SELECT count(*) ,  hand FROM players GROUP BY hand
SELECT count(*) ,  hand FROM players GROUP BY hand
SELECT count(*) FROM ship WHERE disposition_of_ship  =  'Captured'
SELECT name ,  tonnage FROM ship ORDER BY name DESC
SELECT max(killed) ,  min(killed) FROM death
SELECT name ,  RESULT FROM battle WHERE bulgarian_commander != 'Boril'
SELECT DISTINCT T1.id ,  T1.name FROM battle AS T1 JOIN ship AS T2 ON T1.id  =  T2.lost_in_battle WHERE T2.ship_type  =  'Brig'
SELECT name FROM battle WHERE bulgarian_commander  =  'Kaloyan' AND latin_commander  =  'Baldwin I'
SELECT count(DISTINCT RESULT) FROM battle
SELECT note FROM death WHERE note LIKE '%East%'
SELECT line_1 ,  line_2 FROM addresses
SELECT line_1 ,  line_2 FROM addresses
SELECT count(*) FROM Courses
SELECT count(*) FROM Courses
SELECT course_description FROM Courses WHERE course_name  =  'math'
SELECT course_description FROM Courses WHERE course_name  =  'math'
SELECT zip_postcode FROM Addresses WHERE city  =  'Port Chelsea'
SELECT zip_postcode FROM Addresses WHERE city  =  'Port Chelsea'
SELECT T2.department_name ,  T1.department_id FROM Degree_Programs AS T1 JOIN Departments AS T2 ON T1.department_id  =  T2.department_id GROUP BY T1.department_id ORDER BY count(*) DESC LIMIT 1
SELECT count(DISTINCT department_id) FROM Degree_Programs
SELECT count(DISTINCT department_id) FROM Degree_Programs
SELECT count(DISTINCT degree_summary_name) FROM Degree_Programs
SELECT count(DISTINCT degree_summary_name) FROM Degree_Programs
SELECT count(*) FROM Departments AS T1 JOIN Degree_Programs AS T2 ON T1.department_id  =  T2.department_id WHERE T1.department_name  =  'engineer'
SELECT count(*) FROM Departments AS T1 JOIN Degree_Programs AS T2 ON T1.department_id  =  T2.department_id WHERE T1.department_name  =  'engineer'
SELECT section_name ,  section_description FROM Sections
SELECT section_name ,  section_description FROM Sections
SELECT T1.course_name ,  T1.course_id FROM Courses AS T1 JOIN Sections AS T2 ON T1.course_id  =  T2.course_id GROUP BY T1.course_id HAVING count(*)  <=  2
SELECT T1.course_name ,  T1.course_id FROM Courses AS T1 JOIN Sections AS T2 ON T1.course_id  =  T2.course_id GROUP BY T1.course_id HAVING count(*)  <=  2
SELECT section_name FROM Sections ORDER BY section_name DESC
SELECT section_name FROM Sections ORDER BY section_name DESC
SELECT T1.semester_name ,  T1.semester_id FROM Semesters AS T1 JOIN Student_Enrolment AS T2 ON T1.semester_id  =  T2.semester_id GROUP BY T1.semester_id ORDER BY count(*) DESC LIMIT 1
SELECT T1.semester_name ,  T1.semester_id FROM Semesters AS T1 JOIN Student_Enrolment AS T2 ON T1.semester_id  =  T2.semester_id GROUP BY T1.semester_id ORDER BY count(*) DESC LIMIT 1
SELECT department_description FROM Departments WHERE department_name LIKE '%computer%'
SELECT department_description FROM Departments WHERE department_name LIKE '%computer%'
SELECT T1.first_name ,  T1.middle_name ,  T1.last_name ,  T1.student_id FROM Students AS T1 JOIN Student_Enrolment AS T2 ON T1.student_id  =  T2.student_id GROUP BY T1.student_id HAVING count(*)  =  2
SELECT T1.first_name ,  T1.middle_name ,  T1.last_name ,  T1.student_id FROM Students AS T1 JOIN Student_Enrolment AS T2 ON T1.student_id  =  T2.student_id GROUP BY T1.student_id HAVING count(*)  =  2
SELECT DISTINCT T1.first_name ,  T1.middle_name ,  T1.last_name FROM Students AS T1 JOIN Student_Enrolment AS T2 ON T1.student_id  =  T2.student_id JOIN Degree_Programs AS T3 ON T2.degree_program_id  =  T3.degree_program_id WHERE T3.degree_summary_name  =  'Bachelor'
SELECT DISTINCT T1.first_name ,  T1.middle_name ,  T1.last_name FROM Students AS T1 JOIN Student_Enrolment AS T2 ON T1.student_id  =  T2.student_id JOIN Degree_Programs AS T3 ON T2.degree_program_id  =  T3.degree_program_id WHERE T3.degree_summary_name  =  'Bachelor'
SELECT T1.degree_summary_name FROM Degree_Programs AS T1 JOIN Student_Enrolment AS T2 ON T1.degree_program_id  =  T2.degree_program_id GROUP BY T1.degree_summary_name ORDER BY count(*) DESC LIMIT 1
SELECT T1.degree_summary_name FROM Degree_Programs AS T1 JOIN Student_Enrolment AS T2 ON T1.degree_program_id  =  T2.degree_program_id GROUP BY T1.degree_summary_name ORDER BY count(*) DESC LIMIT 1
SELECT T1.degree_program_id ,  T1.degree_summary_name FROM Degree_Programs AS T1 JOIN Student_Enrolment AS T2 ON T1.degree_program_id  =  T2.degree_program_id GROUP BY T1.degree_program_id ORDER BY count(*) DESC LIMIT 1
SELECT T1.degree_program_id ,  T1.degree_summary_name FROM Degree_Programs AS T1 JOIN Student_Enrolment AS T2 ON T1.degree_program_id  =  T2.degree_program_id GROUP BY T1.degree_program_id ORDER BY count(*) DESC LIMIT 1
SELECT semester_name FROM Semesters WHERE semester_id NOT IN( SELECT semester_id FROM Student_Enrolment )
SELECT semester_name FROM Semesters WHERE semester_id NOT IN( SELECT semester_id FROM Student_Enrolment )
SELECT DISTINCT T1.course_name FROM Courses AS T1 JOIN Student_Enrolment_Courses AS T2 ON T1.course_id  =  T2.course_id
SELECT DISTINCT T1.course_name FROM Courses AS T1 JOIN Student_Enrolment_Courses AS T2 ON T1.course_id  =  T2.course_id
SELECT  T1.course_name FROM Courses AS T1 JOIN Student_Enrolment_Courses AS T2 ON T1.course_id  =  T2.course_id GROUP BY T1.course_name ORDER BY count(*) DESC LIMIT 1
SELECT  T1.course_name FROM Courses AS T1 JOIN Student_Enrolment_Courses AS T2 ON T1.course_id  =  T2.course_id GROUP BY T1.course_name ORDER BY count(*) DESC LIMIT 1
SELECT T2.transcript_date ,  T1.transcript_id FROM Transcript_Contents AS T1 JOIN Transcripts AS T2 ON T1.transcript_id  =  T2.transcript_id GROUP BY T1.transcript_id HAVING count(*)  >=  2
SELECT T2.transcript_date ,  T1.transcript_id FROM Transcript_Contents AS T1 JOIN Transcripts AS T2 ON T1.transcript_id  =  T2.transcript_id GROUP BY T1.transcript_id HAVING count(*)  >=  2
SELECT cell_mobile_number FROM Students WHERE first_name  =  'Timmothy' AND last_name  =  'Ward'
select cell_mobile_number from students where first_name  =  'timmothy' and last_name  =  'ward'
SELECT first_name ,  middle_name ,  last_name FROM Students ORDER BY date_first_registered ASC LIMIT 1
SELECT first_name ,  middle_name ,  last_name FROM Students ORDER BY date_first_registered ASC LIMIT 1
SELECT first_name ,  middle_name ,  last_name FROM Students ORDER BY date_left ASC LIMIT 1
SELECT first_name ,  middle_name ,  last_name FROM Students ORDER BY date_left ASC LIMIT 1
SELECT first_name FROM Students WHERE current_address_id != permanent_address_id
SELECT first_name FROM Students WHERE current_address_id != permanent_address_id
SELECT T1.address_id ,  T1.line_1 ,  T1.line_2 FROM Addresses AS T1 JOIN Students AS T2 ON T1.address_id  =  T2.current_address_id GROUP BY T1.address_id ORDER BY count(*) DESC LIMIT 1
SELECT T1.address_id ,  T1.line_1 ,  T1.line_2 FROM Addresses AS T1 JOIN Students AS T2 ON T1.address_id  =  T2.current_address_id GROUP BY T1.address_id ORDER BY count(*) DESC LIMIT 1
SELECT transcript_date ,  other_details FROM Transcripts ORDER BY transcript_date ASC LIMIT 1
SELECT transcript_date ,  other_details FROM Transcripts ORDER BY transcript_date ASC LIMIT 1
SELECT count(*) FROM Transcripts
SELECT count(*) FROM Transcripts
SELECT transcript_date FROM Transcripts ORDER BY transcript_date DESC LIMIT 1
SELECT transcript_date FROM Transcripts ORDER BY transcript_date DESC LIMIT 1
SELECT count(*) ,  student_course_id FROM Transcript_Contents GROUP BY student_course_id ORDER BY count(*) DESC LIMIT 1
SELECT count(*) ,  student_course_id FROM Transcript_Contents GROUP BY student_course_id ORDER BY count(*) DESC LIMIT 1
SELECT T2.transcript_date ,  T1.transcript_id FROM Transcript_Contents AS T1 JOIN Transcripts AS T2 ON T1.transcript_id  =  T2.transcript_id GROUP BY T1.transcript_id ORDER BY count(*) ASC LIMIT 1
SELECT T2.transcript_date ,  T1.transcript_id FROM Transcript_Contents AS T1 JOIN Transcripts AS T2 ON T1.transcript_id  =  T2.transcript_id GROUP BY T1.transcript_id ORDER BY count(*) ASC LIMIT 1
SELECT count(DISTINCT current_address_id) FROM Students
SELECT count(DISTINCT current_address_id) FROM Students
SELECT other_student_details FROM Students ORDER BY other_student_details DESC
SELECT other_student_details FROM Students ORDER BY other_student_details DESC
SELECT section_description FROM Sections WHERE section_name  =  'h'
SELECT section_description FROM Sections WHERE section_name  =  'h'
SELECT Title FROM Cartoon ORDER BY title
SELECT Title FROM Cartoon ORDER BY title
SELECT Title FROM Cartoon WHERE Directed_by = "Ben Jones";
SELECT Title FROM Cartoon WHERE Directed_by = "Ben Jones";
SELECT count(*) FROM Cartoon WHERE Written_by = "Joseph Kuhr";
SELECT count(*) FROM Cartoon WHERE Written_by = "Joseph Kuhr";
SELECT title ,  Directed_by FROM Cartoon ORDER BY Original_air_date
SELECT title ,  Directed_by FROM Cartoon ORDER BY Original_air_date
SELECT Title FROM Cartoon WHERE Directed_by = "Ben Jones" OR Directed_by = "Brandon Vietti";
SELECT Title FROM Cartoon WHERE Directed_by = "Ben Jones" OR Directed_by = "Brandon Vietti";
SELECT Country ,  count(*) FROM TV_Channel GROUP BY Country ORDER BY count(*) DESC LIMIT 1;
SELECT Country ,  count(*) FROM TV_Channel GROUP BY Country ORDER BY count(*) DESC LIMIT 1;
SELECT count(DISTINCT series_name) ,  count(DISTINCT content) FROM TV_Channel;
SELECT count(DISTINCT series_name) ,  count(DISTINCT content) FROM TV_Channel;
SELECT Content FROM TV_Channel WHERE series_name = "Sky Radio";
SELECT Content FROM TV_Channel WHERE series_name = "Sky Radio";
SELECT Package_Option FROM TV_Channel WHERE series_name = "Sky Radio";
SELECT Package_Option FROM TV_Channel WHERE series_name = "Sky Radio";
SELECT count(*) FROM TV_Channel WHERE LANGUAGE = "English";
SELECT count(*) FROM TV_Channel WHERE LANGUAGE = "English";
SELECT LANGUAGE ,  count(*) FROM TV_Channel GROUP BY LANGUAGE ORDER BY count(*) ASC LIMIT 1;
SELECT LANGUAGE ,  count(*) FROM TV_Channel GROUP BY LANGUAGE ORDER BY count(*) ASC LIMIT 1;
SELECT LANGUAGE ,  count(*) FROM TV_Channel GROUP BY LANGUAGE
SELECT LANGUAGE ,  count(*) FROM TV_Channel GROUP BY LANGUAGE
SELECT T1.series_name FROM TV_Channel AS T1 JOIN Cartoon AS T2 ON T1.id = T2.Channel WHERE T2.Title = "The Rise of the Blue Beetle!";
SELECT T1.series_name FROM TV_Channel AS T1 JOIN Cartoon AS T2 ON T1.id = T2.Channel WHERE T2.Title = "The Rise of the Blue Beetle!";
SELECT T2.Title FROM TV_Channel AS T1 JOIN Cartoon AS T2 ON T1.id = T2.Channel WHERE T1.series_name = "Sky Radio";
SELECT T2.Title FROM TV_Channel AS T1 JOIN Cartoon AS T2 ON T1.id = T2.Channel WHERE T1.series_name = "Sky Radio";
SELECT Episode FROM TV_series ORDER BY rating
SELECT Episode FROM TV_series ORDER BY rating
SELECT Episode ,  Rating FROM TV_series ORDER BY Rating DESC LIMIT 3;
SELECT Episode ,  Rating FROM TV_series ORDER BY Rating DESC LIMIT 3;
SELECT max(SHARE) , min(SHARE) FROM TV_series;
SELECT max(SHARE) , min(SHARE) FROM TV_series;
SELECT Air_Date FROM TV_series WHERE Episode = "A Love of a Lifetime";
SELECT Air_Date FROM TV_series WHERE Episode = "A Love of a Lifetime";
SELECT Weekly_Rank FROM TV_series WHERE Episode = "A Love of a Lifetime";
SELECT Weekly_Rank FROM TV_series WHERE Episode = "A Love of a Lifetime";
SELECT T1.series_name FROM TV_Channel AS T1 JOIN TV_series AS T2 ON T1.id = T2.Channel WHERE T2.Episode = "A Love of a Lifetime";
SELECT T1.series_name FROM TV_Channel AS T1 JOIN TV_series AS T2 ON T1.id = T2.Channel WHERE T2.Episode = "A Love of a Lifetime";
SELECT T2.Episode FROM TV_Channel AS T1 JOIN TV_series AS T2 ON T1.id = T2.Channel WHERE T1.series_name = "Sky Radio";
SELECT T2.Episode FROM TV_Channel AS T1 JOIN TV_series AS T2 ON T1.id = T2.Channel WHERE T1.series_name = "Sky Radio";
SELECT count(*) ,  Directed_by FROM cartoon GROUP BY Directed_by
SELECT count(*) ,  Directed_by FROM cartoon GROUP BY Directed_by
select production_code ,  channel from cartoon order by original_air_date desc limit 1
select production_code ,  channel from cartoon order by original_air_date desc limit 1
SELECT package_option ,  series_name FROM TV_Channel WHERE hight_definition_TV  =  "yes"
SELECT package_option ,  series_name FROM TV_Channel WHERE hight_definition_TV  =  "yes"
SELECT T1.country FROM TV_Channel AS T1 JOIN cartoon AS T2 ON T1.id = T2.Channel WHERE T2.written_by  =  'Todd Casey'
SELECT T1.country FROM TV_Channel AS T1 JOIN cartoon AS T2 ON T1.id = T2.Channel WHERE T2.written_by  =  'Todd Casey'
SELECT Pixel_aspect_ratio_PAR ,  country FROM tv_channel WHERE LANGUAGE != 'English'
SELECT Pixel_aspect_ratio_PAR ,  country FROM tv_channel WHERE LANGUAGE != 'English'
SELECT id FROM tv_channel GROUP BY country HAVING count(*)  >  2
SELECT id FROM tv_channel GROUP BY country HAVING count(*)  >  2
SELECT count(*) FROM poker_player
SELECT count(*) FROM poker_player
SELECT Earnings FROM poker_player ORDER BY Earnings DESC
SELECT Earnings FROM poker_player ORDER BY Earnings DESC
SELECT Final_Table_Made ,  Best_Finish FROM poker_player
SELECT Final_Table_Made ,  Best_Finish FROM poker_player
SELECT avg(Earnings) FROM poker_player
SELECT avg(Earnings) FROM poker_player
SELECT Money_Rank FROM poker_player ORDER BY Earnings DESC LIMIT 1
SELECT Money_Rank FROM poker_player ORDER BY Earnings DESC LIMIT 1
SELECT max(Final_Table_Made) FROM poker_player WHERE Earnings  <  200000
SELECT max(Final_Table_Made) FROM poker_player WHERE Earnings  <  200000
SELECT T1.Name FROM people AS T1 JOIN poker_player AS T2 ON T1.People_ID  =  T2.People_ID
SELECT T1.Name FROM people AS T1 JOIN poker_player AS T2 ON T1.People_ID  =  T2.People_ID
SELECT T1.Name FROM people AS T1 JOIN poker_player AS T2 ON T1.People_ID  =  T2.People_ID WHERE T2.Earnings  >  300000
SELECT T1.Name FROM people AS T1 JOIN poker_player AS T2 ON T1.People_ID  =  T2.People_ID WHERE T2.Earnings  >  300000
SELECT T1.Name FROM people AS T1 JOIN poker_player AS T2 ON T1.People_ID  =  T2.People_ID ORDER BY T2.Final_Table_Made
SELECT T1.Name FROM people AS T1 JOIN poker_player AS T2 ON T1.People_ID  =  T2.People_ID ORDER BY T2.Final_Table_Made
SELECT T1.Birth_Date FROM people AS T1 JOIN poker_player AS T2 ON T1.People_ID  =  T2.People_ID ORDER BY T2.Earnings ASC LIMIT 1
SELECT T1.Birth_Date FROM people AS T1 JOIN poker_player AS T2 ON T1.People_ID  =  T2.People_ID ORDER BY T2.Earnings ASC LIMIT 1
SELECT T2.Money_Rank FROM people AS T1 JOIN poker_player AS T2 ON T1.People_ID  =  T2.People_ID ORDER BY T1.Height DESC LIMIT 1
SELECT T2.Money_Rank FROM people AS T1 JOIN poker_player AS T2 ON T1.People_ID  =  T2.People_ID ORDER BY T1.Height DESC LIMIT 1
SELECT avg(T2.Earnings) FROM people AS T1 JOIN poker_player AS T2 ON T1.People_ID  =  T2.People_ID WHERE T1.Height  >  200
SELECT avg(T2.Earnings) FROM people AS T1 JOIN poker_player AS T2 ON T1.People_ID  =  T2.People_ID WHERE T1.Height  >  200
SELECT T1.Name FROM people AS T1 JOIN poker_player AS T2 ON T1.People_ID  =  T2.People_ID ORDER BY T2.Earnings DESC
SELECT T1.Name FROM people AS T1 JOIN poker_player AS T2 ON T1.People_ID  =  T2.People_ID ORDER BY T2.Earnings DESC
SELECT Nationality ,  COUNT(*) FROM people GROUP BY Nationality
SELECT Nationality ,  COUNT(*) FROM people GROUP BY Nationality
SELECT Nationality FROM people GROUP BY Nationality ORDER BY COUNT(*) DESC LIMIT 1
SELECT Nationality FROM people GROUP BY Nationality ORDER BY COUNT(*) DESC LIMIT 1
SELECT Nationality FROM people GROUP BY Nationality HAVING COUNT(*)  >=  2
SELECT Nationality FROM people GROUP BY Nationality HAVING COUNT(*)  >=  2
SELECT Name ,  Birth_Date FROM people ORDER BY Name ASC
SELECT Name ,  Birth_Date FROM people ORDER BY Name ASC
SELECT Name FROM people WHERE Nationality != "Russia"
SELECT Name FROM people WHERE Nationality != "Russia"
SELECT Name FROM people WHERE People_ID NOT IN (SELECT People_ID FROM poker_player)
SELECT Name FROM people WHERE People_ID NOT IN (SELECT People_ID FROM poker_player)
SELECT count(DISTINCT Nationality) FROM people
SELECT count(DISTINCT Nationality) FROM people
SELECT count(*) FROM area_code_state
SELECT contestant_number ,  contestant_name FROM contestants ORDER BY contestant_name DESC
SELECT vote_id ,  phone_number ,  state FROM votes
SELECT max(area_code) ,  min(area_code) FROM area_code_state
SELECT max(created) FROM votes WHERE state  =  'CA'
SELECT contestant_name FROM contestants WHERE contestant_name != 'Jessie Alloway'
SELECT DISTINCT state ,  created FROM votes
SELECT T1.contestant_number , T1.contestant_name FROM contestants AS T1 JOIN votes AS T2 ON T1.contestant_number  =  T2.contestant_number GROUP BY T1.contestant_number HAVING count(*)  >=  2
SELECT T1.contestant_number , T1.contestant_name FROM contestants AS T1 JOIN votes AS T2 ON T1.contestant_number  =  T2.contestant_number GROUP BY T1.contestant_number ORDER BY count(*) ASC LIMIT 1
SELECT count(*) FROM votes WHERE state  =  'NY' OR state  =  'CA'
SELECT T1.area_code FROM area_code_state AS T1 JOIN votes AS T2 ON T1.state  =  T2.state GROUP BY T1.area_code ORDER BY count(*) DESC LIMIT 1
SELECT T2.created ,  T2.state ,  T2.phone_number FROM contestants AS T1 JOIN votes AS T2 ON T1.contestant_number  =  T2.contestant_number WHERE T1.contestant_name  =  'Tabatha Gehling'
select contestant_name from contestants where contestant_name like "%al%"
SELECT Name FROM country WHERE IndepYear  >  1950
SELECT Name FROM country WHERE IndepYear  >  1950
SELECT Continent FROM country WHERE Name  =  "Anguilla"
SELECT Continent FROM country WHERE Name  =  "Anguilla"
SELECT Region FROM country AS T1 JOIN city AS T2 ON T1.Code  =  T2.CountryCode WHERE T2.Name  =  "Kabul"
SELECT Region FROM country AS T1 JOIN city AS T2 ON T1.Code  =  T2.CountryCode WHERE T2.Name  =  "Kabul"
SELECT T2.Language FROM country AS T1 JOIN countrylanguage AS T2 ON T1.Code  =  T2.CountryCode WHERE T1.Name  =  "Aruba" ORDER BY Percentage DESC LIMIT 1
SELECT T2.Language FROM country AS T1 JOIN countrylanguage AS T2 ON T1.Code  =  T2.CountryCode WHERE T1.Name  =  "Aruba" ORDER BY Percentage DESC LIMIT 1
SELECT Population ,  LifeExpectancy FROM country WHERE Name  =  "Brazil"
SELECT Population ,  LifeExpectancy FROM country WHERE Name  =  "Brazil"
SELECT Population ,  Region FROM country WHERE Name  =  "Angola"
SELECT Population ,  Region FROM country WHERE Name  =  "Angola"
SELECT Name FROM country WHERE Continent  =  "Asia" ORDER BY LifeExpectancy LIMIT 1
SELECT Name FROM country WHERE Continent  =  "Asia" ORDER BY LifeExpectancy LIMIT 1
SELECT T1.Name FROM country AS T1 JOIN countrylanguage AS T2 ON T1.Code  =  T2.CountryCode GROUP BY T1.Name ORDER BY COUNT(*) DESC LIMIT 1
SELECT T1.Name FROM country AS T1 JOIN countrylanguage AS T2 ON T1.Code  =  T2.CountryCode GROUP BY T1.Name ORDER BY COUNT(*) DESC LIMIT 1
SELECT T1.Continent FROM country AS T1 JOIN countrylanguage AS T2 ON T1.Code  =  T2.CountryCode GROUP BY T1.Continent ORDER BY COUNT(*) DESC LIMIT 1
SELECT T1.Continent FROM country AS T1 JOIN countrylanguage AS T2 ON T1.Code  =  T2.CountryCode GROUP BY T1.Continent ORDER BY COUNT(*) DESC LIMIT 1
SELECT DISTINCT T1.Region FROM country AS T1 JOIN countrylanguage AS T2 ON T1.Code  =  T2.CountryCode WHERE T2.Language  =  "English" OR T2.Language  =  "Dutch"
SELECT DISTINCT T1.Region FROM country AS T1 JOIN countrylanguage AS T2 ON T1.Code  =  T2.CountryCode WHERE T2.Language  =  "English" OR T2.Language  =  "Dutch"
SELECT T2.Language FROM country AS T1 JOIN countrylanguage AS T2 ON T1.Code  =  T2.CountryCode WHERE T1.Continent  =  "Asia" GROUP BY T2.Language ORDER BY COUNT (*) DESC LIMIT 1
SELECT T2.Language FROM country AS T1 JOIN countrylanguage AS T2 ON T1.Code  =  T2.CountryCode WHERE T1.Continent  =  "Asia" GROUP BY T2.Language ORDER BY COUNT (*) DESC LIMIT 1
SELECT T2.Language FROM country AS T1 JOIN countrylanguage AS T2 ON T1.Code  =  T2.CountryCode WHERE T1.GovernmentForm  =  "Republic" GROUP BY T2.Language HAVING COUNT(*)  =  1
SELECT T2.Language FROM country AS T1 JOIN countrylanguage AS T2 ON T1.Code  =  T2.CountryCode WHERE T1.GovernmentForm  =  "Republic" GROUP BY T2.Language HAVING COUNT(*)  =  1
SELECT T1.Name ,  T1.Population FROM city AS T1 JOIN countrylanguage AS T2 ON T1.CountryCode  =  T2.CountryCode WHERE T2.Language  =  "English" ORDER BY T1.Population DESC LIMIT 1
SELECT T1.Name ,  T1.Population FROM city AS T1 JOIN countrylanguage AS T2 ON T1.CountryCode  =  T2.CountryCode WHERE T2.Language  =  "English" ORDER BY T1.Population DESC LIMIT 1
SELECT Name ,  Population ,  LifeExpectancy FROM country WHERE Continent  =  "Asia" ORDER BY SurfaceArea DESC LIMIT 1
SELECT Name ,  Population ,  LifeExpectancy FROM country WHERE Continent  =  "Asia" ORDER BY SurfaceArea DESC LIMIT 1
SELECT T2.Language FROM country AS T1 JOIN countrylanguage AS T2 ON T1.Code  =  T2.CountryCode WHERE T1.HeadOfState  =  "Beatrix" AND T2.IsOfficial  =  "T"
SELECT T2.Language FROM country AS T1 JOIN countrylanguage AS T2 ON T1.Code  =  T2.CountryCode WHERE T1.HeadOfState  =  "Beatrix" AND T2.IsOfficial  =  "T"
SELECT DISTINCT CountryCode FROM countrylanguage WHERE LANGUAGE != "English"
SELECT DISTINCT CountryCode FROM countrylanguage WHERE LANGUAGE != "English"
SELECT DISTINCT T3.Name FROM country AS T1 JOIN countrylanguage AS T2 ON T1.Code  =  T2.CountryCode JOIN city AS T3 ON T1.Code  =  T3.CountryCode WHERE T2.IsOfficial  =  'T' AND T2.Language  =  'Chinese' AND T1.Continent  =  "Asia"
SELECT Name ,  SurfaceArea ,  IndepYear FROM country ORDER BY Population LIMIT 1
SELECT Name ,  SurfaceArea ,  IndepYear FROM country ORDER BY Population LIMIT 1
SELECT Name ,  population ,  HeadOfState FROM country ORDER BY SurfaceArea DESC LIMIT 1
SELECT Name ,  population ,  HeadOfState FROM country ORDER BY SurfaceArea DESC LIMIT 1
SELECT COUNT(T2.Language) ,  T1.Name FROM country AS T1 JOIN countrylanguage AS T2 ON T1.Code  =  T2.CountryCode GROUP BY T1.Name HAVING COUNT(*)  >  2
SELECT COUNT(T2.Language) ,  T1.Name FROM country AS T1 JOIN countrylanguage AS T2 ON T1.Code  =  T2.CountryCode GROUP BY T1.Name HAVING COUNT(*)  >  2
SELECT Name ,  SurfaceArea FROM country ORDER BY SurfaceArea DESC LIMIT 5
SELECT Name ,  SurfaceArea FROM country ORDER BY SurfaceArea DESC LIMIT 5
SELECT Name FROM country ORDER BY Population DESC LIMIT 3
SELECT Name FROM country ORDER BY Population DESC LIMIT 3
SELECT Name FROM country ORDER BY Population ASC LIMIT 3
SELECT Name FROM country ORDER BY Population ASC LIMIT 3
SELECT Name FROM country WHERE continent  =  "Europe" AND Population  =  "80000"
SELECT Name FROM country WHERE continent  =  "Europe" AND Population  =  "80000"
SELECT name FROM city WHERE Population BETWEEN 160000 AND 900000
select name from city where population between 160000 and 900000
SELECT LANGUAGE FROM countrylanguage GROUP BY LANGUAGE ORDER BY count(*) DESC LIMIT 1
SELECT LANGUAGE FROM countrylanguage GROUP BY LANGUAGE ORDER BY count(*) DESC LIMIT 1
SELECT LANGUAGE ,  CountryCode ,  max(Percentage) FROM countrylanguage GROUP BY CountryCode
SELECT LANGUAGE ,  CountryCode ,  max(Percentage) FROM countrylanguage GROUP BY CountryCode
SELECT CountryCode ,  max(Percentage) FROM countrylanguage WHERE LANGUAGE  =  "Spanish" GROUP BY CountryCode
SELECT CountryCode ,  max(Percentage) FROM countrylanguage WHERE LANGUAGE  =  "Spanish" GROUP BY CountryCode
SELECT count(*) FROM conductor
SELECT count(*) FROM conductor
SELECT Name FROM conductor ORDER BY Age ASC
SELECT Name FROM conductor ORDER BY Age ASC
SELECT Name FROM conductor WHERE Nationality != 'USA'
SELECT Name FROM conductor WHERE Nationality != 'USA'
SELECT Record_Company FROM orchestra ORDER BY Year_of_Founded DESC
SELECT Record_Company FROM orchestra ORDER BY Year_of_Founded DESC
SELECT avg(Attendance) FROM SHOW
SELECT avg(Attendance) FROM SHOW
SELECT max(SHARE) ,  min(SHARE) FROM performance WHERE TYPE != "Live final"
SELECT max(SHARE) ,  min(SHARE) FROM performance WHERE TYPE != "Live final"
SELECT count(DISTINCT Nationality) FROM conductor
SELECT count(DISTINCT Nationality) FROM conductor
SELECT Name FROM conductor ORDER BY Year_of_Work DESC
SELECT Name FROM conductor ORDER BY Year_of_Work DESC
SELECT Name FROM conductor ORDER BY Year_of_Work DESC LIMIT 1
SELECT Name FROM conductor ORDER BY Year_of_Work DESC LIMIT 1
SELECT T1.Name ,  T2.Orchestra FROM conductor AS T1 JOIN orchestra AS T2 ON T1.Conductor_ID  =  T2.Conductor_ID
SELECT T1.Name ,  T2.Orchestra FROM conductor AS T1 JOIN orchestra AS T2 ON T1.Conductor_ID  =  T2.Conductor_ID
SELECT T1.Name FROM conductor AS T1 JOIN orchestra AS T2 ON T1.Conductor_ID  =  T2.Conductor_ID GROUP BY T2.Conductor_ID HAVING COUNT(*)  >  1
SELECT T1.Name FROM conductor AS T1 JOIN orchestra AS T2 ON T1.Conductor_ID  =  T2.Conductor_ID GROUP BY T2.Conductor_ID HAVING COUNT(*)  >  1
SELECT T1.Name FROM conductor AS T1 JOIN orchestra AS T2 ON T1.Conductor_ID  =  T2.Conductor_ID WHERE Year_of_Founded  >  2008
SELECT T1.Name FROM conductor AS T1 JOIN orchestra AS T2 ON T1.Conductor_ID  =  T2.Conductor_ID WHERE Year_of_Founded  >  2008
SELECT Record_Company ,  COUNT(*) FROM orchestra GROUP BY Record_Company
SELECT Record_Company ,  COUNT(*) FROM orchestra GROUP BY Record_Company
SELECT Major_Record_Format FROM orchestra GROUP BY Major_Record_Format ORDER BY COUNT(*) ASC
SELECT Major_Record_Format FROM orchestra GROUP BY Major_Record_Format ORDER BY COUNT(*) ASC
SELECT Record_Company FROM orchestra GROUP BY Record_Company ORDER BY COUNT(*) DESC LIMIT 1
SELECT Record_Company FROM orchestra GROUP BY Record_Company ORDER BY COUNT(*) DESC LIMIT 1
SELECT Orchestra FROM orchestra WHERE Orchestra_ID NOT IN (SELECT Orchestra_ID FROM performance)
SELECT Orchestra FROM orchestra WHERE Orchestra_ID NOT IN (SELECT Orchestra_ID FROM performance)
SELECT COUNT(*) FROM orchestra WHERE Major_Record_Format  =  "CD" OR Major_Record_Format  =  "DVD"
SELECT COUNT(*) FROM orchestra WHERE Major_Record_Format  =  "CD" OR Major_Record_Format  =  "DVD"
SELECT count(*) FROM Highschooler
SELECT count(*) FROM Highschooler
SELECT name ,  grade FROM Highschooler
SELECT name ,  grade FROM Highschooler
SELECT grade FROM Highschooler
SELECT grade FROM Highschooler
SELECT grade FROM Highschooler WHERE name  =  "Kyle"
SELECT grade FROM Highschooler WHERE name  =  "Kyle"
SELECT name FROM Highschooler WHERE grade  =  10
SELECT name FROM Highschooler WHERE grade  =  10
SELECT ID FROM Highschooler WHERE name  =  "Kyle"
SELECT ID FROM Highschooler WHERE name  =  "Kyle"
SELECT count(*) FROM Highschooler WHERE grade  =  9 OR grade  =  10
SELECT count(*) FROM Highschooler WHERE grade  =  9 OR grade  =  10
SELECT grade ,  count(*) FROM Highschooler GROUP BY grade
SELECT grade ,  count(*) FROM Highschooler GROUP BY grade
SELECT grade FROM Highschooler GROUP BY grade HAVING count(*)  >=  4
SELECT grade FROM Highschooler GROUP BY grade HAVING count(*)  >=  4
SELECT student_id ,  count(*) FROM Friend GROUP BY student_id
SELECT student_id ,  count(*) FROM Friend GROUP BY student_id
SELECT T2.name ,  count(*) FROM Friend AS T1 JOIN Highschooler AS T2 ON T1.student_id  =  T2.id GROUP BY T1.student_id
SELECT T2.name ,  count(*) FROM Friend AS T1 JOIN Highschooler AS T2 ON T1.student_id  =  T2.id GROUP BY T1.student_id
SELECT T2.name FROM Friend AS T1 JOIN Highschooler AS T2 ON T1.student_id  =  T2.id GROUP BY T1.student_id ORDER BY count(*) DESC LIMIT 1
SELECT T2.name FROM Friend AS T1 JOIN Highschooler AS T2 ON T1.student_id  =  T2.id GROUP BY T1.student_id ORDER BY count(*) DESC LIMIT 1
SELECT T2.name FROM Friend AS T1 JOIN Highschooler AS T2 ON T1.student_id  =  T2.id GROUP BY T1.student_id HAVING count(*)  >=  3
SELECT T2.name FROM Friend AS T1 JOIN Highschooler AS T2 ON T1.student_id  =  T2.id GROUP BY T1.student_id HAVING count(*)  >=  3
SELECT T3.name FROM Friend AS T1 JOIN Highschooler AS T2 ON T1.student_id  =  T2.id JOIN Highschooler AS T3 ON T1.friend_id  =  T3.id WHERE T2.name  =  "Kyle"
SELECT T3.name FROM Friend AS T1 JOIN Highschooler AS T2 ON T1.student_id  =  T2.id JOIN Highschooler AS T3 ON T1.friend_id  =  T3.id WHERE T2.name  =  "Kyle"
SELECT student_id ,  count(*) FROM Likes GROUP BY student_id
SELECT student_id ,  count(*) FROM Likes GROUP BY student_id
SELECT T2.name ,  count(*) FROM Likes AS T1 JOIN Highschooler AS T2 ON T1.student_id  =  T2.id GROUP BY T1.student_id
SELECT T2.name ,  count(*) FROM Likes AS T1 JOIN Highschooler AS T2 ON T1.student_id  =  T2.id GROUP BY T1.student_id
SELECT T2.name FROM Likes AS T1 JOIN Highschooler AS T2 ON T1.student_id  =  T2.id GROUP BY T1.student_id ORDER BY count(*) DESC LIMIT 1
SELECT T2.name FROM Likes AS T1 JOIN Highschooler AS T2 ON T1.student_id  =  T2.id GROUP BY T1.student_id ORDER BY count(*) DESC LIMIT 1
SELECT T2.name FROM Likes AS T1 JOIN Highschooler AS T2 ON T1.student_id  =  T2.id GROUP BY T1.student_id HAVING count(*)  >=  2
SELECT T2.name FROM Likes AS T1 JOIN Highschooler AS T2 ON T1.student_id  =  T2.id GROUP BY T1.student_id HAVING count(*)  >=  2
SELECT T2.name FROM Friend AS T1 JOIN Highschooler AS T2 ON T1.student_id  =  T2.id WHERE T2.grade  >  5 GROUP BY T1.student_id HAVING count(*)  >=  2
SELECT T2.name FROM Friend AS T1 JOIN Highschooler AS T2 ON T1.student_id  =  T2.id WHERE T2.grade  >  5 GROUP BY T1.student_id HAVING count(*)  >=  2
SELECT T1.owner_id ,  T2.first_name ,  T2.last_name FROM Dogs AS T1 JOIN Owners AS T2 ON T1.owner_id  =  T2.owner_id GROUP BY T1.owner_id ORDER BY count(*) DESC LIMIT 1
SELECT T1.owner_id ,  T2.first_name ,  T2.last_name FROM Dogs AS T1 JOIN Owners AS T2 ON T1.owner_id  =  T2.owner_id GROUP BY T1.owner_id ORDER BY count(*) DESC LIMIT 1
SELECT T1.professional_id ,  T1.role_code ,  T1.first_name FROM Professionals AS T1 JOIN Treatments AS T2 ON T1.professional_id  =  T2.professional_id GROUP BY T1.professional_id HAVING count(*)  >=  2
SELECT T1.professional_id ,  T1.role_code ,  T1.first_name FROM Professionals AS T1 JOIN Treatments AS T2 ON T1.professional_id  =  T2.professional_id GROUP BY T1.professional_id HAVING count(*)  >=  2
SELECT T1.breed_name FROM Breeds AS T1 JOIN Dogs AS T2 ON T1.breed_code  =  T2.breed_code GROUP BY T1.breed_name ORDER BY count(*) DESC LIMIT 1
SELECT T1.breed_name FROM Breeds AS T1 JOIN Dogs AS T2 ON T1.breed_code  =  T2.breed_code GROUP BY T1.breed_name ORDER BY count(*) DESC LIMIT 1
SELECT T1.owner_id ,  T1.last_name FROM Owners AS T1 JOIN Dogs AS T2 ON T1.owner_id  =  T2.owner_id JOIN Treatments AS T3 ON T2.dog_id  =  T3.dog_id GROUP BY T1.owner_id ORDER BY count(*) DESC LIMIT 1
SELECT T1.owner_id ,  T1.last_name FROM Owners AS T1 JOIN Dogs AS T2 ON T1.owner_id  =  T2.owner_id JOIN Treatments AS T3 ON T2.dog_id  =  T3.dog_id GROUP BY T1.owner_id ORDER BY count(*) DESC LIMIT 1
SELECT T1.professional_id ,  T1.cell_number FROM Professionals AS T1 JOIN Treatments AS T2 ON T1.professional_id  =  T2.professional_id GROUP BY T1.professional_id HAVING count(*)  >=  2
SELECT T1.professional_id ,  T1.cell_number FROM Professionals AS T1 JOIN Treatments AS T2 ON T1.professional_id  =  T2.professional_id GROUP BY T1.professional_id HAVING count(*)  >=  2
SELECT T1.date_of_treatment ,  T2.first_name FROM Treatments AS T1 JOIN Professionals AS T2 ON T1.professional_id  =  T2.professional_id
SELECT T1.date_of_treatment ,  T2.first_name FROM Treatments AS T1 JOIN Professionals AS T2 ON T1.professional_id  =  T2.professional_id
SELECT T1.cost_of_treatment ,  T2.treatment_type_description FROM Treatments AS T1 JOIN treatment_types AS T2 ON T1.treatment_type_code  =  T2.treatment_type_code
SELECT T1.cost_of_treatment ,  T2.treatment_type_description FROM Treatments AS T1 JOIN treatment_types AS T2 ON T1.treatment_type_code  =  T2.treatment_type_code
SELECT T1.first_name ,  T1.last_name ,  T2.size_code FROM Owners AS T1 JOIN Dogs AS T2 ON T1.owner_id  =  T2.owner_id
SELECT T1.first_name ,  T1.last_name ,  T2.size_code FROM Owners AS T1 JOIN Dogs AS T2 ON T1.owner_id  =  T2.owner_id
SELECT T1.first_name ,  T2.name FROM Owners AS T1 JOIN Dogs AS T2 ON T1.owner_id  =  T2.owner_id
SELECT T1.first_name ,  T2.name FROM Owners AS T1 JOIN Dogs AS T2 ON T1.owner_id  =  T2.owner_id
SELECT T1.first_name ,  T2.name FROM Owners AS T1 JOIN Dogs AS T2 ON T1.owner_id  =  T2.owner_id WHERE T1.state  =  'Virginia'
SELECT T1.first_name ,  T2.name FROM Owners AS T1 JOIN Dogs AS T2 ON T1.owner_id  =  T2.owner_id WHERE T1.state  =  'Virginia'
SELECT DISTINCT T1.date_arrived ,  T1.date_departed FROM Dogs AS T1 JOIN Treatments AS T2 ON T1.dog_id  =  T2.dog_id
SELECT DISTINCT T1.date_arrived ,  T1.date_departed FROM Dogs AS T1 JOIN Treatments AS T2 ON T1.dog_id  =  T2.dog_id
SELECT email_address FROM Professionals WHERE state  =  'Hawaii' OR state  =  'Wisconsin'
SELECT email_address FROM Professionals WHERE state  =  'Hawaii' OR state  =  'Wisconsin'
SELECT date_arrived ,  date_departed FROM Dogs
SELECT date_arrived ,  date_departed FROM Dogs
SELECT count(DISTINCT dog_id) FROM Treatments
SELECT count(DISTINCT dog_id) FROM Treatments
SELECT count(DISTINCT professional_id) FROM Treatments
SELECT count(DISTINCT professional_id) FROM Treatments
SELECT role_code ,  street ,  city ,  state FROM professionals WHERE city LIKE '%West%'
SELECT role_code ,  street ,  city ,  state FROM professionals WHERE city LIKE '%West%'
SELECT first_name ,  last_name ,  email_address FROM Owners WHERE state LIKE '%North%'
SELECT first_name ,  last_name ,  email_address FROM Owners WHERE state LIKE '%North%'
SELECT cost_of_treatment FROM Treatments ORDER BY date_of_treatment DESC LIMIT 1
SELECT cost_of_treatment FROM Treatments ORDER BY date_of_treatment DESC LIMIT 1
SELECT count(*) FROM Dogs WHERE dog_id NOT IN ( SELECT dog_id FROM Treatments )
select count(*) from dogs where dog_id not in ( select dog_id from treatments )
SELECT count(*) FROM Owners WHERE owner_id NOT IN ( SELECT owner_id FROM Dogs )
SELECT count(*) FROM Owners WHERE owner_id NOT IN ( SELECT owner_id FROM Dogs )
SELECT count(*) FROM Professionals WHERE professional_id NOT IN ( SELECT professional_id FROM Treatments )
SELECT count(*) FROM Professionals WHERE professional_id NOT IN ( SELECT professional_id FROM Treatments )
SELECT name ,  age ,  weight FROM Dogs WHERE abandoned_yn  =  1
SELECT name ,  age ,  weight FROM Dogs WHERE abandoned_yn  =  1
SELECT max(age) FROM Dogs
SELECT max(age) FROM Dogs
SELECT charge_type ,  charge_amount FROM Charges
SELECT charge_type ,  charge_amount FROM Charges
SELECT max(charge_amount) FROM Charges
SELECT max(charge_amount) FROM Charges
SELECT email_address ,  cell_number ,  home_phone FROM professionals
SELECT email_address ,  cell_number ,  home_phone FROM professionals
SELECT DISTINCT breed_code ,  size_code FROM dogs
SELECT DISTINCT breed_code ,  size_code FROM dogs
SELECT DISTINCT T1.first_name ,  T3.treatment_type_description FROM professionals AS T1 JOIN Treatments AS T2 ON T1.professional_id  =  T2.professional_id JOIN Treatment_types AS T3 ON T2.treatment_type_code  =  T3.treatment_type_code
SELECT DISTINCT T1.first_name ,  T3.treatment_type_description FROM professionals AS T1 JOIN Treatments AS T2 ON T1.professional_id  =  T2.professional_id JOIN Treatment_types AS T3 ON T2.treatment_type_code  =  T3.treatment_type_code
SELECT count(*) FROM singer
SELECT count(*) FROM singer
SELECT Name FROM singer ORDER BY Net_Worth_Millions ASC
SELECT Name FROM singer ORDER BY Net_Worth_Millions ASC
SELECT Birth_Year ,  Citizenship FROM singer
SELECT Birth_Year ,  Citizenship FROM singer
SELECT Name FROM singer WHERE Citizenship != "France"
SELECT Name FROM singer WHERE Citizenship != "France"
SELECT Name FROM singer WHERE Birth_Year  =  1948 OR Birth_Year  =  1949
SELECT Name FROM singer WHERE Birth_Year  =  1948 OR Birth_Year  =  1949
SELECT Name FROM singer ORDER BY Net_Worth_Millions DESC LIMIT 1
SELECT Name FROM singer ORDER BY Net_Worth_Millions DESC LIMIT 1
SELECT Citizenship ,  COUNT(*) FROM singer GROUP BY Citizenship
SELECT Citizenship ,  COUNT(*) FROM singer GROUP BY Citizenship
SELECT Citizenship FROM singer GROUP BY Citizenship ORDER BY COUNT(*) DESC LIMIT 1
select citizenship from singer group by citizenship order by count(*) desc limit 1
SELECT T2.Title ,  T1.Name FROM singer AS T1 JOIN song AS T2 ON T1.Singer_ID  =  T2.Singer_ID
SELECT T2.Title ,  T1.Name FROM singer AS T1 JOIN song AS T2 ON T1.Singer_ID  =  T2.Singer_ID
SELECT DISTINCT T1.Name FROM singer AS T1 JOIN song AS T2 ON T1.Singer_ID  =  T2.Singer_ID WHERE T2.Sales  >  300000
SELECT DISTINCT T1.Name FROM singer AS T1 JOIN song AS T2 ON T1.Singer_ID  =  T2.Singer_ID WHERE T2.Sales  >  300000
SELECT T1.Name FROM singer AS T1 JOIN song AS T2 ON T1.Singer_ID  =  T2.Singer_ID GROUP BY T1.Name HAVING COUNT(*)  >  1
SELECT T1.Name FROM singer AS T1 JOIN song AS T2 ON T1.Singer_ID  =  T2.Singer_ID GROUP BY T1.Name HAVING COUNT(*)  >  1
SELECT Name FROM singer WHERE Singer_ID NOT IN (SELECT Singer_ID FROM song)
SELECT Name FROM singer WHERE Singer_ID NOT IN (SELECT Singer_ID FROM song)
SELECT count(*) FROM Other_Available_Features
SELECT T2.feature_type_name FROM Other_Available_Features AS T1 JOIN Ref_Feature_Types AS T2 ON T1.feature_type_code  =  T2.feature_type_code WHERE T1.feature_name  =  "AirCon"
SELECT T2.property_type_description FROM Properties AS T1 JOIN Ref_Property_Types AS T2 ON T1.property_type_code  =  T2.property_type_code GROUP BY T1.property_type_code
SELECT property_name FROM Properties WHERE property_type_code  =  "House" UNION SELECT property_name FROM Properties WHERE property_type_code  =  "Apartment" AND room_count  >  1

baseline pred: MATCH (singer:`concert_singer.singer`) WHERE singer.Age = 'French' RETURN avg(singer.Age),min(singer.Age),max(singer.Age)
label query  : MATCH (singer:`concert_singer.singer`) WHERE singer.Country = 'France' RETURN avg(singer.Age),min(singer.Age),max(singer.Age)


baseline pred: MATCH (singer:`concert_singer.singer`) RETURN singer.Name,singer.Song_release_year ORDER BY singer.Age DESC LIMIT 1
label query  : MATCH (singer:`concert_singer.singer`) RETURN singer.Song_Name,singer.Song_release_year ORDER BY singer.Age LIMIT 1


baseline pred: MATCH (singer:`concert_singer.singer`) RETURN singer.Name,singer.Song_release_year ORDER BY singer.Age DESC LIMIT 1
label query  : MATCH (singer:`concert_singer.singer`) RETURN singer.Song_Name,singer.Song_release_year ORDER BY singer.Age LIMIT 1


baseline pred: MATCH (singer:`concert_singer.singer`) WITH avg(singer.Age) AS age MATCH (singer:`concert_singer.singer`) WHERE singer.Age > age RETURN singer.Song_Name
label query  : MATCH (singer:`concert_singer.singer`) WITH avg(singer.Age) AS age MATCH (singer:`concert_singer.singer`) WHERE  singer.Age >  age  RETURN singer.Song_Name


baseline pred: MATCH (singer:`concert_singer.singer`) WITH avg(singer.Age) AS age MATCH (singer:`concert_singer.singer`) WHERE singer.Age > age RETURN singer.Song_Name
label query  : MATCH (singer:`concert_singer.singer`) WITH avg(singer.Age) AS age MATCH (singer:`concert_singer.singer`) WHERE  singer.Age >  age  RETURN singer.Song_Name


baseline pred: MATCH (stadium:`concert_singer.stadium`) WHERE stadium.Capacity > 5000 AND stadium.Capacity > 10000 RETURN stadium.Location,stadium.Name
label query  : MATCH (stadium:`concert_singer.stadium`) WHERE 5000<=stadium.Capacity<=10000 RETURN stadium.Location,stadium.Name


baseline pred: MATCH (stadium:`concert_singer.stadium`) WHERE 5000=stadium.Capacity=10000 RETURN station.Location,stadium.Name
label query  : MATCH (stadium:`concert_singer.stadium`) WHERE 5000<=stadium.Capacity<=10000 RETURN stadium.Location,stadium.Name


baseline pred: MATCH (concert:`concert_singer.concert`) WHERE concert.Year = 2014 OR concert.Year = 2015 RETURN count(*)
label query  : MATCH (concert:`concert_singer.concert`) WHERE concert.Year = '2014' OR concert.Year = '2015' RETURN count(*)


baseline pred: MATCH (concert:`concert_singer.concert`) WHERE concert.Year = 2014 OR concert.Year = 2015 RETURN count(*)
label query  : MATCH (concert:`concert_singer.concert`) WHERE concert.Year = '2014' OR concert.Year = '2015' RETURN count(*)


baseline pred: MATCH (stadium:`concert_singer.stadium`) RETURN stadium.Name,count(*)
label query  : MATCH (T1:`concert_singer.concert`)-[]-(T2:`concert_singer.stadium`) RETURN T2.Name,count(*)


baseline pred: MATCH (stadium:`concert_singer.stadium`) RETURN stadium.Name,count(*)
label query  : MATCH (T1:`concert_singer.concert`)-[]-(T2:`concert_singer.stadium`) RETURN T2.Name,count(*)


baseline pred: MATCH (concert:`concert_singer.concert`) WHERE concert.Year > 2014 RETURN concert.Name,concert.Capacity ORDER BY concert.Year DESC LIMIT 1
label query  : MATCH (T1:`concert_singer.concert`)-[]-(T2:`concert_singer.stadium`) WHERE T1.Year >= '2014' WITH count(T1.Stadium_ID) AS cnt, T2 RETURN T2.Name,T2.Capacity ORDER BY cnt DESC LIMIT 1


baseline pred: MATCH (stadium:`concert_singer.stadium`) WHERE stadium.Year > 2013 RETURN stadium.Name,stadium.Capacity ORDER BY stadium.Highest DESC LIMIT 1
label query  : MATCH (t1:`concert_singer.concert`)-[]-(t2:`concert_singer.stadium`) WHERE t1.Year > '2013' WITH count(t1.Stadium_ID) AS cnt, t2 RETURN t2.Name,t2.Capacity ORDER BY cnt DESC LIMIT 1


baseline pred: MATCH (stadium:`concert_singer.stadium`) WHERE NOT (stadium)-[]-(:`concert_singer.concert`) RETURN stadium.Name
label query  : MATCH (stadium:`concert_singer.stadium`) WHERE NOT (stadium)-[]-(:`concert_singer.concert`)     RETURN stadium.Name


baseline pred: MATCH (stadium:`concert_singer.stadium`) WHERE NOT (stadium)-[]-(:`concert_singer.concert`) RETURN stadium.Name
label query  : MATCH (stadium:`concert_singer.stadium`) WHERE NOT (stadium)-[]-(:`concert_singer.concert`)     RETURN stadium.Name


baseline pred: MATCH (concert:`concert_singer.concert`) RETURN concert.concert_name,concert.Theme,count(*)
label query  : MATCH (T2:`concert_singer.concert`)-[T1:`concert_singer.singer_in_concert`]-() RETURN T2.concert_Name,T2.Theme,count(*)


baseline pred: MATCH (concert:`concert_singer.concert`) RETURN concert.Name,concert.Theme,count(*)
label query  : MATCH (t2:`concert_singer.concert`)-[t1:`concert_singer.singer_in_concert`]-() RETURN t2.concert_Name,t2.Theme,count(*)


baseline pred: MATCH (T1:`concert_singer.singer`)-[]-(T2:`concert_singer.concert`) RETURN T1.Name,count(*)
label query  : MATCH (T2:`concert_singer.singer`)-[T1:`concert_singer.singer_in_concert`]-() RETURN T2.Name,count(*)


baseline pred: MATCH (T1:`concert_singer.singer`)-[]-(T2:`concert_singer.concert`) RETURN T1.Name,count(*)
label query  : MATCH (T2:`concert_singer.singer`)-[T1:`concert_singer.singer_in_concert`]-() RETURN T2.Name,count(*)


baseline pred: MATCH (singer:`concert_singer.singer`) WHERE singer.Year = 2014 RETURN singer.Name
label query  : MATCH (T2:`concert_singer.singer`)-[T1:`concert_singer.singer_in_concert`]-(T3:`concert_singer.concert`) WHERE T3.Year = '2014' RETURN T2.Name


baseline pred: MATCH (singer_in_concert:`concert_singer.singer_in_concert`) WHERE singer_in_concert.Year = 2014 RETURN singer_in_concert.Name
label query  : MATCH (T2:`concert_singer.singer`)-[T1:`concert_singer.singer_in_concert`]-(T3:`concert_singer.concert`) WHERE T3.Year = '2014' RETURN T2.Name


baseline pred: MATCH (singer:`concert_singer.singer`) WHERE singer.Song_Name = 'Hey' RETURN singer.Name,singer.Country
label query  : MATCH (singer:`concert_singer.singer`) WHERE singer.Song_Name =~'.*[H|h]ey.*' RETURN singer.Name,singer.Country


baseline pred: MATCH (singer:`concert_singer.singer`) WHERE singer.Song_Name = 'Hey' RETURN singer.Name,singer.Country
label query  : MATCH (singer:`concert_singer.singer`) WHERE singer.Song_Name =~'.*[H|h]ey.*' RETURN singer.Name,singer.Country


baseline pred: MATCH (pets:`pets_1.Pets`) WITH count(*) AS count, pets.weight AS weight WHERE count > 10 RETURN count
label query  : MATCH (pets:`pets_1.Pets`) WHERE pets.weight > 10 RETURN count(*)


baseline pred: MATCH (pets:`pets_1.Pets`) WHERE pets.PetType = 'dog' RETURN pets.weight ORDER BY pets.weight DESC LIMIT 1
label query  : MATCH (pets:`pets_1.Pets`) RETURN pets.weight ORDER BY pets.pet_age LIMIT 1


baseline pred: MATCH (pets:`pets_1.Pets`) WHERE pets.petType = 'dog' RETURN pets.weight ORDER BY pets.weight DESC LIMIT 1
label query  : MATCH (pets:`pets_1.Pets`) RETURN pets.weight ORDER BY pets.pet_age LIMIT 1


baseline pred: MATCH (pets:`pets_1.Pets`) RETURN pets.weight,pets.petType ORDER BY pets.weight DESC LIMIT 1
label query  : MATCH (pets:`pets_1.Pets`) RETURN max(pets.weight),pets.PetType


baseline pred: MATCH (student:`pets_1.Student`) WHERE student.Age > 20 RETURN count(*)
label query  : MATCH (T1:`pets_1.Student`)-[T2:`pets_1.Has_Pet`]-() WHERE T1.Age > 20 RETURN count(*)


baseline pred: MATCH (student:`pets_1.Student`) WHERE student.Age > 20 RETURN count(*)
label query  : MATCH (T1:`pets_1.Student`)-[T2:`pets_1.Has_Pet`]-() WHERE T1.Age > 20 RETURN count(*)


baseline pred: MATCH (student:`pets_1.Student`) WHERE student.Sex = 'F' RETURN count(*),student.PetType
label query  : MATCH (T1:`pets_1.Student`)-[T2:`pets_1.Has_Pet`]-(T3:`pets_1.Pets`) WHERE T1.Sex = 'F' AND T3.PetType = 'dog' RETURN count(*)


baseline pred: MATCH (student:`pets_1.Student`) WHERE student.Sex = 'F' AND student.PetType = 'dog' RETURN count(*)
label query  : MATCH (T1:`pets_1.Student`)-[T2:`pets_1.Has_Pet`]-(T3:`pets_1.Pets`) WHERE T1.Sex = 'F' AND T3.PetType = 'dog' RETURN count(*)


baseline pred: MATCH (student:`pets_1.Student`) WHERE student.PetType = 'cat' OR student.PetType = 'dog' RETURN student.Fname
label query  : MATCH (T1:`pets_1.Student`)-[T2:`pets_1.Has_Pet`]-(T3:`pets_1.Pets`) WHERE T3.PetType = 'cat' OR T3.PetType = 'dog' RETURN DISTINCT T1.Fname


baseline pred: MATCH (student:`pets_1.Student`) WHERE student.PetType = 'cat' OR student.PetType = 'dog' RETURN student.Fname
label query  : MATCH (T1:`pets_1.Student`)-[T2:`pets_1.Has_Pet`]-(T3:`pets_1.Pets`) WHERE T3.PetType = 'cat' OR T3.PetType = 'dog' RETURN DISTINCT T1.Fname


baseline pred: MATCH (pets:`pets_1.Pets`) RETURN pets.PetType,pets.weight ORDER BY pets.Age DESC LIMIT 1
label query  : MATCH (pets:`pets_1.Pets`) RETURN pets.PetType,pets.weight ORDER BY pets.pet_age LIMIT 1


baseline pred: MATCH (pets:`pets_1.Pets`) RETURN pets.PetType,pets.weight ORDER BY pets.weight DESC LIMIT 1
label query  : MATCH (pets:`pets_1.Pets`) RETURN pets.PetType,pets.weight ORDER BY pets.pet_age LIMIT 1


baseline pred: MATCH (pets:`pets_1.Pets`) WHERE pets.age ` 1 RETURN pets.PetID,pets.weight
label query  : MATCH (pets:`pets_1.Pets`) WHERE pets.pet_age > 1 RETURN pets.PetID,pets.weight


baseline pred: MATCH (pets:`pets_1.Pets`) WHERE pets.Age > 1 RETURN pets.PeID,pets.weight
label query  : MATCH (pets:`pets_1.Pets`) WHERE pets.pet_age > 1 RETURN pets.PetID,pets.weight


baseline pred: MATCH (pets:`pets_1.Pets`) RETURN avg(pets.pet_age),max(pets.pet_age)
label query  : MATCH (pets:`pets_1.Pets`) RETURN avg(pets.pet_age),max(pets.pet_age),pets.PetType


baseline pred: MATCH (pets:`pets_1.Pets`) RETURN avg(pets.pet_age),max(pets.pet_age)
label query  : MATCH (pets:`pets_1.Pets`) RETURN avg(pets.pet_age),max(pets.pet_age),pets.PetType


baseline pred: MATCH (pets:`pets_1.Pets`) RETURN pets.weight ORDER BY pets.petType DESC LIMIT 1
label query  : MATCH (pets:`pets_1.Pets`) RETURN avg(pets.weight),pets.PetType


baseline pred: MATCH (pets:`pets_1.Pets`) RETURN pets.weight ORDER BY pets.petType DESC LIMIT 1
label query  : MATCH (pets:`pets_1.Pets`) RETURN avg(pets.weight),pets.PetType


baseline pred: MATCH (student:`pets_1.Student`) WHERE student.Fname = 'Pet' RETURN student.LName,student.Age
label query  : MATCH (T1:`pets_1.Student`)-[T2:`pets_1.Has_Pet`]-() RETURN DISTINCT T1.Fname,T1.Age


baseline pred: MATCH (student:`pets_1.Student`) WHERE student.Fname = 'Pets' RETURN DISTINCT student.LName,student.Age
label query  : MATCH (T1:`pets_1.Student`)-[T2:`pets_1.Has_Pet`]-() RETURN DISTINCT T1.Fname,T1.Age


baseline pred: MATCH (student:`pets_1.Student`) WHERE student.Fname = 'Smith' RETURN student.PetID
label query  : MATCH (T1:`pets_1.Student`)-[T2:`pets_1.Has_Pet`]-() WHERE T1.LName = 'Smith' RETURN T2.PetID


baseline pred: MATCH (student:`pets_1.Student`) WHERE student.LName = 'Smith' RETURN student.PetID
label query  : MATCH (T1:`pets_1.Student`)-[T2:`pets_1.Has_Pet`]-() WHERE T1.LName = 'Smith' RETURN T2.PetID


baseline pred: MATCH (student:`pets_1.Student`) RETURN student.PetID,count(*)
label query  : MATCH (T1:`pets_1.Student`)-[T2:`pets_1.Has_Pet`]-() RETURN count(*),T1.StuID


baseline pred: MATCH (student:`pets_1.Student`) WHERE student.Fname = 'pets' RETURN student.StuID,count(*)
label query  : MATCH (t1:`pets_1.Student`)-[t2:`pets_1.Has_Pet`]-() RETURN count(*),t1.StuID


baseline pred: MATCH (student:`pets_1.Student`) WITH count(*) AS count, student.Fname,student.Gender AS Gender WHERE count > 1 RETURN Fname,Gender
label query  : MATCH (T1:`pets_1.Student`)-[T2:`pets_1.Has_Pet`]-() WITH count(*) AS count, T1.Sex AS Sex, T1.Fname AS Fname WHERE count  > 1 RETURN Fname,Sex


baseline pred: MATCH (student:`pets_1.Student`) WITH count(*) AS count, student.Fname AS Fname, student.Gender AS Gender WHERE count > 1 RETURN Fname,Gender
label query  : MATCH (T1:`pets_1.Student`)-[T2:`pets_1.Has_Pet`]-() WITH count(*) AS count, T1.Sex AS Sex, T1.Fname AS Fname WHERE count  > 1 RETURN Fname,Sex


baseline pred: MATCH (student:`pets_1.Student`) WHERE student.PetType = 'cat' AND student.Age > 3 RETURN student.LName
label query  : MATCH (T1:`pets_1.Student`)-[T2:`pets_1.Has_Pet`]-(T3:`pets_1.Pets`) WHERE T3.pet_age = 3 AND T3.PetType = 'cat' RETURN T1.LName


baseline pred: MATCH (student:`pets_1.Student`) WHERE student.PetType = 'cat' AND student.Age > 3 RETURN student.LName
label query  : MATCH (T1:`pets_1.Student`)-[T2:`pets_1.Has_Pet`]-(T3:`pets_1.Pets`) WHERE T3.pet_age = 3 AND T3.PetType = 'cat' RETURN T1.LName


baseline pred: MATCH (continents:`car_1.continents`) RETURN continents.ContId,continents.CountryName,count(*)
label query  : MATCH (T1:`car_1.continents`)-[]-(T2:`car_1.countries`) RETURN T1.ContId,T1.Continent,count(*)


baseline pred: MATCH (continents:`car_1.continents`) RETURN continents.Continent,count(*)
label query  : MATCH (T1:`car_1.continents`)-[]-(T2:`car_1.countries`) RETURN T1.ContId,T1.Continent,count(*)


baseline pred: MATCH (car_names:`car_1.car_names`) RETURN car_names.FullName,car_names.Make,count(*)
label query  : MATCH (T1:`car_1.car_makers`)-[]-(T2:`car_1.model_list`) RETURN T1.FullName,T1.Id,count(*)


baseline pred: MATCH (car_makers:`car_1.car_makers`) RETURN car_makers.FullName,car_makers.Make,count(*)
label query  : MATCH (T1:`car_1.car_makers`)-[]-(T2:`car_1.model_list`) RETURN T1.FullName,T1.Id,count(*)


baseline pred: MATCH (car_names:`car_1.car_names`) RETURN car_names.Model ORDER BY car_names.Horsepower DESC LIMIT 1
label query  : MATCH (T1:`car_1.car_names`)-[]-(T2:`car_1.cars_data`) RETURN T1.Model ORDER BY T2.Horsepower ASC LIMIT 1


baseline pred: MATCH (car_names:`car_1.car_names`) RETURN car_names.Model ORDER BY car_names.Horsepower DESC LIMIT 1
label query  : MATCH (T1:`car_1.car_names`)-[]-(T2:`car_1.cars_data`) RETURN T1.Model ORDER BY T2.Horsepower ASC LIMIT 1


baseline pred: MATCH (car_names:`car_1.car_names`) WHERE cars.Year > 1980 RETURN DISTINCT cars.Model
label query  : MATCH (T1:`car_1.model_list`)-[]-(T2:`car_1.car_names`)-[]-(T3:`car_1.cars_data`) WHERE T3.Year > 1980 RETURN DISTINCT T1.Model


baseline pred: MATCH (car_names:`car_1.car_names`) WHERE cars_names.Year > 1980 RETURN cars_names.Model
label query  : MATCH (T1:`car_1.model_list`)-[]-(T2:`car_1.car_names`)-[]-(T3:`car_1.cars_data`) WHERE T3.Year > 1980 RETURN DISTINCT T1.Model


baseline pred: MATCH (car_makers:`car_1.car_makers`) RETURN count(*),car_makers.Continent
label query  : MATCH (T1:`car_1.continents`)-[]-(T2:`car_1.countries`)-[]-(T3:`car_1.car_makers`) RETURN T1.Continent,count(*)


baseline pred: MATCH (car_names:`car_1.car_names`) RETURN car_names.Continent,count(*)
label query  : MATCH (T1:`car_1.continents`)-[]-(T2:`car_1.countries`)-[]-(T3:`car_1.car_makers`) RETURN T1.Continent,count(*)


baseline pred: MATCH (car_makers:`car_1.car_makers`) RETURN count(*),car_makers.FullName
label query  : MATCH (t1:`car_1.model_list`)-[]-(t2:`car_1.car_makers`) RETURN count(*),t2.FullName


baseline pred: MATCH (car_names:`car_1.car_names`) RETURN count(*),car_names.Make,car_names.FullName
label query  : MATCH (T1:`car_1.model_list`)-[]-(T2:`car_1.car_makers`) RETURN count(*),T2.FullName,T2.Id


baseline pred: MATCH (car_names:`car_1.car_names`) WHERE car_names.Make = 'amc hornet sportabout (sw)' RETURN car_names.Application
label query  : MATCH (T1:`car_1.cars_data`)-[]-(T2:`car_1.car_names`) WHERE T2.Make = 'amc hornet sportabout (sw)' RETURN T1.Accelerate


baseline pred: MATCH (car_names:`car_1.car_names`) WHERE car_names.Make = 'amc hornet sportabout (sw)' RETURN car_names.Adjusted
label query  : MATCH (T1:`car_1.cars_data`)-[]-(T2:`car_1.car_names`) WHERE T2.Make = 'amc hornet sportabout (sw)' RETURN T1.Accelerate


baseline pred: MATCH (car_makers:`car_1.car_makers`) WHERE cars.CountryName = 'france' RETURN count(*)
label query  : MATCH (T1:`car_1.car_makers`)-[]-(T2:`car_1.countries`) WHERE T2.CountryName = 'france' RETURN count(*)


baseline pred: MATCH (car_makers:`car_1.car_makers`) WHERE cars.CountryName = 'france' RETURN count(*)
label query  : MATCH (T1:`car_1.car_makers`)-[]-(T2:`car_1.countries`) WHERE T2.CountryName = 'france' RETURN count(*)


baseline pred: MATCH (car_names:`car_1.car_names`) WHERE cars.CountryName = 'usa' RETURN count(*)
label query  : MATCH (T1:`car_1.model_list`)-[]-(T2:`car_1.car_makers`)-[]-(T3:`car_1.countries`) WHERE T3.CountryName = 'usa' RETURN count(*)


baseline pred: MATCH (car_names:`car_1.car_names`) WHERE cars.Country = 'United States' RETURN count(*)
label query  : MATCH (T1:`car_1.model_list`)-[]-(T2:`car_1.car_makers`)-[]-(T3:`car_1.countries`) WHERE T3.CountryName = 'usa' RETURN count(*)


baseline pred: MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Year = 1974 AND cars_data.Cylinders = 8 RETURN cars_data.Weight ORDER BY cars_data.Weight DESC LIMIT 8
label query  : MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Cylinders = 8 AND cars_data.Year = 1974 RETURN min(cars_data.Weight)


baseline pred: MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Year = 1974 AND cars_data.Cylinders = 8 RETURN min(cars_data.Weight)
label query  : MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Cylinders = 8 AND cars_data.Year = 1974 RETURN min(cars_data.Weight)


baseline pred: MATCH (car_names:`car_1.car_names`) RETURN car_names.Make,car_names.Model
label query  : MATCH (model_list:`car_1.model_list`) RETURN model_list.Maker,model_list.Model


baseline pred: MATCH (car_names:`car_1.car_names`) RETURN car_names.Make,car_names.Model
label query  : MATCH (model_list:`car_1.model_list`) RETURN model_list.Maker,model_list.Model


baseline pred: MATCH (car_makers:`car_1.car_makers`) WITH count(*) AS count, cars.CountryName AS CountryName WHERE count >= 1 RETURN CountryName,CountryId
label query  : MATCH (T1:`car_1.countries`)-[]-(T2:`car_1.car_makers`) WITH count(*) AS count, T1.CountryName AS CountryName, T1.CountryId AS CountryId WHERE count  >= 1 RETURN CountryName,CountryId


baseline pred: MATCH (car_makers:`car_1.car_makers`) WITH count(*) AS count, cars.CountryName AS CountryName WHERE count >= 1 RETURN CountryName,CountryId
label query  : MATCH (T1:`car_1.countries`)-[]-(T2:`car_1.car_makers`) WITH count(*) AS count, T1.CountryName AS CountryName, T1.CountryId AS CountryId WHERE count  >= 1 RETURN CountryName,CountryId


baseline pred: MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Heavypower > 150 RETURN count(*)
label query  : MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Horsepower > '150' RETURN count(*)


baseline pred: MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Horsepower > 150 RETURN count(*)
label query  : MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Horsepower > '150' RETURN count(*)


baseline pred: MATCH (car_names:`car_1.car_names`) WHERE cars.Cylinders = 3 RETURN max(car_names.Horsepower),car_names.Make
label query  : MATCH (T1:`car_1.car_names`)-[]-(T2:`car_1.cars_data`) WHERE T2.Cylinders = 3 RETURN T2.Horsepower,T1.Make ORDER BY T2.Horsepower DESC LIMIT 1


baseline pred: MATCH (car_names:`car_1.car_names`) WHERE cars.Cylinders = 3 RETURN cars.Model,car_names.Make
label query  : MATCH (T1:`car_1.car_names`)-[]-(T2:`car_1.cars_data`) WHERE T2.Cylinders = 3 RETURN T2.Horsepower,T1.Make ORDER BY T2.Horsepower DESC LIMIT 1


baseline pred: MATCH (cars_data:`car_1.cars_data`) RETURN cars_data.Model ORDER BY cars_data.MPG DESC LIMIT 1
label query  : MATCH (T1:`car_1.car_names`)-[]-(T2:`car_1.cars_data`) RETURN T1.Model ORDER BY T2.MPG DESC LIMIT 1


baseline pred: MATCH (cars_data:`car_1.cars_data`) RETURN cars_data.Model ORDER BY cars_data.MPG DESC LIMIT 1
label query  : MATCH (t1:`car_1.car_names`)-[]-(t2:`car_1.cars_data`) RETURN t1.Model ORDER BY t2.MPG DESC LIMIT 1


baseline pred: MATCH (cars_data:`car_1.cars_data`) RETURN max(cars_data.Accelerate)
label query  : MATCH (cars_data:`car_1.cars_data`) RETURN max(cars_data.Accelerate),cars_data.Cylinders


baseline pred: MATCH (cars_data:`car_1.cars_data`) WITH count(*) AS count, cars_data.Cylinders AS Cylinders WHERE count > 4 RETURN count
label query  : MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Cylinders > 4 RETURN count(*)


baseline pred: MATCH (cars_data:`car_1.cars_data`) WITH count(*) AS count, cars_data.Cylinders AS Cylinders WHERE count > 4 RETURN count
label query  : MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Cylinders > 4 RETURN count(*)


baseline pred: MATCH (car_names:`car_1.car_names`) WHERE cars.Year = 1980 RETURN count(*)
label query  : MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Year = 1980 RETURN count(*)


baseline pred: MATCH (car_makers:`car_1.car_makers`) WHERE car_makers.FullName = 'American Motor Company' RETURN count(*)
label query  : MATCH (T1:`car_1.car_makers`)-[]-(T2:`car_1.model_list`) WHERE T1.FullName = 'American Motor Company' RETURN count(*)


baseline pred: MATCH (car_names:`car_1.car_names`) WHERE cars.FullName = 'American Motor Company' RETURN count(*)
label query  : MATCH (T1:`car_1.car_makers`)-[]-(T2:`car_1.model_list`) WHERE T1.FullName = 'American Motor Company' RETURN count(*)


baseline pred: MATCH (car_makers:`car_1.car_makers`) WITH count(*) AS count, car_makers.FullName AS FullName WHERE count > 3 RETURN FullName,MakeId
label query  : MATCH (T1:`car_1.car_makers`)-[]-(T2:`car_1.model_list`) WITH count(*) AS count, T1.Id AS Id, T1.FullName AS FullName WHERE count  > 3 RETURN FullName,Id


baseline pred: MATCH (car_names:`car_1.car_names`) WITH count(*) AS count, car_names.Make AS Maker WHERE count > 3 RETURN Maker,MakeId
label query  : MATCH (T1:`car_1.car_makers`)-[]-(T2:`car_1.model_list`) WITH count(*) AS count, T1.Id AS Id, T1.FullName AS FullName WHERE count  > 3 RETURN FullName,Id


baseline pred: MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Weight ` 3000 AND cars_data.Weight ` 4000 RETURN cars_data.Year
label query  : MATCH (cars_data:`car_1.cars_data`) WHERE 3000<=cars_data.Weight<=4000 RETURN DISTINCT cars_data.Year


baseline pred: MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Weight ` 4000 AND cars_data.Weight > 3000 RETURN cars_data.Year,cars_data.Year
label query  : MATCH (cars_data:`car_1.cars_data`) WHERE 3000<=cars_data.Weight<=4000 RETURN DISTINCT cars_data.Year


baseline pred: MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Model = 'volvo' RETURN cars_data.Cylinders ORDER BY cars_data.Accelerate DESC LIMIT 1
label query  : MATCH (T1:`car_1.cars_data`)-[]-(T2:`car_1.car_names`) WHERE T2.Model = 'volvo' RETURN T1.Cylinders ORDER BY T1.Accelerate ASC LIMIT 1


baseline pred: MATCH (car_names:`car_1.car_names`) WHERE cars_names.Model = 'volvo' RETURN cars_names.Cylinders ORDER BY cars_names.Accelerate DESC LIMIT 1
label query  : MATCH (T1:`car_1.cars_data`)-[]-(T2:`car_1.car_names`) WHERE T2.Model = 'volvo' RETURN T1.Cylinders ORDER BY T1.Accelerate ASC LIMIT 1


baseline pred: MATCH (cars_data:`car_1.cars_data`) WITH cars_data.Cylinders AS Cylinders, count(*) AS count WHERE count > 6 RETURN count
label query  : MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Cylinders > 6 RETURN count(*)


baseline pred: MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Cylinders = 4 RETURN cars_data.Model ORDER BY cars_data.Horsepower DESC LIMIT 1
label query  : MATCH (T1:`car_1.car_names`)-[]-(T2:`car_1.cars_data`) WHERE T2.Cylinders = 4 RETURN T1.Model ORDER BY T2.Horsepower DESC LIMIT 1


baseline pred: MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Cylinders = '4' RETURN cars_data.Model ORDER BY cars_data.Horsepower DESC LIMIT 1
label query  : MATCH (T1:`car_1.car_names`)-[]-(T2:`car_1.cars_data`) WHERE T2.Cylinders = 4 RETURN T1.Model ORDER BY T2.Horsepower DESC LIMIT 1


baseline pred: MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Year ` 1980 RETURN max(cars_data.MPG),cars_data.Cylinders
label query  : MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Cylinders = 8 OR cars_data.Year < 1980 RETURN max(cars_data.MPG)


baseline pred: MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Cylinders = 8 RETURN max(cars_data.MPG)
label query  : MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Cylinders = 8 OR cars_data.Year < 1980 RETURN max(cars_data.MPG)


baseline pred: MATCH (airports:`flight_2.airports`) WHERE airports.City = 'Alton' RETURN airports.City,airports.Country
label query  : MATCH (airports:`flight_2.airports`) WHERE airports.AirportName = 'Alton' RETURN airports.City,airports.Country


baseline pred: MATCH (airports:`flight_2.airports`) WHERE airports.City = 'Alton' RETURN airports.City,airports.Country
label query  : MATCH (airports:`flight_2.airports`) WHERE airports.AirportName = 'Alton' RETURN airports.City,airports.Country


baseline pred: MATCH (flights:`flight_2.flights`) WHERE flights.DestAirport = 'APG' RETURN count(*)
label query  : MATCH (flights:`flight_2.flights`) WHERE flights.SourceAirport = 'APG' RETURN count(*)


baseline pred: MATCH (flights:`flight_2.flights`) WHERE flights.DestAirport = 'APG' RETURN count(*)
label query  : MATCH (flights:`flight_2.flights`) WHERE flights.SourceAirport = 'APG' RETURN count(*)


baseline pred: MATCH (flights:`flight_2.flights`) WHERE flights.AirportCode = 'ATO' RETURN count(*)
label query  : MATCH (flights:`flight_2.flights`) WHERE flights.DestAirport = 'ATO' RETURN count(*)


baseline pred: MATCH (flights:`flight_2.flights`) WHERE flights.AirportCode = 'ATO' RETURN count(*)
label query  : MATCH (flights:`flight_2.flights`) WHERE flights.DestAirport = 'ATO' RETURN count(*)


baseline pred: MATCH (flights:`flight_2.flights`) WHERE flights.City = 'Aberdeen' RETURN count(*)
label query  : MATCH (T1:`flight_2.flights`)-[]-(T2:`flight_2.airports`) WHERE T2.City = 'Aberdeen' RETURN count(*)


baseline pred: MATCH (flights:`flight_2.flights`) WHERE flights.City = 'Aberdeen' RETURN count(*)
label query  : MATCH (T1:`flight_2.flights`)-[]-(T2:`flight_2.airports`) WHERE T2.City = 'Aberdeen' RETURN count(*)


baseline pred: MATCH (airports:`flight_2.airports`) WHERE airports.City = 'Aberdeen' RETURN count(*)
label query  : MATCH (T1:`flight_2.flights`)-[]-(T2:`flight_2.airports`) WHERE T2.City = 'Aberdeen' RETURN count(*)


baseline pred: MATCH (airports:`flight_2.airports`) WHERE airports.City = 'Aberdeen' RETURN count(*)
label query  : MATCH (T1:`flight_2.flights`)-[]-(T2:`flight_2.airports`) WHERE T2.City = 'Aberdeen' RETURN count(*)


baseline pred: MATCH (flights:`flight_2.flights`) WHERE flights.City = 'Aberdeen' AND flights.City = 'Ashley' RETURN count(*)
label query  : MATCH (T1:`flight_2.flights`)-[]-(T2:`flight_2.airports`)-[]-(T3:`flight_2.airports`) WHERE T2.City = 'Ashley' AND T3.City = 'Aberdeen' RETURN count(*)


baseline pred: MATCH (flights:`flight_2.flights`) WHERE flights.City = 'Aberdeen' AND flights.AirportName = 'Ashley' RETURN count(*)
label query  : MATCH (T1:`flight_2.flights`)-[]-(T2:`flight_2.airports`)-[]-(T3:`flight_2.airports`) WHERE T2.City = 'Ashley' AND T3.City = 'Aberdeen' RETURN count(*)


baseline pred: MATCH (flights:`flight_2.flights`) WHERE flights.Airline = 'United Airlines' AND flights.AirportCode = 'ASY' RETURN count(*)
label query  : MATCH (T1:`flight_2.airlines`)-[]-(T2:`flight_2.flights`) WHERE T1.Airline = 'United Airlines' AND T2.DestAirport = 'ASY' RETURN count(*)


baseline pred: MATCH (flights:`flight_2.flights`) WHERE flights.Airline = 'United Airlines' RETURN count(*)
label query  : MATCH (T1:`flight_2.airlines`)-[]-(T2:`flight_2.flights`) WHERE T1.Airline = 'United Airlines' AND T2.DestAirport = 'ASY' RETURN count(*)


baseline pred: MATCH (flights:`flight_2.flights`) WHERE flights.Airline = 'United Airlines' RETURN count(*)
label query  : MATCH (T1:`flight_2.airlines`)-[]-(T2:`flight_2.flights`) WHERE T1.Airline = 'United Airlines' AND T2.SourceAirport = 'AHD' RETURN count(*)


baseline pred: MATCH (flights:`flight_2.flights`) WHERE flights.Airline = 'United Airlines' AND flights.DestAirport = 'AHD' RETURN count(*)
label query  : MATCH (T1:`flight_2.airlines`)-[]-(T2:`flight_2.flights`) WHERE T1.Airline = 'United Airlines' AND T2.SourceAirport = 'AHD' RETURN count(*)


baseline pred: MATCH (T1:`flight_2.airlines`)-[]-(T2:`flight_2.flights`) WHERE T2.City = 'Aberdeen' AND T1.Airline = 'United Airlines' RETURN count(*)
label query  : MATCH (T1:`flight_2.flights`)-[]-(T2:`flight_2.airports`)-[]-(T3:`flight_2.airlines`) WHERE T2.City = 'Aberdeen' AND T3.Airline = 'United Airlines' RETURN count(*)


baseline pred: MATCH (flights:`flight_2.flights`) WHERE flights.Airline = 'United Airlines' AND flights.City = 'Aberdeen' RETURN count(*)
label query  : MATCH (T1:`flight_2.flights`)-[]-(T2:`flight_2.airports`)-[]-(T3:`flight_2.airlines`) WHERE T2.City = 'Aberdeen' AND T3.Airline = 'United Airlines' RETURN count(*)


baseline pred: MATCH (flights:`flight_2.flights`) RETURN flights.City ORDER BY flights.FlightNode DESC LIMIT 1
label query  : MATCH (T1:`flight_2.airports`)-[]-(T2:`flight_2.flights`) WITH count(T1.City) AS cnt, T1 RETURN T1.City ORDER BY cnt DESC LIMIT 1


baseline pred: MATCH (airports:`flight_2.airports`) RETURN airports.City ORDER BY airports.DestAirport DESC LIMIT 1
label query  : MATCH (T1:`flight_2.airports`)-[]-(T2:`flight_2.flights`) WITH count(T1.City) AS cnt, T1 RETURN T1.City ORDER BY cnt DESC LIMIT 1


baseline pred: MATCH (flights:`flight_2.flights`) RETURN flights.City ORDER BY flights.FlightNode DESC LIMIT 1
label query  : MATCH (T1:`flight_2.airports`)-[]-(T2:`flight_2.flights`) WITH count(T1.City) AS cnt, T1 RETURN T1.City ORDER BY cnt DESC LIMIT 1


baseline pred: MATCH (airports:`flight_2.airports`) RETURN airports.City ORDER BY airports.SourceAirport DESC LIMIT 1
label query  : MATCH (T1:`flight_2.airports`)-[]-(T2:`flight_2.flights`) WITH count(T1.City) AS cnt, T1 RETURN T1.City ORDER BY cnt DESC LIMIT 1


baseline pred: MATCH (flights:`flight_2.flights`) RETURN flights.AirportCode ORDER BY flights.FlightNode DESC LIMIT 1
label query  : MATCH (T1:`flight_2.airports`)-[]-(T2:`flight_2.flights`) WITH T1, count(T1.AirportCode) AS cnt RETURN T1.AirportCode ORDER BY cnt DESC LIMIT 1


baseline pred: MATCH (airports:`flight_2.airports`) RETURN airports.AirportCode ORDER BY airports.FlightNode DESC LIMIT 1
label query  : MATCH (T1:`flight_2.airports`)-[]-(T2:`flight_2.flights`) WITH T1, count(T1.AirportCode) AS cnt RETURN T1.AirportCode ORDER BY cnt DESC LIMIT 1


baseline pred: MATCH (flights:`flight_2.flights`) RETURN flights.AirportCode ORDER BY flights.FlightNode DESC LIMIT 1
label query  : MATCH (T1:`flight_2.airports`)-[]-(T2:`flight_2.flights`) WITH T1, count(T1.AirportCode) AS cnt RETURN T1.AirportCode ORDER BY cnt LIMIT 1


baseline pred: MATCH (airports:`flight_2.airports`) RETURN airports.AirportCode ORDER BY airports.FlightNode DESC LIMIT 1
label query  : MATCH (T1:`flight_2.airports`)-[]-(T2:`flight_2.flights`) WITH T1, count(T1.AirportCode) AS cnt RETURN T1.AirportCode ORDER BY cnt LIMIT 1


baseline pred: MATCH (flights:`flight_2.flights`) WHERE flights.DestAirport = 'AHD' RETURN flights.Airline
label query  : MATCH (T1:`flight_2.airlines`)-[]-(T2:`flight_2.flights`) WHERE T2.SourceAirport = 'AHD' RETURN T1.Airline


baseline pred: MATCH (flights:`flight_2.flights`) WHERE flights.SourceAirport = 'AHD' RETURN flights.Airline
label query  : MATCH (T1:`flight_2.airlines`)-[]-(T2:`flight_2.flights`) WHERE T2.SourceAirport = 'AHD' RETURN T1.Airline


baseline pred: MATCH (flights:`flight_2.flights`) WHERE flights.AirportCode = 'AHD' RETURN flights.Airline
label query  : MATCH (T1:`flight_2.airlines`)-[]-(T2:`flight_2.flights`) WHERE T2.DestAirport = 'AHD' RETURN T1.Airline


baseline pred: MATCH (flights:`flight_2.flights`) WHERE flights.DestAirport = 'AHD' RETURN flights.Airline
label query  : MATCH (T1:`flight_2.airlines`)-[]-(T2:`flight_2.flights`) WHERE T2.DestAirport = 'AHD' RETURN T1.Airline


baseline pred: MATCH (flights:`flight_2.flights`) WHERE flights.AirportCode = 'APG' RETURN flights.FlightNo
label query  : MATCH (flights:`flight_2.flights`) WHERE flights.SourceAirport = 'APG' RETURN flights.FlightNo


baseline pred: MATCH (flights:`flight_2.flights`) WHERE flights.DestAirport = 'APG' RETURN flights.FlightNo
label query  : MATCH (flights:`flight_2.flights`) WHERE flights.SourceAirport = 'APG' RETURN flights.FlightNo


baseline pred: MATCH (flights:`flight_2.flights`) WHERE flights.AirportCode = 'APG' RETURN flights.FlightNo
label query  : MATCH (flights:`flight_2.flights`) WHERE flights.DestAirport = 'APG' RETURN flights.FlightNo


baseline pred: MATCH (flights:`flight_2.flights`) WHERE flights.AirportCode = 'APG' RETURN flights.FlightNo
label query  : MATCH (flights:`flight_2.flights`) WHERE flights.DestAirport = 'APG' RETURN flights.FlightNo


baseline pred: MATCH (flights:`flight_2.flights`) WHERE flights.City = 'Aberdeen' RETURN flights.FlightNo
label query  : MATCH (T1:`flight_2.flights`)-[]-(T2:`flight_2.airports`) WHERE T2.City = 'Aberdeen' RETURN T1.FlightNo


baseline pred: MATCH (flights:`flight_2.flights`) WHERE flights.City = 'Aberdeen' RETURN flights.FlightNo
label query  : MATCH (T1:`flight_2.flights`)-[]-(T2:`flight_2.airports`) WHERE T2.City = 'Aberdeen' RETURN T1.FlightNo


baseline pred: MATCH (flights:`flight_2.flights`) WHERE flights.City = 'Aberdeen' RETURN flights.FlightNo
label query  : MATCH (T1:`flight_2.flights`)-[]-(T2:`flight_2.airports`) WHERE T2.City = 'Aberdeen' RETURN T1.FlightNo


baseline pred: MATCH (flights:`flight_2.flights`) WHERE flights.City = 'Aberdeen' RETURN flights.FlightNo
label query  : MATCH (T1:`flight_2.flights`)-[]-(T2:`flight_2.airports`) WHERE T2.City = 'Aberdeen' RETURN T1.FlightNo


baseline pred: MATCH (flights:`flight_2.flights`) WHERE flights.City = 'Aberdeen' OR flights.City = 'Abilene' RETURN count(*)
label query  : MATCH (T1:`flight_2.flights`)-[]-(T2:`flight_2.airports`) WHERE T2.City = 'Aberdeen' OR T2.City = 'Abilene' RETURN count(*)


baseline pred: MATCH (flights:`flight_2.flights`) WHERE flights.City = 'Aberdeen' OR flights.City = 'Abilene' RETURN count(*)
label query  : MATCH (T1:`flight_2.flights`)-[]-(T2:`flight_2.airports`) WHERE T2.City = 'Aberdeen' OR T2.City = 'Abilene' RETURN count(*)


baseline pred: MATCH (airports:`flight_2.airports`) WHERE NOT (airports)-[]-(:`flight_2.flights`) RETURN airports.AirportName
label query  : MATCH (airports:`flight_2.airports`) WHERE NOT (airports)-[]-(:`flight_2.flights`)     RETURN airports.AirportName


baseline pred: MATCH (airports:`flight_2.airports`) WHERE NOT (airports)-[]-(:`flight_2.flights`) RETURN airports.AirportName
label query  : MATCH (airports:`flight_2.airports`) WHERE NOT (airports)-[]-(:`flight_2.flights`)     RETURN airports.AirportName


baseline pred: MATCH (employee:`employee_hire_evaluation.employee`) RETURN employee.Name ORDER BY employee.Age ASC
label query  : MATCH (employee:`employee_hire_evaluation.employee`) RETURN employee.Name ORDER BY employee.Age


baseline pred: MATCH (employee:`employee_hire_evaluation.employee`) RETURN employee.Name ORDER BY employee.Age ASC
label query  : MATCH (employee:`employee_hire_evaluation.employee`) RETURN employee.Name ORDER BY employee.Age


baseline pred: MATCH (employee:`employee_hire_evaluation.employee`) RETURN employee.City,count(*)
label query  : MATCH (employee:`employee_hire_evaluation.employee`) RETURN count(*),employee.City


baseline pred: MATCH (employee:`employee_hire_evaluation.employee`) RETURN employee.City,count(*)
label query  : MATCH (employee:`employee_hire_evaluation.employee`) RETURN count(*),employee.City


baseline pred: MATCH (employee:`employee_hire_evaluation.employee`) WITH count(*) AS count, employee.City AS City WHERE count > 1 RETURN City
label query  : MATCH (employee:`employee_hire_evaluation.employee`) WHERE employee.Age < 30 WITH count(*) AS count, employee.City AS City WHERE count  > 1 RETURN City


baseline pred: MATCH (employee:`employee_hire_evaluation.employee`) WITH count(*) AS count, employee.City AS City WHERE count > 1 RETURN City
label query  : MATCH (employee:`employee_hire_evaluation.employee`) WHERE employee.Age < 30 WITH count(*) AS count, employee.City AS City WHERE count  > 1 RETURN City


baseline pred: MATCH (shop:`employee_hire_evaluation.shop`) RETURN shop.Location,count(*)
label query  : MATCH (shop:`employee_hire_evaluation.shop`) RETURN count(*),shop.Location


baseline pred: MATCH (shop:`employee_hire_evaluation.shop`) RETURN shop.Location,count(*)
label query  : MATCH (shop:`employee_hire_evaluation.shop`) RETURN count(*),shop.Location


baseline pred: MATCH (shop:`employee_hire_evaluation.shop`) RETURN shop.Name,shop.Location ORDER BY shop.Number_products DESC
label query  : MATCH (shop:`employee_hire_evaluation.shop`) RETURN shop.Name,shop.Location,shop.District ORDER BY shop.Number_products DESC


baseline pred: MATCH (shop:`employee_hire_evaluation.shop`) WITH count(*) AS count, shop.Name AS Manager_name WHERE count > number_products RETURN Manager_name
label query  : MATCH (shop:`employee_hire_evaluation.shop`) WITH avg(shop.Number_products) AS number_products MATCH (shop:`employee_hire_evaluation.shop`) WHERE  shop.Number_products >  number_products  RETURN shop.Name


baseline pred: MATCH (shop:`employee_hire_evaluation.shop`) WITH count(*) AS count, shop.Name AS Manager_name WHERE count > number_products RETURN Manager_name
label query  : MATCH (shop:`employee_hire_evaluation.shop`) WITH avg(shop.Number_products) AS number_products MATCH (shop:`employee_hire_evaluation.shop`) WHERE  shop.Number_products >  number_products  RETURN shop.Name


baseline pred: MATCH (evaluation:`employee_hire_evaluation.evaluation`) RETURN evaluation.Name ORDER BY evaluation.Year_awarded DESC LIMIT 1
label query  : MATCH (t1:`employee_hire_evaluation.employee`)-[]-(t2:`employee_hire_evaluation.evaluation`) WITH t1, count(t1.Employee_ID) AS cnt RETURN t1.Name ORDER BY cnt DESC LIMIT 1


baseline pred: MATCH (evaluation:`employee_hire_evaluation.evaluation`) RETURN evaluation.Name ORDER BY evaluation.Year_awarded DESC LIMIT 1
label query  : MATCH (t1:`employee_hire_evaluation.employee`)-[]-(t2:`employee_hire_evaluation.evaluation`) WITH t1, count(t1.Employee_ID) AS cnt RETURN t1.Name ORDER BY cnt DESC LIMIT 1


baseline pred: MATCH (evaluation:`employee_hire_evaluation.evaluation`) RETURN evaluation.Name ORDER BY evaluation.Bonus DESC LIMIT 1
label query  : MATCH (t1:`employee_hire_evaluation.employee`)-[]-(t2:`employee_hire_evaluation.evaluation`) RETURN t1.Name ORDER BY t2.Bonus DESC LIMIT 1


baseline pred: MATCH (evaluation:`employee_hire_evaluation.evaluation`) RETURN evaluation.Name ORDER BY evaluation.Bonus DESC LIMIT 1
label query  : MATCH (t1:`employee_hire_evaluation.employee`)-[]-(t2:`employee_hire_evaluation.evaluation`) RETURN t1.Name ORDER BY t2.Bonus DESC LIMIT 1


baseline pred: MATCH (evaluation:`employee_hire_evaluation.evaluation`) WHERE evaluation.Year_awarded ` > 'No' RETURN evaluation.Name
label query  : MATCH (employee:`employee_hire_evaluation.employee`) WHERE NOT (employee)-[]-(:`employee_hire_evaluation.evaluation`)     RETURN employee.Name


baseline pred: MATCH (employee:`employee_hire_evaluation.employee`) WHERE NOT (employee)-[]-(:`employee_hire_evaluation.evaluation`) RETURN employee.Name
label query  : MATCH (employee:`employee_hire_evaluation.employee`) WHERE NOT (employee)-[]-(:`employee_hire_evaluation.evaluation`)     RETURN employee.Name


baseline pred: MATCH (employee:`employee_hire_evaluation.employee`) RETURN employee.Name ORDER BY employee.Number_products DESC LIMIT 1
label query  : MATCH (t1:`employee_hire_evaluation.hiring`)-[]-(t2:`employee_hire_evaluation.shop`) WITH t2, count(t1.Shop_ID) AS cnt RETURN t2.Name ORDER BY cnt DESC LIMIT 1


baseline pred: MATCH (employee:`employee_hire_evaluation.employee`) RETURN employee.Name ORDER BY employee.Name DESC LIMIT 1
label query  : MATCH (t1:`employee_hire_evaluation.hiring`)-[]-(t2:`employee_hire_evaluation.shop`) WITH t2, count(t1.Shop_ID) AS cnt RETURN t2.Name ORDER BY cnt DESC LIMIT 1


baseline pred: MATCH (shop:`employee_hire_evaluation.shop`) WHERE NOT (shop)-[]-(:`employee_hire_evaluation.hiring`) RETURN shop.Name
label query  : MATCH (shop:`employee_hire_evaluation.shop`) WHERE NOT (shop)-[]-(:`employee_hire_evaluation.hiring`)     RETURN shop.Name


baseline pred: MATCH (shop:`employee_hire_evaluation.shop`) WHERE NOT (shop)-[]-(:`employee_hire_evaluation.employee`) RETURN shop.Name
label query  : MATCH (shop:`employee_hire_evaluation.shop`) WHERE NOT (shop)-[]-(:`employee_hire_evaluation.hiring`)     RETURN shop.Name


baseline pred: MATCH (employee:`employee_hire_evaluation.employee`) RETURN employee.Name,count(*)
label query  : MATCH (t1:`employee_hire_evaluation.hiring`)-[]-(t2:`employee_hire_evaluation.shop`) RETURN count(*),t2.Name


baseline pred: MATCH (employee:`employee_hire_evaluation.employee`) RETURN employee.Number_products,employee.Name
label query  : MATCH (t1:`employee_hire_evaluation.hiring`)-[]-(t2:`employee_hire_evaluation.shop`) RETURN count(*),t2.Name


baseline pred: MATCH (documents:`cre_Doc_Template_Mgt.Documents`) WHERE documents.Document_Name = 'Robbin CV' RETURN documents.Document_ID,documents.Template_ID,documents.Document_Description
label query  : MATCH (documents:`cre_Doc_Template_Mgt.Documents`) WHERE documents.Document_Name = "Robbin CV" RETURN documents.Document_ID,documents.Template_ID,documents.Document_Description


baseline pred: MATCH (documents:`cre_Doc_Template_Mgt.Documents`) WHERE documents.Document_Name = 'Robbin CV' RETURN documents.Document_ID,documents.Document_Description
label query  : MATCH (documents:`cre_Doc_Template_Mgt.Documents`) WHERE documents.Document_Name = "Robbin CV" RETURN documents.Document_ID,documents.Template_ID,documents.Document_Description


baseline pred: MATCH (documents:`cre_Doc_Template_Mgt.Documents`) RETURN count(DISTINCT documents.Template_Type_Code)
label query  : MATCH (documents:`cre_Doc_Template_Mgt.Documents`) RETURN count(DISTINCT documents.Template_ID)


baseline pred: MATCH (documents:`cre_Doc_Template_Mgt.Documents`) RETURN count(DISTINCT documents.Template_Type_Code)
label query  : MATCH (documents:`cre_Doc_Template_Mgt.Documents`) RETURN count(DISTINCT documents.Template_ID)


baseline pred: MATCH (documents:`cre_Doc_Template_Mgt.Documents`) WHERE documents.Template_Type_Code = 'PPT' RETURN count(*)
label query  : MATCH (T1:`cre_Doc_Template_Mgt.Documents`)-[]-(T2:`cre_Doc_Template_Mgt.Templates`) WHERE T2.Template_Type_Code = 'PPT' RETURN count(*)


baseline pred: MATCH (documents:`cre_Doc_Template_Mgt.Documents`) WHERE documents.Template_Type_Code = 'PPT' RETURN count(*)
label query  : MATCH (T1:`cre_Doc_Template_Mgt.Documents`)-[]-(T2:`cre_Doc_Template_Mgt.Templates`) WHERE T2.Template_Type_Code = 'PPT' RETURN count(*)


baseline pred: MATCH (T1:`cre_Doc_Template_Mgt.Documents`)-[]-(T2:`cre_Doc_Template_Mgt.Templates`) WITH count(*) AS count, T1.Template_ID AS Template_ID WHERE count > 1 RETURN Template_ID
label query  : MATCH (documents:`cre_Doc_Template_Mgt.Documents`) WITH documents.Template_ID AS Template_ID, count(*) AS count WHERE count  > 1 RETURN Template_ID


baseline pred: MATCH (T1:`cre_Doc_Template_Mgt.Templates`)-[]-(T2:`cre_Doc_Template_Mgt.Documents`) WITH count(*) AS count, T1.Template_ID AS Template_ID WHERE count > 1 RETURN Template_ID
label query  : MATCH (documents:`cre_Doc_Template_Mgt.Documents`) WITH documents.Template_ID AS Template_ID, count(*) AS count WHERE count  > 1 RETURN Template_ID


baseline pred: MATCH (T1:`cre_Doc_Template_Mgt.Templates`)-[]-(T2:`cre_Doc_Template_Mgt.Ref_Template_Types`) RETURN DISTINCT T1.Template_Type_Code
label query  : MATCH (templates:`cre_Doc_Template_Mgt.Templates`) RETURN DISTINCT templates.Template_Type_Code


baseline pred: MATCH (T1:`cre_Doc_Template_Mgt.Templates`)-[]-(T2:`cre_Doc_Template_Mgt.Ref_Templates`) RETURN DISTINCT T1.Template_Type_Code
label query  : MATCH (templates:`cre_Doc_Template_Mgt.Templates`) RETURN DISTINCT templates.Template_Type_Code


baseline pred: MATCH (T1:`cre_Doc_Template_Mgt.Templates`)-[]-(T2:`cre_Doc_Template_Mgt.Ref_Templates`) WHERE T2.Version_Number ` 5 RETURN T1.Template_Type_Code,T1.Template_Type_Code
label query  : MATCH (templates:`cre_Doc_Template_Mgt.Templates`) WHERE templates.Version_Number > 5 RETURN templates.Version_Number,templates.Template_Type_Code


baseline pred: MATCH (T1:`cre_Doc_Template_Mgt.Templates`)-[]-(T2:`cre_Doc_Template_Mgt.Ref_Template_Types`) WHERE T2.Version_Number > 5 RETURN T1.Version_Number,T1.Template_Type_Code
label query  : MATCH (templates:`cre_Doc_Template_Mgt.Templates`) WHERE templates.Version_Number > 5 RETURN templates.Version_Number,templates.Template_Type_Code


baseline pred: MATCH (T1:`cre_Doc_Template_Mgt.Templates`)-[]-(T2:`cre_Doc_Template_Mgt.Ref_Template_Types`) RETURN T1.Template_Type_Code,count(*)
label query  : MATCH (templates:`cre_Doc_Template_Mgt.Templates`) RETURN templates.Template_Type_Code,count(*)


baseline pred: MATCH (T1:`cre_Doc_Template_Mgt.Templates`)-[]-(T2:`cre_Doc_Template_Mgt.Ref_Template_Types`) RETURN T1.Template_Type_Code,count(*)
label query  : MATCH (templates:`cre_Doc_Template_Mgt.Templates`) RETURN templates.Template_Type_Code,count(*)


baseline pred: MATCH (T1:`cre_Doc_Template_Mgt.Templates`)-[]-(T2:`cre_Doc_Template_Mgt.Ref_Templates`) WITH count(*) AS count, T1.Template_Type_Code AS Template_Type_Code WHERE count > 3 RETURN Template_Type_Code
label query  : MATCH (templates:`cre_Doc_Template_Mgt.Templates`) WITH templates.Template_Type_Code AS Template_Type_Code, count(*) AS count WHERE count  < 3 RETURN Template_Type_Code


baseline pred: MATCH (T1:`cre_Doc_Template_Mgt.Templates`)-[]-(T2:`cre_Doc_Template_Mgt.Ref_Template_Types`) WITH count(*) AS count, T1.Template_Type_Code AS Template_Type_Code WHERE count > 3 RETURN Template_Type_Code
label query  : MATCH (templates:`cre_Doc_Template_Mgt.Templates`) WITH templates.Template_Type_Code AS Template_Type_Code, count(*) AS count WHERE count  < 3 RETURN Template_Type_Code


baseline pred: MATCH (documents:`cre_Doc_Template_Mgt.Documents`) WHERE documents.Document_Name = 'Data base' RETURN documents.Template_Type_Code
label query  : MATCH (T1:`cre_Doc_Template_Mgt.Templates`)-[]-(T2:`cre_Doc_Template_Mgt.Documents`) WHERE T2.Document_Name = "Data base" RETURN T1.Template_Type_Code


baseline pred: MATCH (documents:`cre_Doc_Template_Mgt.Documents`) WHERE documents.Document_Name = 'Data base' RETURN documents.Template_Type_Code
label query  : MATCH (T1:`cre_Doc_Template_Mgt.Templates`)-[]-(T2:`cre_Doc_Template_Mgt.Documents`) WHERE T2.Document_Name = "Data base" RETURN T1.Template_Type_Code


baseline pred: MATCH (T1:`cre_Doc_Template_Mgt.Ref_Templates`)-[]-(T2:`cre_Doc_Template_Mgt.Documents`) RETURN T1.Template_Type_Code,count(*)
label query  : MATCH (T1:`cre_Doc_Template_Mgt.Templates`)-[]-(T2:`cre_Doc_Template_Mgt.Documents`) RETURN T1.Template_Type_Code,count(*)


baseline pred: MATCH (documents:`cre_Doc_Template_Mgt.Documents`) RETURN documents.Template_Type_Code,count(*)
label query  : MATCH (T1:`cre_Doc_Template_Mgt.Templates`)-[]-(T2:`cre_Doc_Template_Mgt.Documents`) RETURN T1.Template_Type_Code,count(*)


baseline pred: MATCH (T1:`cre_Doc_Template_Mgt.Ref_Templates`)-[]-(T2:`cre_Doc_Template_Mgt.Templates`) RETURN T1.Template_Type_Code,T1.Template_Type_Description
label query  : MATCH (ref_template_types:`cre_Doc_Template_Mgt.Ref_Template_Types`) RETURN ref_template_types.Template_Type_Code,ref_template_types.Template_Type_Description


baseline pred: MATCH (T1:`cre_Doc_Template_Mgt.Ref_Template_Types`)-[]-(T2:`cre_Doc_Template_Mgt.Documents`) RETURN DISTINCT T1.Template_Type_Description
label query  : MATCH (T1:`cre_Doc_Template_Mgt.Ref_Template_Types`)-[]-(T2:`cre_Doc_Template_Mgt.Templates`)-[]-(T3:`cre_Doc_Template_Mgt.Documents`) RETURN DISTINCT T1.Template_Type_Description


baseline pred: MATCH (T1:`cre_Doc_Template_Mgt.Documents`)-[]-(T2:`cre_Doc_Template_Mgt.Ref_Template_Types`) RETURN DISTINCT T1.Template_Description
label query  : MATCH (T1:`cre_Doc_Template_Mgt.Ref_Template_Types`)-[]-(T2:`cre_Doc_Template_Mgt.Templates`)-[]-(T3:`cre_Doc_Template_Mgt.Documents`) RETURN DISTINCT T1.Template_Type_Description


baseline pred: MATCH (documents:`cre_Doc_Template_Mgt.Documents`) WHERE documents.Document_Name = 'Summer Show' RETURN count(*)
label query  : MATCH (T1:`cre_Doc_Template_Mgt.Paragraphs`)-[]-(T2:`cre_Doc_Template_Mgt.Documents`) WHERE T2.Document_Name = 'Summer Show' RETURN count(*)


baseline pred: MATCH (documents:`cre_Doc_Template_Mgt.Documents`) WHERE documents.Document_Name = 'Summer Show' RETURN count(*)
label query  : MATCH (T1:`cre_Doc_Template_Mgt.Paragraphs`)-[]-(T2:`cre_Doc_Template_Mgt.Documents`) WHERE T2.Document_Name = 'Summer Show' RETURN count(*)


baseline pred: MATCH (paragraphs:`cre_Doc_Template_Mgt.Paragraphs`) WHERE paragraphs.Paragraph_Text = 'Korea' RETURN paragraphs.Paragraph_Details
label query  : MATCH (paragraphs:`cre_Doc_Template_Mgt.Paragraphs`) WHERE paragraphs.Paragraph_Text =~'.*[K|k]orea.*' RETURN paragraphs.Other_Details


baseline pred: MATCH (paragraphs:`cre_Doc_Template_Mgt.Paragraphs`) WHERE paragraphs.Paragraph_Text = 'Korea' RETURN paragraphs.Paragraph_Details
label query  : MATCH (paragraphs:`cre_Doc_Template_Mgt.Paragraphs`) WHERE paragraphs.Paragraph_Text =~'.*[K|k]orea.*' RETURN paragraphs.Other_Details


baseline pred: MATCH (documents:`cre_Doc_Template_Mgt.Documents`) WHERE documents.Document_Name = 'Welcome to NY' RETURN documents.Paragraph_ID,documents.Paragraph_Text
label query  : MATCH (T1:`cre_Doc_Template_Mgt.Paragraphs`)-[]-(T2:`cre_Doc_Template_Mgt.Documents`) WHERE T2.Document_Name = 'Welcome to NY' RETURN T1.Paragraph_ID,T1.Paragraph_Text


baseline pred: MATCH (documents:`cre_Doc_Template_Mgt.Documents`) WHERE documents.Document_Name = 'Welcome to NY' RETURN documents.Paragraph_ID,documents.Paragraph_Text
label query  : MATCH (T1:`cre_Doc_Template_Mgt.Paragraphs`)-[]-(T2:`cre_Doc_Template_Mgt.Documents`) WHERE T2.Document_Name = 'Welcome to NY' RETURN T1.Paragraph_ID,T1.Paragraph_Text


baseline pred: MATCH (documents:`cre_Doc_Template_Mgt.Documents`) WHERE documents.Document_Name = "Customer reviews" RETURN documents.Paragraph_Text
label query  : MATCH (T1:`cre_Doc_Template_Mgt.Paragraphs`)-[]-(T2:`cre_Doc_Template_Mgt.Documents`) WHERE T2.Document_Name = "Customer reviews" RETURN T1.Paragraph_Text


baseline pred: MATCH (documents:`cre_Doc_Template_Mgt.Documents`) WHERE documents.Document_Name = 'Customer reviews' RETURN documents.Paragraph_Text
label query  : MATCH (T1:`cre_Doc_Template_Mgt.Paragraphs`)-[]-(T2:`cre_Doc_Template_Mgt.Documents`) WHERE T2.Document_Name = "Customer reviews" RETURN T1.Paragraph_Text


baseline pred: MATCH (documents:`cre_Doc_Template_Mgt.Paragraphs`) RETURN documents.Document_ID,count(*) ORDER BY documents.Document_ID
label query  : MATCH (paragraphs:`cre_Doc_Template_Mgt.Paragraphs`) RETURN paragraphs.Document_ID,count(*) ORDER BY paragraphs.Document_ID


baseline pred: MATCH (documents:`cre_Doc_Template_Mgt.Paragraphs`) RETURN documents.Paragraph_ID,count(*) ORDER BY documents.Paragraph_ID
label query  : MATCH (paragraphs:`cre_Doc_Template_Mgt.Paragraphs`) RETURN paragraphs.Document_ID,count(*) ORDER BY paragraphs.Document_ID


baseline pred: MATCH (documents:`cre_Doc_Template_Mgt.Documents`) RETURN documents.Document_ID,documents.Document_Name,count(*)
label query  : MATCH (T1:`cre_Doc_Template_Mgt.Paragraphs`)-[]-(T2:`cre_Doc_Template_Mgt.Documents`) RETURN T1.Document_ID,T2.Document_Name,count(*)


baseline pred: MATCH (documents:`cre_Doc_Template_Mgt.Documents`) RETURN documents.Document_ID,documents.Document_Name,count(*)
label query  : MATCH (T1:`cre_Doc_Template_Mgt.Paragraphs`)-[]-(T2:`cre_Doc_Template_Mgt.Documents`) RETURN T1.Document_ID,T2.Document_Name,count(*)


baseline pred: MATCH (documents:`cre_Doc_Template_Mgt.Documents`) WITH count(*) AS count, documents.Document_ID AS Document_ID WHERE count >= 2 RETURN Document_ID
label query  : MATCH (paragraphs:`cre_Doc_Template_Mgt.Paragraphs`) WITH count(*) AS count, paragraphs.Document_ID AS Document_ID WHERE count  >= 2 RETURN Document_ID


baseline pred: MATCH (documents:`cre_Doc_Template_Mgt.Documents`) WITH count(*) AS count, documents.Paragraph_ID AS Paragraph_ID WHERE count >= 2 RETURN Paragraph_ID
label query  : MATCH (paragraphs:`cre_Doc_Template_Mgt.Paragraphs`) WITH count(*) AS count, paragraphs.Document_ID AS Document_ID WHERE count  >= 2 RETURN Document_ID


baseline pred: MATCH (documents:`cre_Doc_Template_Mgt.Documents`) RETURN documents.Document_ID,documents.Document_Name ORDER BY documents.Paragraph_Text DESC LIMIT 1
label query  : MATCH (T1:`cre_Doc_Template_Mgt.Paragraphs`)-[]-(T2:`cre_Doc_Template_Mgt.Documents`) WITH count(T1.Document_ID) AS cnt, T1, T2 RETURN T1.Document_ID,T2.Document_Name ORDER BY cnt DESC LIMIT 1


baseline pred: MATCH (documents:`cre_Doc_Template_Mgt.Documents`) RETURN documents.Document_ID,documents.Document_Name ORDER BY documents.Paragraph_Text DESC LIMIT 1
label query  : MATCH (T1:`cre_Doc_Template_Mgt.Paragraphs`)-[]-(T2:`cre_Doc_Template_Mgt.Documents`) WITH count(T1.Document_ID) AS cnt, T1, T2 RETURN T1.Document_ID,T2.Document_Name ORDER BY cnt DESC LIMIT 1


baseline pred: MATCH (paragraphs:`cre_Doc_Template_Mgt.Paragraphs`) RETURN documents.Paragraph_ID ORDER BY documents.Paragraph_ID DESC LIMIT 1
label query  : MATCH (paragraphs:`cre_Doc_Template_Mgt.Paragraphs`) RETURN paragraphs.Document_ID ORDER BY paragraphs.Document_ID ASC LIMIT 1


baseline pred: MATCH (documents:`cre_Doc_Template_Mgt.Documents`) RETURN documents.Document_ID ORDER BY documents.Paragraph_Text DESC LIMIT 1
label query  : MATCH (paragraphs:`cre_Doc_Template_Mgt.Paragraphs`) RETURN paragraphs.Document_ID ORDER BY paragraphs.Document_ID ASC LIMIT 1


baseline pred: MATCH (t1:`course_teach.teacher`)-[]-(t2:`course_teach.course`) WHERE t2.Hometown ` > 'Little Lever Urban District' RETURN DISTINCT t2.Name
label query  : MATCH (teacher:`course_teach.teacher`) WHERE teacher.Hometown <> 'little lever urban district' RETURN teacher.Name


baseline pred: MATCH (teacher:`course_teach.teacher`) WHERE teacher.Hometown ` ` "Little Lever Urban District" RETURN teacher.Name
label query  : MATCH (teacher:`course_teach.teacher`) WHERE teacher.Hometown <> 'little lever urban district' RETURN teacher.Name


baseline pred: MATCH (teacher:`course_teach.teacher`) WHERE teacher.Age = 32 OR teacher.Age = 33 RETURN teacher.Name
label query  : MATCH (teacher:`course_teach.teacher`) WHERE teacher.Age = '32' OR teacher.Age = '33' RETURN teacher.Name


baseline pred: MATCH (teacher:`course_teach.teacher`) WHERE teacher.Age = 32 OR teacher.Age = 33 RETURN teacher.Name
label query  : MATCH (teacher:`course_teach.teacher`) WHERE teacher.Age = '32' OR teacher.Age = '33' RETURN teacher.Name


baseline pred: MATCH (teacher:`course_teach.teacher`) RETURN teacher.Hometown ORDER BY teacher.Age DESC LIMIT 1
label query  : MATCH (teacher:`course_teach.teacher`) RETURN teacher.Hometown ORDER BY teacher.Age ASC LIMIT 1


baseline pred: MATCH (teacher:`course_teach.teacher`) RETURN teacher.Hometown ORDER BY teacher.Age DESC LIMIT 1
label query  : MATCH (teacher:`course_teach.teacher`) RETURN teacher.Hometown ORDER BY teacher.Age ASC LIMIT 1


baseline pred: MATCH (teacher:`course_teach.teacher`) WITH count(*) AS count, teacher.Hometown AS Hometown WHERE count >= 2 RETURN Hometown
label query  : MATCH (teacher:`course_teach.teacher`) WITH teacher.Hometown AS Hometown, count(*) AS count WHERE count  >= 2 RETURN Hometown


baseline pred: MATCH (teacher:`course_teach.teacher`) WITH count(*) AS count, teacher.Hometown AS Hometown WHERE count >= 2 RETURN Hometown
label query  : MATCH (teacher:`course_teach.teacher`) WITH teacher.Hometown AS Hometown, count(*) AS count WHERE count  >= 2 RETURN Hometown


baseline pred: MATCH (course_arrange:`course_teach.course_arrange`) RETURN course_arrange.Name,course_arrange.Course
label query  : MATCH (T2:`course_teach.course`)-[T1:`course_teach.course_arrange`]-(T3:`course_teach.teacher`) RETURN T3.Name,T2.Course


baseline pred: MATCH (teacher:`course_teach.teacher`) RETURN teacher.Name,teacher.Course
label query  : MATCH (T2:`course_teach.course`)-[T1:`course_teach.course_arrange`]-(T3:`course_teach.teacher`) RETURN T3.Name,T2.Course


baseline pred: MATCH (teacher:`course_teach.teacher`) RETURN teacher.Name ORDER BY teacher.Name ASC
label query  : MATCH (T2:`course_teach.course`)-[T1:`course_teach.course_arrange`]-(T3:`course_teach.teacher`) RETURN T3.Name,T2.Course ORDER BY T3.Name


baseline pred: MATCH (teacher:`course_teach.teacher`) RETURN teacher.Name ORDER BY teacher.Name ASC
label query  : MATCH (T2:`course_teach.course`)-[T1:`course_teach.course_arrange`]-(T3:`course_teach.teacher`) RETURN T3.Name,T2.Course ORDER BY T3.Name


baseline pred: MATCH (course:`course_teach.course`) WHERE course.Course = 'Math' RETURN course.Name
label query  : MATCH (T2:`course_teach.course`)-[T1:`course_teach.course_arrange`]-(T3:`course_teach.teacher`) WHERE T2.Course = 'Math' RETURN T3.Name


baseline pred: MATCH (course:`course_teach.course`) WHERE course.Curriculum = 'Math' RETURN course.Name
label query  : MATCH (T2:`course_teach.course`)-[T1:`course_teach.course_arrange`]-(T3:`course_teach.teacher`) WHERE T2.Course = 'Math' RETURN T3.Name


baseline pred: MATCH (course:`course_teach.course`) RETURN course.Name,count(*)
label query  : MATCH (T2:`course_teach.teacher`)-[T1:`course_teach.course_arrange`]-() RETURN T2.Name,count(*)


baseline pred: MATCH (teacher:`course_teach.teacher`) RETURN teacher.Name,count(*)
label query  : MATCH (T2:`course_teach.teacher`)-[T1:`course_teach.course_arrange`]-() RETURN T2.Name,count(*)


baseline pred: MATCH (course:`course_teach.course`) WITH count(*) AS count, course.Name AS Name WHERE count >= 2 RETURN Name
label query  : MATCH (T2:`course_teach.teacher`)-[T1:`course_teach.course_arrange`]-() WITH T2.Name AS Name, count(*) AS count WHERE count  >= 2 RETURN Name


baseline pred: MATCH (teacher:`course_teach.teacher`) WITH count(*) AS count, teacher.Name AS Name WHERE count >= 2 RETURN Name
label query  : MATCH (T2:`course_teach.teacher`)-[T1:`course_teach.course_arrange`]-() WITH T2.Name AS Name, count(*) AS count WHERE count  >= 2 RETURN Name


baseline pred: MATCH (visitor:`museum_visit.visitor`) WHERE visitor.Age ` 30 RETURN count(*)
label query  : MATCH (visitor:`museum_visit.visitor`) WHERE visitor.Age < 30 RETURN count(*)


baseline pred: MATCH (visitor:`museum_visit.visitor`) WHERE visitor.Level_of_membership > 4 RETURN visitor.Name ORDER BY visitor.Level_of_membership
label query  : MATCH (visitor:`museum_visit.visitor`) WHERE visitor.Level_of_membership > 4 RETURN visitor.Name ORDER BY visitor.Level_of_membership DESC


baseline pred: MATCH (visitor:`museum_visit.visitor`) WHERE visitor.Level_of_membership ` 4 RETURN avg(visitor.Age)
label query  : MATCH (visitor:`museum_visit.visitor`) WHERE visitor.Level_of_membership <= 4 RETURN avg(visitor.Age)


baseline pred: MATCH (visitor:`museum_visit.visitor`) WHERE visitor.Level_of_membership > 4 RETURN visitor.Name,visitor.Level_of_membership ORDER BY visitor.Age
label query  : MATCH (visitor:`museum_visit.visitor`) WHERE visitor.Level_of_membership > 4 RETURN visitor.Name,visitor.Level_of_membership ORDER BY visitor.Age DESC


baseline pred: MATCH (museum:`museum_visit.museum`) WHERE museum.Open_Year ` 2009 RETURN avg(museum.Num_of_Staff)
label query  : MATCH (museum:`museum_visit.museum`) WHERE museum.Open_Year < '2009' RETURN avg(museum.Num_of_Staff)


baseline pred: MATCH (museum:`museum_visit.museum`) WHERE museum.Name = 'Plaza Museum' RETURN museum.Open_Year,museum.Num_of_Staff
label query  : MATCH (museum:`museum_visit.museum`) WHERE museum.Name = 'Plaza Museum' RETURN museum.Num_of_Staff,museum.Open_Year


baseline pred: MATCH (visitor:`museum_visit.visitor`) WITH count(*) AS count, visitor.Name AS Name, visitor.Age AS Age WHERE count > 1 RETURN ID,Name,age
label query  : MATCH (t1:`museum_visit.visitor`)-[t2:`museum_visit.visit`]-() WITH count(*) AS count, t1.ID AS ID, t1.Name AS Name, t1.Age AS Age WHERE count  > 1 RETURN ID,Name,Age


baseline pred: MATCH (visitor:`museum_visit.visitor`) RETURN visitor.Name,visitor.Age ORDER BY visitor.Num_of_Ticket DESC LIMIT 1
label query  : MATCH (t1:`museum_visit.visitor`)-[t2:`museum_visit.visit`]-() RETURN t1.Name,t1.Age ORDER BY t2.Num_of_Ticket DESC LIMIT 1


baseline pred: MATCH (museum:`museum_visit.museum`) WHERE museum.Open_Year ` 2013 OR museum.Open_Year ` 2008 RETURN count(*)
label query  : MATCH (museum:`museum_visit.museum`) WHERE museum.Open_Year > '2013' OR museum.Open_Year < '2008' RETURN count(*)


baseline pred: MATCH (ship:`battle_death.ship`) RETURN ship.name,ship.tonnage ORDER BY ship.tonnage DESC
label query  : MATCH (ship:`battle_death.ship`) RETURN ship.name,ship.tonnage ORDER BY ship.name DESC


baseline pred: MATCH (battle:`battle_death.battle`) RETURN battle.name,battle.date,battle.result
label query  : MATCH (battle:`battle_death.battle`) RETURN battle.name,battle.date


baseline pred: MATCH (death:`battle_death.death`) RETURN max(death.death),min(death.death_toll)
label query  : MATCH (death:`battle_death.death`) RETURN max(death.killed),min(death.killed)


baseline pred: MATCH (battle:`battle_death.battle`) WHERE battle.bulgaric_commander ` > 'Boril' RETURN battle.name,battle.result
label query  : MATCH (battle:`battle_death.battle`) WHERE battle.bulgarian_commander <> 'Boril' RETURN battle.name,battle.result


baseline pred: MATCH (ship:`battle_death.ship`) WHERE ship.ship_type = 'Brig' RETURN battle.id,ship.name
label query  : MATCH (T1:`battle_death.battle`)-[]-(T2:`battle_death.ship`) WHERE T2.ship_type = 'Brig' RETURN DISTINCT T1.id,T1.name


baseline pred: MATCH (battle:`battle_death.battle`) WHERE battle.bulgarian_commander = 'Kaloyan' AND battle.latin_commander = 'Baldwin I' RETURN DISTINCT battle.name
label query  : MATCH (battle:`battle_death.battle`) WHERE battle.bulgarian_commander = 'Kaloyan' AND battle.latin_commander = 'Baldwin I' RETURN battle.name


baseline pred: MATCH (death:`battle_death.death`) WHERE death.dead = 'East' RETURN death.note
label query  : MATCH (death:`battle_death.death`) WHERE death.note =~'.*[E|e]ast.*' RETURN death.note


baseline pred: MATCH (addresses:`student_transcripts_tracking.Addresses`) WHERE addresses.line_1 AND addresses.line_2 = 2 RETURN addresses.address_id
label query  : MATCH (addresses:`student_transcripts_tracking.Addresses`) RETURN addresses.line_1,addresses.line_2


baseline pred: MATCH (courses:`student_transcripts_tracking.Courses`) WHERE courses.course_name ='math' RETURN courses.course_description
label query  : MATCH (courses:`student_transcripts_tracking.Courses`) WHERE courses.course_name = 'math' RETURN courses.course_description


baseline pred: MATCH (courses:`student_transcripts_tracking.Courses`) WHERE courses.course_name ='math' RETURN courses.course_description
label query  : MATCH (courses:`student_transcripts_tracking.Courses`) WHERE courses.course_name = 'math' RETURN courses.course_description


baseline pred: MATCH (departments:`student_transcripts_tracking.Departments`) RETURN count(*)
label query  : MATCH (degree_programs:`student_transcripts_tracking.Degree_Programs`) RETURN count(DISTINCT degree_programs.department_id)


baseline pred: MATCH (degree_programs:`student_transcripts_tracking.Degree_Programs`) RETURN count(DISTINCT degree_programs.department_description)
label query  : MATCH (degree_programs:`student_transcripts_tracking.Degree_Programs`) RETURN count(DISTINCT degree_programs.department_id)


baseline pred: MATCH (degree_programs:`student_transcripts_tracking.Degree_Programs`) RETURN count(DISTINCT degree_programs.degree_program_id)
label query  : MATCH (degree_programs:`student_transcripts_tracking.Degree_Programs`) RETURN count(DISTINCT degree_programs.degree_summary_name)


baseline pred: MATCH (departments:`student_transcripts_tracking.Departments`) WHERE departments.department_description = 'engineering' RETURN count(*)
label query  : MATCH (T1:`student_transcripts_tracking.Departments`)-[]-(T2:`student_transcripts_tracking.Degree_Programs`) WHERE T1.department_name = 'engineer' RETURN count(*)


baseline pred: MATCH (departments:`student_transcripts_tracking.Departments`) WHERE departments.degree_program_id = 'engineering' RETURN count(*)
label query  : MATCH (T1:`student_transcripts_tracking.Departments`)-[]-(T2:`student_transcripts_tracking.Degree_Programs`) WHERE T1.department_name = 'engineer' RETURN count(*)


baseline pred: MATCH (courses:`student_transcripts_tracking.Courses`) WITH count(*) AS count, courses.course_name AS course_name WHERE count >= 2 RETURN course_name,course_id
label query  : MATCH (T1:`student_transcripts_tracking.Courses`)-[]-(T2:`student_transcripts_tracking.Sections`) WITH count(*) AS count, T1.course_id AS course_id, T1.course_name AS course_name WHERE count  <= 2 RETURN course_name,course_id


baseline pred: MATCH (courses:`student_transcripts_tracking.Courses`) WITH count(*) AS count, courses.course_name AS course_name WHERE count > 2 RETURN course_name,course_id
label query  : MATCH (T1:`student_transcripts_tracking.Courses`)-[]-(T2:`student_transcripts_tracking.Sections`) WITH count(*) AS count, T1.course_id AS course_id, T1.course_name AS course_name WHERE count  <= 2 RETURN course_name,course_id


baseline pred: MATCH (sections:`student_transcripts_tracking.Sections`) RETURN sections.section_name ORDER BY sections.section_name
label query  : MATCH (sections:`student_transcripts_tracking.Sections`) RETURN sections.section_name ORDER BY sections.section_name DESC


baseline pred: MATCH (sections:`student_transcripts_tracking.Sections`) RETURN sections.section_name ORDER BY sections.section_name
label query  : MATCH (sections:`student_transcripts_tracking.Sections`) RETURN sections.section_name ORDER BY sections.section_name DESC


baseline pred: MATCH (student_enrolment:`student_transcripts_tracking.Student_Enrolment`) RETURN student_enrolment.semester_name,student_enrolment.student_id ORDER BY student_enrolment.date_first_registered DESC LIMIT 1
label query  : MATCH (T1:`student_transcripts_tracking.Semesters`)-[]-(T2:`student_transcripts_tracking.Student_Enrolment`) WITH T1, count(T1.semester_id) AS cnt RETURN T1.semester_name,T1.semester_id ORDER BY cnt DESC LIMIT 1


baseline pred: MATCH (students:`student_transcripts_tracking.Students`) RETURN students.semester_name,students.student_id ORDER BY students.date_first_registered DESC LIMIT 1
label query  : MATCH (T1:`student_transcripts_tracking.Semesters`)-[]-(T2:`student_transcripts_tracking.Student_Enrolment`) WITH T1, count(T1.semester_id) AS cnt RETURN T1.semester_name,T1.semester_id ORDER BY cnt DESC LIMIT 1


baseline pred: MATCH (departments:`student_transcripts_tracking.Departments`) WHERE departments.department_name = 'computer' RETURN departments.department_description
label query  : MATCH (departments:`student_transcripts_tracking.Departments`) WHERE departments.department_name =~'.*[C|c]omputer.*' RETURN departments.department_description


baseline pred: MATCH (departments:`student_transcripts_tracking.Departments`) WHERE departments.department_name = 'computer' RETURN departments.department_description
label query  : MATCH (departments:`student_transcripts_tracking.Departments`) WHERE departments.department_name =~'.*[C|c]omputer.*' RETURN departments.department_description


baseline pred: MATCH (student_enrolment:`student_transcripts_tracking.Student_Enrolment`) WITH count(*) AS count, student_enrolment.first_name,student_enrolment.last_name AS last_name WHERE count >= 2 RETURN first_name,mid_name,last_name,student_enrolment_id
label query  : MATCH (T1:`student_transcripts_tracking.Students`)-[]-(T2:`student_transcripts_tracking.Student_Enrolment`) WITH T1.first_name AS first_name, T1.middle_name AS middle_name, T1.last_name AS last_name, T1.student_id AS student_id, count(*) AS count WHERE count  = 2 RETURN first_name,middle_name,last_name,student_id


baseline pred: MATCH (student_enrolment:`student_transcripts_tracking.Student_Enrolment`) WITH count(*) AS count, student_enrolment.first_name,student_enrolment.last_name AS last_name WHERE count >= 2 RETURN first_name,mid_name,last_name,last_name
label query  : MATCH (T1:`student_transcripts_tracking.Students`)-[]-(T2:`student_transcripts_tracking.Student_Enrolment`) WITH T1.first_name AS first_name, T1.middle_name AS middle_name, T1.last_name AS last_name, T1.student_id AS student_id, count(*) AS count WHERE count  = 2 RETURN first_name,middle_name,last_name,student_id


baseline pred: MATCH (student_enrolment:`student_transcripts_tracking.Student_Enrolment`) WHERE student_enrolment.degree_summary_name = 'Bachelor' RETURN student_enrolment.first_name,student_enrolment.middle_name,student_enrolment.last_name
label query  : MATCH (T1:`student_transcripts_tracking.Students`)-[]-(T2:`student_transcripts_tracking.Student_Enrolment`)-[]-(T3:`student_transcripts_tracking.Degree_Programs`) WHERE T3.degree_summary_name = 'Bachelor' RETURN DISTINCT T1.first_name,T1.middle_name,T1.last_name


baseline pred: MATCH (student_enrolment:`student_transcripts_tracking.Student_Enrolment`) WHERE student_enrolment.degree_program_id = 'Bachelors' RETURN student_enrolment.first_name,student_enrolment.middle_name,student_enrolment.last_name
label query  : MATCH (T1:`student_transcripts_tracking.Students`)-[]-(T2:`student_transcripts_tracking.Student_Enrolment`)-[]-(T3:`student_transcripts_tracking.Degree_Programs`) WHERE T3.degree_summary_name = 'Bachelor' RETURN DISTINCT T1.first_name,T1.middle_name,T1.last_name


baseline pred: MATCH (student_enrolment:`student_transcripts_tracking.Student_Enrolment`) RETURN student_enrolment.degree_program_id ORDER BY student_enrolment.degree_program_id DESC LIMIT 1
label query  : MATCH (T1:`student_transcripts_tracking.Degree_Programs`)-[]-(T2:`student_transcripts_tracking.Student_Enrolment`) WITH T1, count(T1.degree_summary_name) AS cnt RETURN T1.degree_summary_name ORDER BY cnt DESC LIMIT 1


baseline pred: MATCH (student_enrolment:`student_transcripts_tracking.Student_Enrolment`) RETURN student_enrolment.degree_summary_name ORDER BY student_enrolment.degree_summary_name DESC LIMIT 1
label query  : MATCH (T1:`student_transcripts_tracking.Degree_Programs`)-[]-(T2:`student_transcripts_tracking.Student_Enrolment`) WITH T1, count(T1.degree_summary_name) AS cnt RETURN T1.degree_summary_name ORDER BY cnt DESC LIMIT 1


baseline pred: MATCH (student_enrolment:`student_transcripts_tracking.Student_Enrolment`) RETURN student_enrolment.student_enrolment_id,student_enrolment.degree_summary_description ORDER BY student_enrolment.student_enrolment_id DESC LIMIT 1
label query  : MATCH (T1:`student_transcripts_tracking.Degree_Programs`)-[]-(T2:`student_transcripts_tracking.Student_Enrolment`) WITH count(T1.degree_program_id) AS cnt, T1 RETURN T1.degree_program_id,T1.degree_summary_name ORDER BY cnt DESC LIMIT 1


baseline pred: MATCH (student_enrolment:`student_transcripts_tracking.Student_Enrolment`) RETURN student_enrolment.degree_program_id,student_enrolment.degree_summary_name ORDER BY student_enrolment.degree_summary_name DESC LIMIT 1
label query  : MATCH (T1:`student_transcripts_tracking.Degree_Programs`)-[]-(T2:`student_transcripts_tracking.Student_Enrolment`) WITH count(T1.degree_program_id) AS cnt, T1 RETURN T1.degree_program_id,T1.degree_summary_name ORDER BY cnt DESC LIMIT 1


baseline pred: MATCH (student_enrolment_courses:`student_transcripts_tracking.Student_Enrolment_Courses`) RETURN student_enrolment_courses.course_name
label query  : MATCH (T1:`student_transcripts_tracking.Courses`)-[]-(T2:`student_transcripts_tracking.Student_Enrolment_Courses`) RETURN DISTINCT T1.course_name


baseline pred: MATCH (student_enrolment_courses:`student_transcripts_tracking.Student_Enrolment_Courses`) RETURN student_enrolment_courses.course_name
label query  : MATCH (T1:`student_transcripts_tracking.Courses`)-[]-(T2:`student_transcripts_tracking.Student_Enrolment_Courses`) RETURN DISTINCT T1.course_name


baseline pred: MATCH (students:`student_transcripts_tracking.Students`) WHERE students.first_name = 'Timmothy' RETURN students.cell_mobile_number
label query  : MATCH (students:`student_transcripts_tracking.Students`) WHERE students.first_name = 'timmothy' AND students.last_name = 'ward' RETURN students.cell_mobile_number


baseline pred: MATCH (students:`student_transcripts_tracking.Students`) RETURN students.date_first_registered,students.middle_name,students.last_name
label query  : MATCH (students:`student_transcripts_tracking.Students`) RETURN students.first_name,students.middle_name,students.last_name ORDER BY students.date_first_registered ASC LIMIT 1


baseline pred: MATCH (students:`student_transcripts_tracking.Students`) RETURN students.date_first_registered,students.middle_name,students.last_name
label query  : MATCH (students:`student_transcripts_tracking.Students`) RETURN students.first_name,students.middle_name,students.last_name ORDER BY students.date_first_registered ASC LIMIT 1


baseline pred: MATCH (student_enrolment:`student_transcripts_tracking.Student_Enrolment`) RETURN student_enrolment.first_name,student_enrolment.middle_name,student_enrolment.last_name ORDER BY student_enrolment.date_first_registered DESC LIMIT 1
label query  : MATCH (students:`student_transcripts_tracking.Students`) RETURN students.first_name,students.middle_name,students.last_name ORDER BY students.date_left ASC LIMIT 1


baseline pred: MATCH (students:`student_transcripts_tracking.Students`) RETURN students.first_name,students.middle_name,students.last_name ORDER BY students.date_first_registered DESC LIMIT 1
label query  : MATCH (students:`student_transcripts_tracking.Students`) RETURN students.first_name,students.middle_name,students.last_name ORDER BY students.date_left ASC LIMIT 1


baseline pred: MATCH (addresses:`student_transcripts_tracking.Addresses`) WITH avg(addresses.permanent_address_id) AS avg, addresses.permanent_address_id AS permanent_address_id WHERE addresses.permanent_address_id ` permanent_address_id RETURN addresses.permanent_address_id AS permanent_address_id AS permanent_address_id AS permanent_address_id AS permanent_address_id AS permanent_address_id AS permanent_address_id AS permanent_address_id AS permanent_address_id WHERE permanent_address_id WHERE permanent_address_id WHERE permanent_address_id WHERE permanent_address_id WHERE permanent_address_id WHERE permanent_address_id WHERE permanent_address_id WHERE permanent_address_id WHERE permanent_address_id WHERE permanent_address_id WHERE permanent_address_id WHERE permanent_address_id WHERE permanent_address_id WHERE permanent_address_id WHERE permanent_address_id WHERE permanent_address_id WHERE permanent_address_id WHERE permanent_address_id WHERE permanent_address_id WHERE permanent_address_id WHERE permanent_address_id WHERE permanent_address_id WHERE permanent_address_id WHERE permanent_address_id WHERE permanent_address_id WHERE permanent_address_id WHERE permanent_address_id WHERE permanent_address_id WHERE permanent_address_id WHERE permanent_
label query  : MATCH (students:`student_transcripts_tracking.Students`) WHERE students.current_address_id <> students.permanent_address_id RETURN students.first_name


baseline pred: MATCH (students:`student_transcripts_tracking.Students`) WITH students.permanent_address_id AS permanent_address_id, students.first_name AS first_name WHERE student_id ` permanent_address_id RETURN student_id,first_name
label query  : MATCH (students:`student_transcripts_tracking.Students`) WHERE students.current_address_id <> students.permanent_address_id RETURN students.first_name


baseline pred: MATCH (students:`student_transcripts_tracking.Students`) RETURN students.address_id,students.line_2 ORDER BY students.current_address_id DESC LIMIT 1
label query  : MATCH (T1:`student_transcripts_tracking.Addresses`)-[]-(T2:`student_transcripts_tracking.Students`) WITH count(T1.address_id) AS cnt, T1 RETURN T1.address_id,T1.line_1,T1.line_2 ORDER BY cnt DESC LIMIT 1


baseline pred: MATCH (addresses:`student_transcripts_tracking.Addresses`) RETURN addresses.address_id,addresses.line_1,addresses.line_2 ORDER BY addresses.line_1 DESC LIMIT 1
label query  : MATCH (T1:`student_transcripts_tracking.Addresses`)-[]-(T2:`student_transcripts_tracking.Students`) WITH count(T1.address_id) AS cnt, T1 RETURN T1.address_id,T1.line_1,T1.line_2 ORDER BY cnt DESC LIMIT 1


baseline pred: MATCH (transcripts:`student_transcripts_tracking.Transcripts`) RETURN transcripts.date_first_registered,transcripts.student_details
label query  : MATCH (transcripts:`student_transcripts_tracking.Transcripts`) RETURN transcripts.transcript_date,transcripts.other_details ORDER BY transcripts.transcript_date ASC LIMIT 1


baseline pred: MATCH (transcripts:`student_transcripts_tracking.Transcripts`) RETURN transcripts.transcript_date,transcripts.student_details ORDER BY transcripts.date_first_registered DESC LIMIT 1
label query  : MATCH (transcripts:`student_transcripts_tracking.Transcripts`) RETURN transcripts.transcript_date,transcripts.other_details ORDER BY transcripts.transcript_date ASC LIMIT 1


baseline pred: MATCH (students:`student_transcripts_tracking.Students`) RETURN count(DISTINCT students.address_id)
label query  : MATCH (students:`student_transcripts_tracking.Students`) RETURN count(DISTINCT students.current_address_id)


baseline pred: MATCH (addresses:`student_transcripts_tracking.Addresses`) RETURN DISTINCT addresses.address_id
label query  : MATCH (students:`student_transcripts_tracking.Students`) RETURN count(DISTINCT students.current_address_id)


baseline pred: MATCH (student_enrolment:`student_transcripts_tracking.Student_Enrolment`) RETURN student_enrolment.student_details ORDER BY student_enrolment.student_details
label query  : MATCH (students:`student_transcripts_tracking.Students`) RETURN students.other_student_details ORDER BY students.other_student_details DESC


baseline pred: MATCH (students:`student_transcripts_tracking.Students`) RETURN students.other_student_details ORDER BY students.other_student_details
label query  : MATCH (students:`student_transcripts_tracking.Students`) RETURN students.other_student_details ORDER BY students.other_student_details DESC


baseline pred: MATCH (sections:`student_transcripts_tracking.Sections`) WHERE sections.section_id = 'h' RETURN sections.section_name
label query  : MATCH (sections:`student_transcripts_tracking.Sections`) WHERE sections.section_name = 'h' RETURN sections.section_description


baseline pred: MATCH (students:`student_transcripts_tracking.Students`) WHERE students.country = 'Haiti' OR students.cell_mobile_number = 09700166582 RETURN students.first_name
label query  : MATCH (t1:`student_transcripts_tracking.Students`)-[]-(t2:`student_transcripts_tracking.Addresses`) WHERE t2.country = 'haiti' OR t1.cell_mobile_number = '09700166582' RETURN t1.first_name


baseline pred: MATCH (students:`student_transcripts_tracking.Students`) WHERE students.country = 'Haiti' OR students.cell_mobile_number = 09700166582 RETURN students.first_name
label query  : MATCH (t1:`student_transcripts_tracking.Students`)-[]-(t2:`student_transcripts_tracking.Addresses`) WHERE t2.country = 'haiti' OR t1.cell_mobile_number = '09700166582' RETURN t1.first_name


baseline pred: MATCH (cartoon:`tvshow.Cartoon`) WHERE cartoon.Directed_by = 'Ben Jones' RETURN cartoon.Producer_code
label query  : MATCH (cartoon:`tvshow.Cartoon`) WHERE cartoon.Directed_by = 'Ben Jones' RETURN cartoon.Title


baseline pred: MATCH (cartoon:`tvshow.Cartoon`) WHERE cartoon.Directed_by = 'Ben Jones' RETURN cartoon.series_name
label query  : MATCH (cartoon:`tvshow.Cartoon`) WHERE cartoon.Directed_by = 'Ben Jones' RETURN cartoon.Title


baseline pred: MATCH (cartoon:`tvshow.Cartoon`) WHERE cartoon.Writed_by = 'Joseph Kuhr' RETURN count(*)
label query  : MATCH (cartoon:`tvshow.Cartoon`) WHERE cartoon.Written_by = 'Joseph Kuhr' RETURN count(*)


baseline pred: MATCH (cartoon:`tvshow.Cartoon`) WHERE cartoon.Writed_by = 'Joseph Kuhr' RETURN count(*)
label query  : MATCH (cartoon:`tvshow.Cartoon`) WHERE cartoon.Written_by = 'Joseph Kuhr' RETURN count(*)


baseline pred: MATCH (cartoon:`tvshow.Cartoon`) RETURN cartoon.Series_name,cartoon.Directed_by ORDER BY cartoon.Original_air_date
label query  : MATCH (cartoon:`tvshow.Cartoon`) RETURN cartoon.Title,cartoon.Directed_by ORDER BY cartoon.Original_air_date


baseline pred: MATCH (TV_channel:`tvshow.TV_Channel`) WHERE TV_channel.series_name = 'Sky Radio' RETURN TV_channel.Content
label query  : MATCH (tv_channel:`tvshow.TV_Channel`) WHERE tv_channel.series_name = 'Sky Radio' RETURN tv_channel.Content


baseline pred: MATCH (TV_series:`tvshow.TV_series`) WHERE TV_series.series_name = 'Sky Radio' RETURN TV_series.Content
label query  : MATCH (tv_channel:`tvshow.TV_Channel`) WHERE tv_channel.series_name = 'Sky Radio' RETURN tv_channel.Content


baseline pred: MATCH (TV_channel:`tvshow.TV_channel`) WHERE TV_channel.series_name = 'Sky Radio' RETURN TV_channel.Package_Option
label query  : MATCH (tv_channel:`tvshow.TV_Channel`) WHERE tv_channel.series_name = 'Sky Radio' RETURN tv_channel.Package_Option


baseline pred: MATCH (TV_Channel:`tvshow.TV_Channel`) WHERE TV_Channel.series_name = 'Sky Radio' RETURN TV_Channel.Package_Option
label query  : MATCH (tv_channel:`tvshow.TV_Channel`) WHERE tv_channel.series_name = 'Sky Radio' RETURN tv_channel.Package_Option


baseline pred: MATCH (TV_channel:`tvshow.TV_Channel`) WHERE TV_channel.Language = 'English' RETURN count(*)
label query  : MATCH (tv_channel:`tvshow.TV_Channel`) WHERE tv_channel.Language = 'English' RETURN count(*)


baseline pred: MATCH (TV_channel:`tvshow.TV_Channel`) WHERE TV_channel.Language = 'English' RETURN count(*)
label query  : MATCH (tv_channel:`tvshow.TV_Channel`) WHERE tv_channel.Language = 'English' RETURN count(*)


baseline pred: MATCH (TV_Channel:`tvshow.TV_Channel`) RETURN TV_Channel.Language ORDER BY TV_Channel.Language DESC LIMIT 1
label query  : MATCH (tv_channel:`tvshow.TV_Channel`) RETURN tv_channel.Language,count(*) ORDER BY tv_channel.Language ASC LIMIT 1


baseline pred: MATCH (TV_channel:`tvshow.TV_Channel`) RETURN TV_channel.Language ORDER BY TV_channel.Language DESC LIMIT 1
label query  : MATCH (tv_channel:`tvshow.TV_Channel`) RETURN tv_channel.Language,count(*) ORDER BY tv_channel.Language ASC LIMIT 1


baseline pred: MATCH (TV_channel:`tvshow.TV_Channel`) RETURN TV_channel.Language,count(*)
label query  : MATCH (tv_channel:`tvshow.TV_Channel`) RETURN tv_channel.Language,count(*)


baseline pred: MATCH (TV_channel:`tvshow.TV_Channel`) RETURN TV_channel.Language,count(*)
label query  : MATCH (tv_channel:`tvshow.TV_Channel`) RETURN tv_channel.Language,count(*)


baseline pred: MATCH (TV_series:`tvshow.TV_series`) WHERE TV_series.Title = 'The Rise of the Blue Beetle!' RETURN TV_series.Series_name
label query  : MATCH (T1:`tvshow.TV_Channel`)-[]-(T2:`tvshow.Cartoon`) WHERE T2.Title = 'The Rise of the Blue Beetle!' RETURN T1.series_name


baseline pred: MATCH (cartoon:`tvshow.Cartoon`) WHERE cartoon.series_name = 'Sky Radio' RETURN cartoon.Title
label query  : MATCH (T1:`tvshow.TV_Channel`)-[]-(T2:`tvshow.Cartoon`) WHERE T1.series_name = 'Sky Radio' RETURN T2.Title


baseline pred: MATCH (TV_channel:`tvshow.TV_channel`) WHERE TV_channel.series_name = 'Sky Radio' RETURN TV_channel.Title
label query  : MATCH (T1:`tvshow.TV_Channel`)-[]-(T2:`tvshow.Cartoon`) WHERE T1.series_name = 'Sky Radio' RETURN T2.Title


baseline pred: MATCH (TV_series:`tvshow.TV_series`) RETURN TV_series.Episode ORDER BY TV_series.Rating_Share
label query  : MATCH (tv_series:`tvshow.TV_series`) RETURN tv_series.Episode ORDER BY tv_series.Rating


baseline pred: MATCH (TV_series:`tvshow.TV_series`) RETURN TV_series.Episode ORDER BY TV_series.Rating_Share
label query  : MATCH (tv_series:`tvshow.TV_series`) RETURN tv_series.Episode ORDER BY tv_series.Rating


baseline pred: MATCH (TV_series:`tvshow.TV_series`) RETURN TV_series.Episode,TV_series.Rating ORDER BY TV_series.Episode DESC LIMIT 3
label query  : MATCH (tv_series:`tvshow.TV_series`) RETURN tv_series.Episode,tv_series.Rating ORDER BY tv_series.Rating DESC LIMIT 3


baseline pred: MATCH (TV_series:`tvshow.TV_series`) RETURN TV_series.Episode,count(*) ORDER BY TV_series.Rating_Share DESC LIMIT 3
label query  : MATCH (tv_series:`tvshow.TV_series`) RETURN tv_series.Episode,tv_series.Rating ORDER BY tv_series.Rating DESC LIMIT 3


baseline pred: MATCH (TV_series:`tvshow.TV_series`) RETURN min(TV_series.Share),max(TV_series.Share)
label query  : MATCH (tv_series:`tvshow.TV_series`) RETURN max(tv_series.Share),min(tv_series.Share)


baseline pred: MATCH (TV_series:`tvshow.TV_series`) RETURN max(TV_series.Share),min(TV_series.Share)
label query  : MATCH (tv_series:`tvshow.TV_series`) RETURN max(tv_series.Share),min(tv_series.Share)


baseline pred: MATCH (TV_series:`tvshow.TV_series`) WHERE TV_series.Episode = 'A Love of a Lifetime' RETURN TV_series.Air_Date
label query  : MATCH (tv_series:`tvshow.TV_series`) WHERE tv_series.Episode = 'A Love of a Lifetime' RETURN tv_series.Air_Date


baseline pred: MATCH (TV_series:`tvshow.TV_series`) WHERE TV_series.Episode = 'A Love of a Lifetime' RETURN TV_series.Original_air_date
label query  : MATCH (tv_series:`tvshow.TV_series`) WHERE tv_series.Episode = 'A Love of a Lifetime' RETURN tv_series.Air_Date


baseline pred: MATCH (TV_series:`tvshow.TV_series`) WHERE TV_series.Episode = 'A Love of a Lifetime' RETURN TV_series.Weekly_Rank
label query  : MATCH (tv_series:`tvshow.TV_series`) WHERE tv_series.Episode = 'A Love of a Lifetime' RETURN tv_series.Weekly_Rank


baseline pred: MATCH (TV_series:`tvshow.TV_series`) WHERE TV_series.Episode = 'A Love of a Lifetime' RETURN TV_series.Weekly_Rank
label query  : MATCH (tv_series:`tvshow.TV_series`) WHERE tv_series.Episode = 'A Love of a Lifetime' RETURN tv_series.Weekly_Rank


baseline pred: MATCH (TV_series:`tvshow.TV_series`) WHERE TV_series.Episode = 'A Love of a Lifetime' RETURN TV_series.Channel
label query  : MATCH (T1:`tvshow.TV_Channel`)-[]-(T2:`tvshow.TV_series`) WHERE T2.Episode = 'A Love of a Lifetime' RETURN T1.series_name


baseline pred: MATCH (TV_series:`tvshow.TV_series`) WHERE TV_series.Episode = 'A Love of a Lifetime' RETURN TV_series.series_name
label query  : MATCH (T1:`tvshow.TV_Channel`)-[]-(T2:`tvshow.TV_series`) WHERE T2.Episode = 'A Love of a Lifetime' RETURN T1.series_name


baseline pred: MATCH (TV_series:`tvshow.TV_series`) WHERE TV_series.series_name = 'Sky Radio' RETURN TV_series.Episode
label query  : MATCH (T1:`tvshow.TV_Channel`)-[]-(T2:`tvshow.TV_series`) WHERE T1.series_name = 'Sky Radio' RETURN T2.Episode


baseline pred: MATCH (TV_series:`tvshow.TV_series`) WHERE TV_series.series_name = 'Sky Radio' RETURN TV_series.Episode
label query  : MATCH (T1:`tvshow.TV_Channel`)-[]-(T2:`tvshow.TV_series`) WHERE T1.series_name = 'Sky Radio' RETURN T2.Episode


baseline pred: MATCH (cartoon:`tvshow.Cartoon`) RETURN cartoon.Directed_by,count(*)
label query  : MATCH (cartoon:`tvshow.Cartoon`) RETURN count(*),cartoon.Directed_by


baseline pred: MATCH (cartoon:`tvshow.Cartoon`) RETURN cartoon.Directed_by,count(*)
label query  : MATCH (cartoon:`tvshow.Cartoon`) RETURN count(*),cartoon.Directed_by


baseline pred: MATCH (TV_channel:`tvshow.TV_channel`) WHERE TV_channel.Hight_definition_TV RETURN TV_channel.Package_Option,TV_channel.series_name
label query  : MATCH (tv_channel:`tvshow.TV_Channel`) WHERE tv_channel.Hight_definition_TV = 'yes' RETURN tv_channel.Package_Option,tv_channel.series_name


baseline pred: MATCH (TV_Channel:`tvshow.TV_Channel`) WHERE TV_Channel.Package_Option = 'Option' AND TV_Channel.Hight_definition_TV RETURN TV_Channel.series_name,TV_Channel.series_name
label query  : MATCH (tv_channel:`tvshow.TV_Channel`) WHERE tv_channel.Hight_definition_TV = 'yes' RETURN tv_channel.Package_Option,tv_channel.series_name


baseline pred: MATCH (cartoon:`tvshow.Cartoon`) WHERE cartoon.Writed_by = 'Todd Casey' RETURN cartoon.Country
label query  : MATCH (T1:`tvshow.TV_Channel`)-[]-(T2:`tvshow.Cartoon`) WHERE T2.Written_by = 'Todd Casey' RETURN T1.Country


baseline pred: MATCH (cartoon:`tvshow.Cartoon`) WHERE cartoon.Writed_by = 'Todd Casey' RETURN cartoon.Country
label query  : MATCH (T1:`tvshow.TV_Channel`)-[]-(T2:`tvshow.Cartoon`) WHERE T2.Written_by = 'Todd Casey' RETURN T1.Country


baseline pred: MATCH (t1:`tvshow.TV_Channel`)-[]-(t2:`tvshow.TV_Channel`) WHERE t2.Language ` > 'English' RETURN t2.Pixel_aspect_ratio_PAR,t1.Country
label query  : MATCH (tv_channel:`tvshow.TV_Channel`) WHERE tv_channel.Language <> 'English' RETURN tv_channel.Pixel_aspect_ratio_PAR,tv_channel.Country


baseline pred: MATCH (TV_channel:`tvshow.TV_Channel`) WHERE TV_channel.Language ` > 'English' RETURN TV_channel.Pixel_aspect_ratio_PAR,TV_channel.Country
label query  : MATCH (tv_channel:`tvshow.TV_Channel`) WHERE tv_channel.Language <> 'English' RETURN tv_channel.Pixel_aspect_ratio_PAR,tv_channel.Country


baseline pred: MATCH ( poker_player:`poker_player.poker_player`) RETURN count(*)
label query  : MATCH (poker_player:`poker_player.poker_player`) RETURN count(*)


baseline pred: MATCH ( poker_player:`poker_player.poker_player`) RETURN count(*)
label query  : MATCH (poker_player:`poker_player.poker_player`) RETURN count(*)


baseline pred: MATCH (poker_player:`poker_player.poker_player`) WITH max(poker_player.Earnings) AS earnings MATCH (poker_player:`poker_player.poker_player`) WHERE poker_player.Earnings ` 200000 RETURN max(poker_player.Final_Table_Made)
label query  : MATCH (poker_player:`poker_player.poker_player`) WHERE poker_player.Earnings < 200000 RETURN max(poker_player.Final_Table_Made)


baseline pred: MATCH (poker_player:`poker_player.poker_player`) WHERE poker_player.Earnings ` 200000 RETURN max(poker_player.Final_Table_Made)
label query  : MATCH (poker_player:`poker_player.poker_player`) WHERE poker_player.Earnings < 200000 RETURN max(poker_player.Final_Table_Made)


baseline pred: MATCH (people:`poker_player.people`) WHERE people.Poker_Player_ID = 'No' RETURN people.Name
label query  : MATCH (T1:`poker_player.people`)-[]-(T2:`poker_player.poker_player`) RETURN T1.Name


baseline pred: MATCH ( poker_player:`poker_player.poker_player`) RETURN poker_player.Name
label query  : MATCH (T1:`poker_player.people`)-[]-(T2:`poker_player.poker_player`) RETURN T1.Name


baseline pred: MATCH (poker_player:`poker_player.poker_player`) WHERE poker_player.Earnings > 300000 RETURN poker_player.Name
label query  : MATCH (T1:`poker_player.people`)-[]-(T2:`poker_player.poker_player`) WHERE T2.Earnings > 300000 RETURN T1.Name


baseline pred: MATCH (poker_player:`poker_player.poker_player`) WHERE poker_player.Earnings > 300000 RETURN poker_player.Name
label query  : MATCH (T1:`poker_player.people`)-[]-(T2:`poker_player.poker_player`) WHERE T2.Earnings > 300000 RETURN T1.Name


baseline pred: MATCH (poker_player:`poker_player.poker_player`) RETURN poker_player.Name ORDER BY poker_player.Final_Table_Made ASC
label query  : MATCH (T1:`poker_player.people`)-[]-(T2:`poker_player.poker_player`) RETURN T1.Name ORDER BY T2.Final_Table_Made


baseline pred: MATCH (poker_player:`poker_player.poker_player`) RETURN poker_player.Name ORDER BY poker_player.Final_Table_Made ASC
label query  : MATCH (T1:`poker_player.people`)-[]-(T2:`poker_player.poker_player`) RETURN T1.Name ORDER BY T2.Final_Table_Made


baseline pred: MATCH (people:`poker_player.people`) RETURN people.Birth_Date ORDER BY people.Earnings DESC LIMIT 1
label query  : MATCH (T1:`poker_player.people`)-[]-(T2:`poker_player.poker_player`) RETURN T1.Birth_Date ORDER BY T2.Earnings ASC LIMIT 1


baseline pred: MATCH (people:`poker_player.people`) RETURN people.Birth_Date ORDER BY people.Earnings DESC LIMIT 1
label query  : MATCH (T1:`poker_player.people`)-[]-(T2:`poker_player.poker_player`) RETURN T1.Birth_Date ORDER BY T2.Earnings ASC LIMIT 1


baseline pred: MATCH (poker_player:`poker_player.poker_player`) RETURN poker_player.Money_Rank ORDER BY poker_player.Height DESC LIMIT 1
label query  : MATCH (T1:`poker_player.people`)-[]-(T2:`poker_player.poker_player`) RETURN T2.Money_Rank ORDER BY T1.Height DESC LIMIT 1


baseline pred: MATCH (poker_player:`poker_player.poker_player`) RETURN poker_player.Money_Rank ORDER BY poker_player.Height DESC LIMIT 1
label query  : MATCH (T1:`poker_player.people`)-[]-(T2:`poker_player.poker_player`) RETURN T2.Money_Rank ORDER BY T1.Height DESC LIMIT 1


baseline pred: MATCH (poker_player:`poker_player.poker_player`) RETURN poker_player.Name ORDER BY poker_player.Earnings DESC
label query  : MATCH (T1:`poker_player.people`)-[]-(T2:`poker_player.poker_player`) RETURN T1.Name ORDER BY T2.Earnings DESC


baseline pred: MATCH (poker_player:`poker_player.poker_player`) RETURN poker_player.Name ORDER BY poker_player.Earnings DESC
label query  : MATCH (T1:`poker_player.people`)-[]-(T2:`poker_player.poker_player`) RETURN T1.Name ORDER BY T2.Earnings DESC


baseline pred: MATCH (people:`poker_player.people`) WITH count(*) AS count, people.Nationality AS Nationality WHERE count >= 2 RETURN Nationality
label query  : MATCH (people:`poker_player.people`) WITH people.Nationality AS Nationality, count(*) AS count WHERE count  >= 2 RETURN Nationality


baseline pred: MATCH (people:`poker_player.people`) WITH count(*) AS count, people.Nationality AS Nationality WHERE count >= 2 RETURN Nationality
label query  : MATCH (people:`poker_player.people`) WITH people.Nationality AS Nationality, count(*) AS count WHERE count  >= 2 RETURN Nationality


baseline pred: MATCH (people:`poker_player.people`) WHERE people.Nationality ` > 'Russia' RETURN people.Name
label query  : MATCH (people:`poker_player.people`) WHERE people.Nationality <> 'Russia' RETURN people.Name


baseline pred: MATCH (people:`poker_player.people`) WHERE people.Nationality ` > 'Russia' RETURN people.Name
label query  : MATCH (people:`poker_player.people`) WHERE people.Nationality <> 'Russia' RETURN people.Name


baseline pred: MATCH (people:`poker_player.people`) WHERE NOT (people)-[]-(:`poker_player.poker_player`) RETURN people.Name
label query  : MATCH (people:`poker_player.people`) WHERE NOT (people)-[]-(:`poker_player.poker_player`)     RETURN people.Name


baseline pred: MATCH (people:`poker_player.people`) WHERE NOT (people)-[]-(:`poker_player.poker_player`) RETURN people.Name
label query  : MATCH (people:`poker_player.people`) WHERE NOT (people)-[]-(:`poker_player.poker_player`)     RETURN people.Name


baseline pred: MATCH (T1:`voter_1.VOTES`)-[]-(T2:`voter_1.AREA_CODE_STATE`) RETURN count(*)
label query  : MATCH (area_code_state:`voter_1.AREA_CODE_STATE`) RETURN count(*)


baseline pred: MATCH (area_code:`voter_1.AREA_CODE_STATE`) RETURN max(area_code.area_code),min(area_code.area_code)
label query  : MATCH (area_code_state:`voter_1.AREA_CODE_STATE`) RETURN max(area_code_state.area_code),min(area_code_state.area_code)


baseline pred: MATCH (votes:`voter_1.VOTES`) WHERE votes.state = 'CA' RETURN votes.created ORDER BY votes.created DESC LIMIT 1
label query  : MATCH (votes:`voter_1.VOTES`) WHERE votes.state = 'CA' RETURN max(votes.created)


baseline pred: MATCH (contestants:`voter_1.CONTESTANTS`) WHERE contestants.contestant_name ` > 'Jessie Alloway' RETURN contestants.contestant_name
label query  : MATCH (contestants:`voter_1.CONTESTANTS`) WHERE contestants.contestant_name <> 'Jessie Alloway' RETURN contestants.contestant_name


baseline pred: MATCH (contestants:`voter_1.CONTESTANTS`) WITH count(*) AS count, contestants.contestant_number AS contestant_number WHERE count >= 2 RETURN contestant_number,contestant_name
label query  : MATCH (T1:`voter_1.CONTESTANTS`)-[]-(T2:`voter_1.VOTES`) WITH count(*) AS count, T1.contestant_number AS contestant_number, T1.contestant_name AS contestant_name WHERE count  >= 2 RETURN contestant_number,contestant_name


baseline pred: MATCH (contestants:`voter_1.CONTESTANTS`) RETURN contestants.contestant_number,contestants.contestant_name ORDER BY contestants.vote_id LIMIT 1
label query  : MATCH (T1:`voter_1.CONTESTANTS`)-[]-(T2:`voter_1.VOTES`) WITH T1, count(T1.contestant_number) AS cnt RETURN T1.contestant_number,T1.contestant_name ORDER BY cnt ASC LIMIT 1


baseline pred: MATCH (votes:`voter_1.VOTES`) WHERE votes.state = 'NY' OR votes.state = 'CA' RETURN count(DISTINCT votes.voter_id)
label query  : MATCH (votes:`voter_1.VOTES`) WHERE votes.state = 'NY' OR votes.state = 'CA' RETURN count(*)


baseline pred: MATCH (votes:`voter_1.VOTES`) WHERE votes.contestant_name = 'Tabatha Gehling' RETURN votes.created,votes.state,votes.phone_number
label query  : MATCH (T1:`voter_1.CONTESTANTS`)-[]-(T2:`voter_1.VOTES`) WHERE T1.contestant_name = 'Tabatha Gehling' RETURN T2.created,T2.state,T2.phone_number


baseline pred: MATCH (conductor:`orchestra.conductor`) RETURN conductor.Name ORDER BY conductor.Age
label query  : MATCH (conductor:`orchestra.conductor`) RETURN conductor.Name ORDER BY conductor.Age ASC


baseline pred: MATCH (conductor:`orchestra.conductor`) WHERE conductor.Nationality ` > 'USA' RETURN conductor.Name
label query  : MATCH (conductor:`orchestra.conductor`) WHERE conductor.Nationality <> 'USA' RETURN conductor.Name


baseline pred: MATCH (conductor:`orchestra.conductor`) WHERE conductor.Nationality ` > 'USA' RETURN conductor.Name
label query  : MATCH (conductor:`orchestra.conductor`) WHERE conductor.Nationality <> 'USA' RETURN conductor.Name


baseline pred: MATCH (performance:`orchestra.performance`) WHERE performance.Type ` > 'Live final' RETURN max(performance.Share),min(performance.Share)
label query  : MATCH (performance:`orchestra.performance`) WHERE performance.Type <> 'Live final' RETURN max(performance.Share),min(performance.Share)


baseline pred: MATCH (performance:`orchestra.performance`) WHERE performance.Type ` > 'Live final' RETURN max(performance.Share),min(performance.Share)
label query  : MATCH (performance:`orchestra.performance`) WHERE performance.Type <> 'Live final' RETURN max(performance.Share),min(performance.Share)


baseline pred: MATCH (T1:`orchestra.conductor`)-[]-(T2:`orchestra.orchestra`) RETURN T2.Name,T2.Orchestre
label query  : MATCH (T1:`orchestra.conductor`)-[]-(T2:`orchestra.orchestra`) RETURN T1.Name,T2.Orchestra


baseline pred: MATCH (T1:`orchestra.conductor`)-[]-(T2:`orchestra.orchestra`) RETURN T2.Name,T1.Name
label query  : MATCH (T1:`orchestra.conductor`)-[]-(T2:`orchestra.orchestra`) RETURN T1.Name,T2.Orchestra


baseline pred: MATCH (conductor:`orchestra.conductor`) WITH count(*) AS count, conductor.Name AS Name WHERE count > 1 RETURN Name
label query  : MATCH (T1:`orchestra.conductor`)-[]-(T2:`orchestra.orchestra`) WITH T1.Name AS Name, count(*) AS count WHERE count  > 1 RETURN Name


baseline pred: MATCH (conductor:`orchestra.conductor`) WITH count(*) AS count, conductor.Name AS Name WHERE count > 1 RETURN Name
label query  : MATCH (T1:`orchestra.conductor`)-[]-(T2:`orchestra.orchestra`) WITH T1.Name AS Name, count(*) AS count WHERE count  > 1 RETURN Name


baseline pred: MATCH (orchestra:`orchestra.orchestra`) WHERE orchestra.Year_of_Founded > 2008 RETURN orchestra.Name
label query  : MATCH (T1:`orchestra.conductor`)-[]-(T2:`orchestra.orchestra`) WHERE T2.Year_of_Founded > 2008 RETURN T1.Name


baseline pred: MATCH (orchestra:`orchestra.orchestra`) WHERE orchestra.Year_of_Founded > 2008 RETURN orchestra.Name
label query  : MATCH (T1:`orchestra.conductor`)-[]-(T2:`orchestra.orchestra`) WHERE T2.Year_of_Founded > 2008 RETURN T1.Name


baseline pred: MATCH (orchestra:`orchestra.orchestra`) RETURN count(*),orchestra.Record_Company
label query  : MATCH (orchestra:`orchestra.orchestra`) RETURN orchestra.Record_Company,count(*)


baseline pred: MATCH (orchestra:`orchestra.orchestra`) RETURN orchestra.Major_Record_Format ORDER BY orchestra.Record_Format ASC
label query  : MATCH (orchestra:`orchestra.orchestra`) RETURN orchestra.Major_Record_Format ORDER BY orchestra.Major_Record_Format ASC


baseline pred: MATCH (orchestra:`orchestra.orchestra`) RETURN orchestra.Major_Record_Format ORDER BY orchestra.Record_Company DESC
label query  : MATCH (orchestra:`orchestra.orchestra`) RETURN orchestra.Major_Record_Format ORDER BY orchestra.Major_Record_Format ASC


baseline pred: MATCH (orchestra:`orchestra.orchestra`) WHERE NOT (orchestra)-[]-(:`orchestra.performance`) RETURN orchestra.Name
label query  : MATCH (orchestra:`orchestra.orchestra`) WHERE NOT (orchestra)-[]-(:`orchestra.performance`)     RETURN orchestra.Orchestra


baseline pred: MATCH (orchestra:`orchestra.orchestra`) WHERE NOT (orchestra)-[]-(:`orchestra.performance`) RETURN orchestra.Organic
label query  : MATCH (orchestra:`orchestra.orchestra`) WHERE NOT (orchestra)-[]-(:`orchestra.performance`)     RETURN orchestra.Orchestra


baseline pred: MATCH (highschooler:`network_1.Highschooler`) WHERE highschooler.name = 'Kylie' RETURN highschooler.grade
label query  : MATCH (highschooler:`network_1.Highschooler`) WHERE highschooler.name = 'Kyle' RETURN highschooler.grade


baseline pred: MATCH (highschooler:`network_1.Highschooler`) WHERE highschooler.name = 'Kylie' RETURN highschooler.grade
label query  : MATCH (highschooler:`network_1.Highschooler`) WHERE highschooler.name = 'Kyle' RETURN highschooler.grade


baseline pred: MATCH (highschooler:`network_1.Highschooler`) WHERE highschooler.name = 'Kylie' RETURN highschooler.ID
label query  : MATCH (highschooler:`network_1.Highschooler`) WHERE highschooler.name = 'Kyle' RETURN highschooler.ID


baseline pred: MATCH (highschooler:`network_1.Highschooler`) WHERE highschooler.name = 'Kylie' RETURN highschooler.ID
label query  : MATCH (highschooler:`network_1.Highschooler`) WHERE highschooler.name = 'Kyle' RETURN highschooler.ID


baseline pred: MATCH (highschooler:`network_1.Highschooler`) WITH count(*) AS count, highschooler.grade AS grade WHERE count >= 4 RETURN grade
label query  : MATCH (highschooler:`network_1.Highschooler`) WITH highschooler.grade AS grade, count(*) AS count WHERE count  >= 4 RETURN grade


baseline pred: MATCH (highschooler:`network_1.Highschooler`) WITH count(*) AS count, highschooler.grade AS grade WHERE count >= 4 RETURN grade
label query  : MATCH (highschooler:`network_1.Highschooler`) WITH highschooler.grade AS grade, count(*) AS count WHERE count  >= 4 RETURN grade


baseline pred: MATCH (T1:`network_1.Highschooler`)-[T2:`network_1.Likes ` ]-() WITH count(*) AS count, T1.name AS name WHERE count >= 2 RETURN name
label query  : MATCH (T1:`network_1.Likes`)-[]-(T2:`network_1.Highschooler`) WITH count(*) AS count, T2.name AS name WHERE count  >= 2 RETURN name


baseline pred: MATCH (T1:`network_1.Highschooler`)-[T2:`network_1.Likes ` ]-() WITH count(*) AS count, T1.name AS name WHERE count >= 2 RETURN name
label query  : MATCH (T1:`network_1.Likes`)-[]-(T2:`network_1.Highschooler`) WITH count(*) AS count, T2.name AS name WHERE count  >= 2 RETURN name


baseline pred: MATCH (T1:`dog_kennels.Professionals`)-[]-(T2:`dog_kennels.Treatments`) WITH count(*) AS count, T1.professional_id AS professional_id, T1.role_code AS role_code WHERE count >= 2 RETURN professional_id,role_code,first_name
label query  : MATCH (T1:`dog_kennels.Professionals`)-[]-(T2:`dog_kennels.Treatments`) WITH count(*) AS count, T1.role_code AS role_code, T1.first_name AS first_name, T1.professional_id AS professional_id WHERE count  >= 2 RETURN professional_id,role_code,first_name


baseline pred: MATCH (T1:`dog_kennels.Professionals`)-[]-(T2:`dog_kennels.Treatments`) WITH count(*) AS count, T1.professional_id AS professional_id, T1.role_code AS role_code WHERE count >= 2 RETURN professional_id,role_code,first_name
label query  : MATCH (T1:`dog_kennels.Professionals`)-[]-(T2:`dog_kennels.Treatments`) WITH count(*) AS count, T1.role_code AS role_code, T1.first_name AS first_name, T1.professional_id AS professional_id WHERE count  >= 2 RETURN professional_id,role_code,first_name


baseline pred: MATCH (dogs:`dog_kennels.Dogs`) RETURN dogs.breed_name ORDER BY dogs.breed_code DESC LIMIT 1
label query  : MATCH (T1:`dog_kennels.Breeds`)-[]-(T2:`dog_kennels.Dogs`) WITH count(T1.breed_name) AS cnt, T1 RETURN T1.breed_name ORDER BY cnt DESC LIMIT 1


baseline pred: MATCH (dogs:`dog_kennels.Dogs`) RETURN dogs.breed_name ORDER BY dogs.breed_code DESC LIMIT 1
label query  : MATCH (T1:`dog_kennels.Breeds`)-[]-(T2:`dog_kennels.Dogs`) WITH count(T1.breed_name) AS cnt, T1 RETURN T1.breed_name ORDER BY cnt DESC LIMIT 1


baseline pred: MATCH (T1:`dog_kennels.Owners`)-[]-(T2:`dog_kennels.Treatments`) WITH T2.owner_id AS owner_id, count(*) AS count WHERE count >= 1 RETURN owner_id,last_name ORDER BY owner_id DESC LIMIT 1
label query  : MATCH (T1:`dog_kennels.Owners`)-[]-(T2:`dog_kennels.Dogs`)-[]-(T3:`dog_kennels.Treatments`) WITH count(T1.owner_id) AS cnt, T1 RETURN T1.owner_id,T1.last_name ORDER BY cnt DESC LIMIT 1


baseline pred: MATCH (dogs:`dog_kennels.Dogs`) RETURN dogs.owner_id,dogs.last_name ORDER BY dogs.cost_of_treatment DESC LIMIT 1
label query  : MATCH (T1:`dog_kennels.Owners`)-[]-(T2:`dog_kennels.Dogs`)-[]-(T3:`dog_kennels.Treatments`) WITH count(T1.owner_id) AS cnt, T1 RETURN T1.owner_id,T1.last_name ORDER BY cnt DESC LIMIT 1


baseline pred: MATCH (T1:`dog_kennels.Professionals`)-[]-(T2:`dog_kennels.Treatments`) WITH count(*) AS count, T1.professional_id AS professional_id WHERE count >= 2 RETURN professional_id,professional_phone
label query  : MATCH (T1:`dog_kennels.Professionals`)-[]-(T2:`dog_kennels.Treatments`) WITH count(*) AS count, T1.professional_id AS professional_id, T1.cell_number AS cell_number WHERE count  >= 2 RETURN professional_id,cell_number


baseline pred: MATCH (T1:`dog_kennels.Professionals`)-[]-(T2:`dog_kennels.Treatments`) WITH count(*) AS count, T1.professional_id AS professional_id WHERE count >= 2 RETURN professional_id,professional_phone
label query  : MATCH (T1:`dog_kennels.Professionals`)-[]-(T2:`dog_kennels.Treatments`) WITH count(*) AS count, T1.professional_id AS professional_id, T1.cell_number AS cell_number WHERE count  >= 2 RETURN professional_id,cell_number


baseline pred: MATCH (treatments:`dog_kennels.Treatments`) RETURN treatments.date_of_treatment,treatments.first_name ORDER BY treatments.date_of_treatment DESC LIMIT 1
label query  : MATCH (T1:`dog_kennels.Treatments`)-[]-(T2:`dog_kennels.Professionals`) RETURN T1.date_of_treatment,T2.first_name


baseline pred: MATCH (T1:`dog_kennels.Professionals`)-[]-(T2:`dog_kennels.Treatments`) RETURN T1.date_of_treatment,T2.first_name
label query  : MATCH (T1:`dog_kennels.Treatments`)-[]-(T2:`dog_kennels.Professionals`) RETURN T1.date_of_treatment,T2.first_name


baseline pred: MATCH (treatments:`dog_kennels.Treatments`) RETURN treatments.cost_of_treatment,treatments.treatment_type_description
label query  : MATCH (T1:`dog_kennels.Treatments`)-[]-(T2:`dog_kennels.Treatment_Types`) RETURN T1.cost_of_treatment,T2.treatment_type_description


baseline pred: MATCH (treatments:`dog_kennels.Treatments`) RETURN treatments.cost_of_treatment,treatments.treatment_type_description
label query  : MATCH (T1:`dog_kennels.Treatments`)-[]-(T2:`dog_kennels.Treatment_Types`) RETURN T1.cost_of_treatment,T2.treatment_type_description


baseline pred: MATCH (dogs:`dog_kennels.Dogs`) RETURN dogs.first_name,dogs.last_name,dogs.size_code
label query  : MATCH (T1:`dog_kennels.Owners`)-[]-(T2:`dog_kennels.Dogs`) RETURN T1.first_name,T1.last_name,T2.size_code


baseline pred: MATCH (dogs:`dog_kennels.Dogs`) RETURN dogs.first_name,dogs.last_name,dogs.size_code
label query  : MATCH (T1:`dog_kennels.Owners`)-[]-(T2:`dog_kennels.Dogs`) RETURN T1.first_name,T1.last_name,T2.size_code


baseline pred: MATCH (dogs:`dog_kennels.Dogs`) RETURN dogs.first_name,dogs.name
label query  : MATCH (T1:`dog_kennels.Owners`)-[]-(T2:`dog_kennels.Dogs`) RETURN T1.first_name,T2.name


baseline pred: MATCH (dogs:`dog_kennels.Dogs`) RETURN dogs.first_name,dogs.name
label query  : MATCH (T1:`dog_kennels.Owners`)-[]-(T2:`dog_kennels.Dogs`) RETURN T1.first_name,T2.name


baseline pred: MATCH (dogs:`dog_kennels.Dogs`) WHERE dogs.state = 'Virginia' RETURN dogs.first_name,dogs.name
label query  : MATCH (T1:`dog_kennels.Owners`)-[]-(T2:`dog_kennels.Dogs`) WHERE T1.state = 'Virginia' RETURN T1.first_name,T2.name


baseline pred: MATCH (dogs:`dog_kennels.Dogs`) WHERE dogs.state = 'Virginia' RETURN dogs.first_name,dogs.name
label query  : MATCH (T1:`dog_kennels.Owners`)-[]-(T2:`dog_kennels.Dogs`) WHERE T1.state = 'Virginia' RETURN T1.first_name,T2.name


baseline pred: MATCH (dogs:`dog_kennels.Dogs`) RETURN dogs.date_arrived,dogs.date_departed
label query  : MATCH (T1:`dog_kennels.Dogs`)-[]-(T2:`dog_kennels.Treatments`) RETURN DISTINCT T1.date_arrived,T1.date_departed


baseline pred: MATCH (dogs:`dog_kennels.Dogs`) RETURN dogs.date_arrived,dogs.date_departed
label query  : MATCH (T1:`dog_kennels.Dogs`)-[]-(T2:`dog_kennels.Treatments`) RETURN DISTINCT T1.date_arrived,T1.date_departed


baseline pred: MATCH (professionals:`dog_kennels.Professionals`) WHERE professionals.city = 'Hawaii' OR professionals.state = 'Wisconsin' RETURN professionals.email_address
label query  : MATCH (professionals:`dog_kennels.Professionals`) WHERE professionals.state = 'Hawaii' OR professionals.state = 'Wisconsin' RETURN professionals.email_address


baseline pred: MATCH (professionals:`dog_kennels.Professionals`) WHERE professionals.city = 'Hawaii' OR professionals.state = 'Wisconsin' RETURN professionals.email_address
label query  : MATCH (professionals:`dog_kennels.Professionals`) WHERE professionals.state = 'Hawaii' OR professionals.state = 'Wisconsin' RETURN professionals.email_address


baseline pred: MATCH (dogs:`dog_kennels.Dogs`) RETURN count(*)
label query  : MATCH (treatments:`dog_kennels.Treatments`) RETURN count(DISTINCT treatments.dog_id)


baseline pred: MATCH (dogs:`dog_kennels.Dogs`) RETURN count(*)
label query  : MATCH (treatments:`dog_kennels.Treatments`) RETURN count(DISTINCT treatments.dog_id)


baseline pred: MATCH (T1:`dog_kennels.Professionals`)-[]-(T2:`dog_kennels.Dogs`) WHERE T2.date_of_treatment = 'yes' RETURN count(*)
label query  : MATCH (treatments:`dog_kennels.Treatments`) RETURN count(DISTINCT treatments.professional_id)


baseline pred: MATCH (dogs:`dog_kennels.Dogs`) RETURN count(*)
label query  : MATCH (treatments:`dog_kennels.Treatments`) RETURN count(DISTINCT treatments.professional_id)


baseline pred: MATCH (professionals:`dog_kennels.Professionals`) WHERE professionals.city = 'West' RETURN professionals.role_code,professionals.city,professionals.state
label query  : MATCH (professionals:`dog_kennels.Professionals`) WHERE professionals.city =~'.*[W|w]est.*' RETURN professionals.role_code,professionals.street,professionals.city,professionals.state


baseline pred: MATCH (professionals:`dog_kennels.Professionals`) WHERE professionals.city = 'West' RETURN professionals.role_code,professionals.city,professionals.state
label query  : MATCH (professionals:`dog_kennels.Professionals`) WHERE professionals.city =~'.*[W|w]est.*' RETURN professionals.role_code,professionals.street,professionals.city,professionals.state


baseline pred: MATCH (owners:`dog_kennels.Owners`) WHERE owners.state = 'North' RETURN owners.first_name,owners.last_name,owners.email_address
label query  : MATCH (owners:`dog_kennels.Owners`) WHERE owners.state =~'.*[N|n]orth.*' RETURN owners.first_name,owners.last_name,owners.email_address


baseline pred: MATCH (owners:`dog_kennels.Owners`) WHERE owners.city = 'North' RETURN owners.first_name,owners.last_name,owners.email_address
label query  : MATCH (owners:`dog_kennels.Owners`) WHERE owners.state =~'.*[N|n]orth.*' RETURN owners.first_name,owners.last_name,owners.email_address


baseline pred: MATCH (treatments:`dog_kennels.Treatments`) RETURN treatments.cost_of_treatment ORDER BY treatments.cost_of_treatment DESC LIMIT 1
label query  : MATCH (treatments:`dog_kennels.Treatments`) RETURN treatments.cost_of_treatment ORDER BY treatments.date_of_treatment DESC LIMIT 1


baseline pred: MATCH (dogs:`dog_kennels.Dogs`) RETURN dogs.age ORDER BY dogs.age DESC LIMIT 1
label query  : MATCH (dogs:`dog_kennels.Dogs`) RETURN max(dogs.age)


baseline pred: MATCH (dogs:`dog_kennels.Dogs`) RETURN dogs.age ORDER BY dogs.age DESC LIMIT 1
label query  : MATCH (dogs:`dog_kennels.Dogs`) RETURN max(dogs.age)


baseline pred: MATCH (charges:`dog_kennels.Charges`) RETURN charges.charge_amount ORDER BY charges.charge_amount DESC LIMIT 1
label query  : MATCH (charges:`dog_kennels.Charges`) RETURN max(charges.charge_amount)


baseline pred: MATCH (charges:`dog_kennels.Charges`) RETURN charges.charge_amount ORDER BY charges.charge_amount DESC LIMIT 1
label query  : MATCH (charges:`dog_kennels.Charges`) RETURN max(charges.charge_amount)


baseline pred: MATCH (dogs:`dog_kennels.Dogs`) RETURN dogs.breed_code,dogs.size_code
label query  : MATCH (dogs:`dog_kennels.Dogs`) RETURN DISTINCT dogs.breed_code,dogs.size_code


baseline pred: MATCH (professionals:`dog_kennels.Professionals`) RETURN professionals.first_name,professionals.date_of_treatment
label query  : MATCH (T1:`dog_kennels.Professionals`)-[]-(T2:`dog_kennels.Treatments`)-[]-(T3:`dog_kennels.Treatment_Types`) RETURN DISTINCT T1.first_name,T3.treatment_type_description


baseline pred: MATCH (T1:`dog_kennels.Professionals`)-[]-(T2:`dog_kennels.Treatments`) RETURN T2.first_name,T2.date_of_treatment
label query  : MATCH (T1:`dog_kennels.Professionals`)-[]-(T2:`dog_kennels.Treatments`)-[]-(T3:`dog_kennels.Treatment_Types`) RETURN DISTINCT T1.first_name,T3.treatment_type_description


baseline pred: MATCH (singer:`singer.singer`) WHERE singer.Citizenship ` > 'France' RETURN singer.Name
label query  : MATCH (singer:`singer.singer`) WHERE singer.Citizenship <> 'France' RETURN singer.Name


baseline pred: MATCH (singer:`singer.singer`) WHERE singer.Citizenship ` > 'France' RETURN singer.Name
label query  : MATCH (singer:`singer.singer`) WHERE singer.Citizenship <> 'France' RETURN singer.Name


baseline pred: MATCH (singer:`singer.singer`) RETURN singer.Name ORDER BY singer.Citizenship DESC LIMIT 1
label query  : MATCH (singer:`singer.singer`) RETURN singer.Citizenship ORDER BY singer.Citizenship DESC LIMIT 1


baseline pred: MATCH (singer:`singer.singer`) RETURN singer.Name ORDER BY singer.Citizenship DESC LIMIT 1
label query  : MATCH (singer:`singer.singer`) RETURN singer.Citizenship ORDER BY singer.Citizenship DESC LIMIT 1


baseline pred: MATCH (song:`singer.song`) RETURN song.Title,song.Name
label query  : MATCH (T1:`singer.singer`)-[]-(T2:`singer.song`) RETURN T2.Title,T1.Name


baseline pred: MATCH (song:`singer.song`) RETURN song.Title,song.Name
label query  : MATCH (T1:`singer.singer`)-[]-(T2:`singer.song`) RETURN T2.Title,T1.Name


baseline pred: MATCH (singer:`singer.singer`) WHERE singer.Sales > 300000 RETURN DISTINCT singer.Name
label query  : MATCH (T1:`singer.singer`)-[]-(T2:`singer.song`) WHERE T2.Sales > 300000 RETURN DISTINCT T1.Name


baseline pred: MATCH (singer:`singer.singer`) WHERE singer.Sales > 300000 RETURN DISTINCT singer.Name
label query  : MATCH (T1:`singer.singer`)-[]-(T2:`singer.song`) WHERE T2.Sales > 300000 RETURN DISTINCT T1.Name


baseline pred: MATCH (singer:`singer.singer`) WITH count(*) AS count, singer.Name AS Name WHERE count > 1 RETURN Name
label query  : MATCH (T1:`singer.singer`)-[]-(T2:`singer.song`) WITH T1.Name AS Name, count(*) AS count WHERE count  > 1 RETURN Name


baseline pred: MATCH (singer:`singer.singer`) WITH count(*) AS count, singer.Name AS Name WHERE count > 1 RETURN Name
label query  : MATCH (T1:`singer.singer`)-[]-(T2:`singer.song`) WITH T1.Name AS Name, count(*) AS count WHERE count  > 1 RETURN Name


baseline pred: MATCH (singer:`singer.singer`) WHERE NOT (singer)-[]-(:`singer.song`) RETURN singer.Name
label query  : MATCH (singer:`singer.singer`) WHERE NOT (singer)-[]-(:`singer.song`)     RETURN singer.Name


baseline pred: MATCH (singer:`singer.singer`) WHERE NOT (singer)-[]-(:`singer.song`) RETURN singer.Name
label query  : MATCH (singer:`singer.singer`) WHERE NOT (singer)-[]-(:`singer.song`)     RETURN singer.Name


baseline pred: MATCH (T1:`real_estate_properties.Other_Available_Features`)-[]-(T2:`real_estate_properties.Ref_Feature_Types`) RETURN count(*)
label query  : MATCH (other_available_features:`real_estate_properties.Other_Available_Features`) RETURN count(*)


baseline pred: MATCH (T1:`real_estate_properties.Property_Types`)-[]-(T2:`real_estate_properties.Ref_Property_Types`) RETURN T1.property_type_description
label query  : MATCH (T1:`real_estate_properties.Properties`)-[]-(T2:`real_estate_properties.Ref_Property_Types`) RETURN T2.property_type_description


baseline pred: MATCH (properties:`real_estate_properties.Properties`) WHERE properties.house = 'Apartment' OR properties.room_count > 1 RETURN properties.property_name
label query  : MATCH (properties:`real_estate_properties.Properties`) WHERE properties.property_type_code = 'House' RETURN properties.property_name  AS property_name  UNION MATCH (properties:`real_estate_properties.Properties`) WHERE properties.property_type_code = 'Apartment' AND properties.room_count > 1 RETURN properties.property_name  AS property_name



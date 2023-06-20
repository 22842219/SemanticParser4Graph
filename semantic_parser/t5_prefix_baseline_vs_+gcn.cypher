index       : 5
baseline pre: MATCH (singer:`concert_singer.singer`) WHERE singer.Sing_Name = 'French' RETURN avg(singer.Age),min(singer.Age),max(singer.Age)
model1 pred : MATCH (singer:`concert_singer.singer`) WHERE singer.Name = 'French' RETURN avg(singer.Age),min(singer.Age),max(singer.Age)
ground query: MATCH (singer:`concert_singer.singer`) WHERE singer.Country = 'France' RETURN avg(singer.Age),min(singer.Age),max(singer.Age)
NLQ         : What is the average, minimum, and maximum age for all French singers?
Schema      : | concert_singer | `concert_singer.stadium` : Name , Lowest , Stadium_ID , Capacity , Highest , Location , Average | `concert_singer.singer` : Country , Age , Name , Song_Name , Is_male , Singer_ID , Song_release_year | `concert_singer.concert` : Year , Theme , Stadium_ID , concert_Name , concert_ID | `concert_singer.singer_in_concert` : concert_ID , Singer_ID | `concert_singer.concert_HAS_concert_singer.stadium` :


index       : 6
baseline pre: MATCH (singer:`concert_singer.singer`) RETURN singer.Name,singer.Song_release_year ORDER BY singer.Age ASC LIMIT 1
model1 pred : MATCH (singer:`concert_singer.singer`) RETURN singer.Name,singer.Song_release_year ORDER BY singer.Age ASC LIMIT 1
ground query: MATCH (singer:`concert_singer.singer`) RETURN singer.Song_Name,singer.Song_release_year ORDER BY singer.Age LIMIT 1
NLQ         : Show the name and the release year of the song by the youngest singer.
Schema      : | concert_singer | `concert_singer.stadium` : Name , Lowest , Stadium_ID , Capacity , Highest , Location , Average | `concert_singer.singer` : Country , Age , Name , Song_Name , Is_male , Singer_ID , Song_release_year | `concert_singer.concert` : Year , Theme , Stadium_ID , concert_Name , concert_ID | `concert_singer.singer_in_concert` : concert_ID , Singer_ID | `concert_singer.concert_HAS_concert_singer.stadium` :


index       : 7
baseline pre: MATCH (singer:`concert_singer.singer`) RETURN singer.Name,singer.Song_release_year ORDER BY singer.Age ASC LIMIT 1
model1 pred : MATCH (singer:`concert_singer.singer`) RETURN singer.Name,singer.Song_release_year ORDER BY singer.Age ASC LIMIT 1
ground query: MATCH (singer:`concert_singer.singer`) RETURN singer.Song_Name,singer.Song_release_year ORDER BY singer.Age LIMIT 1
NLQ         : What are the names and release years for all the songs of the youngest singer?
Schema      : | concert_singer | `concert_singer.stadium` : Name , Lowest , Stadium_ID , Capacity , Highest , Location , Average | `concert_singer.singer` : Country , Age , Name , Song_Name , Is_male , Singer_ID , Song_release_year | `concert_singer.concert` : Year , Theme , Stadium_ID , concert_Name , concert_ID | `concert_singer.singer_in_concert` : concert_ID , Singer_ID | `concert_singer.concert_HAS_concert_singer.stadium` :


index       : 12
baseline pre: MATCH (singer:`concert_singer.singer`) WITH avg(singer.Age) AS age MATCH (singer:`concert_singer.singer`) WHERE singer.Age > age RETURN singer.Song_Name
model1 pred : MATCH (singer:`concert_singer.singer`) WITH avg(singer.Age) AS age MATCH (singer:`concert_singer.singer`) WHERE singer.Age > age RETURN singer.Name
ground query: MATCH (singer:`concert_singer.singer`) WITH avg(singer.Age) AS age MATCH (singer:`concert_singer.singer`) WHERE  singer.Age >  age  RETURN singer.Song_Name
NLQ         : List all song names by singers above the average age.
Schema      : | concert_singer | `concert_singer.stadium` : Name , Lowest , Stadium_ID , Capacity , Highest , Location , Average | `concert_singer.singer` : Country , Age , Name , Song_Name , Is_male , Singer_ID , Song_release_year | `concert_singer.concert` : Year , Theme , Stadium_ID , concert_Name , concert_ID | `concert_singer.singer_in_concert` : concert_ID , Singer_ID | `concert_singer.concert_HAS_concert_singer.stadium` :


index       : 13
baseline pre: MATCH (singer:`concert_singer.singer`) WITH avg(singer.Age) AS age MATCH (singer:`concert_singer.singer`) WHERE singer.Age > age RETURN singer.Song_Name
model1 pred : MATCH (singer:`concert_singer.singer`) WITH avg(singer.Age) AS age MATCH (singer:`concert_singer.singer`) WHERE singer.Age > age RETURN singer.Name
ground query: MATCH (singer:`concert_singer.singer`) WITH avg(singer.Age) AS age MATCH (singer:`concert_singer.singer`) WHERE  singer.Age >  age  RETURN singer.Song_Name
NLQ         : What are all the song names by singers who are older than average?
Schema      : | concert_singer | `concert_singer.stadium` : Name , Lowest , Stadium_ID , Capacity , Highest , Location , Average | `concert_singer.singer` : Country , Age , Name , Song_Name , Is_male , Singer_ID , Song_release_year | `concert_singer.concert` : Year , Theme , Stadium_ID , concert_Name , concert_ID | `concert_singer.singer_in_concert` : concert_ID , Singer_ID | `concert_singer.concert_HAS_concert_singer.stadium` :


index       : 14
baseline pre: MATCH (stadium:`concert_singer.stadium`) WHERE 5000=stadium.Capacity=10000 RETURN stadium.Location,stadium.Name
model1 pred : MATCH (stadium:`concert_singer.stadium`) WHERE 5000=stadium.Capacity=10000 RETURN stadium.Location,stadium.Name
ground query: MATCH (stadium:`concert_singer.stadium`) WHERE 5000<=stadium.Capacity<=10000 RETURN stadium.Location,stadium.Name
NLQ         : Show location and name for all stadiums with a capacity between 5000 and 10000.
Schema      : | concert_singer | `concert_singer.stadium` : Name , Lowest , Stadium_ID , Capacity , Highest , Location , Average | `concert_singer.singer` : Country , Age , Name , Song_Name , Is_male , Singer_ID , Song_release_year | `concert_singer.concert` : Year , Theme , Stadium_ID , concert_Name , concert_ID | `concert_singer.singer_in_concert` : concert_ID , Singer_ID | `concert_singer.concert_HAS_concert_singer.stadium` :


index       : 15
baseline pre: MATCH (stadium:`concert_singer.stadium`) WHERE 5000=stadium.Capacity=10000 RETURN stadium.Location,stadium.Name
model1 pred : MATCH (stadium:`concert_singer.stadium`) WHERE 5000=stadium.Capacity=10000 RETURN stadium.Location,stadium.Name
ground query: MATCH (stadium:`concert_singer.stadium`) WHERE 5000<=stadium.Capacity<=10000 RETURN stadium.Location,stadium.Name
NLQ         : What are the locations and names of all stations with capacity between 5000 and 10000?
Schema      : | concert_singer | `concert_singer.stadium` : Name , Lowest , Stadium_ID , Capacity , Highest , Location , Average | `concert_singer.singer` : Country , Age , Name , Song_Name , Is_male , Singer_ID , Song_release_year | `concert_singer.concert` : Year , Theme , Stadium_ID , concert_Name , concert_ID | `concert_singer.singer_in_concert` : concert_ID , Singer_ID | `concert_singer.concert_HAS_concert_singer.stadium` :


index       : 19
baseline pre: MATCH (concert:`concert_singer.concert`) WHERE concert.Year = 2014 OR concert.Year = 2015 RETURN count(*)
model1 pred : MATCH (concert:`concert_singer.concert`) WHERE concert.Year = 2014 OR concert.Year = 2015 RETURN count(*)
ground query: MATCH (concert:`concert_singer.concert`) WHERE concert.Year = '2014' OR concert.Year = '2015' RETURN count(*)
NLQ         : How many concerts are there in year 2014 or 2015?
Schema      : | concert_singer | `concert_singer.stadium` : Name , Lowest , Stadium_ID , Capacity , Highest , Location , Average | `concert_singer.singer` : Country , Age , Name , Song_Name , Is_male , Singer_ID , Song_release_year | `concert_singer.concert` : Year , Theme , Stadium_ID , concert_Name , concert_ID | `concert_singer.singer_in_concert` : concert_ID , Singer_ID | `concert_singer.concert_HAS_concert_singer.stadium` :


index       : 20
baseline pre: MATCH (concert:`concert_singer.concert`) WHERE concert.Year = 2014 OR concert.Year = 2015 RETURN count(*)
model1 pred : MATCH (concert:`concert_singer.concert`) WHERE concert.Year = 2014 OR concert.Year = 2015 RETURN count(*)
ground query: MATCH (concert:`concert_singer.concert`) WHERE concert.Year = '2014' OR concert.Year = '2015' RETURN count(*)
NLQ         : How many concerts occurred in 2014 or 2015?
Schema      : | concert_singer | `concert_singer.stadium` : Name , Lowest , Stadium_ID , Capacity , Highest , Location , Average | `concert_singer.singer` : Country , Age , Name , Song_Name , Is_male , Singer_ID , Song_release_year | `concert_singer.concert` : Year , Theme , Stadium_ID , concert_Name , concert_ID | `concert_singer.singer_in_concert` : concert_ID , Singer_ID | `concert_singer.concert_HAS_concert_singer.stadium` :


index       : 21
baseline pre: MATCH (T1:`concert_singer.stadium`)-[]-(T2:`concert_singer.concert`) RETURN T1.Name,count(*)
model1 pred : MATCH (T1:`concert_singer.stadium`)-[]-(T2:`concert_singer.concert`) RETURN T1.Name,count(*)
ground query: MATCH (T1:`concert_singer.concert`)-[]-(T2:`concert_singer.stadium`) RETURN T2.Name,count(*)
NLQ         : Show the stadium name and the number of concerts in each stadium.
Schema      : | concert_singer | `concert_singer.stadium` : Name , Lowest , Stadium_ID , Capacity , Highest , Location , Average | `concert_singer.singer` : Country , Age , Name , Song_Name , Is_male , Singer_ID , Song_release_year | `concert_singer.concert` : Year , Theme , Stadium_ID , concert_Name , concert_ID | `concert_singer.singer_in_concert` : concert_ID , Singer_ID | `concert_singer.concert_HAS_concert_singer.stadium` :


index       : 22
baseline pre: MATCH (T1:`concert_singer.stadium`)-[]-(T2:`concert_singer.concert`) RETURN T1.Name,count(*)
model1 pred : MATCH (stadium:`concert_singer.stadium`) RETURN stadium.Name,count(*)
ground query: MATCH (T1:`concert_singer.concert`)-[]-(T2:`concert_singer.stadium`) RETURN T2.Name,count(*)
NLQ         : For each stadium, how many concerts play there?
Schema      : | concert_singer | `concert_singer.stadium` : Name , Lowest , Stadium_ID , Capacity , Highest , Location , Average | `concert_singer.singer` : Country , Age , Name , Song_Name , Is_male , Singer_ID , Song_release_year | `concert_singer.concert` : Year , Theme , Stadium_ID , concert_Name , concert_ID | `concert_singer.singer_in_concert` : concert_ID , Singer_ID | `concert_singer.concert_HAS_concert_singer.stadium` :


index       : 23
baseline pre: MATCH (T1:`concert_singer.stadium`)-[]-(T2:`concert_singer.concert`) WHERE T2.Year >= 2014 RETURN T1.Name,T1.Capacity ORDER BY T2.Year DESC LIMIT 1
model1 pred : MATCH (stadium:`concert_singer.stadium`) WHERE stadium.Year = 2014 OR stadium.Year >= 2014 RETURN stadium.Name,stadium.Capacity ORDER BY stadium.Capacity DESC LIMIT 1
ground query: MATCH (T1:`concert_singer.concert`)-[]-(T2:`concert_singer.stadium`) WHERE T1.Year >= '2014' WITH count(T1.Stadium_ID) AS cnt, T2 RETURN T2.Name,T2.Capacity ORDER BY cnt DESC LIMIT 1
NLQ         : Show the stadium name and capacity with most number of concerts in year 2014 or after.
Schema      : | concert_singer | `concert_singer.stadium` : Name , Lowest , Stadium_ID , Capacity , Highest , Location , Average | `concert_singer.singer` : Country , Age , Name , Song_Name , Is_male , Singer_ID , Song_release_year | `concert_singer.concert` : Year , Theme , Stadium_ID , concert_Name , concert_ID | `concert_singer.singer_in_concert` : concert_ID , Singer_ID | `concert_singer.concert_HAS_concert_singer.stadium` :


index       : 24
baseline pre: MATCH (T1:`concert_singer.stadium`)-[]-(T2:`concert_singer.concert`) WHERE T2.Year > 2013 WITH count(T1.Stage_ID) AS cnt, T2 RETURN T2.Name,T2.Capacity ORDER BY cnt DESC LIMIT 1
model1 pred : MATCH (stadium:`concert_singer.stadium`) WHERE stadium.Year > 2013 RETURN stadium.Name,stadium.Capacity ORDER BY stadium.Year DESC LIMIT 1
ground query: MATCH (t1:`concert_singer.concert`)-[]-(t2:`concert_singer.stadium`) WHERE t1.Year > '2013' WITH count(t1.Stadium_ID) AS cnt, t2 RETURN t2.Name,t2.Capacity ORDER BY cnt DESC LIMIT 1
NLQ         : What is the name and capacity of the stadium with the most concerts after 2013 ?
Schema      : | concert_singer | `concert_singer.stadium` : Name , Lowest , Stadium_ID , Capacity , Highest , Location , Average | `concert_singer.singer` : Country , Age , Name , Song_Name , Is_male , Singer_ID , Song_release_year | `concert_singer.concert` : Year , Theme , Stadium_ID , concert_Name , concert_ID | `concert_singer.singer_in_concert` : concert_ID , Singer_ID | `concert_singer.concert_HAS_concert_singer.stadium` :


index       : 27
baseline pre: MATCH (stadium:`concert_singer.stadium`) WHERE NOT (stadium)-[]-(:`concert_singer.concert`) RETURN stadium.Name
model1 pred : MATCH (stadium:`concert_singer.stadium`) WHERE NOT (stadium)-[]-(:`concert_singer.concert`) RETURN stadium.Name
ground query: MATCH (stadium:`concert_singer.stadium`) WHERE NOT (stadium)-[]-(:`concert_singer.concert`)     RETURN stadium.Name
NLQ         : Show the stadium names without any concert.
Schema      : | concert_singer | `concert_singer.stadium` : Name , Lowest , Stadium_ID , Capacity , Highest , Location , Average | `concert_singer.singer` : Country , Age , Name , Song_Name , Is_male , Singer_ID , Song_release_year | `concert_singer.concert` : Year , Theme , Stadium_ID , concert_Name , concert_ID | `concert_singer.singer_in_concert` : concert_ID , Singer_ID | `concert_singer.concert_HAS_concert_singer.stadium` :


index       : 28
baseline pre: MATCH (stadium:`concert_singer.stadium`) WHERE NOT (stadium)-[]-(:`concert_singer.concert`) RETURN stadium.Name
model1 pred : MATCH (stadium:`concert_singer.stadium`) WHERE NOT (stadium)-[]-(:`concert_singer.concert`) RETURN stadium.Name
ground query: MATCH (stadium:`concert_singer.stadium`) WHERE NOT (stadium)-[]-(:`concert_singer.concert`)     RETURN stadium.Name
NLQ         : What are the names of the stadiums without any concerts?
Schema      : | concert_singer | `concert_singer.stadium` : Name , Lowest , Stadium_ID , Capacity , Highest , Location , Average | `concert_singer.singer` : Country , Age , Name , Song_Name , Is_male , Singer_ID , Song_release_year | `concert_singer.concert` : Year , Theme , Stadium_ID , concert_Name , concert_ID | `concert_singer.singer_in_concert` : concert_ID , Singer_ID | `concert_singer.concert_HAS_concert_singer.stadium` :


index       : 29
baseline pre: MATCH (T1:`concert_singer.singer`)-[]-(T2:`concert_singer.singer_in_concert`) RETURN T1.Name,T1.Theme,count(*)
model1 pred : MATCH (T1:`concert_singer.singer`)-[]-(T2:`concert_singer.concert`) RETURN T1.Name,T2.Theme,count(*)
ground query: MATCH (T2:`concert_singer.concert`)-[T1:`concert_singer.singer_in_concert`]-() RETURN T2.concert_Name,T2.Theme,count(*)
NLQ         : Show the name and theme for all concerts and the number of singers in each concert.
Schema      : | concert_singer | `concert_singer.stadium` : Name , Lowest , Stadium_ID , Capacity , Highest , Location , Average | `concert_singer.singer` : Country , Age , Name , Song_Name , Is_male , Singer_ID , Song_release_year | `concert_singer.concert` : Year , Theme , Stadium_ID , concert_Name , concert_ID | `concert_singer.singer_in_concert` : concert_ID , Singer_ID | `concert_singer.concert_HAS_concert_singer.stadium` :


index       : 30
baseline pre: MATCH (T1:`concert_singer.singer`)-[]-(T2:`concert_singer.concert`) RETURN T1.Name,T1.Theme,count(*)
model1 pred : MATCH ()-[singer_in_concert:`concert_singer.singer_in_concert ` ]-() RETURN singer_in_concert.Name,singer_in_concert.Theme,count(*)
ground query: MATCH (t2:`concert_singer.concert`)-[t1:`concert_singer.singer_in_concert`]-() RETURN t2.concert_Name,t2.Theme,count(*)
NLQ         : What are the names , themes , and number of singers for every concert ?
Schema      : | concert_singer | `concert_singer.stadium` : Name , Lowest , Stadium_ID , Capacity , Highest , Location , Average | `concert_singer.singer` : Country , Age , Name , Song_Name , Is_male , Singer_ID , Song_release_year | `concert_singer.concert` : Year , Theme , Stadium_ID , concert_Name , concert_ID | `concert_singer.singer_in_concert` : concert_ID , Singer_ID | `concert_singer.concert_HAS_concert_singer.stadium` :


index       : 31
baseline pre: MATCH (T1:`concert_singer.singer`)-[]-(T2:`concert_singer.concert`) RETURN T1.Name,count(*)
model1 pred : MATCH (T1:`concert_singer.singer`)-[]-(T2:`concert_singer.concert`) RETURN T1.Name,count(*)
ground query: MATCH (T2:`concert_singer.singer`)-[T1:`concert_singer.singer_in_concert`]-() RETURN T2.Name,count(*)
NLQ         : List singer names and number of concerts for each singer.
Schema      : | concert_singer | `concert_singer.stadium` : Name , Lowest , Stadium_ID , Capacity , Highest , Location , Average | `concert_singer.singer` : Country , Age , Name , Song_Name , Is_male , Singer_ID , Song_release_year | `concert_singer.concert` : Year , Theme , Stadium_ID , concert_Name , concert_ID | `concert_singer.singer_in_concert` : concert_ID , Singer_ID | `concert_singer.concert_HAS_concert_singer.stadium` :


index       : 32
baseline pre: MATCH (T1:`concert_singer.singer`)-[]-(T2:`concert_singer.concert`) RETURN T1.Name,count(*)
model1 pred : MATCH (T1:`concert_singer.singer`)-[]-(T2:`concert_singer.concert`) RETURN T1.Name,count(*)
ground query: MATCH (T2:`concert_singer.singer`)-[T1:`concert_singer.singer_in_concert`]-() RETURN T2.Name,count(*)
NLQ         : What are the names of the singers and number of concerts for each person?
Schema      : | concert_singer | `concert_singer.stadium` : Name , Lowest , Stadium_ID , Capacity , Highest , Location , Average | `concert_singer.singer` : Country , Age , Name , Song_Name , Is_male , Singer_ID , Song_release_year | `concert_singer.concert` : Year , Theme , Stadium_ID , concert_Name , concert_ID | `concert_singer.singer_in_concert` : concert_ID , Singer_ID | `concert_singer.concert_HAS_concert_singer.stadium` :


index       : 33
baseline pre: MATCH (T1:`concert_singer.singer`)-[]-(T2:`concert_singer.singer_in_concert`) WHERE T2.Year = 2014 RETURN T1.Name
model1 pred : MATCH (singer_in_concert:`concert_singer.singer`) WHERE singer_in_concert.Year = 2014 RETURN singer_in_concert.Name
ground query: MATCH (T2:`concert_singer.singer`)-[T1:`concert_singer.singer_in_concert`]-(T3:`concert_singer.concert`) WHERE T3.Year = '2014' RETURN T2.Name
NLQ         : List all singer names in concerts in year 2014.
Schema      : | concert_singer | `concert_singer.stadium` : Name , Lowest , Stadium_ID , Capacity , Highest , Location , Average | `concert_singer.singer` : Country , Age , Name , Song_Name , Is_male , Singer_ID , Song_release_year | `concert_singer.concert` : Year , Theme , Stadium_ID , concert_Name , concert_ID | `concert_singer.singer_in_concert` : concert_ID , Singer_ID | `concert_singer.concert_HAS_concert_singer.stadium` :


index       : 34
baseline pre: MATCH (T1:`concert_singer.singer`)-[]-(T2:`concert_singer.singer_in_concert`) WHERE T2.Year = 2014 RETURN T1.Name
model1 pred : MATCH (singer_in_concert:`concert_singer.singer_in_concert`) WHERE singer_in_concert.Year = 2014 RETURN singer_in_concert.Name
ground query: MATCH (T2:`concert_singer.singer`)-[T1:`concert_singer.singer_in_concert`]-(T3:`concert_singer.concert`) WHERE T3.Year = '2014' RETURN T2.Name
NLQ         : What are the names of the singers who performed in a concert in 2014?
Schema      : | concert_singer | `concert_singer.stadium` : Name , Lowest , Stadium_ID , Capacity , Highest , Location , Average | `concert_singer.singer` : Country , Age , Name , Song_Name , Is_male , Singer_ID , Song_release_year | `concert_singer.concert` : Year , Theme , Stadium_ID , concert_Name , concert_ID | `concert_singer.singer_in_concert` : concert_ID , Singer_ID | `concert_singer.concert_HAS_concert_singer.stadium` :


index       : 35
baseline pre: MATCH (singer:`concert_singer.singer`) WHERE singer.Song_Name ='.*[Hey|he]y.*' RETURN singer.Name,singer.Country
model1 pred : MATCH (singer:`concert_singer.singer`) WHERE singer.Song_Name = 'Hey' RETURN singer.Name,singer.Country
ground query: MATCH (singer:`concert_singer.singer`) WHERE singer.Song_Name =~'.*[H|h]ey.*' RETURN singer.Name,singer.Country
NLQ         : what is the name and nation of the singer who have a song having 'Hey' in its name?
Schema      : | concert_singer | `concert_singer.stadium` : Name , Lowest , Stadium_ID , Capacity , Highest , Location , Average | `concert_singer.singer` : Country , Age , Name , Song_Name , Is_male , Singer_ID , Song_release_year | `concert_singer.concert` : Year , Theme , Stadium_ID , concert_Name , concert_ID | `concert_singer.singer_in_concert` : concert_ID , Singer_ID | `concert_singer.concert_HAS_concert_singer.stadium` :


index       : 36
baseline pre: MATCH (singer:`concert_singer.singer`) WHERE singer.Song_Name ='.*[Hey|he]y.*' RETURN singer.Name,singer.Country
model1 pred : MATCH (singer:`concert_singer.singer`) WHERE singer.Song_Name ='.*[Hey|hey].*' RETURN singer.Name,singer.Country
ground query: MATCH (singer:`concert_singer.singer`) WHERE singer.Song_Name =~'.*[H|h]ey.*' RETURN singer.Name,singer.Country
NLQ         : What is the name and country of origin of every singer who has a song with the word 'Hey' in its title?
Schema      : | concert_singer | `concert_singer.stadium` : Name , Lowest , Stadium_ID , Capacity , Highest , Location , Average | `concert_singer.singer` : Country , Age , Name , Song_Name , Is_male , Singer_ID , Song_release_year | `concert_singer.concert` : Year , Theme , Stadium_ID , concert_Name , concert_ID | `concert_singer.singer_in_concert` : concert_ID , Singer_ID | `concert_singer.concert_HAS_concert_singer.stadium` :


index       : 39
baseline pre: MATCH (pets:`pets_1.Pets`) WHERE pets.PetType = 'dog' RETURN pets.weight ORDER BY pets.Age ASC LIMIT 1
model1 pred : MATCH (pets:`pets_1.Pets`) WHERE pets.PetType = 'dog' RETURN pets.weight ORDER BY pets.weight ASC LIMIT 1
ground query: MATCH (pets:`pets_1.Pets`) RETURN pets.weight ORDER BY pets.pet_age LIMIT 1
NLQ         : Find the weight of the youngest dog.
Schema      : | pets_1 | `pets_1.Student` : Age , city_code , Advisor , Major , Sex , Fname , StuID , LName | `pets_1.Pets` : weight , PetType ( dog ) , pet_age , PetID | `pets_1.Has_Pet` : StuID , PetID


index       : 40
baseline pre: MATCH (pets:`pets_1.Pets`) WITH min(pets.weight) AS weight MATCH (pets:`pets_1.Pets`) WHERE pets.PetType = 'dog' RETURN pets.weight ORDER BY pets.weight ASC LIMIT 1
model1 pred : MATCH (pets:`pets_1.Pets`) WHERE pets.PetType = 'dog' RETURN pets.weight ORDER BY pets.weight ASC LIMIT 1
ground query: MATCH (pets:`pets_1.Pets`) RETURN pets.weight ORDER BY pets.pet_age LIMIT 1
NLQ         : How much does the youngest dog weigh?
Schema      : | pets_1 | `pets_1.Student` : Age , city_code , Advisor , Major , Sex , Fname , StuID , LName | `pets_1.Pets` : weight , PetType ( dog ) , pet_age , PetID | `pets_1.Has_Pet` : StuID , PetID


index       : 41
baseline pre: MATCH (pets:`pets_1.Pets`) RETURN pets.weight,pets.PetType
model1 pred : MATCH (pets:`pets_1.Pets`) RETURN max(pets.weight),pets.PetType
ground query: MATCH (pets:`pets_1.Pets`) RETURN max(pets.weight),pets.PetType
NLQ         : Find the maximum weight for each type of pet. List the maximum weight and pet type.
Schema      : | pets_1 | `pets_1.Student` : Age , city_code , Advisor , Major , Sex , Fname , StuID , LName | `pets_1.Pets` : weight , PetType , pet_age , PetID | `pets_1.Has_Pet` : StuID , PetID


index       : 43
baseline pre: MATCH (T1:`pets_1.Pets`)-[T2:`pets_1.Has_Pet ` ]-() WHERE T1.Age > 20 RETURN count(*)
model1 pred : MATCH (T1:`pets_1.Pets`)-[T2:`pets_1.Has_Pet ` ]-() WHERE T2.Age > 20 RETURN count(*)
ground query: MATCH (T1:`pets_1.Student`)-[T2:`pets_1.Has_Pet`]-() WHERE T1.Age > 20 RETURN count(*)
NLQ         : Find number of pets owned by students who are older than 20.
Schema      : | pets_1 | `pets_1.Student` : Age , city_code , Advisor , Major , Sex , Fname , StuID , LName | `pets_1.Pets` : weight , PetType , pet_age , PetID | `pets_1.Has_Pet` : StuID , PetID


index       : 44
baseline pre: MATCH (T1:`pets_1.Pets`)-[T2:`pets_1.Has_Pet ` ]-() WHERE T1.Age > 20 RETURN count(*)
model1 pred : MATCH (T1:`pets_1.Pets`)-[T2:`pets_1.Has_Pet ` ]-() WHERE T2.Age > 20 RETURN count(*)
ground query: MATCH (T1:`pets_1.Student`)-[T2:`pets_1.Has_Pet`]-() WHERE T1.Age > 20 RETURN count(*)
NLQ         : How many pets are owned by students that have an age greater than 20?
Schema      : | pets_1 | `pets_1.Student` : Age , city_code , Advisor , Major , Sex , Fname , StuID , LName | `pets_1.Pets` : weight , PetType , pet_age , PetID | `pets_1.Has_Pet` : StuID , PetID


index       : 45
baseline pre: MATCH (T1:`pets_1.Pets`)-[T2:`pets_1.Has_Pet ` ]-(T3:`pets_1.Student`) WHERE T3.Sex = 'F' AND T1.Sex = 'dog' RETURN count(*)
model1 pred : MATCH (T1:`pets_1.Pets`)-[T2:`pets_1.Has_Pet ` ]-() WHERE T2.Sex = 'F' AND T1.Sex = 'dog' RETURN count(*)
ground query: MATCH (T1:`pets_1.Student`)-[T2:`pets_1.Has_Pet`]-(T3:`pets_1.Pets`) WHERE T1.Sex = 'F' AND T3.PetType = 'dog' RETURN count(*)
NLQ         : Find the number of dog pets that are raised by female students (with sex F).
Schema      : | pets_1 | `pets_1.Student` : Age , city_code , Advisor , Major , Sex , Fname , StuID , LName | `pets_1.Pets` : weight , PetType ( dog ) , pet_age , PetID | `pets_1.Has_Pet` : StuID , PetID


index       : 46
baseline pre: MATCH (pets:`pets_1.Pets`) WHERE pets.Sex = 'F' RETURN count(*),pets.PetType
model1 pred : MATCH (T1:`pets_1.Pets`)-[T2:`pets_1.Has_Pet ` ]-() WHERE T2.Sex = 'female' RETURN count(*)
ground query: MATCH (T1:`pets_1.Student`)-[T2:`pets_1.Has_Pet`]-(T3:`pets_1.Pets`) WHERE T1.Sex = 'F' AND T3.PetType = 'dog' RETURN count(*)
NLQ         : How many dog pets are raised by female students?
Schema      : | pets_1 | `pets_1.Student` : Age , city_code , Advisor , Major , Sex , Fname , StuID , LName | `pets_1.Pets` : weight , PetType ( dog ) , pet_age , PetID | `pets_1.Has_Pet` : StuID , PetID


index       : 49
baseline pre: MATCH (T1:`pets_1.Student`)-[T2:`pets_1.Has_Pet ` ]-() WHERE T1.PetType = 'cat' OR T1.PetType = 'dog' RETURN T1.Fname
model1 pred : MATCH (T1:`pets_1.Student`)-[T2:`pets_1.Has_Pet ` ]-() WHERE T2.PetType = 'cat' OR T1.PetType = 'dog' RETURN T1.Fname
ground query: MATCH (T1:`pets_1.Student`)-[T2:`pets_1.Has_Pet`]-(T3:`pets_1.Pets`) WHERE T3.PetType = 'cat' OR T3.PetType = 'dog' RETURN DISTINCT T1.Fname
NLQ         : Find the first name of students who have cat or dog pet.
Schema      : | pets_1 | `pets_1.Student` : Age , city_code , Advisor , Major , Sex , Fname , StuID , LName | `pets_1.Pets` : weight , PetType ( cat , dog ) , pet_age , PetID | `pets_1.Has_Pet` : StuID , PetID


index       : 50
baseline pre: MATCH (T1:`pets_1.Student`)-[T2:`pets_1.Has_Pet ` ]-() WHERE T1.PetType = 'cat' OR T1.PetType = 'dog' RETURN T1.Fname
model1 pred : MATCH (T1:`pets_1.Student`)-[T2:`pets_1.Has_Pet ` ]-() WHERE T2.PetType = 'cat' OR T1.PetType = 'dog' RETURN T1.Fname
ground query: MATCH (T1:`pets_1.Student`)-[T2:`pets_1.Has_Pet`]-(T3:`pets_1.Pets`) WHERE T3.PetType = 'cat' OR T3.PetType = 'dog' RETURN DISTINCT T1.Fname
NLQ         : What are the first names of every student who has a cat or dog as a pet?
Schema      : | pets_1 | `pets_1.Student` : Age , city_code , Advisor , Major , Sex , Fname , StuID , LName | `pets_1.Pets` : weight , PetType ( cat , dog ) , pet_age , PetID | `pets_1.Has_Pet` : StuID , PetID


index       : 51
baseline pre: MATCH (pets:`pets_1.Pets`) RETURN pets.PetType,pets.weight ORDER BY pets.Age ASC LIMIT 1
model1 pred : MATCH (pets:`pets_1.Pets`) RETURN pets.PetType,pets.weight ORDER BY pets.pet_age LIMIT 1
ground query: MATCH (pets:`pets_1.Pets`) RETURN pets.PetType,pets.weight ORDER BY pets.pet_age LIMIT 1
NLQ         : Find the type and weight of the youngest pet.
Schema      : | pets_1 | `pets_1.Student` : Age , city_code , Advisor , Major , Sex , Fname , StuID , LName | `pets_1.Pets` : weight , PetType , pet_age , PetID | `pets_1.Has_Pet` : StuID , PetID


index       : 52
baseline pre: MATCH (pets:`pets_1.Pets`) RETURN pets.PetType,pets.weight ORDER BY pets.age LIMIT 1
model1 pred : MATCH (pets:`pets_1.Pets`) RETURN pets.PetType,pets.weight ORDER BY pets.pet_age LIMIT 1
ground query: MATCH (pets:`pets_1.Pets`) RETURN pets.PetType,pets.weight ORDER BY pets.pet_age LIMIT 1
NLQ         : What type of pet is the youngest animal, and how much does it weigh?
Schema      : | pets_1 | `pets_1.Student` : Age , city_code , Advisor , Major , Sex , Fname , StuID , LName | `pets_1.Pets` : weight , PetType , pet_age , PetID | `pets_1.Has_Pet` : StuID , PetID


index       : 53
baseline pre: MATCH (pets:`pets_1.Pets`) WHERE pets.age > 1 RETURN pets.PetID,pets.weight
model1 pred : MATCH (pets:`pets_1.Pets`) WHERE pets.Pet_age > 1 RETURN pets.PetID,pets.weight
ground query: MATCH (pets:`pets_1.Pets`) WHERE pets.pet_age > 1 RETURN pets.PetID,pets.weight
NLQ         : Find the id and weight of all pets whose age is older than 1.
Schema      : | pets_1 | `pets_1.Student` : Age , city_code , Advisor , Major , Sex , Fname , StuID , LName | `pets_1.Pets` : weight , PetType , pet_age , PetID | `pets_1.Has_Pet` : StuID , PetID


index       : 55
baseline pre: MATCH (pets:`pets_1.Pets`) RETURN avg(pets.Age),max(pets.Age),pets.PetType
model1 pred : MATCH (pets:`pets_1.Pets`) RETURN avg(pets.pet_age),max(pets.pet_age)
ground query: MATCH (pets:`pets_1.Pets`) RETURN avg(pets.pet_age),max(pets.pet_age),pets.PetType
NLQ         : Find the average and maximum age for each type of pet.
Schema      : | pets_1 | `pets_1.Student` : Age , city_code , Advisor , Major , Sex , Fname , StuID , LName | `pets_1.Pets` : weight , PetType , pet_age , PetID | `pets_1.Has_Pet` : StuID , PetID


index       : 56
baseline pre: MATCH (pets:`pets_1.Pets`) RETURN avg(pets.Age),max(pets.Age),pets.PetType
model1 pred : MATCH (pets:`pets_1.Pets`) RETURN avg(pets.pet_age),max(pets.pet_age)
ground query: MATCH (pets:`pets_1.Pets`) RETURN avg(pets.pet_age),max(pets.pet_age),pets.PetType
NLQ         : What is the average and maximum age for each pet type?
Schema      : | pets_1 | `pets_1.Student` : Age , city_code , Advisor , Major , Sex , Fname , StuID , LName | `pets_1.Pets` : weight , PetType , pet_age , PetID | `pets_1.Has_Pet` : StuID , PetID


index       : 59
baseline pre: MATCH (T1:`pets_1.Student`)-[T2:`pets_1.Has_Pet ` ]-() WHERE T1.Sex = 'M' RETURN T1.Fname,T1.Age
model1 pred : MATCH (T1:`pets_1.Student`)-[T2:`pets_1.Has_Pet ` ]-() RETURN T1.Fname,T1.Age
ground query: MATCH (T1:`pets_1.Student`)-[T2:`pets_1.Has_Pet`]-() RETURN DISTINCT T1.Fname,T1.Age
NLQ         : Find the first name and age of students who have a pet.
Schema      : | pets_1 | `pets_1.Student` : Age , city_code , Advisor , Major , Sex , Fname , StuID , LName | `pets_1.Pets` : weight , PetType , pet_age , PetID | `pets_1.Has_Pet` : StuID , PetID


index       : 60
baseline pre: MATCH (T1:`pets_1.Student`)-[T2:`pets_1.Has_Pet ` ]-() WHERE T1.Sex = 'M' AND T1.Sex = 'M' RETURN DISTINCT T1.Fname,T1.Age
model1 pred : MATCH (T1:`pets_1.Student`)-[T2:`pets_1.Has_Pet ` ]-() RETURN DISTINCT T1.Fname,T1.Age
ground query: MATCH (T1:`pets_1.Student`)-[T2:`pets_1.Has_Pet`]-() RETURN DISTINCT T1.Fname,T1.Age
NLQ         : What are the different first names and ages of the students who do have pets?
Schema      : | pets_1 | `pets_1.Student` : Age , city_code , Advisor , Major , Sex , Fname , StuID , LName | `pets_1.Pets` : weight , PetType , pet_age , PetID | `pets_1.Has_Pet` : StuID , PetID


index       : 61
baseline pre: MATCH (T1:`pets_1.Pet`)-[T2:`pets_1.Has_Pet ` ]-() WHERE T1.Fname = 'Smith' RETURN T1.PetID
model1 pred : MATCH (T1:`pets_1.Pet`)-[T2:`pets_1.Has_Pet ` ]-() WHERE T1.LName ='.*[S|s]mith.*' RETURN T1.PetID
ground query: MATCH (T1:`pets_1.Student`)-[T2:`pets_1.Has_Pet`]-() WHERE T1.LName = 'Smith' RETURN T2.PetID
NLQ         : Find the id of the pet owned by student whose last name is ‘Smith’.
Schema      : | pets_1 | `pets_1.Student` : Age , city_code , Advisor , Major , Sex , Fname , StuID , LName | `pets_1.Pets` : weight , PetType , pet_age , PetID | `pets_1.Has_Pet` : StuID , PetID


index       : 62
baseline pre: MATCH (T1:`pets_1.Pet`)-[T2:`pets_1.Has_Pet ` ]-() WHERE T1.LName = 'Smith' RETURN T1.PetID
model1 pred : MATCH (T1:`pets_1.Pet`)-[T2:`pets_1.Has_Pet ` ]-() WHERE T1.LName = 'Smith' RETURN T1.PetID
ground query: MATCH (T1:`pets_1.Student`)-[T2:`pets_1.Has_Pet`]-() WHERE T1.LName = 'Smith' RETURN T2.PetID
NLQ         : What is the id of the pet owned by the student whose last name is 'Smith'?
Schema      : | pets_1 | `pets_1.Student` : Age , city_code , Advisor , Major , Sex , Fname , StuID , LName ( Smith ) | `pets_1.Pets` : weight , PetType , pet_age , PetID | `pets_1.Has_Pet` : StuID , PetID


index       : 63
baseline pre: MATCH (T1:`pets_1.Petствned`)-[T2:`pets_1.Has_Pet ` ]-() RETURN count(*),T1.StuID
model1 pred : MATCH (T1:`pets_1.Student`)-[T2:`pets_1.Has_Pet ` ]-() RETURN count(*),T1.StuID
ground query: MATCH (T1:`pets_1.Student`)-[T2:`pets_1.Has_Pet`]-() RETURN count(*),T1.StuID
NLQ         : Find the number of pets for each student who has any pet and student id.
Schema      : | pets_1 | `pets_1.Student` : Age , city_code , Advisor , Major , Sex , Fname , StuID , LName | `pets_1.Pets` : weight , PetType , pet_age , PetID | `pets_1.Has_Pet` : StuID , PetID


index       : 64
baseline pre: MATCH (T1:`pets_1.Student`)-[T2:`pets_1.Has_Pet ` ]-() WHERE T1.Sex = 'M' RETURN T1.StuID,count(*)
model1 pred : MATCH (T1:`pets_1.Student`)-[T2:`pets_1.Has_Pet ` ]-() WITH count(*) AS count, T1.StuID AS StuID, T1.LName AS LName WHERE count >= 1 RETURN count,StuID
ground query: MATCH (t1:`pets_1.Student`)-[t2:`pets_1.Has_Pet`]-() RETURN count(*),t1.StuID
NLQ         : For students who have pets , how many pets does each student have ? list their ids instead of names .
Schema      : | pets_1 | `pets_1.Student` : Age , city_code , Advisor , Major , Sex , Fname , StuID , LName | `pets_1.Pets` : weight , PetType , pet_age , PetID | `pets_1.Has_Pet` : StuID , PetID


index       : 65
baseline pre: MATCH (T1:`pets_1.Student`)-[T2:`pets_1.Has_Pet ` ]-() WITH count(*) AS count, T1.Fname AS Fname, T1.Sex AS Sex WHERE count > 1 RETURN Fname,Sex
model1 pred : MATCH (T1:`pets_1.Student`)-[T2:`pets_1.Has_Pet ` ]-() WITH count(*) AS count, T1.Sex AS Sex, T1.Fname AS Fname, T1.Sex AS Sex WHERE count > 1 RETURN Fname,Sex
ground query: MATCH (T1:`pets_1.Student`)-[T2:`pets_1.Has_Pet`]-() WITH count(*) AS count, T1.Sex AS Sex, T1.Fname AS Fname WHERE count  > 1 RETURN Fname,Sex
NLQ         : Find the first name and gender of student who have more than one pet.
Schema      : | pets_1 | `pets_1.Student` : Age , city_code , Advisor , Major , Sex , Fname , StuID , LName | `pets_1.Pets` : weight , PetType , pet_age , PetID | `pets_1.Has_Pet` : StuID , PetID


index       : 66
baseline pre: MATCH (T1:`pets_1.Student`)-[T2:`pets_1.Has_Pet ` ]-() WITH count(*) AS count, T1.Fname AS Fname, T1.Sex AS Sex WHERE count > 1 RETURN Fname,Sex
model1 pred : MATCH (T1:`pets_1.Student`)-[T2:`pets_1.Has_Pet ` ]-() WITH count(*) AS count, T1.Fname AS Fname, T1.Sex AS Sex WHERE count > 1 RETURN Fname,Sex
ground query: MATCH (T1:`pets_1.Student`)-[T2:`pets_1.Has_Pet`]-() WITH count(*) AS count, T1.Sex AS Sex, T1.Fname AS Fname WHERE count  > 1 RETURN Fname,Sex
NLQ         : What is the first name and gender of the all the students who have more than one pet?
Schema      : | pets_1 | `pets_1.Student` : Age , city_code , Advisor , Major , Sex , Fname , StuID , LName | `pets_1.Pets` : weight , PetType , pet_age , PetID | `pets_1.Has_Pet` : StuID , PetID


index       : 67
baseline pre: MATCH (T1:`pets_1.Student`)-[T2:`pets_1.Has_Pet ` ]-() WHERE T1.PetType = 'cat' AND T1.Age = 3 RETURN T1.LName
model1 pred : MATCH (T1:`pets_1.Student`)-[T2:`pets_1.Has_Pet ` ]-() WHERE T2.PetType = 'cat' AND T1.Age = 3 RETURN T1.LName
ground query: MATCH (T1:`pets_1.Student`)-[T2:`pets_1.Has_Pet`]-(T3:`pets_1.Pets`) WHERE T3.pet_age = 3 AND T3.PetType = 'cat' RETURN T1.LName
NLQ         : Find the last name of the student who has a cat that is age 3.
Schema      : | pets_1 | `pets_1.Student` : Age , city_code , Advisor , Major , Sex , Fname , StuID , LName | `pets_1.Pets` : weight , PetType ( cat ) , pet_age , PetID | `pets_1.Has_Pet` : StuID , PetID


index       : 68
baseline pre: MATCH (T1:`pets_1.Student`)-[T2:`pets_1.Has_Pet ` ]-() WHERE T1.PetType = 'cat' AND T1.Age >= 3 RETURN T1.LName
model1 pred : MATCH (T1:`pets_1.Student`)-[T2:`pets_1.Has_Pet ` ]-() WHERE T2.PetType = 'cat' AND T1.Age > 3 RETURN T1.LName
ground query: MATCH (T1:`pets_1.Student`)-[T2:`pets_1.Has_Pet`]-(T3:`pets_1.Pets`) WHERE T3.pet_age = 3 AND T3.PetType = 'cat' RETURN T1.LName
NLQ         : What is the last name of the student who has a cat that is 3 years old?
Schema      : | pets_1 | `pets_1.Student` : Age , city_code , Advisor , Major , Sex , Fname , StuID , LName | `pets_1.Pets` : weight , PetType ( cat ) , pet_age , PetID | `pets_1.Has_Pet` : StuID , PetID


index       : 71
baseline pre: MATCH (continents:`car_1.continents`) RETURN continents.ContId,continents.ContName,count(*)
model1 pred : MATCH (T1:`car_1.continents`)-[]-(T2:`car_1.countries`) RETURN T1.ContId,T1.Continent,count(*)
ground query: MATCH (T1:`car_1.continents`)-[]-(T2:`car_1.countries`) RETURN T1.ContId,T1.Continent,count(*)
NLQ         : How many countries does each continent have? List the continent id, continent name and the number of countries.
Schema      : | car_1 | `car_1.continents` : ContId , Continent | `car_1.countries` : CountryName , Continent , CountryId | `car_1.car_makers` : Country , FullName , Id , Maker | `car_1.model_list` : ModelId , Maker , Model | `car_1.car_names` : Make , MakeId , Model | `car_1.cars_data` : MPG , Year , Cylinders , Id , Weight , Accelerate , Edispl , Horsepower | `car_1.countries_HAS_car_1.continents` :  | `car_1.car_makers_HAS_car_1.countries` :  | `car_1.model_list_HAS_car_1.car_makers` :  | `car_1.car_names_HAS_car_1.model_list` :  | `car_1.cars_data_HAS_car_1.car_names` :


index       : 72
baseline pre: MATCH (continents:`car_1.continents`) RETURN continents.Continent,continents.CountryName,count(*)
model1 pred : MATCH (T1:`car_1.continents`)-[]-(T2:`car_1.countries`) RETURN T1.ContId,T1.Continent,count(*)
ground query: MATCH (T1:`car_1.continents`)-[]-(T2:`car_1.countries`) RETURN T1.ContId,T1.Continent,count(*)
NLQ         : For each continent, list its id, name, and how many countries it has?
Schema      : | car_1 | `car_1.continents` : ContId , Continent | `car_1.countries` : CountryName , Continent , CountryId | `car_1.car_makers` : Country , FullName , Id , Maker | `car_1.model_list` : ModelId , Maker , Model | `car_1.car_names` : Make , MakeId , Model | `car_1.cars_data` : MPG , Year , Cylinders , Id , Weight , Accelerate , Edispl , Horsepower | `car_1.countries_HAS_car_1.continents` :  | `car_1.car_makers_HAS_car_1.countries` :  | `car_1.model_list_HAS_car_1.car_makers` :  | `car_1.car_names_HAS_car_1.model_list` :  | `car_1.cars_data_HAS_car_1.car_names` :


index       : 76
baseline pre: MATCH (car_makers:`car_1.car_makers`) RETURN car_makers.FullName,car_makers.Make,count(*)
model1 pred : MATCH (car_makers:`car_1.car_makers`) RETURN car_makers.FullName,count(*)
ground query: MATCH (T1:`car_1.car_makers`)-[]-(T2:`car_1.model_list`) RETURN T1.FullName,T1.Id,count(*)
NLQ         : What is the full name of each car maker, along with its id and how many models it produces?
Schema      : | car_1 | `car_1.continents` : ContId , Continent | `car_1.countries` : CountryName , Continent , CountryId | `car_1.car_makers` : Country , FullName , Id , Maker | `car_1.model_list` : ModelId , Maker , Model | `car_1.car_names` : Make , MakeId , Model | `car_1.cars_data` : MPG , Year , Cylinders , Id , Weight , Accelerate , Edispl , Horsepower | `car_1.countries_HAS_car_1.continents` :  | `car_1.car_makers_HAS_car_1.countries` :  | `car_1.model_list_HAS_car_1.car_makers` :  | `car_1.car_names_HAS_car_1.model_list` :  | `car_1.cars_data_HAS_car_1.car_names` :


index       : 77
baseline pre: MATCH (cars_data:`car_1.cars_data`) RETURN cars_data.Model ORDER BY cars_data.Horsepower ASC LIMIT 1
model1 pred : MATCH (car_names:`car_1.car_names`) RETURN car_names.Model ORDER BY car_names.Headpower ASC LIMIT 1
ground query: MATCH (T1:`car_1.car_names`)-[]-(T2:`car_1.cars_data`) RETURN T1.Model ORDER BY T2.Horsepower ASC LIMIT 1
NLQ         : Which model of the car has the minimum horsepower?
Schema      : | car_1 | `car_1.continents` : ContId , Continent | `car_1.countries` : CountryName , Continent , CountryId | `car_1.car_makers` : Country , FullName , Id , Maker | `car_1.model_list` : ModelId , Maker , Model | `car_1.car_names` : Make , MakeId , Model | `car_1.cars_data` : MPG , Year , Cylinders , Id , Weight , Accelerate , Edispl , Horsepower | `car_1.countries_HAS_car_1.continents` :  | `car_1.car_makers_HAS_car_1.countries` :  | `car_1.model_list_HAS_car_1.car_makers` :  | `car_1.car_names_HAS_car_1.model_list` :  | `car_1.cars_data_HAS_car_1.car_names` :


index       : 78
baseline pre: MATCH (cars_data:`car_1.cars_data`) RETURN cars_data.Model ORDER BY cars_data.Horsepower ASC LIMIT 1
model1 pred : MATCH (car_names:`car_1.car_names`) RETURN car_names.Model ORDER BY car_names.Horsepower ASC LIMIT 1
ground query: MATCH (T1:`car_1.car_names`)-[]-(T2:`car_1.cars_data`) RETURN T1.Model ORDER BY T2.Horsepower ASC LIMIT 1
NLQ         : What is the model of the car with the smallest amount of horsepower?
Schema      : | car_1 | `car_1.continents` : ContId , Continent | `car_1.countries` : CountryName , Continent , CountryId | `car_1.car_makers` : Country , FullName , Id , Maker | `car_1.model_list` : ModelId , Maker , Model | `car_1.car_names` : Make , MakeId , Model | `car_1.cars_data` : MPG , Year , Cylinders , Id , Weight , Accelerate , Edispl , Horsepower | `car_1.countries_HAS_car_1.continents` :  | `car_1.car_makers_HAS_car_1.countries` :  | `car_1.model_list_HAS_car_1.car_makers` :  | `car_1.car_names_HAS_car_1.model_list` :  | `car_1.cars_data_HAS_car_1.car_names` :


index       : 79
baseline pre: MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Year > 1980 RETURN DISTINCT cars_data.Model
model1 pred : MATCH (car_names:`car_1.car_names`) WHERE cars_data.Year > 1980 RETURN DISTINCT car_names.Model
ground query: MATCH (T1:`car_1.model_list`)-[]-(T2:`car_1.car_names`)-[]-(T3:`car_1.cars_data`) WHERE T3.Year > 1980 RETURN DISTINCT T1.Model
NLQ         : Which distinct car models are the produced after 1980?
Schema      : | car_1 | `car_1.continents` : ContId , Continent | `car_1.countries` : CountryName , Continent , CountryId | `car_1.car_makers` : Country , FullName , Id , Maker | `car_1.model_list` : ModelId , Maker , Model | `car_1.car_names` : Make , MakeId , Model | `car_1.cars_data` : MPG , Year , Cylinders , Id , Weight , Accelerate , Edispl , Horsepower | `car_1.countries_HAS_car_1.continents` :  | `car_1.car_makers_HAS_car_1.countries` :  | `car_1.model_list_HAS_car_1.car_makers` :  | `car_1.car_names_HAS_car_1.model_list` :  | `car_1.cars_data_HAS_car_1.car_names` :


index       : 80
baseline pre: MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Year > 1980 RETURN DISTINCT cars_data.Model
model1 pred : MATCH (car_names:`car_1.car_names`) WHERE cars_data.Year > 1980 RETURN DISTINCT models_list.Model
ground query: MATCH (T1:`car_1.model_list`)-[]-(T2:`car_1.car_names`)-[]-(T3:`car_1.cars_data`) WHERE T3.Year > 1980 RETURN DISTINCT T1.Model
NLQ         : What are the different models for the cards produced after 1980?
Schema      : | car_1 | `car_1.continents` : ContId , Continent | `car_1.countries` : CountryName , Continent , CountryId | `car_1.car_makers` : Country , FullName , Id , Maker | `car_1.model_list` : ModelId , Maker , Model | `car_1.car_names` : Make , MakeId , Model | `car_1.cars_data` : MPG , Year , Cylinders , Id , Weight , Accelerate , Edispl , Horsepower | `car_1.countries_HAS_car_1.continents` :  | `car_1.car_makers_HAS_car_1.countries` :  | `car_1.model_list_HAS_car_1.car_makers` :  | `car_1.car_names_HAS_car_1.model_list` :  | `car_1.cars_data_HAS_car_1.car_names` :


index       : 81
baseline pre: MATCH (T1:`car_1.car_makers`)-[]-(T2:`car_1.continents`) RETURN count(*),T1.Continent
model1 pred : MATCH (T1:`car_1.car_makers`)-[]-(T2:`car_1.continents`) RETURN count(*),T1.Continent
ground query: MATCH (T1:`car_1.continents`)-[]-(T2:`car_1.countries`)-[]-(T3:`car_1.car_makers`) RETURN T1.Continent,count(*)
NLQ         : How many car makers are there in each continents? List the continent name and the count.
Schema      : | car_1 | `car_1.continents` : ContId , Continent | `car_1.countries` : CountryName , Continent , CountryId | `car_1.car_makers` : Country , FullName , Id , Maker | `car_1.model_list` : ModelId , Maker , Model | `car_1.car_names` : Make , MakeId , Model | `car_1.cars_data` : MPG , Year , Cylinders , Id , Weight , Accelerate , Edispl , Horsepower | `car_1.countries_HAS_car_1.continents` :  | `car_1.car_makers_HAS_car_1.countries` :  | `car_1.model_list_HAS_car_1.car_makers` :  | `car_1.car_names_HAS_car_1.model_list` :  | `car_1.cars_data_HAS_car_1.car_names` :


index       : 82
baseline pre: MATCH (T1:`car_1.car_makers`)-[]-(T2:`car_1.continents`) RETURN T1.Continent,count(*)
model1 pred : MATCH (T1:`car_1.continents`)-[]-(T2:`car_1.car_makers`) RETURN T1.Continent,count(*)
ground query: MATCH (T1:`car_1.continents`)-[]-(T2:`car_1.countries`)-[]-(T3:`car_1.car_makers`) RETURN T1.Continent,count(*)
NLQ         : What is the name of each continent and how many car makers are there in each one?
Schema      : | car_1 | `car_1.continents` : ContId , Continent | `car_1.countries` : CountryName , Continent , CountryId | `car_1.car_makers` : Country , FullName , Id , Maker | `car_1.model_list` : ModelId , Maker , Model | `car_1.car_names` : Make , MakeId , Model | `car_1.cars_data` : MPG , Year , Cylinders , Id , Weight , Accelerate , Edispl , Horsepower | `car_1.countries_HAS_car_1.continents` :  | `car_1.car_makers_HAS_car_1.countries` :  | `car_1.model_list_HAS_car_1.car_makers` :  | `car_1.car_names_HAS_car_1.model_list` :  | `car_1.cars_data_HAS_car_1.car_names` :


index       : 83
baseline pre: MATCH (T1:`car_1.car_makers`)-[]-(T2:`car_1.model_list`) RETURN count(*),T1.Make
model1 pred : MATCH (car_names:`car_1.car_names`) RETURN car_names.Make,count(*),car_makers.FullName
ground query: MATCH (t1:`car_1.model_list`)-[]-(t2:`car_1.car_makers`) RETURN count(*),t2.FullName
NLQ         : How many car models are produced by each maker ? Only list the count and the maker full name .
Schema      : | car_1 | `car_1.continents` : ContId , Continent | `car_1.countries` : CountryName , Continent , CountryId | `car_1.car_makers` : Country , FullName , Id , Maker | `car_1.model_list` : ModelId , Maker , Model | `car_1.car_names` : Make , MakeId , Model | `car_1.cars_data` : MPG , Year , Cylinders , Id , Weight , Accelerate , Edispl , Horsepower | `car_1.countries_HAS_car_1.continents` :  | `car_1.car_makers_HAS_car_1.countries` :  | `car_1.model_list_HAS_car_1.car_makers` :  | `car_1.car_names_HAS_car_1.model_list` :  | `car_1.cars_data_HAS_car_1.car_names` :


index       : 84
baseline pre: MATCH (car_makers:`car_1.car_makers`) RETURN count(*),car_makers.Make,car_makers.FullName
model1 pred : MATCH (car_names:`car_1.car_names`) RETURN car_names.Make,count(*),car_names.MakeId,car_names.FullName
ground query: MATCH (T1:`car_1.model_list`)-[]-(T2:`car_1.car_makers`) RETURN count(*),T2.FullName,T2.Id
NLQ         : What is the number of car models that are produced by each maker and what is the id and full name of each maker?
Schema      : | car_1 | `car_1.continents` : ContId , Continent | `car_1.countries` : CountryName , Continent , CountryId | `car_1.car_makers` : Country , FullName , Id , Maker | `car_1.model_list` : ModelId , Maker , Model | `car_1.car_names` : Make , MakeId , Model | `car_1.cars_data` : MPG , Year , Cylinders , Id , Weight , Accelerate , Edispl , Horsepower | `car_1.countries_HAS_car_1.continents` :  | `car_1.car_makers_HAS_car_1.countries` :  | `car_1.model_list_HAS_car_1.car_makers` :  | `car_1.car_names_HAS_car_1.model_list` :  | `car_1.cars_data_HAS_car_1.car_names` :


index       : 85
baseline pre: MATCH (car_names:`car_1.car_names`) WHERE car_names.Make = 'ac hornet sportabout (sw)' RETURN car_names.Accurate
model1 pred : MATCH (car_names:`car_1.car_names`) WHERE car_names.Make = 'amc hornet sportabout (sw)' RETURN car_names.Accelerate
ground query: MATCH (T1:`car_1.cars_data`)-[]-(T2:`car_1.car_names`) WHERE T2.Make = 'amc hornet sportabout (sw)' RETURN T1.Accelerate
NLQ         : What is the accelerate of the car make amc hornet sportabout (sw)?
Schema      : | car_1 | `car_1.continents` : ContId , Continent | `car_1.countries` : CountryName , Continent , CountryId | `car_1.car_makers` : Country , FullName , Id , Maker ( amc ) | `car_1.model_list` : ModelId , Maker , Model ( amc ) | `car_1.car_names` : Make ( amc hornet , amc hornet sportabout (sw) ) , MakeId , Model ( amc ) | `car_1.cars_data` : MPG , Year , Cylinders , Id , Weight , Accelerate , Edispl , Horsepower | `car_1.countries_HAS_car_1.continents` :  | `car_1.car_makers_HAS_car_1.countries` :  | `car_1.model_list_HAS_car_1.car_makers` :  | `car_1.car_names_HAS_car_1.model_list` :  | `car_1.cars_data_HAS_car_1.car_names` :


index       : 86
baseline pre: MATCH (car_names:`car_1.car_names`) WHERE car_names.Make = 'ac hornet sportabout (sw)' RETURN car_names.Accurate
model1 pred : MATCH (car_names:`car_1.car_names`) WHERE car_names.Make = 'amc hornet sportabout (sw)' RETURN car_names.Accelerate
ground query: MATCH (T1:`car_1.cars_data`)-[]-(T2:`car_1.car_names`) WHERE T2.Make = 'amc hornet sportabout (sw)' RETURN T1.Accelerate
NLQ         : How much does the car accelerate that makes amc hornet sportabout (sw)?
Schema      : | car_1 | `car_1.continents` : ContId , Continent | `car_1.countries` : CountryName , Continent , CountryId | `car_1.car_makers` : Country , FullName , Id , Maker ( amc ) | `car_1.model_list` : ModelId , Maker , Model ( amc ) | `car_1.car_names` : Make ( amc hornet , amc hornet sportabout (sw) ) , MakeId , Model ( amc ) | `car_1.cars_data` : MPG , Year , Cylinders , Id , Weight , Accelerate , Edispl , Horsepower | `car_1.countries_HAS_car_1.continents` :  | `car_1.car_makers_HAS_car_1.countries` :  | `car_1.model_list_HAS_car_1.car_makers` :  | `car_1.car_names_HAS_car_1.model_list` :  | `car_1.cars_data_HAS_car_1.car_names` :


index       : 87
baseline pre: MATCH (T1:`car_1.car_makers`)-[]-(T2:`car_1.countries`) WHERE T1.CountryName = 'france' RETURN count(*)
model1 pred : MATCH (car_makers:`car_1.car_makers`) WHERE cars.CountryName = 'france' RETURN count(*)
ground query: MATCH (T1:`car_1.car_makers`)-[]-(T2:`car_1.countries`) WHERE T2.CountryName = 'france' RETURN count(*)
NLQ         : How many car makers are there in france?
Schema      : | car_1 | `car_1.continents` : ContId , Continent | `car_1.countries` : CountryName ( france ) , Continent , CountryId | `car_1.car_makers` : Country , FullName , Id , Maker | `car_1.model_list` : ModelId , Maker , Model | `car_1.car_names` : Make , MakeId , Model | `car_1.cars_data` : MPG , Year , Cylinders , Id , Weight , Accelerate , Edispl , Horsepower | `car_1.countries_HAS_car_1.continents` :  | `car_1.car_makers_HAS_car_1.countries` :  | `car_1.model_list_HAS_car_1.car_makers` :  | `car_1.car_names_HAS_car_1.model_list` :  | `car_1.cars_data_HAS_car_1.car_names` :


index       : 88
baseline pre: MATCH (T1:`car_1.countries`)-[]-(T2:`car_1.car_makers`) WHERE T1.CountryName = 'france' RETURN count(*)
model1 pred : MATCH (car_makers:`car_1.car_makers`) WHERE countries.CountryName = 'france' RETURN count(*)
ground query: MATCH (T1:`car_1.car_makers`)-[]-(T2:`car_1.countries`) WHERE T2.CountryName = 'france' RETURN count(*)
NLQ         : What is the number of makers of care in France?
Schema      : | car_1 | `car_1.continents` : ContId , Continent | `car_1.countries` : CountryName ( france ) , Continent , CountryId | `car_1.car_makers` : Country , FullName , Id , Maker | `car_1.model_list` : ModelId , Maker , Model | `car_1.car_names` : Make , MakeId , Model | `car_1.cars_data` : MPG , Year , Cylinders , Id , Weight , Accelerate , Edispl , Horsepower | `car_1.countries_HAS_car_1.continents` :  | `car_1.car_makers_HAS_car_1.countries` :  | `car_1.model_list_HAS_car_1.car_makers` :  | `car_1.car_names_HAS_car_1.model_list` :  | `car_1.cars_data_HAS_car_1.car_names` :


index       : 89
baseline pre: MATCH (countries:`car_1.countries`) WHERE countries.CountryName = 'usa' RETURN count(*)
model1 pred : MATCH (car_names:`car_1.car_names`) WHERE cars_names.CountryName = 'usa' RETURN count(*)
ground query: MATCH (T1:`car_1.model_list`)-[]-(T2:`car_1.car_makers`)-[]-(T3:`car_1.countries`) WHERE T3.CountryName = 'usa' RETURN count(*)
NLQ         : How many car models are produced in the usa?
Schema      : | car_1 | `car_1.continents` : ContId , Continent | `car_1.countries` : CountryName ( usa ) , Continent , CountryId | `car_1.car_makers` : Country , FullName , Id , Maker | `car_1.model_list` : ModelId , Maker , Model | `car_1.car_names` : Make , MakeId , Model | `car_1.cars_data` : MPG , Year , Cylinders , Id , Weight , Accelerate , Edispl , Horsepower | `car_1.countries_HAS_car_1.continents` :  | `car_1.car_makers_HAS_car_1.countries` :  | `car_1.model_list_HAS_car_1.car_makers` :  | `car_1.car_names_HAS_car_1.model_list` :  | `car_1.cars_data_HAS_car_1.car_names` :


index       : 90
baseline pre: MATCH (car_names:`car_1.car_names`) WHERE cars.CountryName = 'United States' RETURN count(*)
model1 pred : MATCH (car_names:`car_1.car_names`) WHERE cars_names.Country = 'United States' RETURN count(*)
ground query: MATCH (T1:`car_1.model_list`)-[]-(T2:`car_1.car_makers`)-[]-(T3:`car_1.countries`) WHERE T3.CountryName = 'usa' RETURN count(*)
NLQ         : What is the count of the car models produced in the United States?
Schema      : | car_1 | `car_1.continents` : ContId , Continent | `car_1.countries` : CountryName , Continent , CountryId | `car_1.car_makers` : Country , FullName , Id , Maker | `car_1.model_list` : ModelId , Maker , Model | `car_1.car_names` : Make , MakeId , Model | `car_1.cars_data` : MPG , Year , Cylinders , Id , Weight , Accelerate , Edispl , Horsepower | `car_1.countries_HAS_car_1.continents` :  | `car_1.car_makers_HAS_car_1.countries` :  | `car_1.model_list_HAS_car_1.car_makers` :  | `car_1.car_names_HAS_car_1.model_list` :  | `car_1.cars_data_HAS_car_1.car_names` :


index       : 91
baseline pre: MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Year = 1974 AND cars_data.Cylinders = 8 RETURN min(cars_data.Weight)
model1 pred : MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Year = 1974 AND cars_data.Year = 1974 RETURN cars_data.Weight ORDER BY cars_data.Weight ASC LIMIT 1
ground query: MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Cylinders = 8 AND cars_data.Year = 1974 RETURN min(cars_data.Weight)
NLQ         : What is the smallest weight of the car produced with 8 cylinders on 1974 ?
Schema      : | car_1 | `car_1.continents` : ContId , Continent | `car_1.countries` : CountryName , Continent , CountryId | `car_1.car_makers` : Country , FullName , Id , Maker | `car_1.model_list` : ModelId , Maker , Model | `car_1.car_names` : Make , MakeId , Model | `car_1.cars_data` : MPG , Year , Cylinders , Id , Weight , Accelerate , Edispl , Horsepower | `car_1.countries_HAS_car_1.continents` :  | `car_1.car_makers_HAS_car_1.countries` :  | `car_1.model_list_HAS_car_1.car_makers` :  | `car_1.car_names_HAS_car_1.model_list` :  | `car_1.cars_data_HAS_car_1.car_names` :


index       : 92
baseline pre: MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Year = 1974 AND cars_data.Cylinders = 8 RETURN min(cars_data.Weight)
model1 pred : MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Year = 1974 AND cars_data.Cylinders = 8 RETURN min(cars_data.Weight)
ground query: MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Cylinders = 8 AND cars_data.Year = 1974 RETURN min(cars_data.Weight)
NLQ         : What is the minimum weight of the car with 8 cylinders produced in 1974 ?
Schema      : | car_1 | `car_1.continents` : ContId , Continent | `car_1.countries` : CountryName , Continent , CountryId | `car_1.car_makers` : Country , FullName , Id , Maker | `car_1.model_list` : ModelId , Maker , Model | `car_1.car_names` : Make , MakeId , Model | `car_1.cars_data` : MPG , Year , Cylinders , Id , Weight , Accelerate , Edispl , Horsepower | `car_1.countries_HAS_car_1.continents` :  | `car_1.car_makers_HAS_car_1.countries` :  | `car_1.model_list_HAS_car_1.car_makers` :  | `car_1.car_names_HAS_car_1.model_list` :  | `car_1.cars_data_HAS_car_1.car_names` :


index       : 93
baseline pre: MATCH (model_list:`car_1.model_list`) RETURN model_list.Make,model_list.Model
model1 pred : MATCH (model_list:`car_1.model_list`) RETURN car_makers.Make,model_list.Model
ground query: MATCH (model_list:`car_1.model_list`) RETURN model_list.Maker,model_list.Model
NLQ         : What are all the makers and models?
Schema      : | car_1 | `car_1.continents` : ContId , Continent | `car_1.countries` : CountryName , Continent , CountryId | `car_1.car_makers` : Country , FullName , Id , Maker | `car_1.model_list` : ModelId , Maker , Model | `car_1.car_names` : Make , MakeId , Model | `car_1.cars_data` : MPG , Year , Cylinders , Id , Weight , Accelerate , Edispl , Horsepower | `car_1.countries_HAS_car_1.continents` :  | `car_1.car_makers_HAS_car_1.countries` :  | `car_1.model_list_HAS_car_1.car_makers` :  | `car_1.car_names_HAS_car_1.model_list` :  | `car_1.cars_data_HAS_car_1.car_names` :


index       : 94
baseline pre: MATCH (model_list:`car_1.model_list`) RETURN model_list.Make,model_list.Model
model1 pred : MATCH (model_list:`car_1.model_list`) RETURN car_makers.Make,model_list.Model
ground query: MATCH (model_list:`car_1.model_list`) RETURN model_list.Maker,model_list.Model
NLQ         : What are the makers and models?
Schema      : | car_1 | `car_1.continents` : ContId , Continent | `car_1.countries` : CountryName , Continent , CountryId | `car_1.car_makers` : Country , FullName , Id , Maker | `car_1.model_list` : ModelId , Maker , Model | `car_1.car_names` : Make , MakeId , Model | `car_1.cars_data` : MPG , Year , Cylinders , Id , Weight , Accelerate , Edispl , Horsepower | `car_1.countries_HAS_car_1.continents` :  | `car_1.car_makers_HAS_car_1.countries` :  | `car_1.model_list_HAS_car_1.car_makers` :  | `car_1.car_names_HAS_car_1.model_list` :  | `car_1.cars_data_HAS_car_1.car_names` :


index       : 95
baseline pre: MATCH (T1:`car_1.countries`)-[]-(T2:`car_1.car_makers`) WITH count(*) AS count, T1.CountryName AS CountryName WHERE count >= 1 RETURN CountryName,CountryName
model1 pred : MATCH (T1:`car_1.countries`)-[]-(T2:`car_1.car_makers`) WITH count(*) AS count, T1.CountryName AS CountryName, T1.CountryId AS CountryId WHERE count >= 1 RETURN CountryName,CountryId
ground query: MATCH (T1:`car_1.countries`)-[]-(T2:`car_1.car_makers`) WITH count(*) AS count, T1.CountryName AS CountryName, T1.CountryId AS CountryId WHERE count  >= 1 RETURN CountryName,CountryId
NLQ         : What are the countries having at least one car maker? List name and id.
Schema      : | car_1 | `car_1.continents` : ContId , Continent | `car_1.countries` : CountryName , Continent , CountryId | `car_1.car_makers` : Country , FullName , Id , Maker | `car_1.model_list` : ModelId , Maker , Model | `car_1.car_names` : Make , MakeId , Model | `car_1.cars_data` : MPG , Year , Cylinders , Id , Weight , Accelerate , Edispl , Horsepower | `car_1.countries_HAS_car_1.continents` :  | `car_1.car_makers_HAS_car_1.countries` :  | `car_1.model_list_HAS_car_1.car_makers` :  | `car_1.car_names_HAS_car_1.model_list` :  | `car_1.cars_data_HAS_car_1.car_names` :


index       : 96
baseline pre: MATCH (T1:`car_1.countries`)-[]-(T2:`car_1.car_makers`) WITH count(*) AS count, T1.CountryName AS CountryName WHERE count >= 1 RETURN CountryName,CountryId
model1 pred : MATCH (T1:`car_1.countries`)-[]-(T2:`car_1.car_makers`) WITH count(*) AS count, T1.CountryName AS CountryName, T1.CountryId AS CountryId WHERE count >= 1 RETURN CountryName,CountryId
ground query: MATCH (T1:`car_1.countries`)-[]-(T2:`car_1.car_makers`) WITH count(*) AS count, T1.CountryName AS CountryName, T1.CountryId AS CountryId WHERE count  >= 1 RETURN CountryName,CountryId
NLQ         : What are the names and ids of all countries with at least one car maker?
Schema      : | car_1 | `car_1.continents` : ContId , Continent | `car_1.countries` : CountryName , Continent , CountryId | `car_1.car_makers` : Country , FullName , Id , Maker | `car_1.model_list` : ModelId , Maker , Model | `car_1.car_names` : Make , MakeId , Model | `car_1.cars_data` : MPG , Year , Cylinders , Id , Weight , Accelerate , Edispl , Horsepower | `car_1.countries_HAS_car_1.continents` :  | `car_1.car_makers_HAS_car_1.countries` :  | `car_1.model_list_HAS_car_1.car_makers` :  | `car_1.car_names_HAS_car_1.model_list` :  | `car_1.cars_data_HAS_car_1.car_names` :


index       : 97
baseline pre: MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Heavypower > 150 RETURN count(*)
model1 pred : MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Horsepower > 150 RETURN count(*)
ground query: MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Horsepower > '150' RETURN count(*)
NLQ         : What is the number of the cars with horsepower more than 150?
Schema      : | car_1 | `car_1.continents` : ContId , Continent | `car_1.countries` : CountryName , Continent , CountryId | `car_1.car_makers` : Country , FullName , Id , Maker | `car_1.model_list` : ModelId , Maker , Model | `car_1.car_names` : Make , MakeId , Model | `car_1.cars_data` : MPG , Year , Cylinders , Id , Weight , Accelerate , Edispl , Horsepower | `car_1.countries_HAS_car_1.continents` :  | `car_1.car_makers_HAS_car_1.countries` :  | `car_1.model_list_HAS_car_1.car_makers` :  | `car_1.car_names_HAS_car_1.model_list` :  | `car_1.cars_data_HAS_car_1.car_names` :


index       : 98
baseline pre: MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Heavypower > 150 RETURN count(*)
model1 pred : MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Horsepower > 150 RETURN count(*)
ground query: MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Horsepower > '150' RETURN count(*)
NLQ         : What is the number of cars with a horsepower greater than 150?
Schema      : | car_1 | `car_1.continents` : ContId , Continent | `car_1.countries` : CountryName , Continent , CountryId | `car_1.car_makers` : Country , FullName , Id , Maker | `car_1.model_list` : ModelId , Maker , Model | `car_1.car_names` : Make , MakeId , Model | `car_1.cars_data` : MPG , Year , Cylinders , Id , Weight , Accelerate , Edispl , Horsepower | `car_1.countries_HAS_car_1.continents` :  | `car_1.car_makers_HAS_car_1.countries` :  | `car_1.model_list_HAS_car_1.car_makers` :  | `car_1.car_names_HAS_car_1.model_list` :  | `car_1.cars_data_HAS_car_1.car_names` :


index       : 99
baseline pre: MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Cylinders = 3 RETURN max(cars_data.Horsepower),cars_data.Make
model1 pred : MATCH (car_names:`car_1.car_names`) WHERE cars_data.Cylinders = 3 RETURN max(car_names.Horsepower),car_names.Make
ground query: MATCH (T1:`car_1.car_names`)-[]-(T2:`car_1.cars_data`) WHERE T2.Cylinders = 3 RETURN T2.Horsepower,T1.Make ORDER BY T2.Horsepower DESC LIMIT 1
NLQ         : What is the maximum horsepower and the make of the car models with 3 cylinders?
Schema      : | car_1 | `car_1.continents` : ContId , Continent | `car_1.countries` : CountryName , Continent , CountryId | `car_1.car_makers` : Country , FullName , Id , Maker | `car_1.model_list` : ModelId , Maker , Model | `car_1.car_names` : Make , MakeId , Model | `car_1.cars_data` : MPG , Year , Cylinders , Id , Weight , Accelerate , Edispl , Horsepower | `car_1.countries_HAS_car_1.continents` :  | `car_1.car_makers_HAS_car_1.countries` :  | `car_1.model_list_HAS_car_1.car_makers` :  | `car_1.car_names_HAS_car_1.model_list` :  | `car_1.cars_data_HAS_car_1.car_names` :


index       : 100
baseline pre: MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Cylinders = 3 RETURN cars_data.Model,cars_data.Make ORDER BY cars_data.Horsepower DESC LIMIT 1
model1 pred : MATCH (car_names:`car_1.car_names`) WHERE cars_data.Cylinders = 3 RETURN cars_data.Horsepower,car_names.Make ORDER BY cars_data.Horsepower DESC LIMIT 1
ground query: MATCH (T1:`car_1.car_names`)-[]-(T2:`car_1.cars_data`) WHERE T2.Cylinders = 3 RETURN T2.Horsepower,T1.Make ORDER BY T2.Horsepower DESC LIMIT 1
NLQ         : What is the largest amount of horsepower for the models with 3 cylinders and what make is it?
Schema      : | car_1 | `car_1.continents` : ContId , Continent | `car_1.countries` : CountryName , Continent , CountryId | `car_1.car_makers` : Country , FullName , Id , Maker | `car_1.model_list` : ModelId , Maker , Model | `car_1.car_names` : Make , MakeId , Model | `car_1.cars_data` : MPG , Year , Cylinders , Id , Weight , Accelerate , Edispl , Horsepower | `car_1.countries_HAS_car_1.continents` :  | `car_1.car_makers_HAS_car_1.countries` :  | `car_1.model_list_HAS_car_1.car_makers` :  | `car_1.car_names_HAS_car_1.model_list` :  | `car_1.cars_data_HAS_car_1.car_names` :


index       : 101
baseline pre: MATCH (cars_data:`car_1.cars_data`) RETURN cars_data.Model ORDER BY cars_data.MPG DESC LIMIT 1
model1 pred : MATCH (cars_data:`car_1.cars_data`) RETURN cars_data.Model ORDER BY cars_data.MPG DESC LIMIT 1
ground query: MATCH (T1:`car_1.car_names`)-[]-(T2:`car_1.cars_data`) RETURN T1.Model ORDER BY T2.MPG DESC LIMIT 1
NLQ         : Which model saves the most gasoline? That is to say, have the maximum miles per gallon.
Schema      : | car_1 | `car_1.continents` : ContId , Continent | `car_1.countries` : CountryName , Continent , CountryId | `car_1.car_makers` : Country , FullName , Id , Maker | `car_1.model_list` : ModelId , Maker , Model | `car_1.car_names` : Make , MakeId , Model | `car_1.cars_data` : MPG , Year , Cylinders , Id , Weight , Accelerate , Edispl , Horsepower | `car_1.countries_HAS_car_1.continents` :  | `car_1.car_makers_HAS_car_1.countries` :  | `car_1.model_list_HAS_car_1.car_makers` :  | `car_1.car_names_HAS_car_1.model_list` :  | `car_1.cars_data_HAS_car_1.car_names` :


index       : 102
baseline pre: MATCH (cars_data:`car_1.cars_data`) RETURN cars_data.Model ORDER BY cars_data.MPG DESC LIMIT 1
model1 pred : MATCH (cars_data:`car_1.cars_data`) RETURN cars_data.Model ORDER BY cars_data.MPG DESC LIMIT 1
ground query: MATCH (t1:`car_1.car_names`)-[]-(t2:`car_1.cars_data`) RETURN t1.Model ORDER BY t2.MPG DESC LIMIT 1
NLQ         : What is the car model with the highest mpg ?
Schema      : | car_1 | `car_1.continents` : ContId , Continent | `car_1.countries` : CountryName , Continent , CountryId | `car_1.car_makers` : Country , FullName , Id , Maker | `car_1.model_list` : ModelId , Maker , Model | `car_1.car_names` : Make , MakeId , Model | `car_1.cars_data` : MPG , Year , Cylinders , Id , Weight , Accelerate , Edispl , Horsepower | `car_1.countries_HAS_car_1.continents` :  | `car_1.car_makers_HAS_car_1.countries` :  | `car_1.model_list_HAS_car_1.car_makers` :  | `car_1.car_names_HAS_car_1.model_list` :  | `car_1.cars_data_HAS_car_1.car_names` :


index       : 103
baseline pre: MATCH (cars_data:`car_1.cars_data`) RETURN cars_data.Application,count(*)
model1 pred : MATCH (cars_data:`car_1.cars_data`) RETURN max(cars_data.Accurate),cars_data.Cylinders
ground query: MATCH (cars_data:`car_1.cars_data`) RETURN max(cars_data.Accelerate),cars_data.Cylinders
NLQ         : What is the maximum accelerate for different number of cylinders?
Schema      : | car_1 | `car_1.continents` : ContId , Continent | `car_1.countries` : CountryName , Continent , CountryId | `car_1.car_makers` : Country , FullName , Id , Maker | `car_1.model_list` : ModelId , Maker , Model | `car_1.car_names` : Make , MakeId , Model | `car_1.cars_data` : MPG , Year , Cylinders , Id , Weight , Accelerate , Edispl , Horsepower | `car_1.countries_HAS_car_1.continents` :  | `car_1.car_makers_HAS_car_1.countries` :  | `car_1.model_list_HAS_car_1.car_makers` :  | `car_1.car_names_HAS_car_1.model_list` :  | `car_1.cars_data_HAS_car_1.car_names` :


index       : 104
baseline pre: MATCH (cars_data:`car_1.cars_data`) RETURN max(cars_data.Accommodate),cars_data.Cylinders
model1 pred : MATCH (cars_data:`car_1.cars_data`) RETURN max(cars_data.Accurate),cars_data.Cylinders
ground query: MATCH (cars_data:`car_1.cars_data`) RETURN max(cars_data.Accelerate),cars_data.Cylinders
NLQ         : What is the maximum accelerate for all the different cylinders?
Schema      : | car_1 | `car_1.continents` : ContId , Continent | `car_1.countries` : CountryName , Continent , CountryId | `car_1.car_makers` : Country , FullName , Id , Maker | `car_1.model_list` : ModelId , Maker , Model | `car_1.car_names` : Make , MakeId , Model | `car_1.cars_data` : MPG , Year , Cylinders , Id , Weight , Accelerate , Edispl , Horsepower | `car_1.countries_HAS_car_1.continents` :  | `car_1.car_makers_HAS_car_1.countries` :  | `car_1.model_list_HAS_car_1.car_makers` :  | `car_1.car_names_HAS_car_1.model_list` :  | `car_1.cars_data_HAS_car_1.car_names` :


index       : 108
baseline pre: MATCH (car_names:`car_1.car_names`) WHERE car_names.Year = 1980 RETURN count(*)
model1 pred : MATCH (car_names:`car_1.car_names`) WHERE cars_names.Year = 1980 RETURN count(*)
ground query: MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Year = 1980 RETURN count(*)
NLQ         : In 1980, how many cars were made?
Schema      : | car_1 | `car_1.continents` : ContId , Continent | `car_1.countries` : CountryName , Continent , CountryId | `car_1.car_makers` : Country , FullName , Id , Maker | `car_1.model_list` : ModelId , Maker , Model | `car_1.car_names` : Make , MakeId , Model | `car_1.cars_data` : MPG , Year , Cylinders , Id , Weight , Accelerate , Edispl , Horsepower | `car_1.countries_HAS_car_1.continents` :  | `car_1.car_makers_HAS_car_1.countries` :  | `car_1.model_list_HAS_car_1.car_makers` :  | `car_1.car_names_HAS_car_1.model_list` :  | `car_1.cars_data_HAS_car_1.car_names` :


index       : 109
baseline pre: MATCH (car_makers:`car_1.car_makers`) WHERE car_makers.FullName = 'American Motor Company' RETURN count(*)
model1 pred : MATCH (car_makers:`car_1.car_makers`) WHERE car_makers.FullName = 'American Motor Company' RETURN count(*)
ground query: MATCH (T1:`car_1.car_makers`)-[]-(T2:`car_1.model_list`) WHERE T1.FullName = 'American Motor Company' RETURN count(*)
NLQ         : How many car models were produced by the maker with full name American Motor Company?
Schema      : | car_1 | `car_1.continents` : ContId , Continent ( america ) | `car_1.countries` : CountryName , Continent , CountryId | `car_1.car_makers` : Country , FullName ( American Motor Company ) , Id , Maker | `car_1.model_list` : ModelId , Maker , Model | `car_1.car_names` : Make , MakeId , Model | `car_1.cars_data` : MPG , Year , Cylinders , Id , Weight , Accelerate , Edispl , Horsepower | `car_1.countries_HAS_car_1.continents` :  | `car_1.car_makers_HAS_car_1.countries` :  | `car_1.model_list_HAS_car_1.car_makers` :  | `car_1.car_names_HAS_car_1.model_list` :  | `car_1.cars_data_HAS_car_1.car_names` :


index       : 110
baseline pre: MATCH (car_makers:`car_1.car_makers`) WHERE car_makers.FullName = 'American Motor Company' RETURN count(*)
model1 pred : MATCH (car_makers:`car_1.car_makers`) WHERE car_makers.Make = 'American Motor Company' RETURN count(*)
ground query: MATCH (T1:`car_1.car_makers`)-[]-(T2:`car_1.model_list`) WHERE T1.FullName = 'American Motor Company' RETURN count(*)
NLQ         : What is the number of car models created by the car maker American Motor Company?
Schema      : | car_1 | `car_1.continents` : ContId , Continent ( america ) | `car_1.countries` : CountryName , Continent , CountryId | `car_1.car_makers` : Country , FullName ( American Motor Company ) , Id , Maker | `car_1.model_list` : ModelId , Maker , Model | `car_1.car_names` : Make , MakeId , Model | `car_1.cars_data` : MPG , Year , Cylinders , Id , Weight , Accelerate , Edispl , Horsepower | `car_1.countries_HAS_car_1.continents` :  | `car_1.car_makers_HAS_car_1.countries` :  | `car_1.model_list_HAS_car_1.car_makers` :  | `car_1.car_names_HAS_car_1.model_list` :  | `car_1.cars_data_HAS_car_1.car_names` :


index       : 111
baseline pre: MATCH (car_makers:`car_1.car_makers`) WITH count(*) AS count, car_makers.FullName AS FullName, car_makers.Make AS Maker WHERE count > 3 RETURN FullName,MakeId
model1 pred : MATCH (car_makers:`car_1.car_makers`) WITH count(*) AS count, car_makers.FullName AS FullName, car_makers.MakeId AS MakeId WHERE count > 3 RETURN FullName,Id
ground query: MATCH (T1:`car_1.car_makers`)-[]-(T2:`car_1.model_list`) WITH count(*) AS count, T1.Id AS Id, T1.FullName AS FullName WHERE count  > 3 RETURN FullName,Id
NLQ         : Which makers designed more than 3 car models? List full name and the id.
Schema      : | car_1 | `car_1.continents` : ContId , Continent | `car_1.countries` : CountryName , Continent , CountryId | `car_1.car_makers` : Country , FullName , Id , Maker | `car_1.model_list` : ModelId , Maker , Model | `car_1.car_names` : Make , MakeId , Model | `car_1.cars_data` : MPG , Year , Cylinders , Id , Weight , Accelerate , Edispl , Horsepower | `car_1.countries_HAS_car_1.continents` :  | `car_1.car_makers_HAS_car_1.countries` :  | `car_1.model_list_HAS_car_1.car_makers` :  | `car_1.car_names_HAS_car_1.model_list` :  | `car_1.cars_data_HAS_car_1.car_names` :


index       : 112
baseline pre: MATCH (car_makers:`car_1.car_makers`) WITH count(*) AS count, car_makers.Make AS Maker WHERE count > 3 RETURN Maker,MakeId
model1 pred : MATCH (car_names:`car_1.car_names`) WITH count(*) AS count, car_names.Make,car_makers.MakeId AS MakeId WHERE count > 3 RETURN Maker,car_names.MakeId
ground query: MATCH (T1:`car_1.car_makers`)-[]-(T2:`car_1.model_list`) WITH count(*) AS count, T1.Id AS Id, T1.FullName AS FullName WHERE count  > 3 RETURN FullName,Id
NLQ         : What are the names and ids of all makers with more than 3 models?
Schema      : | car_1 | `car_1.continents` : ContId , Continent | `car_1.countries` : CountryName , Continent , CountryId | `car_1.car_makers` : Country , FullName , Id , Maker | `car_1.model_list` : ModelId , Maker , Model | `car_1.car_names` : Make , MakeId , Model | `car_1.cars_data` : MPG , Year , Cylinders , Id , Weight , Accelerate , Edispl , Horsepower | `car_1.countries_HAS_car_1.continents` :  | `car_1.car_makers_HAS_car_1.countries` :  | `car_1.model_list_HAS_car_1.car_makers` :  | `car_1.car_names_HAS_car_1.model_list` :  | `car_1.cars_data_HAS_car_1.car_names` :


index       : 113
baseline pre: MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Weight  < 3000 AND cars_data.Weight ` 4000 RETURN cars_data.Year
model1 pred : MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Weight ` 3000 AND cars_data.Weight ` 4000 RETURN cars_data.Year
ground query: MATCH (cars_data:`car_1.cars_data`) WHERE 3000<=cars_data.Weight<=4000 RETURN DISTINCT cars_data.Year
NLQ         : In which years cars were produced weighing no less than 3000 and no more than 4000 ?
Schema      : | car_1 | `car_1.continents` : ContId , Continent | `car_1.countries` : CountryName , Continent , CountryId | `car_1.car_makers` : Country , FullName , Id , Maker | `car_1.model_list` : ModelId , Maker , Model | `car_1.car_names` : Make , MakeId , Model | `car_1.cars_data` : MPG , Year , Cylinders , Id , Weight , Accelerate , Edispl , Horsepower | `car_1.countries_HAS_car_1.continents` :  | `car_1.car_makers_HAS_car_1.countries` :  | `car_1.model_list_HAS_car_1.car_makers` :  | `car_1.car_names_HAS_car_1.model_list` :  | `car_1.cars_data_HAS_car_1.car_names` :


index       : 114
baseline pre: MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Weight  < 4000 AND cars_data.Weight > 3000 RETURN DISTINCT cars_data.Year
model1 pred : MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Weight ` 4000 AND cars_data.Weight > 3000 RETURN DISTINCT cars_data.Year
ground query: MATCH (cars_data:`car_1.cars_data`) WHERE 3000<=cars_data.Weight<=4000 RETURN DISTINCT cars_data.Year
NLQ         : What are the different years in which there were cars produced that weighed less than 4000 and also cars that weighted more than 3000 ?
Schema      : | car_1 | `car_1.continents` : ContId , Continent | `car_1.countries` : CountryName , Continent , CountryId | `car_1.car_makers` : Country , FullName , Id , Maker | `car_1.model_list` : ModelId , Maker , Model | `car_1.car_names` : Make , MakeId , Model | `car_1.cars_data` : MPG , Year , Cylinders , Id , Weight , Accelerate , Edispl , Horsepower | `car_1.countries_HAS_car_1.continents` :  | `car_1.car_makers_HAS_car_1.countries` :  | `car_1.model_list_HAS_car_1.car_makers` :  | `car_1.car_names_HAS_car_1.model_list` :  | `car_1.cars_data_HAS_car_1.car_names` :


index       : 115
baseline pre: MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Model = 'volvo' RETURN cars_data.Cylinders ORDER BY cars_data.Accelerate ASC LIMIT 1
model1 pred : MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Model = 'volvo' RETURN cars_data.Cylinders ORDER BY cars_data.Accurate ASC LIMIT 1
ground query: MATCH (T1:`car_1.cars_data`)-[]-(T2:`car_1.car_names`) WHERE T2.Model = 'volvo' RETURN T1.Cylinders ORDER BY T1.Accelerate ASC LIMIT 1
NLQ         : For model volvo, how many cylinders does the car with the least accelerate have?
Schema      : | car_1 | `car_1.continents` : ContId , Continent | `car_1.countries` : CountryName , Continent , CountryId | `car_1.car_makers` : Country , FullName ( Volvo ) , Id , Maker ( volvo ) | `car_1.model_list` : ModelId , Maker , Model ( volvo ) | `car_1.car_names` : Make , MakeId , Model ( volvo ) | `car_1.cars_data` : MPG , Year , Cylinders , Id , Weight , Accelerate , Edispl , Horsepower | `car_1.countries_HAS_car_1.continents` :  | `car_1.car_makers_HAS_car_1.countries` :  | `car_1.model_list_HAS_car_1.car_makers` :  | `car_1.car_names_HAS_car_1.model_list` :  | `car_1.cars_data_HAS_car_1.car_names` :


index       : 116
baseline pre: MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Model = 'volvo' RETURN cars_data.Cylinders ORDER BY cars_data.Accelerate ASC LIMIT 1
model1 pred : MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Model = 'volvo' RETURN cars_data.Cylinders,count(*) ORDER BY cars_data.Accurate ASC LIMIT 1
ground query: MATCH (T1:`car_1.cars_data`)-[]-(T2:`car_1.car_names`) WHERE T2.Model = 'volvo' RETURN T1.Cylinders ORDER BY T1.Accelerate ASC LIMIT 1
NLQ         : For a volvo model, how many cylinders does the version with least accelerate have?
Schema      : | car_1 | `car_1.continents` : ContId , Continent | `car_1.countries` : CountryName , Continent , CountryId | `car_1.car_makers` : Country , FullName ( Volvo ) , Id , Maker ( volvo ) | `car_1.model_list` : ModelId , Maker , Model ( volvo ) | `car_1.car_names` : Make , MakeId , Model ( volvo ) | `car_1.cars_data` : MPG , Year , Cylinders , Id , Weight , Accelerate , Edispl , Horsepower | `car_1.countries_HAS_car_1.continents` :  | `car_1.car_makers_HAS_car_1.countries` :  | `car_1.model_list_HAS_car_1.car_makers` :  | `car_1.car_names_HAS_car_1.model_list` :  | `car_1.cars_data_HAS_car_1.car_names` :


index       : 119
baseline pre: MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Cylinders = 4 RETURN cars_data.Model ORDER BY cars_data.Horsepower DESC LIMIT 1
model1 pred : MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Cylinders = 4 RETURN cars_data.Model ORDER BY cars_data.Horsepower DESC LIMIT 1
ground query: MATCH (T1:`car_1.car_names`)-[]-(T2:`car_1.cars_data`) WHERE T2.Cylinders = 4 RETURN T1.Model ORDER BY T2.Horsepower DESC LIMIT 1
NLQ         : For the cars with 4 cylinders, which model has the largest horsepower?
Schema      : | car_1 | `car_1.continents` : ContId , Continent | `car_1.countries` : CountryName , Continent , CountryId | `car_1.car_makers` : Country , FullName , Id , Maker | `car_1.model_list` : ModelId , Maker , Model | `car_1.car_names` : Make , MakeId , Model | `car_1.cars_data` : MPG , Year , Cylinders , Id , Weight , Accelerate , Edispl , Horsepower | `car_1.countries_HAS_car_1.continents` :  | `car_1.car_makers_HAS_car_1.countries` :  | `car_1.model_list_HAS_car_1.car_makers` :  | `car_1.car_names_HAS_car_1.model_list` :  | `car_1.cars_data_HAS_car_1.car_names` :


index       : 120
baseline pre: MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Cylinders = 4 RETURN cars_data.Model ORDER BY cars_data.Horsepower DESC LIMIT 1
model1 pred : MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Cylinders = 4 RETURN cars_data.Model ORDER BY cars_data.Horsepower DESC LIMIT 1
ground query: MATCH (T1:`car_1.car_names`)-[]-(T2:`car_1.cars_data`) WHERE T2.Cylinders = 4 RETURN T1.Model ORDER BY T2.Horsepower DESC LIMIT 1
NLQ         : For all of the 4 cylinder cars, which model has the most horsepower?
Schema      : | car_1 | `car_1.continents` : ContId , Continent | `car_1.countries` : CountryName , Continent , CountryId | `car_1.car_makers` : Country , FullName , Id , Maker | `car_1.model_list` : ModelId , Maker , Model | `car_1.car_names` : Make , MakeId , Model | `car_1.cars_data` : MPG , Year , Cylinders , Id , Weight , Accelerate , Edispl , Horsepower | `car_1.countries_HAS_car_1.continents` :  | `car_1.car_makers_HAS_car_1.countries` :  | `car_1.model_list_HAS_car_1.car_makers` :  | `car_1.car_names_HAS_car_1.model_list` :  | `car_1.cars_data_HAS_car_1.car_names` :


index       : 121
baseline pre: MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Cylinders = 8 OR cars_data.Year  < 1980 RETURN max(*)
model1 pred : MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Cylinders = 8 OR cars_data.Year ` 1980 RETURN max(car_data.MPG)
ground query: MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Cylinders = 8 OR cars_data.Year < 1980 RETURN max(cars_data.MPG)
NLQ         : What is the maximum miles per gallon of the car with 8 cylinders or produced before 1980 ?
Schema      : | car_1 | `car_1.continents` : ContId , Continent | `car_1.countries` : CountryName , Continent , CountryId | `car_1.car_makers` : Country , FullName , Id , Maker | `car_1.model_list` : ModelId , Maker , Model | `car_1.car_names` : Make , MakeId , Model | `car_1.cars_data` : MPG , Year , Cylinders , Id , Weight , Accelerate , Edispl , Horsepower | `car_1.countries_HAS_car_1.continents` :  | `car_1.car_makers_HAS_car_1.countries` :  | `car_1.model_list_HAS_car_1.car_makers` :  | `car_1.car_names_HAS_car_1.model_list` :  | `car_1.cars_data_HAS_car_1.car_names` :


index       : 122
baseline pre: MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Cylinders = 8 OR cars_data.Year  < 1980 RETURN max(*)
model1 pred : MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Cylinders = 8 OR cars_data.Year ` 1980 RETURN max(cars_data.MPG)
ground query: MATCH (cars_data:`car_1.cars_data`) WHERE cars_data.Cylinders = 8 OR cars_data.Year < 1980 RETURN max(cars_data.MPG)
NLQ         : What is the maximum mpg of the cars that had 8 cylinders or that were produced before 1980 ?
Schema      : | car_1 | `car_1.continents` : ContId , Continent | `car_1.countries` : CountryName , Continent , CountryId | `car_1.car_makers` : Country , FullName , Id , Maker | `car_1.model_list` : ModelId , Maker , Model | `car_1.car_names` : Make , MakeId , Model | `car_1.cars_data` : MPG , Year , Cylinders , Id , Weight , Accelerate , Edispl , Horsepower | `car_1.countries_HAS_car_1.continents` :  | `car_1.car_makers_HAS_car_1.countries` :  | `car_1.model_list_HAS_car_1.car_makers` :  | `car_1.car_names_HAS_car_1.model_list` :  | `car_1.cars_data_HAS_car_1.car_names` :


index       : 139
baseline pre: MATCH (airports:`flight_2.airports`) WHERE airports.City = 'Alton' RETURN airports.City,airports.Country
model1 pred : MATCH (airports:`flight_2.airports`) WHERE airports.City = 'Alton' AND airports.Country = 'Country' RETURN airports.City,airports.Country
ground query: MATCH (airports:`flight_2.airports`) WHERE airports.AirportName = 'Alton' RETURN airports.City,airports.Country
NLQ         : Which city and country is the Alton airport at?
Schema      : | flight_2 | `flight_2.airlines` : Country , Abbreviation , uid , Airline | `flight_2.airports` : Country , City ( Alton  ) , AirportName ( Alton  ) , AirportCode , CountryAbbrev | `flight_2.flights` : DestAirport , Airline , SourceAirport , FlightNo


index       : 140
baseline pre: MATCH (airports:`flight_2.airports`) WHERE airports.City = 'Alton' RETURN airports.City,airports.Country
model1 pred : MATCH (airports:`flight_2.airports`) WHERE airports.AirportName = 'Alton' RETURN airports.City,airports.Country
ground query: MATCH (airports:`flight_2.airports`) WHERE airports.AirportName = 'Alton' RETURN airports.City,airports.Country
NLQ         : Give the city and country for the Alton airport.
Schema      : | flight_2 | `flight_2.airlines` : Country , Abbreviation , uid , Airline | `flight_2.airports` : Country , City ( Alton  ) , AirportName ( Alton  ) , AirportCode , CountryAbbrev | `flight_2.flights` : DestAirport , Airline , SourceAirport , FlightNo


index       : 145
baseline pre: MATCH (flights:`flight_2.flights`) WHERE flights.AirportCode = 'APG' RETURN count(*)
model1 pred : MATCH (flights:`flight_2.flights`) WHERE flights.SourceAirport = 'APG' RETURN count(*)
ground query: MATCH (flights:`flight_2.flights`) WHERE flights.SourceAirport = 'APG' RETURN count(*)
NLQ         : How many flights depart from 'APG'?
Schema      : | flight_2 | `flight_2.airlines` : Country , Abbreviation , uid , Airline | `flight_2.airports` : Country , City , AirportName , AirportCode ( APG ) , CountryAbbrev | `flight_2.flights` : DestAirport (  APG ) , Airline , SourceAirport (  APG ) , FlightNo


index       : 146
baseline pre: MATCH (flights:`flight_2.flights`) WHERE flights.AirportCode = 'APG' RETURN count(*)
model1 pred : MATCH (flights:`flight_2.flights`) WHERE flights.SourceAirport = 'APG' RETURN count(*)
ground query: MATCH (flights:`flight_2.flights`) WHERE flights.SourceAirport = 'APG' RETURN count(*)
NLQ         : Count the number of flights departing from 'APG'.
Schema      : | flight_2 | `flight_2.airlines` : Country , Abbreviation , uid , Airline | `flight_2.airports` : Country , City , AirportName , AirportCode ( APG ) , CountryAbbrev | `flight_2.flights` : DestAirport (  APG ) , Airline , SourceAirport (  APG ) , FlightNo


index       : 147
baseline pre: MATCH (flights:`flight_2.flights`) WHERE flights.AirportCode = 'ATO' RETURN count(*)
model1 pred : MATCH (flights:`flight_2.flights`) WHERE flights.AirportCode = 'ATO' RETURN count(*)
ground query: MATCH (flights:`flight_2.flights`) WHERE flights.DestAirport = 'ATO' RETURN count(*)
NLQ         : How many flights have destination ATO?
Schema      : | flight_2 | `flight_2.airlines` : Country , Abbreviation , uid , Airline | `flight_2.airports` : Country , City , AirportName , AirportCode ( ATO ) , CountryAbbrev | `flight_2.flights` : DestAirport , Airline , SourceAirport , FlightNo


index       : 148
baseline pre: MATCH (flights:`flight_2.flights`) WHERE flights.AirportCode = 'ATO' RETURN count(*)
model1 pred : MATCH (flights:`flight_2.flights`) WHERE flights.AirportCode = 'ATO' RETURN count(*)
ground query: MATCH (flights:`flight_2.flights`) WHERE flights.DestAirport = 'ATO' RETURN count(*)
NLQ         : Count the number of flights into ATO.
Schema      : | flight_2 | `flight_2.airlines` : Country , Abbreviation , uid , Airline | `flight_2.airports` : Country , City , AirportName , AirportCode ( ATO ) , CountryAbbrev | `flight_2.flights` : DestAirport , Airline , SourceAirport , FlightNo


index       : 149
baseline pre: MATCH (flights:`flight_2.flights`) WHERE flights.City = 'Aberdeen' RETURN count(*)
model1 pred : MATCH (flights:`flight_2.flights`) WHERE flights.City = 'Aberdeen' RETURN count(*)
ground query: MATCH (T1:`flight_2.flights`)-[]-(T2:`flight_2.airports`) WHERE T2.City = 'Aberdeen' RETURN count(*)
NLQ         : How many flights depart from City Aberdeen?
Schema      : | flight_2 | `flight_2.airlines` : Country , Abbreviation , uid , Airline | `flight_2.airports` : Country , City ( Aberdeen  ) , AirportName , AirportCode , CountryAbbrev | `flight_2.flights` : DestAirport , Airline , SourceAirport , FlightNo


index       : 150
baseline pre: MATCH (flights:`flight_2.flights`) WHERE flights.City = 'Aberdeen' RETURN count(*)
model1 pred : MATCH (flights:`flight_2.flights`) WHERE flights.City = 'Aberdeen' RETURN count(*)
ground query: MATCH (T1:`flight_2.flights`)-[]-(T2:`flight_2.airports`) WHERE T2.City = 'Aberdeen' RETURN count(*)
NLQ         : Return the number of flights departing from Aberdeen.
Schema      : | flight_2 | `flight_2.airlines` : Country , Abbreviation , uid , Airline | `flight_2.airports` : Country , City ( Aberdeen  ) , AirportName , AirportCode , CountryAbbrev | `flight_2.flights` : DestAirport , Airline , SourceAirport , FlightNo


index       : 152
baseline pre: MATCH (T1:`flight_2.flights`)-[T2:`flight_2.airports ` ]-() WHERE T2.City = 'Aberdeen' RETURN count(*)
model1 pred : MATCH (flights:`flight_2.flights`) WHERE flights.City = 'Aberdeen' RETURN count(*)
ground query: MATCH (T1:`flight_2.flights`)-[]-(T2:`flight_2.airports`) WHERE T2.City = 'Aberdeen' RETURN count(*)
NLQ         : Return the number of flights arriving in Aberdeen.
Schema      : | flight_2 | `flight_2.airlines` : Country , Abbreviation , uid , Airline | `flight_2.airports` : Country , City ( Aberdeen  ) , AirportName , AirportCode , CountryAbbrev | `flight_2.flights` : DestAirport , Airline , SourceAirport , FlightNo


index       : 153
baseline pre: MATCH (flights:`flight_2.flights`) WHERE flights.City = 'Aberdeen' AND flights.City = 'Ashley' RETURN count(*)
model1 pred : MATCH (flights:`flight_2.flights`) WHERE flights.City = 'Aberdeen' AND flights.AirportName = 'Ashley' RETURN count(*)
ground query: MATCH (T1:`flight_2.flights`)-[]-(T2:`flight_2.airports`)-[]-(T3:`flight_2.airports`) WHERE T2.City = 'Ashley' AND T3.City = 'Aberdeen' RETURN count(*)
NLQ         : How many flights depart from City 'Aberdeen' and have destination City 'Ashley'?
Schema      : | flight_2 | `flight_2.airlines` : Country , Abbreviation , uid , Airline | `flight_2.airports` : Country , City ( Aberdeen  , Ashley  ) , AirportName ( Ashley  ) , AirportCode , CountryAbbrev | `flight_2.flights` : DestAirport , Airline , SourceAirport , FlightNo


index       : 154
baseline pre: MATCH (flights:`flight_2.flights`) WHERE flights.City = 'Aberdeen'=flights.AirportName = 'Ashley' RETURN count(*)
model1 pred : MATCH (flights:`flight_2.flights`) WHERE flights.City = 'Aberdeen' AND flights.AirportName = 'Ashley' RETURN count(*)
ground query: MATCH (T1:`flight_2.flights`)-[]-(T2:`flight_2.airports`)-[]-(T3:`flight_2.airports`) WHERE T2.City = 'Ashley' AND T3.City = 'Aberdeen' RETURN count(*)
NLQ         : How many flights fly from Aberdeen to Ashley?
Schema      : | flight_2 | `flight_2.airlines` : Country , Abbreviation , uid , Airline | `flight_2.airports` : Country , City ( Aberdeen  , Ashley  ) , AirportName ( Ashley  ) , AirportCode , CountryAbbrev | `flight_2.flights` : DestAirport , Airline , SourceAirport , FlightNo


index       : 155
baseline pre: MATCH (T1:`flight_2.flights`)-[]-(T2:`flight_2.airports`) WHERE T1.Airline = 'United Airlines' AND T2.AirportCode = 'ASY' RETURN count(*)
model1 pred : MATCH (flights:`flight_2.flights`) WHERE flights.Airline = 'United Airlines' AND flights.AirportCode = 'ASY' RETURN count(*)
ground query: MATCH (T1:`flight_2.airlines`)-[]-(T2:`flight_2.flights`) WHERE T1.Airline = 'United Airlines' AND T2.DestAirport = 'ASY' RETURN count(*)
NLQ         : How many 'United Airlines' flights go to Airport 'ASY'?
Schema      : | flight_2 | `flight_2.airlines` : Country , Abbreviation , uid , Airline ( United Airlines ) | `flight_2.airports` : Country , City , AirportName , AirportCode ( ASY ) , CountryAbbrev | `flight_2.flights` : DestAirport , Airline , SourceAirport , FlightNo


index       : 156
baseline pre: MATCH (T1:`flight_2.flights`)-[]-(T2:`flight_2.airlines`) WHERE T2.Airline = 'United Airlines' RETURN count(*)
model1 pred : MATCH (T1:`flight_2.flights`)-[]-(T2:`flight_2.airports`) WHERE T2.Airline = 'United Airlines' AND T2.AirportCode = 'ASY' RETURN count(*)
ground query: MATCH (T1:`flight_2.airlines`)-[]-(T2:`flight_2.flights`) WHERE T1.Airline = 'United Airlines' AND T2.DestAirport = 'ASY' RETURN count(*)
NLQ         : Count the number of United Airlines flights arriving in ASY Airport.
Schema      : | flight_2 | `flight_2.airlines` : Country , Abbreviation , uid , Airline ( United Airlines ) | `flight_2.airports` : Country , City , AirportName , AirportCode ( ASY ) , CountryAbbrev | `flight_2.flights` : DestAirport , Airline , SourceAirport , FlightNo


index       : 157
baseline pre: MATCH (flights:`flight_2.flights`) WHERE flights.Airline = 'United Airlines' RETURN count(*)
model1 pred : MATCH (flights:`flight_2.flights`) WHERE flights.Airline = 'United Airlines' AND flights.DestAirport = 'AHD' RETURN count(*)
ground query: MATCH (T1:`flight_2.airlines`)-[]-(T2:`flight_2.flights`) WHERE T1.Airline = 'United Airlines' AND T2.SourceAirport = 'AHD' RETURN count(*)
NLQ         : How many 'United Airlines' flights depart from Airport 'AHD'?
Schema      : | flight_2 | `flight_2.airlines` : Country , Abbreviation , uid , Airline ( United Airlines ) | `flight_2.airports` : Country , City , AirportName , AirportCode ( AHD ) , CountryAbbrev | `flight_2.flights` : DestAirport (  AHD ) , Airline , SourceAirport (  AHD ) , FlightNo


index       : 158
baseline pre: MATCH (flights:`flight_2.flights`) WHERE flights.Airline = 'United Airlines' RETURN count(*)
model1 pred : MATCH (flights:`flight_2.flights`) WHERE flights.Airline = 'United Airlines' AND flights.DestAirport = 'AHD' RETURN count(*)
ground query: MATCH (T1:`flight_2.airlines`)-[]-(T2:`flight_2.flights`) WHERE T1.Airline = 'United Airlines' AND T2.SourceAirport = 'AHD' RETURN count(*)
NLQ         : Return the number of United Airlines flights leaving from AHD Airport.
Schema      : | flight_2 | `flight_2.airlines` : Country , Abbreviation , uid , Airline ( United Airlines ) | `flight_2.airports` : Country , City , AirportName , AirportCode ( AHD ) , CountryAbbrev | `flight_2.flights` : DestAirport (  AHD ) , Airline , SourceAirport (  AHD ) , FlightNo


index       : 159
baseline pre: MATCH (T1:`flight_2.flights`)-[]-(T2:`flight_2.airports`) WHERE T2.City = 'Aberdeen' AND T1.Airline = 'United Airlines' RETURN count(*)
model1 pred : MATCH (flights:`flight_2.flights`) WHERE flights.City = 'Aberdeen' AND flights.Airline = 'United Airlines' RETURN count(*)
ground query: MATCH (T1:`flight_2.flights`)-[]-(T2:`flight_2.airports`)-[]-(T3:`flight_2.airlines`) WHERE T2.City = 'Aberdeen' AND T3.Airline = 'United Airlines' RETURN count(*)
NLQ         : How many United Airlines flights go to City 'Aberdeen'?
Schema      : | flight_2 | `flight_2.airlines` : Country , Abbreviation , uid , Airline ( United Airlines ) | `flight_2.airports` : Country , City ( Aberdeen  ) , AirportName , AirportCode , CountryAbbrev | `flight_2.flights` : DestAirport , Airline , SourceAirport , FlightNo


index       : 160
baseline pre: MATCH (T1:`flight_2.flights`)-[]-(T2:`flight_2.airports`) WHERE T2.City = 'Aberdeen' AND T1.Airline = 'United Airlines' RETURN count(*)
model1 pred : MATCH (T1:`flight_2.flights`)-[]-(T2:`flight_2.airports`) WHERE T2.City = 'Aberdeen' AND T1.Airline = 'United Airlines' RETURN count(*)
ground query: MATCH (T1:`flight_2.flights`)-[]-(T2:`flight_2.airports`)-[]-(T3:`flight_2.airlines`) WHERE T2.City = 'Aberdeen' AND T3.Airline = 'United Airlines' RETURN count(*)
NLQ         : Count the number of United Airlines flights that arrive in Aberdeen.
Schema      : | flight_2 | `flight_2.airlines` : Country , Abbreviation , uid , Airline ( United Airlines ) | `flight_2.airports` : Country , City ( Aberdeen  ) , AirportName , AirportCode , CountryAbbrev | `flight_2.flights` : DestAirport , Airline , SourceAirport , FlightNo


index       : 161
baseline pre: MATCH (flights:`flight_2.flights`) RETURN flights.City ORDER BY flights.City DESC LIMIT 1
model1 pred : MATCH (T2:`flight_2.airports`)-[T1:`flight_2.flights ` ]-() WITH count(T2.City) AS cnt, T2 RETURN T2.City ORDER BY cnt DESC LIMIT 1
ground query: MATCH (T1:`flight_2.airports`)-[]-(T2:`flight_2.flights`) WITH count(T1.City) AS cnt, T1 RETURN T1.City ORDER BY cnt DESC LIMIT 1
NLQ         : Which city has most number of arriving flights?
Schema      : | flight_2 | `flight_2.airlines` : Country , Abbreviation , uid , Airline | `flight_2.airports` : Country , City , AirportName , AirportCode , CountryAbbrev | `flight_2.flights` : DestAirport , Airline , SourceAirport , FlightNo


index       : 162
baseline pre: MATCH (airports:`flight_2.airports`) RETURN airports.City ORDER BY airports.DestAirport DESC LIMIT 1
model1 pred : MATCH (airports:`flight_2.airports`) RETURN airports.City ORDER BY airports.City DESC LIMIT 1
ground query: MATCH (T1:`flight_2.airports`)-[]-(T2:`flight_2.flights`) WITH count(T1.City) AS cnt, T1 RETURN T1.City ORDER BY cnt DESC LIMIT 1
NLQ         : Which city has the most frequent destination airport?
Schema      : | flight_2 | `flight_2.airlines` : Country , Abbreviation , uid , Airline | `flight_2.airports` : Country , City , AirportName , AirportCode , CountryAbbrev | `flight_2.flights` : DestAirport , Airline , SourceAirport , FlightNo


index       : 163
baseline pre: MATCH (flights:`flight_2.flights`) RETURN flights.City ORDER BY flights.City DESC LIMIT 1
model1 pred : MATCH (T2:`flight_2.airports`)-[T1:`flight_2.flights ` ]-() WITH count(T2.City) AS cnt, T2 RETURN T2.City ORDER BY cnt DESC LIMIT 1
ground query: MATCH (T1:`flight_2.airports`)-[]-(T2:`flight_2.flights`) WITH count(T1.City) AS cnt, T1 RETURN T1.City ORDER BY cnt DESC LIMIT 1
NLQ         : Which city has most number of departing flights?
Schema      : | flight_2 | `flight_2.airlines` : Country , Abbreviation , uid , Airline | `flight_2.airports` : Country , City , AirportName , AirportCode , CountryAbbrev | `flight_2.flights` : DestAirport , Airline , SourceAirport , FlightNo


index       : 164
baseline pre: MATCH (airports:`flight_2.airports`) RETURN airports.City ORDER BY airports.City DESC LIMIT 1
model1 pred : MATCH (airports:`flight_2.airports`) RETURN airports.City ORDER BY airports.SourceAirport DESC LIMIT 1
ground query: MATCH (T1:`flight_2.airports`)-[]-(T2:`flight_2.flights`) WITH count(T1.City) AS cnt, T1 RETURN T1.City ORDER BY cnt DESC LIMIT 1
NLQ         : Which city is the most frequent source airport?
Schema      : | flight_2 | `flight_2.airlines` : Country , Abbreviation , uid , Airline | `flight_2.airports` : Country , City , AirportName , AirportCode , CountryAbbrev | `flight_2.flights` : DestAirport , Airline , SourceAirport , FlightNo


index       : 165
baseline pre: MATCH (T2:`flight_2.flights`)-[T1:`flight_2.flights ` ]-() WITH count(T2.AirportCode) AS cnt, T2 RETURN T2.AirportCode ORDER BY cnt DESC LIMIT 1
model1 pred : MATCH (T2:`flight_2.airports`)-[T1:`flight_2.flights ` ]-() WITH count(T2.AirportCode) AS cnt, T2 RETURN T2.AirportCode ORDER BY cnt DESC LIMIT 1
ground query: MATCH (T1:`flight_2.airports`)-[]-(T2:`flight_2.flights`) WITH T1, count(T1.AirportCode) AS cnt RETURN T1.AirportCode ORDER BY cnt DESC LIMIT 1
NLQ         : What is the code of airport that has the highest number of flights?
Schema      : | flight_2 | `flight_2.airlines` : Country , Abbreviation , uid , Airline | `flight_2.airports` : Country , City , AirportName , AirportCode , CountryAbbrev | `flight_2.flights` : DestAirport , Airline , SourceAirport , FlightNo


index       : 166
baseline pre: MATCH (T2:`flight_2.airports`)-[T1:`flight_2.flights ` ]-() WITH count(T2.AirportCode) AS cnt, T2 RETURN T2.AirportCode ORDER BY cnt DESC LIMIT 1
model1 pred : MATCH (T2:`flight_2.airports`)-[T1:`flight_2.flights ` ]-() WITH count(T2.AirportCode) AS cnt, T2 RETURN T2.AirportCode ORDER BY cnt DESC LIMIT 1
ground query: MATCH (T1:`flight_2.airports`)-[]-(T2:`flight_2.flights`) WITH T1, count(T1.AirportCode) AS cnt RETURN T1.AirportCode ORDER BY cnt DESC LIMIT 1
NLQ         : What is the airport code of the airport with the most flights?
Schema      : | flight_2 | `flight_2.airlines` : Country , Abbreviation , uid , Airline | `flight_2.airports` : Country , City , AirportName , AirportCode , CountryAbbrev | `flight_2.flights` : DestAirport , Airline , SourceAirport , FlightNo


index       : 167
baseline pre: MATCH (T2:`flight_2.airports`)-[T1:`flight_2.flights ` ]-() WITH count(T2.AirportCode) AS cnt, T2 RETURN T2.AirportCode ORDER BY cnt LIMIT 1
model1 pred : MATCH (T2:`flight_2.airports`)-[T1:`flight_2.flights ` ]-() WITH count(T2.AirportCode) AS cnt, T2 RETURN T2.AirportCode ORDER BY cnt ASC LIMIT 1
ground query: MATCH (T1:`flight_2.airports`)-[]-(T2:`flight_2.flights`) WITH T1, count(T1.AirportCode) AS cnt RETURN T1.AirportCode ORDER BY cnt LIMIT 1
NLQ         : What is the code of airport that has fewest number of flights?
Schema      : | flight_2 | `flight_2.airlines` : Country , Abbreviation , uid , Airline | `flight_2.airports` : Country , City , AirportName , AirportCode , CountryAbbrev | `flight_2.flights` : DestAirport , Airline , SourceAirport , FlightNo


index       : 168
baseline pre: MATCH (T2:`flight_2.airports`)-[T1:`flight_2.flights ` ]-() WITH count(T2.AirportCode) AS cnt, T2 RETURN T2.AirportCode ORDER BY cnt LIMIT 1
model1 pred : MATCH (T2:`flight_2.airports`)-[T1:`flight_2.flights ` ]-() WITH count(T2.AirportCode) AS cnt, T2 RETURN T2.AirportCode ORDER BY cnt ASC LIMIT 1
ground query: MATCH (T1:`flight_2.airports`)-[]-(T2:`flight_2.flights`) WITH T1, count(T1.AirportCode) AS cnt RETURN T1.AirportCode ORDER BY cnt LIMIT 1
NLQ         : Give the code of the airport with the least flights.
Schema      : | flight_2 | `flight_2.airlines` : Country , Abbreviation , uid , Airline | `flight_2.airports` : Country , City , AirportName , AirportCode , CountryAbbrev | `flight_2.flights` : DestAirport , Airline , SourceAirport , FlightNo


index       : 169
baseline pre: MATCH (T1:`flight_2.flights`)-[]-(T2:`flight_2.airlines`) WHERE T2.AirportCode = 'AHD' RETURN T1.Airline
model1 pred : MATCH (flights:`flight_2.flights`) WHERE flights.DestAirport = 'AHD' RETURN flights.Airline
ground query: MATCH (T1:`flight_2.airlines`)-[]-(T2:`flight_2.flights`) WHERE T2.SourceAirport = 'AHD' RETURN T1.Airline
NLQ         : What are airlines that have some flight departing from airport 'AHD'?
Schema      : | flight_2 | `flight_2.airlines` : Country , Abbreviation , uid , Airline | `flight_2.airports` : Country , City , AirportName , AirportCode ( AHD ) , CountryAbbrev | `flight_2.flights` : DestAirport (  AHD ) , Airline , SourceAirport (  AHD ) , FlightNo


index       : 170
baseline pre: MATCH (T2:`flight_2.flights`)-[T1:`flight_2.flights ` ]-() WHERE T2.SourceAirport = 'AHD' RETURN T2.Airline
model1 pred : MATCH (T2:`flight_2.airlines`)-[T1:`flight_2.flights ` ]-() WHERE T2.SourceAirport = 'AHD' RETURN T2.Airline
ground query: MATCH (T1:`flight_2.airlines`)-[]-(T2:`flight_2.flights`) WHERE T2.SourceAirport = 'AHD' RETURN T1.Airline
NLQ         : Which airlines have a flight with source airport AHD?
Schema      : | flight_2 | `flight_2.airlines` : Country , Abbreviation , uid , Airline | `flight_2.airports` : Country , City , AirportName , AirportCode ( AHD ) , CountryAbbrev | `flight_2.flights` : DestAirport (  AHD ) , Airline , SourceAirport (  AHD ) , FlightNo


index       : 171
baseline pre: MATCH (T1:`flight_2.airlines`)-[T2:`flight_2.flights ` ]-() WHERE T2.AirportCode = 'AHD' RETURN T1.Airline
model1 pred : MATCH (T1:`flight_2.airlines`)-[T2:`flight_2.flights ` ]-(T3:`flight_2.airlines`) WHERE T3.DestAirport = 'AHD' RETURN T1.Airline
ground query: MATCH (T1:`flight_2.airlines`)-[]-(T2:`flight_2.flights`) WHERE T2.DestAirport = 'AHD' RETURN T1.Airline
NLQ         : What are airlines that have flights arriving at airport 'AHD'?
Schema      : | flight_2 | `flight_2.airlines` : Country , Abbreviation , uid , Airline | `flight_2.airports` : Country , City , AirportName , AirportCode ( AHD ) , CountryAbbrev | `flight_2.flights` : DestAirport (  AHD ) , Airline , SourceAirport (  AHD ) , FlightNo


index       : 172
baseline pre: MATCH (T2:`flight_2.flights`)-[T1:`flight_2.flights ` ]-() WHERE T2.DestAirport = 'AHD' RETURN T2.Airline
model1 pred : MATCH (T2:`flight_2.airlines`)-[T1:`flight_2.flights ` ]-(T3:`flight_2.airlines`) WHERE T3.DestAirport = 'AHD' RETURN T3.Airline
ground query: MATCH (T1:`flight_2.airlines`)-[]-(T2:`flight_2.flights`) WHERE T2.DestAirport = 'AHD' RETURN T1.Airline
NLQ         : Which airlines have a flight with destination airport AHD?
Schema      : | flight_2 | `flight_2.airlines` : Country , Abbreviation , uid , Airline | `flight_2.airports` : Country , City , AirportName , AirportCode ( AHD ) , CountryAbbrev | `flight_2.flights` : DestAirport (  AHD ) , Airline , SourceAirport (  AHD ) , FlightNo


index       : 173
baseline pre: MATCH (flights:`flight_2.flights`) WHERE flights.AirportName = 'APG' RETURN flights.FlightNo
model1 pred : MATCH (flights:`flight_2.flights`) WHERE flights.AirportName = "APG" RETURN flights.FlightNo
ground query: MATCH (flights:`flight_2.flights`) WHERE flights.SourceAirport = 'APG' RETURN flights.FlightNo
NLQ         : What are flight numbers of flights departing from Airport "APG"?
Schema      : | flight_2 | `flight_2.airlines` : Country , Abbreviation , uid , Airline | `flight_2.airports` : Country , City , AirportName , AirportCode ( APG ) , CountryAbbrev | `flight_2.flights` : DestAirport (  APG ) , Airline , SourceAirport (  APG ) , FlightNo


index       : 174
baseline pre: MATCH (flights:`flight_2.flights`) WHERE flights.AirportCode = 'APG' RETURN flights.FlightNo
model1 pred : MATCH (flights:`flight_2.flights`) WHERE flights.SourceAirport = 'APG' RETURN flights.FlightNo
ground query: MATCH (flights:`flight_2.flights`) WHERE flights.SourceAirport = 'APG' RETURN flights.FlightNo
NLQ         : Give the flight numbers of flights leaving from APG.
Schema      : | flight_2 | `flight_2.airlines` : Country , Abbreviation , uid , Airline | `flight_2.airports` : Country , City , AirportName , AirportCode ( APG ) , CountryAbbrev | `flight_2.flights` : DestAirport (  APG ) , Airline , SourceAirport (  APG ) , FlightNo


index       : 175
baseline pre: MATCH (flights:`flight_2.flights`) WHERE flights.AirportName = 'APG' RETURN flights.FlightNo
model1 pred : MATCH (flights:`flight_2.flights`) WHERE flights.AirportName = "APG" RETURN flights.FlightNo
ground query: MATCH (flights:`flight_2.flights`) WHERE flights.DestAirport = 'APG' RETURN flights.FlightNo
NLQ         : What are flight numbers of flights arriving at Airport "APG"?
Schema      : | flight_2 | `flight_2.airlines` : Country , Abbreviation , uid , Airline | `flight_2.airports` : Country , City , AirportName , AirportCode ( APG ) , CountryAbbrev | `flight_2.flights` : DestAirport (  APG ) , Airline , SourceAirport (  APG ) , FlightNo


index       : 176
baseline pre: MATCH (flights:`flight_2.flights`) WHERE flights.AirportCode = 'APG' RETURN flights.FlightNo
model1 pred : MATCH (flights:`flight_2.flights`) WHERE flights.DestAirport = 'APG' RETURN flights.FlightNo
ground query: MATCH (flights:`flight_2.flights`) WHERE flights.DestAirport = 'APG' RETURN flights.FlightNo
NLQ         : Give the flight numbers of flights landing at APG.
Schema      : | flight_2 | `flight_2.airlines` : Country , Abbreviation , uid , Airline | `flight_2.airports` : Country , City , AirportName , AirportCode ( APG ) , CountryAbbrev | `flight_2.flights` : DestAirport (  APG ) , Airline , SourceAirport (  APG ) , FlightNo


index       : 177
baseline pre: MATCH (flights:`flight_2.flights`) WHERE flights.City = 'Aberdeen' RETURN flights.FlightNo
model1 pred : MATCH (flights:`flight_2.flights`) WHERE flights.City = 'Aberdeen' RETURN flights.FlightNo
ground query: MATCH (T1:`flight_2.flights`)-[]-(T2:`flight_2.airports`) WHERE T2.City = 'Aberdeen' RETURN T1.FlightNo
NLQ         : What are flight numbers of flights departing from City "Aberdeen "?
Schema      : | flight_2 | `flight_2.airlines` : Country , Abbreviation , uid , Airline | `flight_2.airports` : Country , City ( Aberdeen  ) , AirportName , AirportCode , CountryAbbrev | `flight_2.flights` : DestAirport , Airline , SourceAirport , FlightNo


index       : 178
baseline pre: MATCH (flights:`flight_2.flights`) WHERE flights.City = 'Aberdeen' RETURN flights.FlightNo
model1 pred : MATCH (flights:`flight_2.flights`) WHERE flights.City = 'Aberdeen' RETURN flights.FlightNo
ground query: MATCH (T1:`flight_2.flights`)-[]-(T2:`flight_2.airports`) WHERE T2.City = 'Aberdeen' RETURN T1.FlightNo
NLQ         : Give the flight numbers of flights leaving from Aberdeen.
Schema      : | flight_2 | `flight_2.airlines` : Country , Abbreviation , uid , Airline | `flight_2.airports` : Country , City ( Aberdeen  ) , AirportName , AirportCode , CountryAbbrev | `flight_2.flights` : DestAirport , Airline , SourceAirport , FlightNo


index       : 179
baseline pre: MATCH (T1:`flight_2.flights`)-[T2:`flight_2.flights ` ]-(T3:`flight_2.airports`) WHERE T3.City = 'Aberdeen' RETURN T1.FlightNo
model1 pred : MATCH (flights:`flight_2.flights`) WHERE flights.City = 'Aberdeen' RETURN flights.FlightNo
ground query: MATCH (T1:`flight_2.flights`)-[]-(T2:`flight_2.airports`) WHERE T2.City = 'Aberdeen' RETURN T1.FlightNo
NLQ         : What are flight numbers of flights arriving at City "Aberdeen"?
Schema      : | flight_2 | `flight_2.airlines` : Country , Abbreviation , uid , Airline | `flight_2.airports` : Country , City ( Aberdeen  ) , AirportName , AirportCode , CountryAbbrev | `flight_2.flights` : DestAirport , Airline , SourceAirport , FlightNo


index       : 180
baseline pre: MATCH (T1:`flight_2.flights`)-[T2:`flight_2.airports ` ]-() WHERE T2.City = 'Aberdeen' RETURN T1.FlightNo
model1 pred : MATCH (flights:`flight_2.flights`) WHERE flights.City = 'Aberdeen' RETURN flights.FlightNo
ground query: MATCH (T1:`flight_2.flights`)-[]-(T2:`flight_2.airports`) WHERE T2.City = 'Aberdeen' RETURN T1.FlightNo
NLQ         : Give the flight numbers of flights arriving in Aberdeen.
Schema      : | flight_2 | `flight_2.airlines` : Country , Abbreviation , uid , Airline | `flight_2.airports` : Country , City ( Aberdeen  ) , AirportName , AirportCode , CountryAbbrev | `flight_2.flights` : DestAirport , Airline , SourceAirport , FlightNo


index       : 181
baseline pre: MATCH (T2:`flight_2.airports`)-[T1:`flight_2.flights ` ]-() WHERE T2.City = 'Aberdeen' OR T2.City = 'Abilene' RETURN count(*)
model1 pred : MATCH (flights:`flight_2.flights`) WHERE flights.City = 'Aberdeen' OR flights.City = 'Abilene' RETURN count(*)
ground query: MATCH (T1:`flight_2.flights`)-[]-(T2:`flight_2.airports`) WHERE T2.City = 'Aberdeen' OR T2.City = 'Abilene' RETURN count(*)
NLQ         : Find the number of flights landing in the city of Aberdeen or Abilene.
Schema      : | flight_2 | `flight_2.airlines` : Country , Abbreviation , uid , Airline | `flight_2.airports` : Country , City ( Abilene  , Aberdeen  ) , AirportName , AirportCode , CountryAbbrev | `flight_2.flights` : DestAirport , Airline , SourceAirport , FlightNo


index       : 182
baseline pre: MATCH (flights:`flight_2.flights`) WHERE flights.City = 'Aberdeen' OR flights.City = 'Abilene' RETURN count(*)
model1 pred : MATCH (flights:`flight_2.flights`) WHERE flights.City = 'Aberdeen' OR flights.City = 'Abilene' RETURN count(*)
ground query: MATCH (T1:`flight_2.flights`)-[]-(T2:`flight_2.airports`) WHERE T2.City = 'Aberdeen' OR T2.City = 'Abilene' RETURN count(*)
NLQ         : How many flights land in Aberdeen or Abilene?
Schema      : | flight_2 | `flight_2.airlines` : Country , Abbreviation , uid , Airline | `flight_2.airports` : Country , City ( Abilene  , Aberdeen  ) , AirportName , AirportCode , CountryAbbrev | `flight_2.flights` : DestAirport , Airline , SourceAirport , FlightNo


index       : 183
baseline pre: MATCH (airports:`flight_2.airports`) WHERE NOT (airports)-[flights.FlightNo = 'No' RETURN airports.AirportName
model1 pred : MATCH (airports:`flight_2.airports`) WHERE airports.FlightNo=0 RETURN airports.AirportName
ground query: MATCH (airports:`flight_2.airports`) WHERE NOT (airports)-[]-(:`flight_2.flights`)     RETURN airports.AirportName
NLQ         : Find the name of airports which do not have any flight in and out.
Schema      : | flight_2 | `flight_2.airlines` : Country , Abbreviation , uid , Airline | `flight_2.airports` : Country , City , AirportName , AirportCode , CountryAbbrev | `flight_2.flights` : DestAirport , Airline , SourceAirport , FlightNo


index       : 184
baseline pre: MATCH (airports:`flight_2.airports`) WHERE NOT (airports)-[flights.FlightNo = 'No' RETURN airports.AirportName
model1 pred : MATCH (airports:`flight_2.airports`) WHERE flights.FlightNo=(airports.DestAirport) OR flights.FlightNo=(airports.Airline) RETURN airports.AirportName
ground query: MATCH (airports:`flight_2.airports`) WHERE NOT (airports)-[]-(:`flight_2.flights`)     RETURN airports.AirportName
NLQ         : Which airports do not have departing or arriving flights?
Schema      : | flight_2 | `flight_2.airlines` : Country , Abbreviation , uid , Airline | `flight_2.airports` : Country , City , AirportName , AirportCode , CountryAbbrev | `flight_2.flights` : DestAirport , Airline , SourceAirport , FlightNo


index       : 187
baseline pre: MATCH (employee:`employee_hire_evaluation.employee`) RETURN employee.Name ORDER BY employee.Age ASC
model1 pred : MATCH (employee:`employee_hire_evaluation.employee`) RETURN employee.Name ORDER BY employee.Age ASC
ground query: MATCH (employee:`employee_hire_evaluation.employee`) RETURN employee.Name ORDER BY employee.Age
NLQ         : Sort employee names by their age in ascending order.
Schema      : | employee_hire_evaluation | `employee_hire_evaluation.employee` : City , Employee_ID , Age , Name | `employee_hire_evaluation.shop` : Name , Manager_name , Number_products , Shop_ID , Location , District | `employee_hire_evaluation.hiring` : Employee_ID , Start_from , Is_full_time , Shop_ID | `employee_hire_evaluation.evaluation` : Employee_ID , Year_awarded , Bonus | `employee_hire_evaluation.hiring_HAS_employee_hire_evaluation.employee` :  | `employee_hire_evaluation.evaluation_HAS_employee_hire_evaluation.employee` :


index       : 188
baseline pre: MATCH (employee:`employee_hire_evaluation.employee`) RETURN employee.Name ORDER BY employee.Age ASC
model1 pred : MATCH (employee:`employee_hire_evaluation.employee`) RETURN employee.Name,employee.Name ORDER BY employee.Age ASC
ground query: MATCH (employee:`employee_hire_evaluation.employee`) RETURN employee.Name ORDER BY employee.Age
NLQ         : List the names of employees and sort in ascending order of age.
Schema      : | employee_hire_evaluation | `employee_hire_evaluation.employee` : City , Employee_ID , Age , Name | `employee_hire_evaluation.shop` : Name , Manager_name , Number_products , Shop_ID , Location , District | `employee_hire_evaluation.hiring` : Employee_ID , Start_from , Is_full_time , Shop_ID | `employee_hire_evaluation.evaluation` : Employee_ID , Year_awarded , Bonus | `employee_hire_evaluation.hiring_HAS_employee_hire_evaluation.employee` :  | `employee_hire_evaluation.evaluation_HAS_employee_hire_evaluation.employee` :


index       : 189
baseline pre: MATCH (employee:`employee_hire_evaluation.employee`) RETURN employee.City,count(*)
model1 pred : MATCH (employee:`employee_hire_evaluation.employee`) RETURN employee.City,count(*)
ground query: MATCH (employee:`employee_hire_evaluation.employee`) RETURN count(*),employee.City
NLQ         : What is the number of employees from each city?
Schema      : | employee_hire_evaluation | `employee_hire_evaluation.employee` : City , Employee_ID , Age , Name | `employee_hire_evaluation.shop` : Name , Manager_name , Number_products , Shop_ID , Location , District | `employee_hire_evaluation.hiring` : Employee_ID , Start_from , Is_full_time , Shop_ID | `employee_hire_evaluation.evaluation` : Employee_ID , Year_awarded , Bonus | `employee_hire_evaluation.hiring_HAS_employee_hire_evaluation.employee` :  | `employee_hire_evaluation.evaluation_HAS_employee_hire_evaluation.employee` :


index       : 190
baseline pre: MATCH (employee:`employee_hire_evaluation.employee`) RETURN employee.City,count(*)
model1 pred : MATCH (employee:`employee_hire_evaluation.employee`) RETURN employee.City,count(*)
ground query: MATCH (employee:`employee_hire_evaluation.employee`) RETURN count(*),employee.City
NLQ         : Count the number of employees for each city.
Schema      : | employee_hire_evaluation | `employee_hire_evaluation.employee` : City , Employee_ID , Age , Name | `employee_hire_evaluation.shop` : Name , Manager_name , Number_products , Shop_ID , Location , District | `employee_hire_evaluation.hiring` : Employee_ID , Start_from , Is_full_time , Shop_ID | `employee_hire_evaluation.evaluation` : Employee_ID , Year_awarded , Bonus | `employee_hire_evaluation.hiring_HAS_employee_hire_evaluation.employee` :  | `employee_hire_evaluation.evaluation_HAS_employee_hire_evaluation.employee` :


index       : 191
baseline pre: MATCH (employee:`employee_hire_evaluation.employee`) WHERE employee.Age > 1 RETURN employee.City
model1 pred : MATCH (employee:`employee_hire_evaluation.employee`) WHERE employee.Age ` 30 WITH count(*) AS count, employee.City AS City WHERE count > 1 RETURN City
ground query: MATCH (employee:`employee_hire_evaluation.employee`) WHERE employee.Age < 30 WITH count(*) AS count, employee.City AS City WHERE count  > 1 RETURN City
NLQ         : Which cities do more than one employee under age 30 come from?
Schema      : | employee_hire_evaluation | `employee_hire_evaluation.employee` : City , Employee_ID , Age , Name | `employee_hire_evaluation.shop` : Name , Manager_name , Number_products , Shop_ID , Location , District | `employee_hire_evaluation.hiring` : Employee_ID , Start_from , Is_full_time , Shop_ID | `employee_hire_evaluation.evaluation` : Employee_ID , Year_awarded , Bonus | `employee_hire_evaluation.hiring_HAS_employee_hire_evaluation.employee` :  | `employee_hire_evaluation.evaluation_HAS_employee_hire_evaluation.employee` :


index       : 192
baseline pre: MATCH (employee:`employee_hire_evaluation.employee`) WHERE employee.Age > 1 RETURN employee.City
model1 pred : MATCH (employee:`employee_hire_evaluation.employee`) WHERE employee.Age ` 30 WITH count(*) AS count, employee.City AS City WHERE count > 1 RETURN City
ground query: MATCH (employee:`employee_hire_evaluation.employee`) WHERE employee.Age < 30 WITH count(*) AS count, employee.City AS City WHERE count  > 1 RETURN City
NLQ         : Find the cities that have more than one employee under age 30.
Schema      : | employee_hire_evaluation | `employee_hire_evaluation.employee` : City , Employee_ID , Age , Name | `employee_hire_evaluation.shop` : Name , Manager_name , Number_products , Shop_ID , Location , District | `employee_hire_evaluation.hiring` : Employee_ID , Start_from , Is_full_time , Shop_ID | `employee_hire_evaluation.evaluation` : Employee_ID , Year_awarded , Bonus | `employee_hire_evaluation.hiring_HAS_employee_hire_evaluation.employee` :  | `employee_hire_evaluation.evaluation_HAS_employee_hire_evaluation.employee` :


index       : 193
baseline pre: MATCH (shop:`employee_hire_evaluation.shop`) RETURN shop.Location,count(*)
model1 pred : MATCH (shop:`employee_hire_evaluation.shop`) RETURN shop.Location,count(*)
ground query: MATCH (shop:`employee_hire_evaluation.shop`) RETURN count(*),shop.Location
NLQ         : Find the number of shops in each location.
Schema      : | employee_hire_evaluation | `employee_hire_evaluation.employee` : City , Employee_ID , Age , Name | `employee_hire_evaluation.shop` : Name , Manager_name , Number_products , Shop_ID , Location , District | `employee_hire_evaluation.hiring` : Employee_ID , Start_from , Is_full_time , Shop_ID | `employee_hire_evaluation.evaluation` : Employee_ID , Year_awarded , Bonus | `employee_hire_evaluation.hiring_HAS_employee_hire_evaluation.employee` :  | `employee_hire_evaluation.evaluation_HAS_employee_hire_evaluation.employee` :


index       : 194
baseline pre: MATCH (shop:`employee_hire_evaluation.shop`) RETURN shop.Location,count(*)
model1 pred : MATCH (shop:`employee_hire_evaluation.shop`) RETURN shop.Location,count(*)
ground query: MATCH (shop:`employee_hire_evaluation.shop`) RETURN count(*),shop.Location
NLQ         : How many shops are there in each location?
Schema      : | employee_hire_evaluation | `employee_hire_evaluation.employee` : City , Employee_ID , Age , Name | `employee_hire_evaluation.shop` : Name , Manager_name , Number_products , Shop_ID , Location , District | `employee_hire_evaluation.hiring` : Employee_ID , Start_from , Is_full_time , Shop_ID | `employee_hire_evaluation.evaluation` : Employee_ID , Year_awarded , Bonus | `employee_hire_evaluation.hiring_HAS_employee_hire_evaluation.employee` :  | `employee_hire_evaluation.evaluation_HAS_employee_hire_evaluation.employee` :


index       : 201
baseline pre: MATCH (shop:`employee_hire_evaluation.shop`) WITH avg(shop.Number_products) AS number_products MATCH (shop:`employee_hire_evaluation.shop`) WHERE shop.Number_products > number_products RETURN shop.Name
model1 pred : MATCH (shop:`employee_hire_evaluation.shop`) WITH avg(shop.Number_products) AS number_products MATCH (shop:`employee_hire_evaluation.shop`) WHERE shop.Number_products > number_products RETURN shop.Name
ground query: MATCH (shop:`employee_hire_evaluation.shop`) WITH avg(shop.Number_products) AS number_products MATCH (shop:`employee_hire_evaluation.shop`) WHERE  shop.Number_products >  number_products  RETURN shop.Name
NLQ         : Find the names of stores whose number products is more than the average number of products.
Schema      : | employee_hire_evaluation | `employee_hire_evaluation.employee` : City , Employee_ID , Age , Name | `employee_hire_evaluation.shop` : Name , Manager_name , Number_products , Shop_ID , Location , District | `employee_hire_evaluation.hiring` : Employee_ID , Start_from , Is_full_time , Shop_ID | `employee_hire_evaluation.evaluation` : Employee_ID , Year_awarded , Bonus | `employee_hire_evaluation.hiring_HAS_employee_hire_evaluation.employee` :  | `employee_hire_evaluation.evaluation_HAS_employee_hire_evaluation.employee` :


index       : 202
baseline pre: MATCH (shop:`employee_hire_evaluation.shop`) WITH avg(shop.Number_products) AS number_products MATCH (shop:`employee_hire_evaluation.shop`) WHERE shop.Number_products > number_products RETURN shop.Name
model1 pred : MATCH (shop:`employee_hire_evaluation.shop`) WITH avg(shop.Number_products) AS number_products MATCH (shop:`employee_hire_evaluation.shop`) WHERE shop.Number_products > number_products RETURN shop.Name
ground query: MATCH (shop:`employee_hire_evaluation.shop`) WITH avg(shop.Number_products) AS number_products MATCH (shop:`employee_hire_evaluation.shop`) WHERE  shop.Number_products >  number_products  RETURN shop.Name
NLQ         : Which shops' number products is above the average? Give me the shop names.
Schema      : | employee_hire_evaluation | `employee_hire_evaluation.employee` : City , Employee_ID , Age , Name | `employee_hire_evaluation.shop` : Name , Manager_name , Number_products , Shop_ID , Location , District | `employee_hire_evaluation.hiring` : Employee_ID , Start_from , Is_full_time , Shop_ID | `employee_hire_evaluation.evaluation` : Employee_ID , Year_awarded , Bonus | `employee_hire_evaluation.hiring_HAS_employee_hire_evaluation.employee` :  | `employee_hire_evaluation.evaluation_HAS_employee_hire_evaluation.employee` :


index       : 203
baseline pre: MATCH (T1:`employee_hire_evaluation.evaluation`)-[]-(T2:`employee_hire_evaluation.employee`) WITH count(T1.Employee_ID) AS cnt, T2 RETURN T2.Name ORDER BY cnt DESC LIMIT 1
model1 pred : MATCH (T1:`employee_hire_evaluation.evaluation`)-[]-(T2:`employee_hire_evaluation.employee`) WITH count(T1.Name) AS cnt, T1 RETURN T1.Name ORDER BY cnt DESC LIMIT 1
ground query: MATCH (t1:`employee_hire_evaluation.employee`)-[]-(t2:`employee_hire_evaluation.evaluation`) WITH t1, count(t1.Employee_ID) AS cnt RETURN t1.Name ORDER BY cnt DESC LIMIT 1
NLQ         : find the name of employee who was awarded the most times in the evaluation.
Schema      : | employee_hire_evaluation | `employee_hire_evaluation.employee` : City , Employee_ID , Age , Name | `employee_hire_evaluation.shop` : Name , Manager_name , Number_products , Shop_ID , Location , District | `employee_hire_evaluation.hiring` : Employee_ID , Start_from , Is_full_time , Shop_ID | `employee_hire_evaluation.evaluation` : Employee_ID , Year_awarded , Bonus | `employee_hire_evaluation.hiring_HAS_employee_hire_evaluation.employee` :  | `employee_hire_evaluation.evaluation_HAS_employee_hire_evaluation.employee` :


index       : 204
baseline pre: MATCH (evaluation:`employee_hire_evaluation.evaluation`) RETURN evaluation.Name ORDER BY evaluation.Year_awarded DESC LIMIT 1
model1 pred : MATCH (T1:`employee_hire_evaluation.evaluation`)-[]-(T2:`employee_hire_evaluation.employee`) WITH count(T1.Name) AS cnt, T1 RETURN T1.Name ORDER BY cnt DESC LIMIT 1
ground query: MATCH (t1:`employee_hire_evaluation.employee`)-[]-(t2:`employee_hire_evaluation.evaluation`) WITH t1, count(t1.Employee_ID) AS cnt RETURN t1.Name ORDER BY cnt DESC LIMIT 1
NLQ         : Which employee received the most awards in evaluations? Give me the employee name.
Schema      : | employee_hire_evaluation | `employee_hire_evaluation.employee` : City , Employee_ID , Age , Name | `employee_hire_evaluation.shop` : Name , Manager_name , Number_products , Shop_ID , Location , District | `employee_hire_evaluation.hiring` : Employee_ID , Start_from , Is_full_time , Shop_ID | `employee_hire_evaluation.evaluation` : Employee_ID , Year_awarded , Bonus | `employee_hire_evaluation.hiring_HAS_employee_hire_evaluation.employee` :  | `employee_hire_evaluation.evaluation_HAS_employee_hire_evaluation.employee` :


index       : 205
baseline pre: MATCH (evaluation:`employee_hire_evaluation.evaluation`) RETURN evaluation.Name ORDER BY evaluation.Bonus DESC LIMIT 1
model1 pred : MATCH (evaluation:`employee_hire_evaluation.evaluation`) RETURN evaluation.Name ORDER BY evaluation.Bonus DESC LIMIT 1
ground query: MATCH (t1:`employee_hire_evaluation.employee`)-[]-(t2:`employee_hire_evaluation.evaluation`) RETURN t1.Name ORDER BY t2.Bonus DESC LIMIT 1
NLQ         : Find the name of the employee who got the highest one time bonus.
Schema      : | employee_hire_evaluation | `employee_hire_evaluation.employee` : City , Employee_ID , Age , Name | `employee_hire_evaluation.shop` : Name , Manager_name , Number_products , Shop_ID , Location , District | `employee_hire_evaluation.hiring` : Employee_ID , Start_from , Is_full_time , Shop_ID | `employee_hire_evaluation.evaluation` : Employee_ID , Year_awarded , Bonus | `employee_hire_evaluation.hiring_HAS_employee_hire_evaluation.employee` :  | `employee_hire_evaluation.evaluation_HAS_employee_hire_evaluation.employee` :


index       : 206
baseline pre: MATCH (evaluation:`employee_hire_evaluation.evaluation`) RETURN evaluation.Name ORDER BY evaluation.Bonus DESC LIMIT 1
model1 pred : MATCH (evaluation:`employee_hire_evaluation.evaluation`) RETURN evaluation.Name ORDER BY evaluation.Bonus DESC LIMIT 1
ground query: MATCH (t1:`employee_hire_evaluation.employee`)-[]-(t2:`employee_hire_evaluation.evaluation`) RETURN t1.Name ORDER BY t2.Bonus DESC LIMIT 1
NLQ         : Which employee received the biggest bonus? Give me the employee name.
Schema      : | employee_hire_evaluation | `employee_hire_evaluation.employee` : City , Employee_ID , Age , Name | `employee_hire_evaluation.shop` : Name , Manager_name , Number_products , Shop_ID , Location , District | `employee_hire_evaluation.hiring` : Employee_ID , Start_from , Is_full_time , Shop_ID | `employee_hire_evaluation.evaluation` : Employee_ID , Year_awarded , Bonus | `employee_hire_evaluation.hiring_HAS_employee_hire_evaluation.employee` :  | `employee_hire_evaluation.evaluation_HAS_employee_hire_evaluation.employee` :


index       : 207
baseline pre: MATCH (employee:`employee_hire_evaluation.evaluation`) WHERE NOT (employee)-[]-(:`employee_hire_evaluation.employee`) RETURN employee.Name
model1 pred : MATCH (evaluation:`employee_hire_evaluation.evaluation`) WHERE NOT (evaluation)-[]-(:`employee_hire_evaluation.employee`) RETURN evaluation.Name
ground query: MATCH (employee:`employee_hire_evaluation.employee`) WHERE NOT (employee)-[]-(:`employee_hire_evaluation.evaluation`)     RETURN employee.Name
NLQ         : Find the names of employees who never won any award in the evaluation.
Schema      : | employee_hire_evaluation | `employee_hire_evaluation.employee` : City , Employee_ID , Age , Name | `employee_hire_evaluation.shop` : Name , Manager_name , Number_products , Shop_ID , Location , District | `employee_hire_evaluation.hiring` : Employee_ID , Start_from , Is_full_time , Shop_ID | `employee_hire_evaluation.evaluation` : Employee_ID , Year_awarded , Bonus | `employee_hire_evaluation.hiring_HAS_employee_hire_evaluation.employee` :  | `employee_hire_evaluation.evaluation_HAS_employee_hire_evaluation.employee` :


index       : 208
baseline pre: MATCH (employee:`employee_hire_evaluation.employee`) WHERE NOT (employee)-[]-(:`employee_hire_evaluation.evaluation`) RETURN employee.Name
model1 pred : MATCH (employee:`employee_hire_evaluation.evaluation`) WHERE NOT (employee)-[]-(:`employee_hire_evaluation.employee`) RETURN employee.Name
ground query: MATCH (employee:`employee_hire_evaluation.employee`) WHERE NOT (employee)-[]-(:`employee_hire_evaluation.evaluation`)     RETURN employee.Name
NLQ         : What are the names of the employees who never received any evaluation?
Schema      : | employee_hire_evaluation | `employee_hire_evaluation.employee` : City , Employee_ID , Age , Name | `employee_hire_evaluation.shop` : Name , Manager_name , Number_products , Shop_ID , Location , District | `employee_hire_evaluation.hiring` : Employee_ID , Start_from , Is_full_time , Shop_ID | `employee_hire_evaluation.evaluation` : Employee_ID , Year_awarded , Bonus | `employee_hire_evaluation.hiring_HAS_employee_hire_evaluation.employee` :  | `employee_hire_evaluation.evaluation_HAS_employee_hire_evaluation.employee` :


index       : 209
baseline pre: MATCH (T1:`employee_hire_evaluation.employee`)-[]-(T2:`employee_hire_evaluation.shop`) WITH count(T1.Shop_ID) AS cnt, T2 RETURN T2.Name ORDER BY cnt DESC LIMIT 1
model1 pred : MATCH (T1:`employee_hire_evaluation.shop`)-[]-(T2:`employee_hire_evaluation.hiring`) WITH count(T1.Shop_ID) AS cnt, T1 RETURN T1.Name ORDER BY cnt DESC LIMIT 1
ground query: MATCH (t1:`employee_hire_evaluation.hiring`)-[]-(t2:`employee_hire_evaluation.shop`) WITH t2, count(t1.Shop_ID) AS cnt RETURN t2.Name ORDER BY cnt DESC LIMIT 1
NLQ         : What is the name of the shop that is hiring the largest number of employees?
Schema      : | employee_hire_evaluation | `employee_hire_evaluation.employee` : City , Employee_ID , Age , Name | `employee_hire_evaluation.shop` : Name , Manager_name , Number_products , Shop_ID , Location , District | `employee_hire_evaluation.hiring` : Employee_ID , Start_from , Is_full_time , Shop_ID | `employee_hire_evaluation.evaluation` : Employee_ID , Year_awarded , Bonus | `employee_hire_evaluation.hiring_HAS_employee_hire_evaluation.employee` :  | `employee_hire_evaluation.evaluation_HAS_employee_hire_evaluation.employee` :


index       : 210
baseline pre: MATCH (employee:`employee_hire_evaluation.employee`) RETURN employee.Name ORDER BY employee.Name DESC LIMIT 1
model1 pred : MATCH (T1:`employee_hire_evaluation.shop`)-[]-(T2:`employee_hire_evaluation.employee`) WITH count(T1.Shop_ID) AS cnt, T1 RETURN T1.Name ORDER BY cnt DESC LIMIT 1
ground query: MATCH (t1:`employee_hire_evaluation.hiring`)-[]-(t2:`employee_hire_evaluation.shop`) WITH t2, count(t1.Shop_ID) AS cnt RETURN t2.Name ORDER BY cnt DESC LIMIT 1
NLQ         : Which shop has the most employees? Give me the shop name.
Schema      : | employee_hire_evaluation | `employee_hire_evaluation.employee` : City , Employee_ID , Age , Name | `employee_hire_evaluation.shop` : Name , Manager_name , Number_products , Shop_ID , Location , District | `employee_hire_evaluation.hiring` : Employee_ID , Start_from , Is_full_time , Shop_ID | `employee_hire_evaluation.evaluation` : Employee_ID , Year_awarded , Bonus | `employee_hire_evaluation.hiring_HAS_employee_hire_evaluation.employee` :  | `employee_hire_evaluation.evaluation_HAS_employee_hire_evaluation.employee` :


index       : 211
baseline pre: MATCH (shop:`employee_hire_evaluation.shop`) WHERE NOT (shop)-[]-(:`employee_hire_evaluation.hiring`) RETURN shop.Name
model1 pred : MATCH (shop:`employee_hire_evaluation.shop`) WHERE NOT (shop)-[]-(:`employee_hire_evaluation.hiring`) RETURN shop.Name
ground query: MATCH (shop:`employee_hire_evaluation.shop`) WHERE NOT (shop)-[]-(:`employee_hire_evaluation.hiring`)     RETURN shop.Name
NLQ         : Find the name of the shops that do not hire any employee.
Schema      : | employee_hire_evaluation | `employee_hire_evaluation.employee` : City , Employee_ID , Age , Name | `employee_hire_evaluation.shop` : Name , Manager_name , Number_products , Shop_ID , Location , District | `employee_hire_evaluation.hiring` : Employee_ID , Start_from , Is_full_time , Shop_ID | `employee_hire_evaluation.evaluation` : Employee_ID , Year_awarded , Bonus | `employee_hire_evaluation.hiring_HAS_employee_hire_evaluation.employee` :  | `employee_hire_evaluation.evaluation_HAS_employee_hire_evaluation.employee` :


index       : 212
baseline pre: MATCH (shop:`employee_hire_evaluation.shop`) WHERE NOT (shop)-[]-(:`employee_hire_evaluation.employee`) RETURN shop.Name
model1 pred : MATCH (shop:`employee_hire_evaluation.shop`) WHERE NOT (shop)-[]-(:`employee_hire_evaluation.employee`) RETURN shop.Name
ground query: MATCH (shop:`employee_hire_evaluation.shop`) WHERE NOT (shop)-[]-(:`employee_hire_evaluation.hiring`)     RETURN shop.Name
NLQ         : Which shops run with no employees? Find the shop names
Schema      : | employee_hire_evaluation | `employee_hire_evaluation.employee` : City , Employee_ID , Age , Name | `employee_hire_evaluation.shop` : Name , Manager_name , Number_products , Shop_ID , Location , District | `employee_hire_evaluation.hiring` : Employee_ID , Start_from , Is_full_time , Shop_ID | `employee_hire_evaluation.evaluation` : Employee_ID , Year_awarded , Bonus | `employee_hire_evaluation.hiring_HAS_employee_hire_evaluation.employee` :  | `employee_hire_evaluation.evaluation_HAS_employee_hire_evaluation.employee` :


index       : 213
baseline pre: MATCH (T1:`employee_hire_evaluation.employee`)-[]-(T2:`employee_hire_evaluation.shop`) RETURN count(*),T2.Name
model1 pred : MATCH (T1:`employee_hire_evaluation.employee`)-[]-(T2:`employee_hire_evaluation.hiring`) RETURN count(*),T1.Name
ground query: MATCH (t1:`employee_hire_evaluation.hiring`)-[]-(t2:`employee_hire_evaluation.shop`) RETURN count(*),t2.Name
NLQ         : Find the number of employees hired in each shop; show the shop name as well.
Schema      : | employee_hire_evaluation | `employee_hire_evaluation.employee` : City , Employee_ID , Age , Name | `employee_hire_evaluation.shop` : Name , Manager_name , Number_products , Shop_ID , Location , District | `employee_hire_evaluation.hiring` : Employee_ID , Start_from , Is_full_time , Shop_ID | `employee_hire_evaluation.evaluation` : Employee_ID , Year_awarded , Bonus | `employee_hire_evaluation.hiring_HAS_employee_hire_evaluation.employee` :  | `employee_hire_evaluation.evaluation_HAS_employee_hire_evaluation.employee` :


index       : 214
baseline pre: MATCH (T1:`employee_hire_evaluation.employee`)-[]-(T2:`employee_hire_evaluation.shop`) RETURN count(*),T2.Name
model1 pred : MATCH (employee:`employee_hire_evaluation.employee`) RETURN count(*),employee.Name
ground query: MATCH (t1:`employee_hire_evaluation.hiring`)-[]-(t2:`employee_hire_evaluation.shop`) RETURN count(*),t2.Name
NLQ         : For each shop, return the number of employees working there and the name of the shop.
Schema      : | employee_hire_evaluation | `employee_hire_evaluation.employee` : City , Employee_ID , Age , Name | `employee_hire_evaluation.shop` : Name , Manager_name , Number_products , Shop_ID , Location , District | `employee_hire_evaluation.hiring` : Employee_ID , Start_from , Is_full_time , Shop_ID | `employee_hire_evaluation.evaluation` : Employee_ID , Year_awarded , Bonus | `employee_hire_evaluation.hiring_HAS_employee_hire_evaluation.employee` :  | `employee_hire_evaluation.evaluation_HAS_employee_hire_evaluation.employee` :


index       : 223
baseline pre: MATCH (templates:`cre_Doc_Template_Mgt.Templates`) RETURN count(DISTINCT templates.Template_Type_Code)
model1 pred : MATCH (T1:`cre_Doc_Template_Mgt.Templates`)-[]-(T2:`cre_Doc_Template_Mgt.Documents`) RETURN count(DISTINCT T1.Template_Type_Code)
ground query: MATCH (documents:`cre_Doc_Template_Mgt.Documents`) RETURN count(DISTINCT documents.Template_ID)
NLQ         : How many different templates do all document use?
Schema      : | cre_Doc_Template_Mgt | `cre_Doc_Template_Mgt.Ref_Template_Types` : Template_Type_Description , Template_Type_Code | `cre_Doc_Template_Mgt.Templates` : Template_Type_Code , Date_Effective_To , Version_Number , Template_Details , Template_ID , Date_Effective_From | `cre_Doc_Template_Mgt.Documents` : Document_Name , Document_Description , Template_ID , Document_ID | `cre_Doc_Template_Mgt.Paragraphs` : Paragraph_Text , Paragraph_ID , Document_ID | `cre_Doc_Template_Mgt.templates_HAS_cre_Doc_Template_Mgt.ref_template_types` :  | `cre_Doc_Template_Mgt.documents_HAS_cre_Doc_Template_Mgt.templates` :  | `cre_Doc_Template_Mgt.paragraphs_HAS_cre_Doc_Template_Mgt.documents` :


index       : 224
baseline pre: MATCH (documents:`cre_Doc_Template_Mgt.Documents`) RETURN count(DISTINCT documents.Template_Type_Code)
model1 pred : MATCH (T1:`cre_Doc_Template_Mgt.Templates`)-[]-(T2:`cre_Doc_Template_Mgt.Documents`) RETURN count(DISTINCT T1.Template_Type_Code)
ground query: MATCH (documents:`cre_Doc_Template_Mgt.Documents`) RETURN count(DISTINCT documents.Template_ID)
NLQ         : Count the number of different templates used for documents.
Schema      : | cre_Doc_Template_Mgt | `cre_Doc_Template_Mgt.Ref_Template_Types` : Template_Type_Description , Template_Type_Code | `cre_Doc_Template_Mgt.Templates` : Template_Type_Code , Date_Effective_To , Version_Number , Template_Details , Template_ID , Date_Effective_From | `cre_Doc_Template_Mgt.Documents` : Document_Name , Document_Description , Template_ID , Document_ID | `cre_Doc_Template_Mgt.Paragraphs` : Paragraph_Text , Paragraph_ID , Document_ID | `cre_Doc_Template_Mgt.templates_HAS_cre_Doc_Template_Mgt.ref_template_types` :  | `cre_Doc_Template_Mgt.documents_HAS_cre_Doc_Template_Mgt.templates` :  | `cre_Doc_Template_Mgt.paragraphs_HAS_cre_Doc_Template_Mgt.documents` :


index       : 225
baseline pre: MATCH (T1:`cre_Doc_Template_Mgt.Documents`)-[]-(T2:`cre_Doc_Template_Mgt.Ref_Template_Types`) WHERE T2.Template_Type_Code = 'PPT' RETURN count(*)
model1 pred : MATCH (T1:`cre_Doc_Template_Mgt.Templates`)-[]-(T2:`cre_Doc_Template_Mgt.Documents`) WHERE T2.Template_Type_Code = 'PPT' RETURN count(*)
ground query: MATCH (T1:`cre_Doc_Template_Mgt.Documents`)-[]-(T2:`cre_Doc_Template_Mgt.Templates`) WHERE T2.Template_Type_Code = 'PPT' RETURN count(*)
NLQ         : How many documents are using the template with type code 'PPT'?
Schema      : | cre_Doc_Template_Mgt | `cre_Doc_Template_Mgt.Ref_Template_Types` : Template_Type_Description , Template_Type_Code ( PPT ) | `cre_Doc_Template_Mgt.Templates` : Template_Type_Code ( PPT ) , Date_Effective_To , Version_Number , Template_Details , Template_ID , Date_Effective_From | `cre_Doc_Template_Mgt.Documents` : Document_Name , Document_Description , Template_ID , Document_ID | `cre_Doc_Template_Mgt.Paragraphs` : Paragraph_Text , Paragraph_ID , Document_ID | `cre_Doc_Template_Mgt.templates_HAS_cre_Doc_Template_Mgt.ref_template_types` :  | `cre_Doc_Template_Mgt.documents_HAS_cre_Doc_Template_Mgt.templates` :  | `cre_Doc_Template_Mgt.paragraphs_HAS_cre_Doc_Template_Mgt.documents` :


index       : 226
baseline pre: MATCH (documents:`cre_Doc_Template_Mgt.Documents`) WHERE documents.Template_Type_Code = 'PPT' RETURN count(*)
model1 pred : MATCH (T1:`cre_Doc_Template_Mgt.Ref_Template_Types`)-[]-(T2:`cre_Doc_Template_Mgt.Documents`) WHERE T2.Template_Type_Code = "PPT" RETURN count(*)
ground query: MATCH (T1:`cre_Doc_Template_Mgt.Documents`)-[]-(T2:`cre_Doc_Template_Mgt.Templates`) WHERE T2.Template_Type_Code = 'PPT' RETURN count(*)
NLQ         : Count the number of documents that use the PPT template type.
Schema      : | cre_Doc_Template_Mgt | `cre_Doc_Template_Mgt.Ref_Template_Types` : Template_Type_Description , Template_Type_Code ( PPT ) | `cre_Doc_Template_Mgt.Templates` : Template_Type_Code ( PPT ) , Date_Effective_To , Version_Number , Template_Details , Template_ID , Date_Effective_From | `cre_Doc_Template_Mgt.Documents` : Document_Name , Document_Description , Template_ID , Document_ID | `cre_Doc_Template_Mgt.Paragraphs` : Paragraph_Text , Paragraph_ID , Document_ID | `cre_Doc_Template_Mgt.templates_HAS_cre_Doc_Template_Mgt.ref_template_types` :  | `cre_Doc_Template_Mgt.documents_HAS_cre_Doc_Template_Mgt.templates` :  | `cre_Doc_Template_Mgt.paragraphs_HAS_cre_Doc_Template_Mgt.documents` :


index       : 227
baseline pre: MATCH (T1:`cre_Doc_Template_Mgt.Documents`)-[]-(T2:`cre_Doc_Template_Mgt.Templates`) RETURN T1.Template_ID,count(*)
model1 pred : MATCH (documents:`cre_Doc_Template_Mgt.Documents`) RETURN documents.Template_ID,count(*)
ground query: MATCH (documents:`cre_Doc_Template_Mgt.Documents`) RETURN documents.Template_ID,count(*)
NLQ         : Show all template ids and number of documents using each template.
Schema      : | cre_Doc_Template_Mgt | `cre_Doc_Template_Mgt.Ref_Template_Types` : Template_Type_Description , Template_Type_Code | `cre_Doc_Template_Mgt.Templates` : Template_Type_Code , Date_Effective_To , Version_Number , Template_Details , Template_ID , Date_Effective_From | `cre_Doc_Template_Mgt.Documents` : Document_Name , Document_Description , Template_ID , Document_ID | `cre_Doc_Template_Mgt.Paragraphs` : Paragraph_Text , Paragraph_ID , Document_ID | `cre_Doc_Template_Mgt.templates_HAS_cre_Doc_Template_Mgt.ref_template_types` :  | `cre_Doc_Template_Mgt.documents_HAS_cre_Doc_Template_Mgt.templates` :  | `cre_Doc_Template_Mgt.paragraphs_HAS_cre_Doc_Template_Mgt.documents` :


index       : 228
baseline pre: MATCH (T1:`cre_Doc_Template_Mgt.Documents`)-[]-(T2:`cre_Doc_Template_Mgt.Ref_Template_Types`) RETURN T1.Template_ID,count(*)
model1 pred : MATCH (documents:`cre_Doc_Template_Mgt.Documents`) RETURN documents.Template_ID,count(*)
ground query: MATCH (documents:`cre_Doc_Template_Mgt.Documents`) RETURN documents.Template_ID,count(*)
NLQ         : What are all different template ids used for documents, and how many times were each of them used?
Schema      : | cre_Doc_Template_Mgt | `cre_Doc_Template_Mgt.Ref_Template_Types` : Template_Type_Description , Template_Type_Code | `cre_Doc_Template_Mgt.Templates` : Template_Type_Code , Date_Effective_To , Version_Number , Template_Details , Template_ID , Date_Effective_From | `cre_Doc_Template_Mgt.Documents` : Document_Name , Document_Description , Template_ID , Document_ID | `cre_Doc_Template_Mgt.Paragraphs` : Paragraph_Text , Paragraph_ID , Document_ID | `cre_Doc_Template_Mgt.templates_HAS_cre_Doc_Template_Mgt.ref_template_types` :  | `cre_Doc_Template_Mgt.documents_HAS_cre_Doc_Template_Mgt.templates` :  | `cre_Doc_Template_Mgt.paragraphs_HAS_cre_Doc_Template_Mgt.documents` :


index       : 229
baseline pre: MATCH (T1:`cre_Doc_Template_Mgt.Documents`)-[]-(T2:`cre_Doc_Template_Mgt.Templates`) WITH count(*) AS count, T2.Template_ID AS Template_ID WHERE count > 1 RETURN Template_ID
model1 pred : MATCH (T1:`cre_Doc_Template_Mgt.Templates`)-[]-(T2:`cre_Doc_Template_Mgt.Documents`) WITH T1.Template_ID AS Template_ID, count(*) AS count WHERE count > 1 RETURN Template_ID
ground query: MATCH (documents:`cre_Doc_Template_Mgt.Documents`) WITH documents.Template_ID AS Template_ID, count(*) AS count WHERE count  > 1 RETURN Template_ID
NLQ         : Show ids for all templates that are used by more than one document.
Schema      : | cre_Doc_Template_Mgt | `cre_Doc_Template_Mgt.Ref_Template_Types` : Template_Type_Description , Template_Type_Code | `cre_Doc_Template_Mgt.Templates` : Template_Type_Code , Date_Effective_To , Version_Number , Template_Details , Template_ID , Date_Effective_From | `cre_Doc_Template_Mgt.Documents` : Document_Name , Document_Description , Template_ID , Document_ID | `cre_Doc_Template_Mgt.Paragraphs` : Paragraph_Text , Paragraph_ID , Document_ID | `cre_Doc_Template_Mgt.templates_HAS_cre_Doc_Template_Mgt.ref_template_types` :  | `cre_Doc_Template_Mgt.documents_HAS_cre_Doc_Template_Mgt.templates` :  | `cre_Doc_Template_Mgt.paragraphs_HAS_cre_Doc_Template_Mgt.documents` :


index       : 230
baseline pre: MATCH (T1:`cre_Doc_Template_Mgt.Documents`)-[]-(T2:`cre_Doc_Template_Mgt.Templates`) WITH count(*) AS count, T2.Template_ID AS Template_ID WHERE count > 1 RETURN Template_ID
model1 pred : MATCH (T1:`cre_Doc_Template_Mgt.Templates`)-[]-(T2:`cre_Doc_Template_Mgt.Documents`) WITH T1.Template_ID AS Template_ID, count(*) AS count WHERE count > 1 RETURN Template_ID
ground query: MATCH (documents:`cre_Doc_Template_Mgt.Documents`) WITH documents.Template_ID AS Template_ID, count(*) AS count WHERE count  > 1 RETURN Template_ID
NLQ         : What are the template ids of any templates used in more than a single document?
Schema      : | cre_Doc_Template_Mgt | `cre_Doc_Template_Mgt.Ref_Template_Types` : Template_Type_Description , Template_Type_Code | `cre_Doc_Template_Mgt.Templates` : Template_Type_Code , Date_Effective_To , Version_Number , Template_Details , Template_ID , Date_Effective_From | `cre_Doc_Template_Mgt.Documents` : Document_Name , Document_Description , Template_ID , Document_ID | `cre_Doc_Template_Mgt.Paragraphs` : Paragraph_Text , Paragraph_ID , Document_ID | `cre_Doc_Template_Mgt.templates_HAS_cre_Doc_Template_Mgt.ref_template_types` :  | `cre_Doc_Template_Mgt.documents_HAS_cre_Doc_Template_Mgt.templates` :  | `cre_Doc_Template_Mgt.paragraphs_HAS_cre_Doc_Template_Mgt.documents` :


index       : 235
baseline pre: MATCH (ref_template_types:`cre_Doc_Template_Mgt.Ref_Template_Types`) RETURN DISTINCT ref_template_types.Template_Type_Code
model1 pred : MATCH (T1:`cre_Doc_Template_Mgt.Templates`)-[]-(T2:`cre_Doc_Template_Mgt.Ref_Template_Types`) RETURN DISTINCT T1.Template_Type_Code
ground query: MATCH (templates:`cre_Doc_Template_Mgt.Templates`) RETURN DISTINCT templates.Template_Type_Code
NLQ         : Show all distinct template type codes for all templates.
Schema      : | cre_Doc_Template_Mgt | `cre_Doc_Template_Mgt.Ref_Template_Types` : Template_Type_Description , Template_Type_Code | `cre_Doc_Template_Mgt.Templates` : Template_Type_Code , Date_Effective_To , Version_Number , Template_Details , Template_ID , Date_Effective_From | `cre_Doc_Template_Mgt.Documents` : Document_Name , Document_Description , Template_ID , Document_ID | `cre_Doc_Template_Mgt.Paragraphs` : Paragraph_Text , Paragraph_ID , Document_ID | `cre_Doc_Template_Mgt.templates_HAS_cre_Doc_Template_Mgt.ref_template_types` :  | `cre_Doc_Template_Mgt.documents_HAS_cre_Doc_Template_Mgt.templates` :  | `cre_Doc_Template_Mgt.paragraphs_HAS_cre_Doc_Template_Mgt.documents` :


index       : 236
baseline pre: MATCH (ref_template_types:`cre_Doc_Template_Mgt.Ref_Template_Types`) RETURN DISTINCT ref_template_types.Template_Type_Code
model1 pred : MATCH (ref_template_types:`cre_Doc_Template_Mgt.Ref_Template_Types`) RETURN DISTINCT ref_template_types.Template_Type_Code
ground query: MATCH (templates:`cre_Doc_Template_Mgt.Templates`) RETURN DISTINCT templates.Template_Type_Code
NLQ         : What are the different template type codes?
Schema      : | cre_Doc_Template_Mgt | `cre_Doc_Template_Mgt.Ref_Template_Types` : Template_Type_Description , Template_Type_Code | `cre_Doc_Template_Mgt.Templates` : Template_Type_Code , Date_Effective_To , Version_Number , Template_Details , Template_ID , Date_Effective_From | `cre_Doc_Template_Mgt.Documents` : Document_Name , Document_Description , Template_ID , Document_ID | `cre_Doc_Template_Mgt.Paragraphs` : Paragraph_Text , Paragraph_ID , Document_ID | `cre_Doc_Template_Mgt.templates_HAS_cre_Doc_Template_Mgt.ref_template_types` :  | `cre_Doc_Template_Mgt.documents_HAS_cre_Doc_Template_Mgt.templates` :  | `cre_Doc_Template_Mgt.paragraphs_HAS_cre_Doc_Template_Mgt.documents` :


index       : 237
baseline pre: MATCH (T1:`cre_Doc_Template_Mgt.Templates`)-[]-(T2:`cre_Doc_Template_Mgt.Ref_Template_Types`) WHERE T2.Version_Number > 5 RETURN T1.Version_Number,T1.Template_Type_Code
model1 pred : MATCH (T1:`cre_Doc_Template_Mgt.Templates`)-[]-(T2:`cre_Doc_Template_Mgt.Templates`) WHERE T2.Version_Number > 5 RETURN T1.Template_Type_Code,T1.Template_Type_Code
ground query: MATCH (templates:`cre_Doc_Template_Mgt.Templates`) WHERE templates.Version_Number > 5 RETURN templates.Version_Number,templates.Template_Type_Code
NLQ         : What is the version number and template type code for the template with version number later than 5?
Schema      : | cre_Doc_Template_Mgt | `cre_Doc_Template_Mgt.Ref_Template_Types` : Template_Type_Description , Template_Type_Code | `cre_Doc_Template_Mgt.Templates` : Template_Type_Code , Date_Effective_To , Version_Number , Template_Details , Template_ID , Date_Effective_From | `cre_Doc_Template_Mgt.Documents` : Document_Name , Document_Description , Template_ID , Document_ID | `cre_Doc_Template_Mgt.Paragraphs` : Paragraph_Text , Paragraph_ID , Document_ID | `cre_Doc_Template_Mgt.templates_HAS_cre_Doc_Template_Mgt.ref_template_types` :  | `cre_Doc_Template_Mgt.documents_HAS_cre_Doc_Template_Mgt.templates` :  | `cre_Doc_Template_Mgt.paragraphs_HAS_cre_Doc_Template_Mgt.documents` :


index       : 238
baseline pre: MATCH (T1:`cre_Doc_Template_Mgt.Templates`)-[]-(T2:`cre_Doc_Template_Mgt.Ref_Template_Types`) WHERE T2.Version_Number > 5 RETURN T1.Version_Number,T1.Template_Type_Code
model1 pred : MATCH (T1:`cre_Doc_Template_Mgt.Templates`)-[]-(T2:`cre_Doc_Template_Mgt.Ref_Template_Types`) WHERE T2.Version_Number > 5 RETURN T1.Version_Number,T1.Template_Type_Code
ground query: MATCH (templates:`cre_Doc_Template_Mgt.Templates`) WHERE templates.Version_Number > 5 RETURN templates.Version_Number,templates.Template_Type_Code
NLQ         : Return the version numbers and template type codes of templates with a version number greater than 5.
Schema      : | cre_Doc_Template_Mgt | `cre_Doc_Template_Mgt.Ref_Template_Types` : Template_Type_Description , Template_Type_Code | `cre_Doc_Template_Mgt.Templates` : Template_Type_Code , Date_Effective_To , Version_Number , Template_Details , Template_ID , Date_Effective_From | `cre_Doc_Template_Mgt.Documents` : Document_Name , Document_Description , Template_ID , Document_ID | `cre_Doc_Template_Mgt.Paragraphs` : Paragraph_Text , Paragraph_ID , Document_ID | `cre_Doc_Template_Mgt.templates_HAS_cre_Doc_Template_Mgt.ref_template_types` :  | `cre_Doc_Template_Mgt.documents_HAS_cre_Doc_Template_Mgt.templates` :  | `cre_Doc_Template_Mgt.paragraphs_HAS_cre_Doc_Template_Mgt.documents` :


index       : 239
baseline pre: MATCH (T1:`cre_Doc_Template_Mgt.Ref_Template_Types`)-[]-(T2:`cre_Doc_Template_Mgt.Templates`) RETURN T1.Template_Type_Code,count(*)
model1 pred : MATCH (T1:`cre_Doc_Template_Mgt.Templates`)-[]-(T2:`cre_Doc_Template_Mgt.Ref_Template_Types`) RETURN T1.Template_Type_Code,count(*)
ground query: MATCH (templates:`cre_Doc_Template_Mgt.Templates`) RETURN templates.Template_Type_Code,count(*)
NLQ         : Show all template type codes and number of templates for each.
Schema      : | cre_Doc_Template_Mgt | `cre_Doc_Template_Mgt.Ref_Template_Types` : Template_Type_Description , Template_Type_Code | `cre_Doc_Template_Mgt.Templates` : Template_Type_Code , Date_Effective_To , Version_Number , Template_Details , Template_ID , Date_Effective_From | `cre_Doc_Template_Mgt.Documents` : Document_Name , Document_Description , Template_ID , Document_ID | `cre_Doc_Template_Mgt.Paragraphs` : Paragraph_Text , Paragraph_ID , Document_ID | `cre_Doc_Template_Mgt.templates_HAS_cre_Doc_Template_Mgt.ref_template_types` :  | `cre_Doc_Template_Mgt.documents_HAS_cre_Doc_Template_Mgt.templates` :  | `cre_Doc_Template_Mgt.paragraphs_HAS_cre_Doc_Template_Mgt.documents` :


index       : 240
baseline pre: MATCH (T1:`cre_Doc_Template_Mgt.Ref_Template_Types`)-[]-(T2:`cre_Doc_Template_Mgt.Templates`) RETURN T1.Template_Type_Code,count(*)
model1 pred : MATCH (T1:`cre_Doc_Template_Mgt.Templates`)-[]-(T2:`cre_Doc_Template_Mgt.Ref_Template_Types`) RETURN T1.Template_Type_Code,count(*)
ground query: MATCH (templates:`cre_Doc_Template_Mgt.Templates`) RETURN templates.Template_Type_Code,count(*)
NLQ         : What are the different template type codes, and how many templates correspond to each?
Schema      : | cre_Doc_Template_Mgt | `cre_Doc_Template_Mgt.Ref_Template_Types` : Template_Type_Description , Template_Type_Code | `cre_Doc_Template_Mgt.Templates` : Template_Type_Code , Date_Effective_To , Version_Number , Template_Details , Template_ID , Date_Effective_From | `cre_Doc_Template_Mgt.Documents` : Document_Name , Document_Description , Template_ID , Document_ID | `cre_Doc_Template_Mgt.Paragraphs` : Paragraph_Text , Paragraph_ID , Document_ID | `cre_Doc_Template_Mgt.templates_HAS_cre_Doc_Template_Mgt.ref_template_types` :  | `cre_Doc_Template_Mgt.documents_HAS_cre_Doc_Template_Mgt.templates` :  | `cre_Doc_Template_Mgt.paragraphs_HAS_cre_Doc_Template_Mgt.documents` :


index       : 241
baseline pre: MATCH (T1:`cre_Doc_Template_Mgt.Ref_Template_Types`)-[]-(T2:`cre_Doc_Template_Mgt.Templates`) WITH count(*) AS count, T2.Template_Type_Code AS Template_Type_Code WHERE count  < 3 RETURN Template_Type_Code
model1 pred : MATCH (T1:`cre_Doc_Template_Mgt.Templates`)-[]-(T2:`cre_Doc_Template_Mgt.Ref_Template_Types`) WITH count(*) AS count, T1.Template_Type_Code AS Template_Type_Code WHERE count ` 3 RETURN Template_Type_Code
ground query: MATCH (templates:`cre_Doc_Template_Mgt.Templates`) WITH templates.Template_Type_Code AS Template_Type_Code, count(*) AS count WHERE count  < 3 RETURN Template_Type_Code
NLQ         : Show all template type codes with less than three templates.
Schema      : | cre_Doc_Template_Mgt | `cre_Doc_Template_Mgt.Ref_Template_Types` : Template_Type_Description , Template_Type_Code | `cre_Doc_Template_Mgt.Templates` : Template_Type_Code , Date_Effective_To , Version_Number , Template_Details , Template_ID , Date_Effective_From | `cre_Doc_Template_Mgt.Documents` : Document_Name , Document_Description , Template_ID , Document_ID | `cre_Doc_Template_Mgt.Paragraphs` : Paragraph_Text , Paragraph_ID , Document_ID | `cre_Doc_Template_Mgt.templates_HAS_cre_Doc_Template_Mgt.ref_template_types` :  | `cre_Doc_Template_Mgt.documents_HAS_cre_Doc_Template_Mgt.templates` :  | `cre_Doc_Template_Mgt.paragraphs_HAS_cre_Doc_Template_Mgt.documents` :


index       : 242
baseline pre: MATCH (T1:`cre_Doc_Template_Mgt.Ref_Template_Types`)-[]-(T2:`cre_Doc_Template_Mgt.Templates`) WITH count(*) AS count, T1.Template_Type_Code AS Template_Type_Code WHERE count  < 3 RETURN Template_Type_Code
model1 pred : MATCH (T1:`cre_Doc_Template_Mgt.Ref_Template_Types`)-[]-(T2:`cre_Doc_Template_Mgt.Templates`) WITH count(*) AS count, T1.Template_Type_Code AS Template_Type_Code WHERE count ` 3 RETURN Template_Type_Code
ground query: MATCH (templates:`cre_Doc_Template_Mgt.Templates`) WITH templates.Template_Type_Code AS Template_Type_Code, count(*) AS count WHERE count  < 3 RETURN Template_Type_Code
NLQ         : What are the codes of template types that have fewer than 3 templates?
Schema      : | cre_Doc_Template_Mgt | `cre_Doc_Template_Mgt.Ref_Template_Types` : Template_Type_Description , Template_Type_Code | `cre_Doc_Template_Mgt.Templates` : Template_Type_Code , Date_Effective_To , Version_Number , Template_Details , Template_ID , Date_Effective_From | `cre_Doc_Template_Mgt.Documents` : Document_Name , Document_Description , Template_ID , Document_ID | `cre_Doc_Template_Mgt.Paragraphs` : Paragraph_Text , Paragraph_ID , Document_ID | `cre_Doc_Template_Mgt.templates_HAS_cre_Doc_Template_Mgt.ref_template_types` :  | `cre_Doc_Template_Mgt.documents_HAS_cre_Doc_Template_Mgt.templates` :  | `cre_Doc_Template_Mgt.paragraphs_HAS_cre_Doc_Template_Mgt.documents` :


index       : 243
baseline pre: MATCH (T1:`cre_Doc_Template_Mgt.Ref_Template_Types`)-[]-(T2:`cre_Doc_Template_Mgt.Documents`) WHERE T2.Document_Name = "Data base" RETURN T1.Template_Type_Code
model1 pred : MATCH (T1:`cre_Doc_Template_Mgt.Templates`)-[]-(T2:`cre_Doc_Template_Mgt.Documents`) WHERE T2.Document_Name = "Data base" RETURN T1.Template_Type_Code
ground query: MATCH (T1:`cre_Doc_Template_Mgt.Templates`)-[]-(T2:`cre_Doc_Template_Mgt.Documents`) WHERE T2.Document_Name = "Data base" RETURN T1.Template_Type_Code
NLQ         : What is the template type code of the template used by document with the name "Data base"?
Schema      : | cre_Doc_Template_Mgt | `cre_Doc_Template_Mgt.Ref_Template_Types` : Template_Type_Description , Template_Type_Code | `cre_Doc_Template_Mgt.Templates` : Template_Type_Code , Date_Effective_To , Version_Number , Template_Details , Template_ID , Date_Effective_From | `cre_Doc_Template_Mgt.Documents` : Document_Name ( Data base ) , Document_Description , Template_ID , Document_ID | `cre_Doc_Template_Mgt.Paragraphs` : Paragraph_Text , Paragraph_ID , Document_ID | `cre_Doc_Template_Mgt.templates_HAS_cre_Doc_Template_Mgt.ref_template_types` :  | `cre_Doc_Template_Mgt.documents_HAS_cre_Doc_Template_Mgt.templates` :  | `cre_Doc_Template_Mgt.paragraphs_HAS_cre_Doc_Template_Mgt.documents` :


index       : 244
baseline pre: MATCH (T1:`cre_Doc_Template_Mgt.Ref_Template_Types`)-[]-(T2:`cre_Doc_Template_Mgt.Documents`) WHERE T2.Document_Name = "Data base" RETURN T1.Template_Type_Code
model1 pred : MATCH (T1:`cre_Doc_Template_Mgt.Templates`)-[]-(T2:`cre_Doc_Template_Mgt.Documents`) WHERE T1.Document_Name = "Data base" RETURN T1.Template_Type_Code
ground query: MATCH (T1:`cre_Doc_Template_Mgt.Templates`)-[]-(T2:`cre_Doc_Template_Mgt.Documents`) WHERE T2.Document_Name = "Data base" RETURN T1.Template_Type_Code
NLQ         : Return the template type code of the template that is used by a document named Data base.
Schema      : | cre_Doc_Template_Mgt | `cre_Doc_Template_Mgt.Ref_Template_Types` : Template_Type_Description , Template_Type_Code | `cre_Doc_Template_Mgt.Templates` : Template_Type_Code , Date_Effective_To , Version_Number , Template_Details , Template_ID , Date_Effective_From | `cre_Doc_Template_Mgt.Documents` : Document_Name ( Data base ) , Document_Description , Template_ID , Document_ID | `cre_Doc_Template_Mgt.Paragraphs` : Paragraph_Text , Paragraph_ID , Document_ID | `cre_Doc_Template_Mgt.templates_HAS_cre_Doc_Template_Mgt.ref_template_types` :  | `cre_Doc_Template_Mgt.documents_HAS_cre_Doc_Template_Mgt.templates` :  | `cre_Doc_Template_Mgt.paragraphs_HAS_cre_Doc_Template_Mgt.documents` :


index       : 245
baseline pre: MATCH (T1:`cre_Doc_Template_Mgt.Ref_Template_Types`)-[]-(T2:`cre_Doc_Template_Mgt.Documents`) RETURN T1.Template_Type_Code,count(*)
model1 pred : MATCH (T1:`cre_Doc_Template_Mgt.Ref_Template_Types`)-[]-(T2:`cre_Doc_Template_Mgt.Documents`) RETURN T1.Template_Type_Code,count(*)
ground query: MATCH (T1:`cre_Doc_Template_Mgt.Templates`)-[]-(T2:`cre_Doc_Template_Mgt.Documents`) RETURN T1.Template_Type_Code,count(*)
NLQ         : Show all template type codes and the number of documents using each type.
Schema      : | cre_Doc_Template_Mgt | `cre_Doc_Template_Mgt.Ref_Template_Types` : Template_Type_Description , Template_Type_Code | `cre_Doc_Template_Mgt.Templates` : Template_Type_Code , Date_Effective_To , Version_Number , Template_Details , Template_ID , Date_Effective_From | `cre_Doc_Template_Mgt.Documents` : Document_Name , Document_Description , Template_ID , Document_ID | `cre_Doc_Template_Mgt.Paragraphs` : Paragraph_Text , Paragraph_ID , Document_ID | `cre_Doc_Template_Mgt.templates_HAS_cre_Doc_Template_Mgt.ref_template_types` :  | `cre_Doc_Template_Mgt.documents_HAS_cre_Doc_Template_Mgt.templates` :  | `cre_Doc_Template_Mgt.paragraphs_HAS_cre_Doc_Template_Mgt.documents` :


index       : 246
baseline pre: MATCH (T1:`cre_Doc_Template_Mgt.Ref_Template_Types`)-[]-(T2:`cre_Doc_Template_Mgt.Documents`) RETURN T1.Template_Type_Code,count(*)
model1 pred : MATCH (T1:`cre_Doc_Template_Mgt.Ref_Template_Types`)-[]-(T2:`cre_Doc_Template_Mgt.Documents`) RETURN T1.Template_Type_Code,count(*)
ground query: MATCH (T1:`cre_Doc_Template_Mgt.Templates`)-[]-(T2:`cre_Doc_Template_Mgt.Documents`) RETURN T1.Template_Type_Code,count(*)
NLQ         : What are the different template type codes, and how many documents use each type?
Schema      : | cre_Doc_Template_Mgt | `cre_Doc_Template_Mgt.Ref_Template_Types` : Template_Type_Description , Template_Type_Code | `cre_Doc_Template_Mgt.Templates` : Template_Type_Code , Date_Effective_To , Version_Number , Template_Details , Template_ID , Date_Effective_From | `cre_Doc_Template_Mgt.Documents` : Document_Name , Document_Description , Template_ID , Document_ID | `cre_Doc_Template_Mgt.Paragraphs` : Paragraph_Text , Paragraph_ID , Document_ID | `cre_Doc_Template_Mgt.templates_HAS_cre_Doc_Template_Mgt.ref_template_types` :  | `cre_Doc_Template_Mgt.documents_HAS_cre_Doc_Template_Mgt.templates` :  | `cre_Doc_Template_Mgt.paragraphs_HAS_cre_Doc_Template_Mgt.documents` :


index       : 249
baseline pre: MATCH (T1:`cre_Doc_Template_Mgt.Ref_Template_Types`)-[]-(T2:`cre_Doc_Template_Mgt.Documents`) RETURN DISTINCT T1.Template_Type_Description
model1 pred : MATCH (T1:`cre_Doc_Template_Mgt.Ref_Template_Types`)-[]-(T2:`cre_Doc_Template_Mgt.Documents`) RETURN DISTINCT T1.Template_Type_Description
ground query: MATCH (T1:`cre_Doc_Template_Mgt.Ref_Template_Types`)-[]-(T2:`cre_Doc_Template_Mgt.Templates`)-[]-(T3:`cre_Doc_Template_Mgt.Documents`) RETURN DISTINCT T1.Template_Type_Description
NLQ         : What are the distinct template type descriptions for the templates ever used by any document?
Schema      : | cre_Doc_Template_Mgt | `cre_Doc_Template_Mgt.Ref_Template_Types` : Template_Type_Description , Template_Type_Code | `cre_Doc_Template_Mgt.Templates` : Template_Type_Code , Date_Effective_To , Version_Number , Template_Details , Template_ID , Date_Effective_From | `cre_Doc_Template_Mgt.Documents` : Document_Name , Document_Description , Template_ID , Document_ID | `cre_Doc_Template_Mgt.Paragraphs` : Paragraph_Text , Paragraph_ID , Document_ID | `cre_Doc_Template_Mgt.templates_HAS_cre_Doc_Template_Mgt.ref_template_types` :  | `cre_Doc_Template_Mgt.documents_HAS_cre_Doc_Template_Mgt.templates` :  | `cre_Doc_Template_Mgt.paragraphs_HAS_cre_Doc_Template_Mgt.documents` :


index       : 250
baseline pre: MATCH (T1:`cre_Doc_Template_Mgt.Ref_Template_Types`)-[]-(T2:`cre_Doc_Template_Mgt.Documents`) RETURN DISTINCT T1.Template_Description
model1 pred : MATCH (T1:`cre_Doc_Template_Mgt.Templates`)-[]-(T2:`cre_Doc_Template_Mgt.Documents`) RETURN DISTINCT T1.Template_Type_Description
ground query: MATCH (T1:`cre_Doc_Template_Mgt.Ref_Template_Types`)-[]-(T2:`cre_Doc_Template_Mgt.Templates`)-[]-(T3:`cre_Doc_Template_Mgt.Documents`) RETURN DISTINCT T1.Template_Type_Description
NLQ         : Return the different descriptions for templates that have been used in a document.
Schema      : | cre_Doc_Template_Mgt | `cre_Doc_Template_Mgt.Ref_Template_Types` : Template_Type_Description , Template_Type_Code | `cre_Doc_Template_Mgt.Templates` : Template_Type_Code , Date_Effective_To , Version_Number , Template_Details , Template_ID , Date_Effective_From | `cre_Doc_Template_Mgt.Documents` : Document_Name , Document_Description , Template_ID , Document_ID | `cre_Doc_Template_Mgt.Paragraphs` : Paragraph_Text , Paragraph_ID , Document_ID | `cre_Doc_Template_Mgt.templates_HAS_cre_Doc_Template_Mgt.ref_template_types` :  | `cre_Doc_Template_Mgt.documents_HAS_cre_Doc_Template_Mgt.templates` :  | `cre_Doc_Template_Mgt.paragraphs_HAS_cre_Doc_Template_Mgt.documents` :


index       : 255
baseline pre: MATCH (paragraphs:`cre_Doc_Template_Mgt.Paragraphs`) WHERE paragraphs.Paragraph_Text = 'Korea' RETURN paragraphs.Paragraph_Details
model1 pred : MATCH (paragraphs:`cre_Doc_Template_Mgt.Paragraphs`) WHERE paragraphs.Paragraph_Text = 'Korea' RETURN paragraphs.Paragraph_Details
ground query: MATCH (paragraphs:`cre_Doc_Template_Mgt.Paragraphs`) WHERE paragraphs.Paragraph_Text =~'.*[K|k]orea.*' RETURN paragraphs.Other_Details
NLQ         : Show paragraph details for paragraph with text 'Korea ' .
Schema      : | cre_Doc_Template_Mgt | `cre_Doc_Template_Mgt.Ref_Template_Types` : Template_Type_Description , Template_Type_Code | `cre_Doc_Template_Mgt.Templates` : Template_Type_Code , Date_Effective_To , Version_Number , Template_Details , Template_ID , Date_Effective_From | `cre_Doc_Template_Mgt.Documents` : Document_Name , Document_Description , Template_ID , Document_ID | `cre_Doc_Template_Mgt.Paragraphs` : Paragraph_Text ( Korea ) , Paragraph_ID , Document_ID | `cre_Doc_Template_Mgt.templates_HAS_cre_Doc_Template_Mgt.ref_template_types` :  | `cre_Doc_Template_Mgt.documents_HAS_cre_Doc_Template_Mgt.templates` :  | `cre_Doc_Template_Mgt.paragraphs_HAS_cre_Doc_Template_Mgt.documents` :


index       : 256
baseline pre: MATCH (paragraphs:`cre_Doc_Template_Mgt.Paragraphs`) WHERE paragraphs.Paragraph_Text = 'Korea' RETURN paragraphs.Paragraph_Details
model1 pred : MATCH (paragraphs:`cre_Doc_Template_Mgt.Paragraphs`) WHERE paragraphs.Paragraph_Text = 'Korea' RETURN paragraphs.Paragraph_Details
ground query: MATCH (paragraphs:`cre_Doc_Template_Mgt.Paragraphs`) WHERE paragraphs.Paragraph_Text =~'.*[K|k]orea.*' RETURN paragraphs.Other_Details
NLQ         : What are the details for the paragraph that includes the text 'Korea ' ?
Schema      : | cre_Doc_Template_Mgt | `cre_Doc_Template_Mgt.Ref_Template_Types` : Template_Type_Description , Template_Type_Code | `cre_Doc_Template_Mgt.Templates` : Template_Type_Code , Date_Effective_To , Version_Number , Template_Details , Template_ID , Date_Effective_From | `cre_Doc_Template_Mgt.Documents` : Document_Name , Document_Description , Template_ID , Document_ID | `cre_Doc_Template_Mgt.Paragraphs` : Paragraph_Text ( Korea ) , Paragraph_ID , Document_ID | `cre_Doc_Template_Mgt.templates_HAS_cre_Doc_Template_Mgt.ref_template_types` :  | `cre_Doc_Template_Mgt.documents_HAS_cre_Doc_Template_Mgt.templates` :  | `cre_Doc_Template_Mgt.paragraphs_HAS_cre_Doc_Template_Mgt.documents` :


index       : 263
baseline pre: MATCH (T1:`cre_Doc_Template_Mgt.Paragraphs`)-[]-(T2:`cre_Doc_Template_Mgt.Documents`) RETURN T1.Document_ID,T1.Document_Name,count(*)
model1 pred : MATCH (documents:`cre_Doc_Template_Mgt.Documents`) RETURN documents.Document_ID,documents.Document_Name,count(*)
ground query: MATCH (T1:`cre_Doc_Template_Mgt.Paragraphs`)-[]-(T2:`cre_Doc_Template_Mgt.Documents`) RETURN T1.Document_ID,T2.Document_Name,count(*)
NLQ         : Show all document ids, names and the number of paragraphs in each document.
Schema      : | cre_Doc_Template_Mgt | `cre_Doc_Template_Mgt.Ref_Template_Types` : Template_Type_Description , Template_Type_Code | `cre_Doc_Template_Mgt.Templates` : Template_Type_Code , Date_Effective_To , Version_Number , Template_Details , Template_ID , Date_Effective_From | `cre_Doc_Template_Mgt.Documents` : Document_Name , Document_Description , Template_ID , Document_ID | `cre_Doc_Template_Mgt.Paragraphs` : Paragraph_Text , Paragraph_ID , Document_ID | `cre_Doc_Template_Mgt.templates_HAS_cre_Doc_Template_Mgt.ref_template_types` :  | `cre_Doc_Template_Mgt.documents_HAS_cre_Doc_Template_Mgt.templates` :  | `cre_Doc_Template_Mgt.paragraphs_HAS_cre_Doc_Template_Mgt.documents` :


index       : 264
baseline pre: MATCH (T1:`cre_Doc_Template_Mgt.Documents`)-[]-(T2:`cre_Doc_Template_Mgt.Paragraphs`) RETURN T1.Document_ID,T1.Document_Name,count(*)
model1 pred : MATCH (documents:`cre_Doc_Template_Mgt.Documents`) RETURN documents.Document_ID,documents.Document_Name,count(*)
ground query: MATCH (T1:`cre_Doc_Template_Mgt.Paragraphs`)-[]-(T2:`cre_Doc_Template_Mgt.Documents`) RETURN T1.Document_ID,T2.Document_Name,count(*)
NLQ         : What are the ids and names of each document, as well as the number of paragraphs in each?
Schema      : | cre_Doc_Template_Mgt | `cre_Doc_Template_Mgt.Ref_Template_Types` : Template_Type_Description , Template_Type_Code | `cre_Doc_Template_Mgt.Templates` : Template_Type_Code , Date_Effective_To , Version_Number , Template_Details , Template_ID , Date_Effective_From | `cre_Doc_Template_Mgt.Documents` : Document_Name , Document_Description , Template_ID , Document_ID | `cre_Doc_Template_Mgt.Paragraphs` : Paragraph_Text , Paragraph_ID , Document_ID | `cre_Doc_Template_Mgt.templates_HAS_cre_Doc_Template_Mgt.ref_template_types` :  | `cre_Doc_Template_Mgt.documents_HAS_cre_Doc_Template_Mgt.templates` :  | `cre_Doc_Template_Mgt.paragraphs_HAS_cre_Doc_Template_Mgt.documents` :


index       : 265
baseline pre: MATCH (paragraphs:`cre_Doc_Template_Mgt.Paragraphs`) WITH count(*) AS count, paragraphs.Paragraph_ID AS Paragraph_ID WHERE count >= 2 RETURN Paragraph_ID
model1 pred : MATCH (paragraphs:`cre_Doc_Template_Mgt.Paragraphs`) WITH count(*) AS count, documents.Paragraph_ID AS Paragraph_ID WHERE count >= 2 RETURN Paragraph_ID
ground query: MATCH (paragraphs:`cre_Doc_Template_Mgt.Paragraphs`) WITH count(*) AS count, paragraphs.Document_ID AS Document_ID WHERE count  >= 2 RETURN Document_ID
NLQ         : List all document ids with at least two paragraphs.
Schema      : | cre_Doc_Template_Mgt | `cre_Doc_Template_Mgt.Ref_Template_Types` : Template_Type_Description , Template_Type_Code | `cre_Doc_Template_Mgt.Templates` : Template_Type_Code , Date_Effective_To , Version_Number , Template_Details , Template_ID , Date_Effective_From | `cre_Doc_Template_Mgt.Documents` : Document_Name , Document_Description , Template_ID , Document_ID | `cre_Doc_Template_Mgt.Paragraphs` : Paragraph_Text , Paragraph_ID , Document_ID | `cre_Doc_Template_Mgt.templates_HAS_cre_Doc_Template_Mgt.ref_template_types` :  | `cre_Doc_Template_Mgt.documents_HAS_cre_Doc_Template_Mgt.templates` :  | `cre_Doc_Template_Mgt.paragraphs_HAS_cre_Doc_Template_Mgt.documents` :


index       : 266
baseline pre: MATCH (T1:`cre_Doc_Template_Mgt.Documents`)-[]-(T2:`cre_Doc_Template_Mgt.Paragraphs`) WITH count(*) AS count, T1.Document_ID AS Document_ID WHERE count >= 2 RETURN Document_ID
model1 pred : MATCH (T1:`cre_Doc_Template_Mgt.Paragraphs`)-[]-(T2:`cre_Doc_Template_Mgt.Documents`) WITH count(*) AS count, T2.Paragraph_ID AS Paragraph_ID WHERE count >= 2 RETURN Paragraph_ID
ground query: MATCH (paragraphs:`cre_Doc_Template_Mgt.Paragraphs`) WITH count(*) AS count, paragraphs.Document_ID AS Document_ID WHERE count  >= 2 RETURN Document_ID
NLQ         : What are the ids of documents that have 2 or more paragraphs?
Schema      : | cre_Doc_Template_Mgt | `cre_Doc_Template_Mgt.Ref_Template_Types` : Template_Type_Description , Template_Type_Code | `cre_Doc_Template_Mgt.Templates` : Template_Type_Code , Date_Effective_To , Version_Number , Template_Details , Template_ID , Date_Effective_From | `cre_Doc_Template_Mgt.Documents` : Document_Name , Document_Description , Template_ID , Document_ID | `cre_Doc_Template_Mgt.Paragraphs` : Paragraph_Text , Paragraph_ID , Document_ID | `cre_Doc_Template_Mgt.templates_HAS_cre_Doc_Template_Mgt.ref_template_types` :  | `cre_Doc_Template_Mgt.documents_HAS_cre_Doc_Template_Mgt.templates` :  | `cre_Doc_Template_Mgt.paragraphs_HAS_cre_Doc_Template_Mgt.documents` :


index       : 267
baseline pre: MATCH (paragraphs:`cre_Doc_Template_Mgt.Paragraphs`) RETURN paragraphs.Document_ID,paragraphs.Document_Name ORDER BY paragraphs.Paragraph_ID DESC LIMIT 1
model1 pred : MATCH (documents:`cre_Doc_Template_Mgt.Documents`) RETURN documents.Document_ID,documents.Document_Name ORDER BY documents.Document_Name DESC LIMIT 1
ground query: MATCH (T1:`cre_Doc_Template_Mgt.Paragraphs`)-[]-(T2:`cre_Doc_Template_Mgt.Documents`) WITH count(T1.Document_ID) AS cnt, T1, T2 RETURN T1.Document_ID,T2.Document_Name ORDER BY cnt DESC LIMIT 1
NLQ         : What is the document id and name with greatest number of paragraphs?
Schema      : | cre_Doc_Template_Mgt | `cre_Doc_Template_Mgt.Ref_Template_Types` : Template_Type_Description , Template_Type_Code | `cre_Doc_Template_Mgt.Templates` : Template_Type_Code , Date_Effective_To , Version_Number , Template_Details , Template_ID , Date_Effective_From | `cre_Doc_Template_Mgt.Documents` : Document_Name , Document_Description , Template_ID , Document_ID | `cre_Doc_Template_Mgt.Paragraphs` : Paragraph_Text , Paragraph_ID , Document_ID | `cre_Doc_Template_Mgt.templates_HAS_cre_Doc_Template_Mgt.ref_template_types` :  | `cre_Doc_Template_Mgt.documents_HAS_cre_Doc_Template_Mgt.templates` :  | `cre_Doc_Template_Mgt.paragraphs_HAS_cre_Doc_Template_Mgt.documents` :


index       : 268
baseline pre: MATCH (T1:`cre_Doc_Template_Mgt.Documents`)-[]-(T2:`cre_Doc_Template_Mgt.Paragraphs`) WITH count(T1.Document_ID) AS cnt, T2 RETURN T2.Document_ID,T2.Document_Name ORDER BY cnt DESC LIMIT 1
model1 pred : MATCH (documents:`cre_Doc_Template_Mgt.Documents`) RETURN documents.Document_ID,documents.Document_Name ORDER BY documents.Document_Name DESC LIMIT 1
ground query: MATCH (T1:`cre_Doc_Template_Mgt.Paragraphs`)-[]-(T2:`cre_Doc_Template_Mgt.Documents`) WITH count(T1.Document_ID) AS cnt, T1, T2 RETURN T1.Document_ID,T2.Document_Name ORDER BY cnt DESC LIMIT 1
NLQ         : Return the id and name of the document with the most paragraphs.
Schema      : | cre_Doc_Template_Mgt | `cre_Doc_Template_Mgt.Ref_Template_Types` : Template_Type_Description , Template_Type_Code | `cre_Doc_Template_Mgt.Templates` : Template_Type_Code , Date_Effective_To , Version_Number , Template_Details , Template_ID , Date_Effective_From | `cre_Doc_Template_Mgt.Documents` : Document_Name , Document_Description , Template_ID , Document_ID | `cre_Doc_Template_Mgt.Paragraphs` : Paragraph_Text , Paragraph_ID , Document_ID | `cre_Doc_Template_Mgt.templates_HAS_cre_Doc_Template_Mgt.ref_template_types` :  | `cre_Doc_Template_Mgt.documents_HAS_cre_Doc_Template_Mgt.templates` :  | `cre_Doc_Template_Mgt.paragraphs_HAS_cre_Doc_Template_Mgt.documents` :


index       : 269
baseline pre: MATCH (paragraphs:`cre_Doc_Template_Mgt.Paragraphs`) RETURN paragraphs.Paragraph_ID ORDER BY paragraphs.Paragraph_ID ASC LIMIT 1
model1 pred : MATCH (paragraphs:`cre_Doc_Template_Mgt.Paragraphs`) RETURN documents.Paragraph_ID ORDER BY documents.Paragraph_Text ASC LIMIT 1
ground query: MATCH (paragraphs:`cre_Doc_Template_Mgt.Paragraphs`) RETURN paragraphs.Document_ID ORDER BY paragraphs.Document_ID ASC LIMIT 1
NLQ         : What is the document id with least number of paragraphs?
Schema      : | cre_Doc_Template_Mgt | `cre_Doc_Template_Mgt.Ref_Template_Types` : Template_Type_Description , Template_Type_Code | `cre_Doc_Template_Mgt.Templates` : Template_Type_Code , Date_Effective_To , Version_Number , Template_Details , Template_ID , Date_Effective_From | `cre_Doc_Template_Mgt.Documents` : Document_Name , Document_Description , Template_ID , Document_ID | `cre_Doc_Template_Mgt.Paragraphs` : Paragraph_Text , Paragraph_ID , Document_ID | `cre_Doc_Template_Mgt.templates_HAS_cre_Doc_Template_Mgt.ref_template_types` :  | `cre_Doc_Template_Mgt.documents_HAS_cre_Doc_Template_Mgt.templates` :  | `cre_Doc_Template_Mgt.paragraphs_HAS_cre_Doc_Template_Mgt.documents` :


index       : 270
baseline pre: MATCH (paragraphs:`cre_Doc_Template_Mgt.Paragraphs`) RETURN paragraphs.Paragraph_ID ORDER BY paragraphs.Paragraph_ID ASC LIMIT 1
model1 pred : MATCH (paragraphs:`cre_Doc_Template_Mgt.Paragraphs`) RETURN documents.Paragraph_ID ORDER BY documents.Paragraph_Text ASC LIMIT 1
ground query: MATCH (paragraphs:`cre_Doc_Template_Mgt.Paragraphs`) RETURN paragraphs.Document_ID ORDER BY paragraphs.Document_ID ASC LIMIT 1
NLQ         : Return the id of the document with the fewest paragraphs.
Schema      : | cre_Doc_Template_Mgt | `cre_Doc_Template_Mgt.Ref_Template_Types` : Template_Type_Description , Template_Type_Code | `cre_Doc_Template_Mgt.Templates` : Template_Type_Code , Date_Effective_To , Version_Number , Template_Details , Template_ID , Date_Effective_From | `cre_Doc_Template_Mgt.Documents` : Document_Name , Document_Description , Template_ID , Document_ID | `cre_Doc_Template_Mgt.Paragraphs` : Paragraph_Text , Paragraph_ID , Document_ID | `cre_Doc_Template_Mgt.templates_HAS_cre_Doc_Template_Mgt.ref_template_types` :  | `cre_Doc_Template_Mgt.documents_HAS_cre_Doc_Template_Mgt.templates` :  | `cre_Doc_Template_Mgt.paragraphs_HAS_cre_Doc_Template_Mgt.documents` :


index       : 277
baseline pre: MATCH (teacher:`course_teach.teacher`) WHERE teacher.Hometown  < > 'Little Lever Urban District' RETURN teacher.Name
model1 pred : MATCH (teacher:`course_teach.teacher`) WHERE teacher.Hometown ` > 'Little Lever Urban District' RETURN teacher.Name
ground query: MATCH (teacher:`course_teach.teacher`) WHERE teacher.Hometown <> 'little lever urban district' RETURN teacher.Name
NLQ         : List the name of teachers whose hometown is not `` Little Lever Urban District '' .
Schema      : | course_teach | `course_teach.course` : Course , Course_ID , Staring_Date | `course_teach.teacher` : Age , Name , Teacher_ID , Hometown ( Little Lever Urban District ) | `course_teach.course_arrange` : Teacher_ID , Course_ID , Grade


index       : 278
baseline pre: MATCH (teacher:`course_teach.teacher`) WHERE teacher.Hometown  < > 'Little Lever Urban District' RETURN teacher.Name
model1 pred : MATCH (teacher:`course_teach.teacher`) WHERE teacher.Hometown ` > 'Little Lever Urban District' RETURN teacher.Name
ground query: MATCH (teacher:`course_teach.teacher`) WHERE teacher.Hometown <> 'little lever urban district' RETURN teacher.Name
NLQ         : What are the names of the teachers whose hometown is not `` Little Lever Urban District '' ?
Schema      : | course_teach | `course_teach.course` : Course , Course_ID , Staring_Date | `course_teach.teacher` : Age , Name , Teacher_ID , Hometown ( Little Lever Urban District ) | `course_teach.course_arrange` : Teacher_ID , Course_ID , Grade


index       : 279
baseline pre: MATCH (teacher:`course_teach.teacher`) WHERE teacher.Age = 32 OR teacher.Age = 33 RETURN teacher.Name
model1 pred : MATCH (teacher:`course_teach.teacher`) WHERE teacher.Age = 32 OR teacher.Age = 33 RETURN teacher.Name
ground query: MATCH (teacher:`course_teach.teacher`) WHERE teacher.Age = '32' OR teacher.Age = '33' RETURN teacher.Name
NLQ         : Show the name of teachers aged either 32 or 33?
Schema      : | course_teach | `course_teach.course` : Course , Course_ID , Staring_Date | `course_teach.teacher` : Age , Name , Teacher_ID , Hometown | `course_teach.course_arrange` : Teacher_ID , Course_ID , Grade


index       : 280
baseline pre: MATCH (teacher:`course_teach.teacher`) WHERE teacher.Age = 32 OR teacher.Age = 33 RETURN teacher.Name
model1 pred : MATCH (teacher:`course_teach.teacher`) WHERE teacher.Age = 32 OR teacher.Age = 33 RETURN teacher.Name
ground query: MATCH (teacher:`course_teach.teacher`) WHERE teacher.Age = '32' OR teacher.Age = '33' RETURN teacher.Name
NLQ         : What are the names of the teachers who are aged either 32 or 33?
Schema      : | course_teach | `course_teach.course` : Course , Course_ID , Staring_Date | `course_teach.teacher` : Age , Name , Teacher_ID , Hometown | `course_teach.course_arrange` : Teacher_ID , Course_ID , Grade


index       : 287
baseline pre: MATCH (teacher:`course_teach.teacher`) WITH teacher.Hometown AS Hometown, count(*) AS count WHERE count >= 2 RETURN Hometown
model1 pred : MATCH (teacher:`course_teach.teacher`) WITH count(*) AS count, teacher.Hometown AS Hometown WHERE count >= 2 RETURN Hometown
ground query: MATCH (teacher:`course_teach.teacher`) WITH teacher.Hometown AS Hometown, count(*) AS count WHERE count  >= 2 RETURN Hometown
NLQ         : Show the hometowns shared by at least two teachers.
Schema      : | course_teach | `course_teach.course` : Course , Course_ID , Staring_Date | `course_teach.teacher` : Age , Name , Teacher_ID , Hometown | `course_teach.course_arrange` : Teacher_ID , Course_ID , Grade


index       : 288
baseline pre: MATCH (teacher:`course_teach.teacher`) WITH count(*) AS count, teacher.Hometown AS Hometown WHERE count >= 2 RETURN Hometown
model1 pred : MATCH (teacher:`course_teach.teacher`) WITH count(*) AS count, teacher.Hometown AS Hometown WHERE count >= 2 RETURN Hometown
ground query: MATCH (teacher:`course_teach.teacher`) WITH teacher.Hometown AS Hometown, count(*) AS count WHERE count  >= 2 RETURN Hometown
NLQ         : What are the towns from which at least two teachers come from?
Schema      : | course_teach | `course_teach.course` : Course , Course_ID , Staring_Date | `course_teach.teacher` : Age , Name , Teacher_ID , Hometown | `course_teach.course_arrange` : Teacher_ID , Course_ID , Grade


index       : 289
baseline pre: MATCH (T1:`course_teach.teacher`)-[T2:`course_teach.course_arrange ` ]-() RETURN T1.Name,T2.Course
model1 pred : MATCH (T2:`course_teach.course_arrange`)-[T1:`course_teach.course_arrange ` ]-() RETURN T2.Name,T2.Course_ID
ground query: MATCH (T2:`course_teach.course`)-[T1:`course_teach.course_arrange`]-(T3:`course_teach.teacher`) RETURN T3.Name,T2.Course
NLQ         : Show names of teachers and the courses they are arranged to teach.
Schema      : | course_teach | `course_teach.course` : Course , Course_ID , Staring_Date | `course_teach.teacher` : Age , Name , Teacher_ID , Hometown | `course_teach.course_arrange` : Teacher_ID , Course_ID , Grade


index       : 290
baseline pre: MATCH (T1:`course_teach.teacher`)-[T2:`course_teach.course_arrange ` ]-() RETURN T1.Name,T2.Course
model1 pred : MATCH (T1:`course_teach.course`)-[T2:`course_teach.course_arrange ` ]-() RETURN T1.Name,T1.Course_ID
ground query: MATCH (T2:`course_teach.course`)-[T1:`course_teach.course_arrange`]-(T3:`course_teach.teacher`) RETURN T3.Name,T2.Course
NLQ         : What is the name of each teacher and what course they teach?
Schema      : | course_teach | `course_teach.course` : Course , Course_ID , Staring_Date | `course_teach.teacher` : Age , Name , Teacher_ID , Hometown | `course_teach.course_arrange` : Teacher_ID , Course_ID , Grade


index       : 291
baseline pre: MATCH (T1:`course_teach.teacher`)-[T2:`course_teach.course_arrange ` ]-() RETURN T1.Name,T2.Course ORDER BY T1.Name ASC
model1 pred : MATCH (T2:`course_teach.course`)-[T1:`course_teach.course_arrange ` ]-() RETURN T2.Name,T2.Course ORDER BY T2.Name ASC
ground query: MATCH (T2:`course_teach.course`)-[T1:`course_teach.course_arrange`]-(T3:`course_teach.teacher`) RETURN T3.Name,T2.Course ORDER BY T3.Name
NLQ         : Show names of teachers and the courses they are arranged to teach in ascending alphabetical order of the teacher's name.
Schema      : | course_teach | `course_teach.course` : Course , Course_ID , Staring_Date | `course_teach.teacher` : Age , Name , Teacher_ID , Hometown | `course_teach.course_arrange` : Teacher_ID , Course_ID , Grade


index       : 292
baseline pre: MATCH (T1:`course_teach.teacher`)-[T2:`course_teach.course_arrange ` ]-() RETURN T1.Name,T2.Course ORDER BY T1.Name ASC
model1 pred : MATCH (T2:`course_teach.course`)-[T1:`course_teach.course_arrange ` ]-() RETURN T2.Name,T2.Course ORDER BY T2.Name ASC
ground query: MATCH (T2:`course_teach.course`)-[T1:`course_teach.course_arrange`]-(T3:`course_teach.teacher`) RETURN T3.Name,T2.Course ORDER BY T3.Name
NLQ         : What are the names of the teachers and the courses they teach in ascending alphabetical order by the name of the teacher?
Schema      : | course_teach | `course_teach.course` : Course , Course_ID , Staring_Date | `course_teach.teacher` : Age , Name , Teacher_ID , Hometown | `course_teach.course_arrange` : Teacher_ID , Course_ID , Grade


index       : 293
baseline pre: MATCH (T1:`course_teach.teacher`)-[T2:`course_teach.course_arrange ` ]-() WHERE T2.Curriculum = 'Mathematic' RETURN T1.Name
model1 pred : MATCH (T1:`course_teach.course`)-[T2:`course_teach.course_arrange ` ]-(T3:`course_teach.teacher`) WHERE T3.Course = 'Math' RETURN T3.Name
ground query: MATCH (T2:`course_teach.course`)-[T1:`course_teach.course_arrange`]-(T3:`course_teach.teacher`) WHERE T2.Course = 'Math' RETURN T3.Name
NLQ         : Show the name of the teacher for the math course.
Schema      : | course_teach | `course_teach.course` : Course ( Math ) , Course_ID , Staring_Date | `course_teach.teacher` : Age , Name , Teacher_ID , Hometown | `course_teach.course_arrange` : Teacher_ID , Course_ID , Grade


index       : 294
baseline pre: MATCH (T1:`course_teach.course`)-[T2:`course_teach.course_arrange ` ]-() WHERE T2.Curriculum = 'Mathematic' RETURN T1.Name
model1 pred : MATCH (T1:`course_teach.course`)-[T2:`course_teach.course_arrange ` ]-(T3:`course_teach.teacher`) WHERE T3.Course = 'Math' RETURN T1.Name
ground query: MATCH (T2:`course_teach.course`)-[T1:`course_teach.course_arrange`]-(T3:`course_teach.teacher`) WHERE T2.Course = 'Math' RETURN T3.Name
NLQ         : What are the names of the people who teach math courses?
Schema      : | course_teach | `course_teach.course` : Course ( Math ) , Course_ID , Staring_Date | `course_teach.teacher` : Age , Name , Teacher_ID , Hometown | `course_teach.course_arrange` : Teacher_ID , Course_ID , Grade


index       : 295
baseline pre: MATCH (T1:`course_teach.teacher`)-[T2:`course_teach.course_arrange ` ]-() RETURN T1.Name,count(*)
model1 pred : MATCH (T1:`course_teach.course`)-[T2:`course_teach.course_arrange ` ]-() RETURN T1.Name,count(*)
ground query: MATCH (T2:`course_teach.teacher`)-[T1:`course_teach.course_arrange`]-() RETURN T2.Name,count(*)
NLQ         : Show names of teachers and the number of courses they teach.
Schema      : | course_teach | `course_teach.course` : Course , Course_ID , Staring_Date | `course_teach.teacher` : Age , Name , Teacher_ID , Hometown | `course_teach.course_arrange` : Teacher_ID , Course_ID , Grade


index       : 296
baseline pre: MATCH (T1:`course_teach.teacher`)-[T2:`course_teach.course_arrange ` ]-() RETURN T1.Name,count(*)
model1 pred : MATCH (T1:`course_teach.course`)-[T2:`course_teach.course_arrange ` ]-() RETURN T1.Name,count(*)
ground query: MATCH (T2:`course_teach.teacher`)-[T1:`course_teach.course_arrange`]-() RETURN T2.Name,count(*)
NLQ         : What are the names of the teachers and how many courses do they teach?
Schema      : | course_teach | `course_teach.course` : Course , Course_ID , Staring_Date | `course_teach.teacher` : Age , Name , Teacher_ID , Hometown | `course_teach.course_arrange` : Teacher_ID , Course_ID , Grade


index       : 297
baseline pre: MATCH (T1:`course_teach.teacher`)-[T2:`course_teach.course_arrange ` ]-() WITH T1.Name AS Name, count(*) AS count WHERE count >= 2 RETURN Name
model1 pred : MATCH (T1:`course_teach.teacher`)-[T2:`course_teach.course_arrange ` ]-() WITH count(*) AS count, T1.Name AS Name WHERE count >= 2 RETURN Name
ground query: MATCH (T2:`course_teach.teacher`)-[T1:`course_teach.course_arrange`]-() WITH T2.Name AS Name, count(*) AS count WHERE count  >= 2 RETURN Name
NLQ         : Show names of teachers that teach at least two courses.
Schema      : | course_teach | `course_teach.course` : Course , Course_ID , Staring_Date | `course_teach.teacher` : Age , Name , Teacher_ID , Hometown | `course_teach.course_arrange` : Teacher_ID , Course_ID , Grade


index       : 298
baseline pre: MATCH (T1:`course_teach.teacher`)-[T2:`course_teach.course_arrange ` ]-() WITH count(*) AS count, T1.Name AS Name WHERE count >= 2 RETURN Name
model1 pred : MATCH (T1:`course_teach.teacher`)-[T2:`course_teach.course_arrange ` ]-() WITH count(*) AS count, T1.Name AS Name WHERE count >= 2 RETURN Name
ground query: MATCH (T2:`course_teach.teacher`)-[T1:`course_teach.course_arrange`]-() WITH T2.Name AS Name, count(*) AS count WHERE count  >= 2 RETURN Name
NLQ         : What are the names of the teachers who teach at least two courses?
Schema      : | course_teach | `course_teach.course` : Course , Course_ID , Staring_Date | `course_teach.teacher` : Age , Name , Teacher_ID , Hometown | `course_teach.course_arrange` : Teacher_ID , Course_ID , Grade


index       : 299
baseline pre: MATCH (visitor:`museum_visit.visitor`) WHERE visitor.Age  < 30 RETURN count(*)
model1 pred : MATCH (visitor:`museum_visit.visitor`) WHERE visitor.Age ` 30 RETURN count(*)
ground query: MATCH (visitor:`museum_visit.visitor`) WHERE visitor.Age < 30 RETURN count(*)
NLQ         : How many visitors below age 30 are there?
Schema      : | museum_visit | `museum_visit.museum` : Name , Museum_ID , Open_Year , Num_of_Staff | `museum_visit.visitor` : Age , Name , Level_of_membership , ID | `museum_visit.visit` : Total_spent , Museum_ID , Num_of_Ticket , visitor_ID


index       : 300
baseline pre: MATCH (visitor:`museum_visit.visitor`) WHERE visitor.Level_of_membership > 4 RETURN visitor.Name ORDER BY visitor.Level_of_membership
model1 pred : MATCH (visitor:`museum_visit.visitor`) WHERE visitor.Level_of_membership > 4 RETURN visitor.Name ORDER BY visitor.Level_of_membership DESC
ground query: MATCH (visitor:`museum_visit.visitor`) WHERE visitor.Level_of_membership > 4 RETURN visitor.Name ORDER BY visitor.Level_of_membership DESC
NLQ         : Find the names of the visitors whose membership level is higher than 4, and order the results by the level from high to low.
Schema      : | museum_visit | `museum_visit.museum` : Name , Museum_ID , Open_Year , Num_of_Staff | `museum_visit.visitor` : Age , Name , Level_of_membership , ID | `museum_visit.visit` : Total_spent , Museum_ID , Num_of_Ticket , visitor_ID


index       : 301
baseline pre: MATCH (visitor:`museum_visit.visitor`) WHERE visitor.Level_of_membership  < 4 RETURN avg(visitor.Age)
model1 pred : MATCH (visitor:`museum_visit.visitor`) WHERE visitor.Level_of_membership ` 4 RETURN avg(visitor.Age)
ground query: MATCH (visitor:`museum_visit.visitor`) WHERE visitor.Level_of_membership <= 4 RETURN avg(visitor.Age)
NLQ         : What is the average age of the visitors whose membership level is not higher than 4?
Schema      : | museum_visit | `museum_visit.museum` : Name , Museum_ID , Open_Year , Num_of_Staff | `museum_visit.visitor` : Age , Name , Level_of_membership , ID | `museum_visit.visit` : Total_spent , Museum_ID , Num_of_Ticket , visitor_ID


index       : 304
baseline pre: MATCH (museum:`museum_visit.museum`) WHERE museum.Open_Year  < 2009 RETURN avg(museum.Num_of_Staff)
model1 pred : MATCH (museum:`museum_visit.museum`) WHERE museum.Open_Year ` 2009 RETURN avg(museum.Num_of_Staff)
ground query: MATCH (museum:`museum_visit.museum`) WHERE museum.Open_Year < '2009' RETURN avg(museum.Num_of_Staff)
NLQ         : Find the average number of staff working for the museums that were open before 2009.
Schema      : | museum_visit | `museum_visit.museum` : Name , Museum_ID , Open_Year , Num_of_Staff | `museum_visit.visitor` : Age , Name , Level_of_membership , ID | `museum_visit.visit` : Total_spent , Museum_ID , Num_of_Ticket , visitor_ID


index       : 305
baseline pre: MATCH (museum:`museum_visit.museum`) WHERE museum.Name = 'Plaza Museum' RETURN museum.Open_Year,museum.Num_of_Staff
model1 pred : MATCH (museum:`museum_visit.museum`) WHERE museum.Name = 'Plaza Museum' RETURN museum.Open_Year,museum.Num_of_Staff
ground query: MATCH (museum:`museum_visit.museum`) WHERE museum.Name = 'Plaza Museum' RETURN museum.Num_of_Staff,museum.Open_Year
NLQ         : What are the opening year and staff number of the museum named Plaza Museum?
Schema      : | museum_visit | `museum_visit.museum` : Name ( Plaza Museum ) , Museum_ID , Open_Year , Num_of_Staff | `museum_visit.visitor` : Age , Name , Level_of_membership , ID | `museum_visit.visit` : Total_spent , Museum_ID , Num_of_Ticket , visitor_ID


index       : 306
baseline pre: MATCH (visitor:`museum_visit.visitor`) WITH count(*) AS count, visitor.Name AS Name, visitor.Age AS Age WHERE count > 1 RETURN ID,Name,Age
model1 pred : MATCH (visitor:`museum_visit.visitor`) WITH count(*) AS count, visitor.Name AS Name, visitor.ID AS Museum_ID WHERE count > 1 RETURN ID,Name,Age
ground query: MATCH (t1:`museum_visit.visitor`)-[t2:`museum_visit.visit`]-() WITH count(*) AS count, t1.ID AS ID, t1.Name AS Name, t1.Age AS Age WHERE count  > 1 RETURN ID,Name,Age
NLQ         : find the id, name and age for visitors who visited some museums more than once.
Schema      : | museum_visit | `museum_visit.museum` : Name , Museum_ID , Open_Year , Num_of_Staff | `museum_visit.visitor` : Age , Name , Level_of_membership , ID | `museum_visit.visit` : Total_spent , Museum_ID , Num_of_Ticket , visitor_ID


index       : 307
baseline pre: MATCH (visitor:`museum_visit.visitor`) RETURN visitor.Name,visitor.Age ORDER BY visitor.Num_of_Ticket DESC LIMIT 1
model1 pred : MATCH (visitor:`museum_visit.visitor`) RETURN visitor.Name,visitor.Age ORDER BY visitor.Num_of_Ticket DESC LIMIT 1
ground query: MATCH (t1:`museum_visit.visitor`)-[t2:`museum_visit.visit`]-() RETURN t1.Name,t1.Age ORDER BY t2.Num_of_Ticket DESC LIMIT 1
NLQ         : Find the name and age of the visitor who bought the most tickets at once.
Schema      : | museum_visit | `museum_visit.museum` : Name , Museum_ID , Open_Year , Num_of_Staff | `museum_visit.visitor` : Age , Name , Level_of_membership , ID | `museum_visit.visit` : Total_spent , Museum_ID , Num_of_Ticket , visitor_ID


index       : 308
baseline pre: MATCH (museum:`museum_visit.museum`) WHERE museum.Open_Year > 2013 OR museum.Open_Year  < 2008 RETURN count(*)
model1 pred : MATCH (museum:`museum_visit.museum`) WHERE museum.Open_Year > 2013 OR museum.Open_Year ` 2008 RETURN count(*)
ground query: MATCH (museum:`museum_visit.museum`) WHERE museum.Open_Year > '2013' OR museum.Open_Year < '2008' RETURN count(*)
NLQ         : How many museums were opened after 2013 or before 2008?
Schema      : | museum_visit | `museum_visit.museum` : Name , Museum_ID , Open_Year , Num_of_Staff | `museum_visit.visitor` : Age , Name , Level_of_membership , ID | `museum_visit.visit` : Total_spent , Museum_ID , Num_of_Ticket , visitor_ID


index       : 311
baseline pre: MATCH (battle:`battle_death.battle`) RETURN battle.name,battle.date,battle.result
model1 pred : MATCH (battle:`battle_death.battle`) RETURN battle.name,battle.date,battle.result
ground query: MATCH (battle:`battle_death.battle`) RETURN battle.name,battle.date
NLQ         : List the name, date and result of each battle.
Schema      : | battle_death | `battle_death.battle` : name , id , bulgarian_commander , result , latin_commander , date | `battle_death.ship` : name , id , disposition_of_ship , ship_type , location , lost_in_battle , tonnage | `battle_death.death` : id , caused_by_ship_id , injured , killed , note | `battle_death.ship_HAS_battle_death.battle` :  | `battle_death.death_HAS_battle_death.ship` :


index       : 312
baseline pre: MATCH (death:`battle_death.death`) RETURN max(death.toll),min(death.toll),death.caused_by_ship
model1 pred : MATCH (death:`battle_death.death`) RETURN max(death.tonnage),min(death.tonnage),death.killed
ground query: MATCH (death:`battle_death.death`) RETURN max(death.killed),min(death.killed)
NLQ         : What is maximum and minimum death toll caused each time?
Schema      : | battle_death | `battle_death.battle` : name , id , bulgarian_commander , result , latin_commander , date | `battle_death.ship` : name , id , disposition_of_ship , ship_type , location , lost_in_battle , tonnage | `battle_death.death` : id , caused_by_ship_id , injured , killed , note | `battle_death.ship_HAS_battle_death.battle` :  | `battle_death.death_HAS_battle_death.ship` :


index       : 313
baseline pre: MATCH (battle:`battle_death.battle`) WHERE battle.bulgar_commander  < > 'Boril' RETURN battle.name,battle.result
model1 pred : MATCH (battle:`battle_death.battle`) WHERE battle.bulgararian_commander ` > 'Boril' RETURN battle.name,battle.result
ground query: MATCH (battle:`battle_death.battle`) WHERE battle.bulgarian_commander <> 'Boril' RETURN battle.name,battle.result
NLQ         : What are the name and results of the battles when the bulgarian commander is not 'Boril'
Schema      : | battle_death | `battle_death.battle` : name , id , bulgarian_commander ( Boril ) , result , latin_commander , date | `battle_death.ship` : name , id , disposition_of_ship , ship_type , location , lost_in_battle , tonnage | `battle_death.death` : id , caused_by_ship_id , injured , killed , note | `battle_death.ship_HAS_battle_death.battle` :  | `battle_death.death_HAS_battle_death.ship` :


index       : 315
baseline pre: MATCH (battle:`battle_death.battle`) WHERE battle.bulgaric_commander = 'Kaloyan' AND battle.latin_commander = 'Baldwin I' RETURN DISTINCT battle.name
model1 pred : MATCH (battle:`battle_death.battle`) WHERE battle.bulgar_commander = 'Kaloyan' AND battle.latin_commander = 'Baldwin I' RETURN DISTINCT battle.name
ground query: MATCH (battle:`battle_death.battle`) WHERE battle.bulgarian_commander = 'Kaloyan' AND battle.latin_commander = 'Baldwin I' RETURN battle.name
NLQ         : What are the distinct battle names which are between bulgarian commander 'Kaloyan' and latin commander 'Baldwin I'?
Schema      : | battle_death | `battle_death.battle` : name , id , bulgarian_commander ( Kaloyan ) , result , latin_commander ( Baldwin I ) , date | `battle_death.ship` : name , id , disposition_of_ship , ship_type , location , lost_in_battle , tonnage | `battle_death.death` : id , caused_by_ship_id , injured , killed , note | `battle_death.ship_HAS_battle_death.battle` :  | `battle_death.death_HAS_battle_death.ship` :


index       : 317
baseline pre: MATCH (death:`battle_death.death`) WHERE death.death ='.*[E|e]nt.*' RETURN death.note
model1 pred : MATCH (T1:`battle_death.death`)-[]-(T2:`battle_death.ship`) WHERE T2.substring = 'East' RETURN T1.note
ground query: MATCH (death:`battle_death.death`) WHERE death.note =~'.*[E|e]ast.*' RETURN death.note
NLQ         : What are the notes of the death events which has substring 'East'?
Schema      : | battle_death | `battle_death.battle` : name , id , bulgarian_commander , result , latin_commander , date | `battle_death.ship` : name , id , disposition_of_ship , ship_type , location , lost_in_battle , tonnage | `battle_death.death` : id , caused_by_ship_id , injured , killed , note | `battle_death.ship_HAS_battle_death.battle` :  | `battle_death.death_HAS_battle_death.ship` :


index       : 318
baseline pre: MATCH (addresses:`student_transcripts_tracking.Addresses`) WHERE addresses.line_1=addresses.line_2=1 RETURN addresses.address_id
model1 pred : MATCH (addresses:`student_transcripts_tracking.Addresses`) WHERE addresses.line_1 and addresses.line_2 RETURN addresses.address_id
ground query: MATCH (addresses:`student_transcripts_tracking.Addresses`) RETURN addresses.line_1,addresses.line_2
NLQ         : what are all the addresses including line 1 and line 2?
Schema      : | student_transcripts_tracking | `student_transcripts_tracking.Addresses` : city , line_2 , state_province_county , country , address_id , zip_postcode , line_1 | `student_transcripts_tracking.Courses` : course_description , course_id , course_name | `student_transcripts_tracking.Departments` : department_description , department_name , department_id | `student_transcripts_tracking.Degree_Programs` : degree_summary_name , degree_program_id , department_id , degree_summary_description | `student_transcripts_tracking.Sections` : section_id , course_id , section_name , section_description | `student_transcripts_tracking.Semesters` : semester_id , semester_description , semester_name | `student_transcripts_tracking.Students` : ssn , cell_mobile_number , last_name , first_name , date_first_registered , current_address_id , middle_name , email_address , date_left , student_id , other_student_details , permanent_address_id | `student_transcripts_tracking.Student_Enrolment` : semester_id , degree_program_id , student_enrolment_id , student_id | `student_transcripts_tracking.Student_Enrolment_Courses` : student_course_id , course_id , student_enrolment_id | `student_transcripts_tracking.Transcripts` : transcript_date , transcript_id | `student_transcripts_tracking.Transcript_Contents` : student_course_id , transcript_id | `student_transcripts_tracking.degree_programs_HAS_student_transcripts_tracking.departments` :  | `student_transcripts_tracking.sections_HAS_student_transcripts_tracking.courses` :  | `student_transcripts_tracking.students_HAS_student_transcripts_tracking.addresses` :  | `student_transcripts_tracking.student_enrolment_HAS_student_transcripts_tracking.students` :  | `student_transcripts_tracking.student_enrolment_courses_HAS_student_transcripts_tracking.student_enrolment` :


index       : 322
baseline pre: MATCH (courses:`student_transcripts_tracking.Courses`) WHERE courses.course_name ='math' RETURN courses.course_description
model1 pred : MATCH (courses:`student_transcripts_tracking.Courses`) WHERE courses.course_name = "math" RETURN courses.course_description
ground query: MATCH (courses:`student_transcripts_tracking.Courses`) WHERE courses.course_name = 'math' RETURN courses.course_description
NLQ         : How is the math course described?
Schema      : | student_transcripts_tracking | `student_transcripts_tracking.Addresses` : city , line_2 , state_province_county , country , address_id , zip_postcode , line_1 | `student_transcripts_tracking.Courses` : course_description , course_id , course_name ( math ) | `student_transcripts_tracking.Departments` : department_description , department_name ( math ) , department_id | `student_transcripts_tracking.Degree_Programs` : degree_summary_name , degree_program_id , department_id , degree_summary_description | `student_transcripts_tracking.Sections` : section_id , course_id , section_name , section_description | `student_transcripts_tracking.Semesters` : semester_id , semester_description , semester_name | `student_transcripts_tracking.Students` : ssn , cell_mobile_number , last_name , first_name , date_first_registered , current_address_id , middle_name , email_address , date_left , student_id , other_student_details , permanent_address_id | `student_transcripts_tracking.Student_Enrolment` : semester_id , degree_program_id , student_enrolment_id , student_id | `student_transcripts_tracking.Student_Enrolment_Courses` : student_course_id , course_id , student_enrolment_id | `student_transcripts_tracking.Transcripts` : transcript_date , transcript_id | `student_transcripts_tracking.Transcript_Contents` : student_course_id , transcript_id | `student_transcripts_tracking.degree_programs_HAS_student_transcripts_tracking.departments` :  | `student_transcripts_tracking.sections_HAS_student_transcripts_tracking.courses` :  | `student_transcripts_tracking.students_HAS_student_transcripts_tracking.addresses` :  | `student_transcripts_tracking.student_enrolment_HAS_student_transcripts_tracking.students` :  | `student_transcripts_tracking.student_enrolment_courses_HAS_student_transcripts_tracking.student_enrolment` :


index       : 323
baseline pre: MATCH (courses:`student_transcripts_tracking.Courses`) WHERE courses.course_name ='math' RETURN courses.course_description
model1 pred : MATCH (courses:`student_transcripts_tracking.Courses`) WHERE courses.course_name ='math' RETURN courses.course_description
ground query: MATCH (courses:`student_transcripts_tracking.Courses`) WHERE courses.course_name = 'math' RETURN courses.course_description
NLQ         : What are the descriptions for all the math courses?
Schema      : | student_transcripts_tracking | `student_transcripts_tracking.Addresses` : city , line_2 , state_province_county , country , address_id , zip_postcode , line_1 | `student_transcripts_tracking.Courses` : course_description , course_id , course_name ( math ) | `student_transcripts_tracking.Departments` : department_description , department_name ( math ) , department_id | `student_transcripts_tracking.Degree_Programs` : degree_summary_name , degree_program_id , department_id , degree_summary_description | `student_transcripts_tracking.Sections` : section_id , course_id , section_name , section_description | `student_transcripts_tracking.Semesters` : semester_id , semester_description , semester_name | `student_transcripts_tracking.Students` : ssn , cell_mobile_number , last_name , first_name , date_first_registered , current_address_id , middle_name , email_address , date_left , student_id , other_student_details , permanent_address_id | `student_transcripts_tracking.Student_Enrolment` : semester_id , degree_program_id , student_enrolment_id , student_id | `student_transcripts_tracking.Student_Enrolment_Courses` : student_course_id , course_id , student_enrolment_id | `student_transcripts_tracking.Transcripts` : transcript_date , transcript_id | `student_transcripts_tracking.Transcript_Contents` : student_course_id , transcript_id | `student_transcripts_tracking.degree_programs_HAS_student_transcripts_tracking.departments` :  | `student_transcripts_tracking.sections_HAS_student_transcripts_tracking.courses` :  | `student_transcripts_tracking.students_HAS_student_transcripts_tracking.addresses` :  | `student_transcripts_tracking.student_enrolment_HAS_student_transcripts_tracking.students` :  | `student_transcripts_tracking.student_enrolment_courses_HAS_student_transcripts_tracking.student_enrolment` :


index       : 326
baseline pre: MATCH (departments:`student_transcripts_tracking.Departments`) RETURN count(DISTINCT departments.department_id)
model1 pred : MATCH (T1:`student_transcripts_tracking.Departments`)-[T2:`student_transcripts_tracking.Degree_Programs ` ]-() RETURN count(DISTINCT T1.department_name)
ground query: MATCH (degree_programs:`student_transcripts_tracking.Degree_Programs`) RETURN count(DISTINCT degree_programs.department_id)
NLQ         : How many departments offer any degree?
Schema      : | student_transcripts_tracking | `student_transcripts_tracking.Addresses` : city , line_2 , state_province_county , country , address_id , zip_postcode , line_1 | `student_transcripts_tracking.Courses` : course_description , course_id , course_name | `student_transcripts_tracking.Departments` : department_description , department_name , department_id | `student_transcripts_tracking.Degree_Programs` : degree_summary_name , degree_program_id , department_id , degree_summary_description | `student_transcripts_tracking.Sections` : section_id , course_id , section_name , section_description | `student_transcripts_tracking.Semesters` : semester_id , semester_description , semester_name | `student_transcripts_tracking.Students` : ssn , cell_mobile_number , last_name , first_name , date_first_registered , current_address_id , middle_name , email_address , date_left , student_id , other_student_details , permanent_address_id | `student_transcripts_tracking.Student_Enrolment` : semester_id , degree_program_id , student_enrolment_id , student_id | `student_transcripts_tracking.Student_Enrolment_Courses` : student_course_id , course_id , student_enrolment_id | `student_transcripts_tracking.Transcripts` : transcript_date , transcript_id | `student_transcripts_tracking.Transcript_Contents` : student_course_id , transcript_id | `student_transcripts_tracking.degree_programs_HAS_student_transcripts_tracking.departments` :  | `student_transcripts_tracking.sections_HAS_student_transcripts_tracking.courses` :  | `student_transcripts_tracking.students_HAS_student_transcripts_tracking.addresses` :  | `student_transcripts_tracking.student_enrolment_HAS_student_transcripts_tracking.students` :  | `student_transcripts_tracking.student_enrolment_courses_HAS_student_transcripts_tracking.student_enrolment` :


index       : 327
baseline pre: MATCH (departments:`student_transcripts_tracking.Departments`) RETURN count(DISTINCT departments.department_id)
model1 pred : MATCH (T1:`student_transcripts_tracking.Departments`)-[T2:`student_transcripts_tracking.Degree_Programs ` ]-() RETURN count(DISTINCT T1.department_name)
ground query: MATCH (degree_programs:`student_transcripts_tracking.Degree_Programs`) RETURN count(DISTINCT degree_programs.department_id)
NLQ         : How many different departments offer degrees?
Schema      : | student_transcripts_tracking | `student_transcripts_tracking.Addresses` : city , line_2 , state_province_county , country , address_id , zip_postcode , line_1 | `student_transcripts_tracking.Courses` : course_description , course_id , course_name | `student_transcripts_tracking.Departments` : department_description , department_name , department_id | `student_transcripts_tracking.Degree_Programs` : degree_summary_name , degree_program_id , department_id , degree_summary_description | `student_transcripts_tracking.Sections` : section_id , course_id , section_name , section_description | `student_transcripts_tracking.Semesters` : semester_id , semester_description , semester_name | `student_transcripts_tracking.Students` : ssn , cell_mobile_number , last_name , first_name , date_first_registered , current_address_id , middle_name , email_address , date_left , student_id , other_student_details , permanent_address_id | `student_transcripts_tracking.Student_Enrolment` : semester_id , degree_program_id , student_enrolment_id , student_id | `student_transcripts_tracking.Student_Enrolment_Courses` : student_course_id , course_id , student_enrolment_id | `student_transcripts_tracking.Transcripts` : transcript_date , transcript_id | `student_transcripts_tracking.Transcript_Contents` : student_course_id , transcript_id | `student_transcripts_tracking.degree_programs_HAS_student_transcripts_tracking.departments` :  | `student_transcripts_tracking.sections_HAS_student_transcripts_tracking.courses` :  | `student_transcripts_tracking.students_HAS_student_transcripts_tracking.addresses` :  | `student_transcripts_tracking.student_enrolment_HAS_student_transcripts_tracking.students` :  | `student_transcripts_tracking.student_enrolment_courses_HAS_student_transcripts_tracking.student_enrolment` :


index       : 329
baseline pre: MATCH (degree_programs:`student_transcripts_tracking.Degree_Programs`) RETURN count(DISTINCT degree_programs.degree_program_id)
model1 pred : MATCH (degree_programs:`student_transcripts_tracking.Degree_Programs`) RETURN count(DISTINCT degree_programs.degree_summary_name)
ground query: MATCH (degree_programs:`student_transcripts_tracking.Degree_Programs`) RETURN count(DISTINCT degree_programs.degree_summary_name)
NLQ         : How many different degrees are offered?
Schema      : | student_transcripts_tracking | `student_transcripts_tracking.Addresses` : city , line_2 , state_province_county , country , address_id , zip_postcode , line_1 | `student_transcripts_tracking.Courses` : course_description , course_id , course_name | `student_transcripts_tracking.Departments` : department_description , department_name , department_id | `student_transcripts_tracking.Degree_Programs` : degree_summary_name , degree_program_id , department_id , degree_summary_description | `student_transcripts_tracking.Sections` : section_id , course_id , section_name , section_description | `student_transcripts_tracking.Semesters` : semester_id , semester_description , semester_name | `student_transcripts_tracking.Students` : ssn , cell_mobile_number , last_name , first_name , date_first_registered , current_address_id , middle_name , email_address , date_left , student_id , other_student_details , permanent_address_id | `student_transcripts_tracking.Student_Enrolment` : semester_id , degree_program_id , student_enrolment_id , student_id | `student_transcripts_tracking.Student_Enrolment_Courses` : student_course_id , course_id , student_enrolment_id | `student_transcripts_tracking.Transcripts` : transcript_date , transcript_id | `student_transcripts_tracking.Transcript_Contents` : student_course_id , transcript_id | `student_transcripts_tracking.degree_programs_HAS_student_transcripts_tracking.departments` :  | `student_transcripts_tracking.sections_HAS_student_transcripts_tracking.courses` :  | `student_transcripts_tracking.students_HAS_student_transcripts_tracking.addresses` :  | `student_transcripts_tracking.student_enrolment_HAS_student_transcripts_tracking.students` :  | `student_transcripts_tracking.student_enrolment_courses_HAS_student_transcripts_tracking.student_enrolment` :


index       : 330
baseline pre: MATCH (department:`student_transcripts_tracking.Department`) WHERE department.department_id = 'engineering' RETURN count(DISTINCT department.degree_program_id)
model1 pred : MATCH (departments:`student_transcripts_tracking.Departments`) WHERE departments.degree_program_id = 'engineering' RETURN count(DISTINCT departments.department_id)
ground query: MATCH (T1:`student_transcripts_tracking.Departments`)-[]-(T2:`student_transcripts_tracking.Degree_Programs`) WHERE T1.department_name = 'engineer' RETURN count(*)
NLQ         : How many degrees does the engineering department offer?
Schema      : | student_transcripts_tracking | `student_transcripts_tracking.Addresses` : city , line_2 , state_province_county , country , address_id , zip_postcode , line_1 | `student_transcripts_tracking.Courses` : course_description , course_id , course_name | `student_transcripts_tracking.Departments` : department_description , department_name , department_id | `student_transcripts_tracking.Degree_Programs` : degree_summary_name , degree_program_id , department_id , degree_summary_description | `student_transcripts_tracking.Sections` : section_id , course_id , section_name , section_description | `student_transcripts_tracking.Semesters` : semester_id , semester_description , semester_name | `student_transcripts_tracking.Students` : ssn , cell_mobile_number , last_name , first_name , date_first_registered , current_address_id , middle_name , email_address , date_left , student_id , other_student_details , permanent_address_id | `student_transcripts_tracking.Student_Enrolment` : semester_id , degree_program_id , student_enrolment_id , student_id | `student_transcripts_tracking.Student_Enrolment_Courses` : student_course_id , course_id , student_enrolment_id | `student_transcripts_tracking.Transcripts` : transcript_date , transcript_id | `student_transcripts_tracking.Transcript_Contents` : student_course_id , transcript_id | `student_transcripts_tracking.degree_programs_HAS_student_transcripts_tracking.departments` :  | `student_transcripts_tracking.sections_HAS_student_transcripts_tracking.courses` :  | `student_transcripts_tracking.students_HAS_student_transcripts_tracking.addresses` :  | `student_transcripts_tracking.student_enrolment_HAS_student_transcripts_tracking.students` :  | `student_transcripts_tracking.student_enrolment_courses_HAS_student_transcripts_tracking.student_enrolment` :


index       : 331
baseline pre: MATCH (departments:`student_transcripts_tracking.Departments`) WHERE departments.degree_program_id = 'engineering' RETURN count(*)
model1 pred : MATCH (departments:`student_transcripts_tracking.Departments`) WHERE departments.degree_program_id = 'engineering' RETURN count(DISTINCT departments.department_id)
ground query: MATCH (T1:`student_transcripts_tracking.Departments`)-[]-(T2:`student_transcripts_tracking.Degree_Programs`) WHERE T1.department_name = 'engineer' RETURN count(*)
NLQ         : How many degrees does the engineering department have?
Schema      : | student_transcripts_tracking | `student_transcripts_tracking.Addresses` : city , line_2 , state_province_county , country , address_id , zip_postcode , line_1 | `student_transcripts_tracking.Courses` : course_description , course_id , course_name | `student_transcripts_tracking.Departments` : department_description , department_name , department_id | `student_transcripts_tracking.Degree_Programs` : degree_summary_name , degree_program_id , department_id , degree_summary_description | `student_transcripts_tracking.Sections` : section_id , course_id , section_name , section_description | `student_transcripts_tracking.Semesters` : semester_id , semester_description , semester_name | `student_transcripts_tracking.Students` : ssn , cell_mobile_number , last_name , first_name , date_first_registered , current_address_id , middle_name , email_address , date_left , student_id , other_student_details , permanent_address_id | `student_transcripts_tracking.Student_Enrolment` : semester_id , degree_program_id , student_enrolment_id , student_id | `student_transcripts_tracking.Student_Enrolment_Courses` : student_course_id , course_id , student_enrolment_id | `student_transcripts_tracking.Transcripts` : transcript_date , transcript_id | `student_transcripts_tracking.Transcript_Contents` : student_course_id , transcript_id | `student_transcripts_tracking.degree_programs_HAS_student_transcripts_tracking.departments` :  | `student_transcripts_tracking.sections_HAS_student_transcripts_tracking.courses` :  | `student_transcripts_tracking.students_HAS_student_transcripts_tracking.addresses` :  | `student_transcripts_tracking.student_enrolment_HAS_student_transcripts_tracking.students` :  | `student_transcripts_tracking.student_enrolment_courses_HAS_student_transcripts_tracking.student_enrolment` :


index       : 334
baseline pre: MATCH (T1:`student_transcripts_tracking.Courses`)-[]-(T2:`student_transcripts_tracking.Student_Enrolment_Courses`) WITH count(*) AS count, T1.course_name AS course_name, T1.course_id AS course_id WHERE count  < = 2 RETURN course_name,course_id
model1 pred : MATCH (T1:`student_transcripts_tracking.Courses`)-[T2:`student_transcripts_tracking.Student_Enrolment_Courses ` ]-() WITH count(*) AS count, T1.course_name AS course_name, T1.course_id AS course_id WHERE count ` 2 RETURN course_name,course_id
ground query: MATCH (T1:`student_transcripts_tracking.Courses`)-[]-(T2:`student_transcripts_tracking.Sections`) WITH count(*) AS count, T1.course_id AS course_id, T1.course_name AS course_name WHERE count  <= 2 RETURN course_name,course_id
NLQ         : What are the names and id of courses having at most 2 sections?
Schema      : | student_transcripts_tracking | `student_transcripts_tracking.Addresses` : city , line_2 , state_province_county , country , address_id , zip_postcode , line_1 | `student_transcripts_tracking.Courses` : course_description , course_id , course_name | `student_transcripts_tracking.Departments` : department_description , department_name , department_id | `student_transcripts_tracking.Degree_Programs` : degree_summary_name , degree_program_id , department_id , degree_summary_description | `student_transcripts_tracking.Sections` : section_id , course_id , section_name , section_description | `student_transcripts_tracking.Semesters` : semester_id , semester_description , semester_name | `student_transcripts_tracking.Students` : ssn , cell_mobile_number , last_name , first_name , date_first_registered , current_address_id , middle_name , email_address , date_left , student_id , other_student_details , permanent_address_id | `student_transcripts_tracking.Student_Enrolment` : semester_id , degree_program_id , student_enrolment_id , student_id | `student_transcripts_tracking.Student_Enrolment_Courses` : student_course_id , course_id , student_enrolment_id | `student_transcripts_tracking.Transcripts` : transcript_date , transcript_id | `student_transcripts_tracking.Transcript_Contents` : student_course_id , transcript_id | `student_transcripts_tracking.degree_programs_HAS_student_transcripts_tracking.departments` :  | `student_transcripts_tracking.sections_HAS_student_transcripts_tracking.courses` :  | `student_transcripts_tracking.students_HAS_student_transcripts_tracking.addresses` :  | `student_transcripts_tracking.student_enrolment_HAS_student_transcripts_tracking.students` :  | `student_transcripts_tracking.student_enrolment_courses_HAS_student_transcripts_tracking.student_enrolment` :


index       : 335
baseline pre: MATCH (T1:`student_transcripts_tracking.Courses`)-[]-(T2:`student_transcripts_tracking.Student_Enrolment_Courses`) WITH count(*) AS count, T1.course_name AS course_name, T1.course_id AS course_id WHERE count  < 2 RETURN course_name,course_id
model1 pred : MATCH (T1:`student_transcripts_tracking.Courses`)-[T2:`student_transcripts_tracking.Student_Enrolment_Courses ` ]-() WITH count(*) AS count, T1.course_name AS course_name, T1.course_id AS course_id WHERE count ` 2 RETURN course_name,course_id
ground query: MATCH (T1:`student_transcripts_tracking.Courses`)-[]-(T2:`student_transcripts_tracking.Sections`) WITH count(*) AS count, T1.course_id AS course_id, T1.course_name AS course_name WHERE count  <= 2 RETURN course_name,course_id
NLQ         : What are the names and ids of every course with less than 2 sections?
Schema      : | student_transcripts_tracking | `student_transcripts_tracking.Addresses` : city , line_2 , state_province_county , country , address_id , zip_postcode , line_1 | `student_transcripts_tracking.Courses` : course_description , course_id , course_name | `student_transcripts_tracking.Departments` : department_description , department_name , department_id | `student_transcripts_tracking.Degree_Programs` : degree_summary_name , degree_program_id , department_id , degree_summary_description | `student_transcripts_tracking.Sections` : section_id , course_id , section_name , section_description | `student_transcripts_tracking.Semesters` : semester_id , semester_description , semester_name | `student_transcripts_tracking.Students` : ssn , cell_mobile_number , last_name , first_name , date_first_registered , current_address_id , middle_name , email_address , date_left , student_id , other_student_details , permanent_address_id | `student_transcripts_tracking.Student_Enrolment` : semester_id , degree_program_id , student_enrolment_id , student_id | `student_transcripts_tracking.Student_Enrolment_Courses` : student_course_id , course_id , student_enrolment_id | `student_transcripts_tracking.Transcripts` : transcript_date , transcript_id | `student_transcripts_tracking.Transcript_Contents` : student_course_id , transcript_id | `student_transcripts_tracking.degree_programs_HAS_student_transcripts_tracking.departments` :  | `student_transcripts_tracking.sections_HAS_student_transcripts_tracking.courses` :  | `student_transcripts_tracking.students_HAS_student_transcripts_tracking.addresses` :  | `student_transcripts_tracking.student_enrolment_HAS_student_transcripts_tracking.students` :  | `student_transcripts_tracking.student_enrolment_courses_HAS_student_transcripts_tracking.student_enrolment` :


index       : 336
baseline pre: MATCH (sections:`student_transcripts_tracking.Sections`) RETURN sections.section_name ORDER BY sections.section_name
model1 pred : MATCH (sections:`student_transcripts_tracking.Sections`) RETURN sections.section_name ORDER BY sections.section_name
ground query: MATCH (sections:`student_transcripts_tracking.Sections`) RETURN sections.section_name ORDER BY sections.section_name DESC
NLQ         : List the section_name in reversed lexicographical order.
Schema      : | student_transcripts_tracking | `student_transcripts_tracking.Addresses` : city , line_2 , state_province_county , country , address_id , zip_postcode , line_1 | `student_transcripts_tracking.Courses` : course_description , course_id , course_name | `student_transcripts_tracking.Departments` : department_description , department_name , department_id | `student_transcripts_tracking.Degree_Programs` : degree_summary_name , degree_program_id , department_id , degree_summary_description | `student_transcripts_tracking.Sections` : section_id , course_id , section_name , section_description | `student_transcripts_tracking.Semesters` : semester_id , semester_description , semester_name | `student_transcripts_tracking.Students` : ssn , cell_mobile_number , last_name , first_name , date_first_registered , current_address_id , middle_name , email_address , date_left , student_id , other_student_details , permanent_address_id | `student_transcripts_tracking.Student_Enrolment` : semester_id , degree_program_id , student_enrolment_id , student_id | `student_transcripts_tracking.Student_Enrolment_Courses` : student_course_id , course_id , student_enrolment_id | `student_transcripts_tracking.Transcripts` : transcript_date , transcript_id | `student_transcripts_tracking.Transcript_Contents` : student_course_id , transcript_id | `student_transcripts_tracking.degree_programs_HAS_student_transcripts_tracking.departments` :  | `student_transcripts_tracking.sections_HAS_student_transcripts_tracking.courses` :  | `student_transcripts_tracking.students_HAS_student_transcripts_tracking.addresses` :  | `student_transcripts_tracking.student_enrolment_HAS_student_transcripts_tracking.students` :  | `student_transcripts_tracking.student_enrolment_courses_HAS_student_transcripts_tracking.student_enrolment` :


index       : 337
baseline pre: MATCH (sections:`student_transcripts_tracking.Sections`) RETURN sections.section_name ORDER BY sections.section_name
model1 pred : MATCH (sections:`student_transcripts_tracking.Sections`) RETURN sections.section_name ORDER BY sections.section_name DESC
ground query: MATCH (sections:`student_transcripts_tracking.Sections`) RETURN sections.section_name ORDER BY sections.section_name DESC
NLQ         : What are the names of the sections in reverse alphabetical order?
Schema      : | student_transcripts_tracking | `student_transcripts_tracking.Addresses` : city , line_2 , state_province_county , country , address_id , zip_postcode , line_1 | `student_transcripts_tracking.Courses` : course_description , course_id , course_name | `student_transcripts_tracking.Departments` : department_description , department_name , department_id | `student_transcripts_tracking.Degree_Programs` : degree_summary_name , degree_program_id , department_id , degree_summary_description | `student_transcripts_tracking.Sections` : section_id , course_id , section_name , section_description | `student_transcripts_tracking.Semesters` : semester_id , semester_description , semester_name | `student_transcripts_tracking.Students` : ssn , cell_mobile_number , last_name , first_name , date_first_registered , current_address_id , middle_name , email_address , date_left , student_id , other_student_details , permanent_address_id | `student_transcripts_tracking.Student_Enrolment` : semester_id , degree_program_id , student_enrolment_id , student_id | `student_transcripts_tracking.Student_Enrolment_Courses` : student_course_id , course_id , student_enrolment_id | `student_transcripts_tracking.Transcripts` : transcript_date , transcript_id | `student_transcripts_tracking.Transcript_Contents` : student_course_id , transcript_id | `student_transcripts_tracking.degree_programs_HAS_student_transcripts_tracking.departments` :  | `student_transcripts_tracking.sections_HAS_student_transcripts_tracking.courses` :  | `student_transcripts_tracking.students_HAS_student_transcripts_tracking.addresses` :  | `student_transcripts_tracking.student_enrolment_HAS_student_transcripts_tracking.students` :  | `student_transcripts_tracking.student_enrolment_courses_HAS_student_transcripts_tracking.student_enrolment` :


index       : 338
baseline pre: MATCH (student_enrolment:`student_transcripts_tracking.Student_Enrolment`) RETURN student_enrolment.semester_name,student_enrolment.student_id ORDER BY student_enrolment.date_first_registered DESC LIMIT 1
model1 pred : MATCH (student_enrolment:`student_transcripts_tracking.Student_Enrolment`) WITH student_enrolment.semester_name AS semester_name, count(student_enrolment.student_id) AS count WHERE count ` = 1 RETURN semester_name,student_enrolment.semester_id
ground query: MATCH (T1:`student_transcripts_tracking.Semesters`)-[]-(T2:`student_transcripts_tracking.Student_Enrolment`) WITH T1, count(T1.semester_id) AS cnt RETURN T1.semester_name,T1.semester_id ORDER BY cnt DESC LIMIT 1
NLQ         : What is the semester which most student registered in? Show both the name and the id.
Schema      : | student_transcripts_tracking | `student_transcripts_tracking.Addresses` : city , line_2 , state_province_county , country , address_id , zip_postcode , line_1 | `student_transcripts_tracking.Courses` : course_description , course_id , course_name | `student_transcripts_tracking.Departments` : department_description , department_name , department_id | `student_transcripts_tracking.Degree_Programs` : degree_summary_name , degree_program_id , department_id , degree_summary_description | `student_transcripts_tracking.Sections` : section_id , course_id , section_name , section_description | `student_transcripts_tracking.Semesters` : semester_id , semester_description , semester_name | `student_transcripts_tracking.Students` : ssn , cell_mobile_number , last_name , first_name , date_first_registered , current_address_id , middle_name , email_address , date_left , student_id , other_student_details , permanent_address_id | `student_transcripts_tracking.Student_Enrolment` : semester_id , degree_program_id , student_enrolment_id , student_id | `student_transcripts_tracking.Student_Enrolment_Courses` : student_course_id , course_id , student_enrolment_id | `student_transcripts_tracking.Transcripts` : transcript_date , transcript_id | `student_transcripts_tracking.Transcript_Contents` : student_course_id , transcript_id | `student_transcripts_tracking.degree_programs_HAS_student_transcripts_tracking.departments` :  | `student_transcripts_tracking.sections_HAS_student_transcripts_tracking.courses` :  | `student_transcripts_tracking.students_HAS_student_transcripts_tracking.addresses` :  | `student_transcripts_tracking.student_enrolment_HAS_student_transcripts_tracking.students` :  | `student_transcripts_tracking.student_enrolment_courses_HAS_student_transcripts_tracking.student_enrolment` :


index       : 339
baseline pre: MATCH (student_enrolment:`student_transcripts_tracking.Student_Enrolment`) RETURN student_enrolment.semester_name,student_enrolment.student_id ORDER BY student_enrolment.date_first_registered DESC LIMIT 1
model1 pred : MATCH (student_enrolment:`student_transcripts_tracking.Student_Enrolment`) RETURN students.semester_name,student_enrolment.semester_id ORDER BY students.date_first_registered DESC LIMIT 1
ground query: MATCH (T1:`student_transcripts_tracking.Semesters`)-[]-(T2:`student_transcripts_tracking.Student_Enrolment`) WITH T1, count(T1.semester_id) AS cnt RETURN T1.semester_name,T1.semester_id ORDER BY cnt DESC LIMIT 1
NLQ         : For each semester, what is the name and id of the one with the most students registered?
Schema      : | student_transcripts_tracking | `student_transcripts_tracking.Addresses` : city , line_2 , state_province_county , country , address_id , zip_postcode , line_1 | `student_transcripts_tracking.Courses` : course_description , course_id , course_name | `student_transcripts_tracking.Departments` : department_description , department_name , department_id | `student_transcripts_tracking.Degree_Programs` : degree_summary_name , degree_program_id , department_id , degree_summary_description | `student_transcripts_tracking.Sections` : section_id , course_id , section_name , section_description | `student_transcripts_tracking.Semesters` : semester_id , semester_description , semester_name | `student_transcripts_tracking.Students` : ssn , cell_mobile_number , last_name , first_name , date_first_registered , current_address_id , middle_name , email_address , date_left , student_id , other_student_details , permanent_address_id | `student_transcripts_tracking.Student_Enrolment` : semester_id , degree_program_id , student_enrolment_id , student_id | `student_transcripts_tracking.Student_Enrolment_Courses` : student_course_id , course_id , student_enrolment_id | `student_transcripts_tracking.Transcripts` : transcript_date , transcript_id | `student_transcripts_tracking.Transcript_Contents` : student_course_id , transcript_id | `student_transcripts_tracking.degree_programs_HAS_student_transcripts_tracking.departments` :  | `student_transcripts_tracking.sections_HAS_student_transcripts_tracking.courses` :  | `student_transcripts_tracking.students_HAS_student_transcripts_tracking.addresses` :  | `student_transcripts_tracking.student_enrolment_HAS_student_transcripts_tracking.students` :  | `student_transcripts_tracking.student_enrolment_courses_HAS_student_transcripts_tracking.student_enrolment` :


index       : 340
baseline pre: MATCH (t1:`student_transcripts_tracking.Departments`)-[t2:`student_transcripts_tracking.Departments_Department_Department_Department_Department_Department_Department_Department_Department_Department_Department_Department_Department_Department_Department_Department_Department_Department_Department_Department_department_department_department_department_description = 'computer' RETURN department_description
model1 pred : MATCH (T1:`student_transcripts_tracking.Departments`)-[]-(T2:`student_transcripts_tracking.Departments`) WHERE T1.department_name ='.*["|"]computer.*' RETURN T1.department_description
ground query: MATCH (departments:`student_transcripts_tracking.Departments`) WHERE departments.department_name =~'.*[C|c]omputer.*' RETURN departments.department_description
NLQ         : What is the description of the department whose name has the substring the computer?
Schema      : | student_transcripts_tracking | `student_transcripts_tracking.Addresses` : city , line_2 , state_province_county , country , address_id , zip_postcode , line_1 | `student_transcripts_tracking.Courses` : course_description , course_id , course_name | `student_transcripts_tracking.Departments` : department_description , department_name , department_id | `student_transcripts_tracking.Degree_Programs` : degree_summary_name , degree_program_id , department_id , degree_summary_description | `student_transcripts_tracking.Sections` : section_id , course_id , section_name , section_description | `student_transcripts_tracking.Semesters` : semester_id , semester_description , semester_name | `student_transcripts_tracking.Students` : ssn , cell_mobile_number , last_name , first_name , date_first_registered , current_address_id , middle_name , email_address , date_left , student_id , other_student_details , permanent_address_id | `student_transcripts_tracking.Student_Enrolment` : semester_id , degree_program_id , student_enrolment_id , student_id | `student_transcripts_tracking.Student_Enrolment_Courses` : student_course_id , course_id , student_enrolment_id | `student_transcripts_tracking.Transcripts` : transcript_date , transcript_id | `student_transcripts_tracking.Transcript_Contents` : student_course_id , transcript_id | `student_transcripts_tracking.degree_programs_HAS_student_transcripts_tracking.departments` :  | `student_transcripts_tracking.sections_HAS_student_transcripts_tracking.courses` :  | `student_transcripts_tracking.students_HAS_student_transcripts_tracking.addresses` :  | `student_transcripts_tracking.student_enrolment_HAS_student_transcripts_tracking.students` :  | `student_transcripts_tracking.student_enrolment_courses_HAS_student_transcripts_tracking.student_enrolment` :


index       : 341
baseline pre: MATCH (t1:`student_transcripts_tracking.Departments`)-[t2:`student_transcripts_tracking.Departments_Department_Department_Department_Department_Department_Department_Department_Department_Department_Department_Department_Department_Department_Department_Department_Department_Department_Department_Department_department_department_department_department_department_name = 'computer' RETURN department_description
model1 pred : MATCH (departments:`student_transcripts_tracking.Departments`) WHERE departments.department_name ='.*[Computer.*' RETURN departments.department_description
ground query: MATCH (departments:`student_transcripts_tracking.Departments`) WHERE departments.department_name =~'.*[C|c]omputer.*' RETURN departments.department_description
NLQ         : What is the department description for the one whose name has the word computer?
Schema      : | student_transcripts_tracking | `student_transcripts_tracking.Addresses` : city , line_2 , state_province_county , country , address_id , zip_postcode , line_1 | `student_transcripts_tracking.Courses` : course_description , course_id , course_name | `student_transcripts_tracking.Departments` : department_description , department_name , department_id | `student_transcripts_tracking.Degree_Programs` : degree_summary_name , degree_program_id , department_id , degree_summary_description | `student_transcripts_tracking.Sections` : section_id , course_id , section_name , section_description | `student_transcripts_tracking.Semesters` : semester_id , semester_description , semester_name | `student_transcripts_tracking.Students` : ssn , cell_mobile_number , last_name , first_name , date_first_registered , current_address_id , middle_name , email_address , date_left , student_id , other_student_details , permanent_address_id | `student_transcripts_tracking.Student_Enrolment` : semester_id , degree_program_id , student_enrolment_id , student_id | `student_transcripts_tracking.Student_Enrolment_Courses` : student_course_id , course_id , student_enrolment_id | `student_transcripts_tracking.Transcripts` : transcript_date , transcript_id | `student_transcripts_tracking.Transcript_Contents` : student_course_id , transcript_id | `student_transcripts_tracking.degree_programs_HAS_student_transcripts_tracking.departments` :  | `student_transcripts_tracking.sections_HAS_student_transcripts_tracking.courses` :  | `student_transcripts_tracking.students_HAS_student_transcripts_tracking.addresses` :  | `student_transcripts_tracking.student_enrolment_HAS_student_transcripts_tracking.students` :  | `student_transcripts_tracking.student_enrolment_courses_HAS_student_transcripts_tracking.student_enrolment` :


index       : 342
baseline pre: MATCH (student_enrolment:`student_transcripts_tracking.Student_Enrolment`) WITH count(*) AS count, student_enrolment.middle_name AS middle_name, student_enrolment.student_id AS student_enrolment_id WHERE count >= 2 RETURN first_name,middle_name,last_name,student_enrolment_id
model1 pred : MATCH (student_enrolment:`student_transcripts_tracking.Student_Enrolment`) WITH student_enrolment.first_name,student_enrolment.middle_name,student_enrolment.last_name AS last_name, count(*) AS count WHERE count = 2 RETURN first_name,middle_name,student_enrolment_id
ground query: MATCH (T1:`student_transcripts_tracking.Students`)-[]-(T2:`student_transcripts_tracking.Student_Enrolment`) WITH T1.first_name AS first_name, T1.middle_name AS middle_name, T1.last_name AS last_name, T1.student_id AS student_id, count(*) AS count WHERE count  = 2 RETURN first_name,middle_name,last_name,student_id
NLQ         : Who are enrolled in 2 degree programs in one semester? List the first name, middle name and last name and the id.
Schema      : | student_transcripts_tracking | `student_transcripts_tracking.Addresses` : city , line_2 , state_province_county , country , address_id , zip_postcode , line_1 | `student_transcripts_tracking.Courses` : course_description , course_id , course_name | `student_transcripts_tracking.Departments` : department_description , department_name , department_id | `student_transcripts_tracking.Degree_Programs` : degree_summary_name , degree_program_id , department_id , degree_summary_description | `student_transcripts_tracking.Sections` : section_id , course_id , section_name , section_description | `student_transcripts_tracking.Semesters` : semester_id , semester_description , semester_name | `student_transcripts_tracking.Students` : ssn , cell_mobile_number , last_name , first_name , date_first_registered , current_address_id , middle_name , email_address , date_left , student_id , other_student_details , permanent_address_id | `student_transcripts_tracking.Student_Enrolment` : semester_id , degree_program_id , student_enrolment_id , student_id | `student_transcripts_tracking.Student_Enrolment_Courses` : student_course_id , course_id , student_enrolment_id | `student_transcripts_tracking.Transcripts` : transcript_date , transcript_id | `student_transcripts_tracking.Transcript_Contents` : student_course_id , transcript_id | `student_transcripts_tracking.degree_programs_HAS_student_transcripts_tracking.departments` :  | `student_transcripts_tracking.sections_HAS_student_transcripts_tracking.courses` :  | `student_transcripts_tracking.students_HAS_student_transcripts_tracking.addresses` :  | `student_transcripts_tracking.student_enrolment_HAS_student_transcripts_tracking.students` :  | `student_transcripts_tracking.student_enrolment_courses_HAS_student_transcripts_tracking.student_enrolment` :


index       : 343
baseline pre: MATCH (student_enrolment:`student_transcripts_tracking.Student_Enrolment`) WITH count(*) AS count, student_enrolment.middle_name AS middle_name, student_enrolment.last_name AS last_name WHERE count >= 2 RETURN first_name,middle_name,last_name,student_enrolment_id
model1 pred : MATCH (student_enrolment:`student_transcripts_tracking.Student_Enrolment`) WITH student_enrolment.first_name,student_enrolment.middle_name,student_enrolment.last_name AS last_name, count(*) AS count WHERE count = 2 RETURN first_name,middle_name,last_name
ground query: MATCH (T1:`student_transcripts_tracking.Students`)-[]-(T2:`student_transcripts_tracking.Student_Enrolment`) WITH T1.first_name AS first_name, T1.middle_name AS middle_name, T1.last_name AS last_name, T1.student_id AS student_id, count(*) AS count WHERE count  = 2 RETURN first_name,middle_name,last_name,student_id
NLQ         : What are the first, middle, and last names, along with the ids, of all students who enrolled in 2 degree programs in one semester?
Schema      : | student_transcripts_tracking | `student_transcripts_tracking.Addresses` : city , line_2 , state_province_county , country , address_id , zip_postcode , line_1 | `student_transcripts_tracking.Courses` : course_description , course_id , course_name | `student_transcripts_tracking.Departments` : department_description , department_name , department_id | `student_transcripts_tracking.Degree_Programs` : degree_summary_name , degree_program_id , department_id , degree_summary_description | `student_transcripts_tracking.Sections` : section_id , course_id , section_name , section_description | `student_transcripts_tracking.Semesters` : semester_id , semester_description , semester_name | `student_transcripts_tracking.Students` : ssn , cell_mobile_number , last_name , first_name , date_first_registered , current_address_id , middle_name , email_address , date_left , student_id , other_student_details , permanent_address_id | `student_transcripts_tracking.Student_Enrolment` : semester_id , degree_program_id , student_enrolment_id , student_id | `student_transcripts_tracking.Student_Enrolment_Courses` : student_course_id , course_id , student_enrolment_id | `student_transcripts_tracking.Transcripts` : transcript_date , transcript_id | `student_transcripts_tracking.Transcript_Contents` : student_course_id , transcript_id | `student_transcripts_tracking.degree_programs_HAS_student_transcripts_tracking.departments` :  | `student_transcripts_tracking.sections_HAS_student_transcripts_tracking.courses` :  | `student_transcripts_tracking.students_HAS_student_transcripts_tracking.addresses` :  | `student_transcripts_tracking.student_enrolment_HAS_student_transcripts_tracking.students` :  | `student_transcripts_tracking.student_enrolment_courses_HAS_student_transcripts_tracking.student_enrolment` :


index       : 344
baseline pre: MATCH (student_enrolment:`student_transcripts_tracking.Student_Enrolment`) WHERE student_enrolment.degree_summary_name = 'Bachelor' RETURN student_enrolment.first_name,student_enrolment.middle_name,student_enrolment.last_name
model1 pred : MATCH (student_enrolment:`student_transcripts_tracking.Student_Enrolment`) WHERE degree_programs.degree_summary_name = "Bachelor" RETURN student_enrolment.first_name,student_enrolment.middle_name,student_enrolment.last_name
ground query: MATCH (T1:`student_transcripts_tracking.Students`)-[]-(T2:`student_transcripts_tracking.Student_Enrolment`)-[]-(T3:`student_transcripts_tracking.Degree_Programs`) WHERE T3.degree_summary_name = 'Bachelor' RETURN DISTINCT T1.first_name,T1.middle_name,T1.last_name
NLQ         : Who is enrolled in a Bachelor degree program? List the first name, middle name, last name.
Schema      : | student_transcripts_tracking | `student_transcripts_tracking.Addresses` : city , line_2 , state_province_county , country , address_id , zip_postcode , line_1 | `student_transcripts_tracking.Courses` : course_description , course_id , course_name | `student_transcripts_tracking.Departments` : department_description , department_name , department_id | `student_transcripts_tracking.Degree_Programs` : degree_summary_name ( Bachelor ) , degree_program_id , department_id , degree_summary_description | `student_transcripts_tracking.Sections` : section_id , course_id , section_name , section_description | `student_transcripts_tracking.Semesters` : semester_id , semester_description , semester_name | `student_transcripts_tracking.Students` : ssn , cell_mobile_number , last_name , first_name , date_first_registered , current_address_id , middle_name , email_address , date_left , student_id , other_student_details , permanent_address_id | `student_transcripts_tracking.Student_Enrolment` : semester_id , degree_program_id , student_enrolment_id , student_id | `student_transcripts_tracking.Student_Enrolment_Courses` : student_course_id , course_id , student_enrolment_id | `student_transcripts_tracking.Transcripts` : transcript_date , transcript_id | `student_transcripts_tracking.Transcript_Contents` : student_course_id , transcript_id | `student_transcripts_tracking.degree_programs_HAS_student_transcripts_tracking.departments` :  | `student_transcripts_tracking.sections_HAS_student_transcripts_tracking.courses` :  | `student_transcripts_tracking.students_HAS_student_transcripts_tracking.addresses` :  | `student_transcripts_tracking.student_enrolment_HAS_student_transcripts_tracking.students` :  | `student_transcripts_tracking.student_enrolment_courses_HAS_student_transcripts_tracking.student_enrolment` :


index       : 345
baseline pre: MATCH (student_enrolment:`student_transcripts_tracking.Student_Enrolment`) WHERE student_enrolment.degree_program_id = 'B' RETURN student_enrolment.first_name,student_enrolment.middle_name,student_enrolment.last_name
model1 pred : MATCH (student_enrolment:`student_transcripts_tracking.Student_Enrolment`) WHERE student_enrolment.degree_program_id = 'Bachelors' RETURN student_enrolment.first_name,student_enrolment.middle_name,student_enrolment.last_name
ground query: MATCH (T1:`student_transcripts_tracking.Students`)-[]-(T2:`student_transcripts_tracking.Student_Enrolment`)-[]-(T3:`student_transcripts_tracking.Degree_Programs`) WHERE T3.degree_summary_name = 'Bachelor' RETURN DISTINCT T1.first_name,T1.middle_name,T1.last_name
NLQ         : What are the first, middle, and last names for everybody enrolled in a Bachelors program?
Schema      : | student_transcripts_tracking | `student_transcripts_tracking.Addresses` : city , line_2 , state_province_county , country , address_id , zip_postcode , line_1 | `student_transcripts_tracking.Courses` : course_description , course_id , course_name | `student_transcripts_tracking.Departments` : department_description , department_name , department_id | `student_transcripts_tracking.Degree_Programs` : degree_summary_name , degree_program_id , department_id , degree_summary_description | `student_transcripts_tracking.Sections` : section_id , course_id , section_name , section_description | `student_transcripts_tracking.Semesters` : semester_id , semester_description , semester_name | `student_transcripts_tracking.Students` : ssn , cell_mobile_number , last_name , first_name , date_first_registered , current_address_id , middle_name , email_address , date_left , student_id , other_student_details , permanent_address_id | `student_transcripts_tracking.Student_Enrolment` : semester_id , degree_program_id , student_enrolment_id , student_id | `student_transcripts_tracking.Student_Enrolment_Courses` : student_course_id , course_id , student_enrolment_id | `student_transcripts_tracking.Transcripts` : transcript_date , transcript_id | `student_transcripts_tracking.Transcript_Contents` : student_course_id , transcript_id | `student_transcripts_tracking.degree_programs_HAS_student_transcripts_tracking.departments` :  | `student_transcripts_tracking.sections_HAS_student_transcripts_tracking.courses` :  | `student_transcripts_tracking.students_HAS_student_transcripts_tracking.addresses` :  | `student_transcripts_tracking.student_enrolment_HAS_student_transcripts_tracking.students` :  | `student_transcripts_tracking.student_enrolment_courses_HAS_student_transcripts_tracking.student_enrolment` :


index       : 346
baseline pre: MATCH (student_enrolment:`student_transcripts_tracking.Student_Enrolment`) RETURN student_enrolment.degree_program_id ORDER BY student_enrolment.degree_program_id DESC LIMIT 1
model1 pred : MATCH (student_enrolment:`student_transcripts_tracking.Student_Enrolment`) RETURN degree_programs.degree_program_id ORDER BY degree_programs.degree_program_id DESC LIMIT 1
ground query: MATCH (T1:`student_transcripts_tracking.Degree_Programs`)-[]-(T2:`student_transcripts_tracking.Student_Enrolment`) WITH T1, count(T1.degree_summary_name) AS cnt RETURN T1.degree_summary_name ORDER BY cnt DESC LIMIT 1
NLQ         : Find the kind of program which most number of students are enrolled in?
Schema      : | student_transcripts_tracking | `student_transcripts_tracking.Addresses` : city , line_2 , state_province_county , country , address_id , zip_postcode , line_1 | `student_transcripts_tracking.Courses` : course_description , course_id , course_name | `student_transcripts_tracking.Departments` : department_description , department_name , department_id | `student_transcripts_tracking.Degree_Programs` : degree_summary_name , degree_program_id , department_id , degree_summary_description | `student_transcripts_tracking.Sections` : section_id , course_id , section_name , section_description | `student_transcripts_tracking.Semesters` : semester_id , semester_description , semester_name | `student_transcripts_tracking.Students` : ssn , cell_mobile_number , last_name , first_name , date_first_registered , current_address_id , middle_name , email_address , date_left , student_id , other_student_details , permanent_address_id | `student_transcripts_tracking.Student_Enrolment` : semester_id , degree_program_id , student_enrolment_id , student_id | `student_transcripts_tracking.Student_Enrolment_Courses` : student_course_id , course_id , student_enrolment_id | `student_transcripts_tracking.Transcripts` : transcript_date , transcript_id | `student_transcripts_tracking.Transcript_Contents` : student_course_id , transcript_id | `student_transcripts_tracking.degree_programs_HAS_student_transcripts_tracking.departments` :  | `student_transcripts_tracking.sections_HAS_student_transcripts_tracking.courses` :  | `student_transcripts_tracking.students_HAS_student_transcripts_tracking.addresses` :  | `student_transcripts_tracking.student_enrolment_HAS_student_transcripts_tracking.students` :  | `student_transcripts_tracking.student_enrolment_courses_HAS_student_transcripts_tracking.student_enrolment` :


index       : 347
baseline pre: MATCH (T1:`student_transcripts_tracking.Degree_Programs`)-[T2:`student_transcripts_tracking.Student_Enrolment ` ]-() WITH count(T1.degree_summary_description) AS cnt, T1 RETURN T1.degree_summary_name ORDER BY cnt DESC LIMIT 1
model1 pred : MATCH (T1:`student_transcripts_tracking.Degree_Programs`)-[T2:`student_transcripts_tracking.Student_Enrolment ` ]-() WITH count(T1.degree_summary_name) AS cnt, T1 RETURN T1.degree_summary_name ORDER BY cnt DESC LIMIT 1
ground query: MATCH (T1:`student_transcripts_tracking.Degree_Programs`)-[]-(T2:`student_transcripts_tracking.Student_Enrolment`) WITH T1, count(T1.degree_summary_name) AS cnt RETURN T1.degree_summary_name ORDER BY cnt DESC LIMIT 1
NLQ         : What is the degree summary name that has the most number of students enrolled?
Schema      : | student_transcripts_tracking | `student_transcripts_tracking.Addresses` : city , line_2 , state_province_county , country , address_id , zip_postcode , line_1 | `student_transcripts_tracking.Courses` : course_description , course_id , course_name | `student_transcripts_tracking.Departments` : department_description , department_name , department_id | `student_transcripts_tracking.Degree_Programs` : degree_summary_name , degree_program_id , department_id , degree_summary_description | `student_transcripts_tracking.Sections` : section_id , course_id , section_name , section_description | `student_transcripts_tracking.Semesters` : semester_id , semester_description , semester_name | `student_transcripts_tracking.Students` : ssn , cell_mobile_number , last_name , first_name , date_first_registered , current_address_id , middle_name , email_address , date_left , student_id , other_student_details , permanent_address_id | `student_transcripts_tracking.Student_Enrolment` : semester_id , degree_program_id , student_enrolment_id , student_id | `student_transcripts_tracking.Student_Enrolment_Courses` : student_course_id , course_id , student_enrolment_id | `student_transcripts_tracking.Transcripts` : transcript_date , transcript_id | `student_transcripts_tracking.Transcript_Contents` : student_course_id , transcript_id | `student_transcripts_tracking.degree_programs_HAS_student_transcripts_tracking.departments` :  | `student_transcripts_tracking.sections_HAS_student_transcripts_tracking.courses` :  | `student_transcripts_tracking.students_HAS_student_transcripts_tracking.addresses` :  | `student_transcripts_tracking.student_enrolment_HAS_student_transcripts_tracking.students` :  | `student_transcripts_tracking.student_enrolment_courses_HAS_student_transcripts_tracking.student_enrolment` :


index       : 348
baseline pre: MATCH (student_enrolment:`student_transcripts_tracking.Student_Enrolment`) RETURN student_enrolment.degree_program_id,student_enrolment.degree_summary_name ORDER BY student_enrolment.degree_enrolment_id DESC LIMIT 1
model1 pred : MATCH (T1:`student_transcripts_tracking.Degree_Programs`)-[T2:`student_transcripts_tracking.Student_Enrolment ` ]-() WITH count(T1.degree_program_id) AS cnt, T1 RETURN T1.degree_program_id,T1.degree_summary_description ORDER BY cnt DESC LIMIT 1
ground query: MATCH (T1:`student_transcripts_tracking.Degree_Programs`)-[]-(T2:`student_transcripts_tracking.Student_Enrolment`) WITH count(T1.degree_program_id) AS cnt, T1 RETURN T1.degree_program_id,T1.degree_summary_name ORDER BY cnt DESC LIMIT 1
NLQ         : Find the program which most number of students are enrolled in. List both the id and the summary.
Schema      : | student_transcripts_tracking | `student_transcripts_tracking.Addresses` : city , line_2 , state_province_county , country , address_id , zip_postcode , line_1 | `student_transcripts_tracking.Courses` : course_description , course_id , course_name | `student_transcripts_tracking.Departments` : department_description , department_name , department_id | `student_transcripts_tracking.Degree_Programs` : degree_summary_name , degree_program_id , department_id , degree_summary_description | `student_transcripts_tracking.Sections` : section_id , course_id , section_name , section_description | `student_transcripts_tracking.Semesters` : semester_id , semester_description , semester_name | `student_transcripts_tracking.Students` : ssn , cell_mobile_number , last_name , first_name , date_first_registered , current_address_id , middle_name , email_address , date_left , student_id , other_student_details , permanent_address_id | `student_transcripts_tracking.Student_Enrolment` : semester_id , degree_program_id , student_enrolment_id , student_id | `student_transcripts_tracking.Student_Enrolment_Courses` : student_course_id , course_id , student_enrolment_id | `student_transcripts_tracking.Transcripts` : transcript_date , transcript_id | `student_transcripts_tracking.Transcript_Contents` : student_course_id , transcript_id | `student_transcripts_tracking.degree_programs_HAS_student_transcripts_tracking.departments` :  | `student_transcripts_tracking.sections_HAS_student_transcripts_tracking.courses` :  | `student_transcripts_tracking.students_HAS_student_transcripts_tracking.addresses` :  | `student_transcripts_tracking.student_enrolment_HAS_student_transcripts_tracking.students` :  | `student_transcripts_tracking.student_enrolment_courses_HAS_student_transcripts_tracking.student_enrolment` :


index       : 349
baseline pre: MATCH (T1:`student_transcripts_tracking.Degree_Programs`)-[T2:`student_transcripts_tracking.Student_Enrolment ` ]-() WITH count(T1.degree_program_id) AS cnt, T1 RETURN T1.degree_program_id,T1.degree_summary_description ORDER BY cnt DESC LIMIT 1
model1 pred : MATCH (T1:`student_transcripts_tracking.Degree_Programs`)-[T2:`student_transcripts_tracking.Student_Enrolment ` ]-() WITH count(T1.degree_program_id) AS cnt, T1 RETURN T1.degree_program_id,T1.degree_summary_description ORDER BY cnt DESC LIMIT 1
ground query: MATCH (T1:`student_transcripts_tracking.Degree_Programs`)-[]-(T2:`student_transcripts_tracking.Student_Enrolment`) WITH count(T1.degree_program_id) AS cnt, T1 RETURN T1.degree_program_id,T1.degree_summary_name ORDER BY cnt DESC LIMIT 1
NLQ         : What is the program id and the summary of the degree that has the most students enrolled?
Schema      : | student_transcripts_tracking | `student_transcripts_tracking.Addresses` : city , line_2 , state_province_county , country , address_id , zip_postcode , line_1 | `student_transcripts_tracking.Courses` : course_description , course_id , course_name | `student_transcripts_tracking.Departments` : department_description , department_name , department_id | `student_transcripts_tracking.Degree_Programs` : degree_summary_name , degree_program_id , department_id , degree_summary_description | `student_transcripts_tracking.Sections` : section_id , course_id , section_name , section_description | `student_transcripts_tracking.Semesters` : semester_id , semester_description , semester_name | `student_transcripts_tracking.Students` : ssn , cell_mobile_number , last_name , first_name , date_first_registered , current_address_id , middle_name , email_address , date_left , student_id , other_student_details , permanent_address_id | `student_transcripts_tracking.Student_Enrolment` : semester_id , degree_program_id , student_enrolment_id , student_id | `student_transcripts_tracking.Student_Enrolment_Courses` : student_course_id , course_id , student_enrolment_id | `student_transcripts_tracking.Transcripts` : transcript_date , transcript_id | `student_transcripts_tracking.Transcript_Contents` : student_course_id , transcript_id | `student_transcripts_tracking.degree_programs_HAS_student_transcripts_tracking.departments` :  | `student_transcripts_tracking.sections_HAS_student_transcripts_tracking.courses` :  | `student_transcripts_tracking.students_HAS_student_transcripts_tracking.addresses` :  | `student_transcripts_tracking.student_enrolment_HAS_student_transcripts_tracking.students` :  | `student_transcripts_tracking.student_enrolment_courses_HAS_student_transcripts_tracking.student_enrolment` :


index       : 350
baseline pre: MATCH (student_enrolment_courses:`student_transcripts_tracking.Student_Enrolment_Courses`) RETURN student_enrolment_courses.course_name
model1 pred : MATCH (T1:`student_transcripts_tracking.Courses`)-[T2:`student_transcripts_tracking.Student_Enrolment_Courses ` ]-() RETURN T1.course_name
ground query: MATCH (T1:`student_transcripts_tracking.Courses`)-[]-(T2:`student_transcripts_tracking.Student_Enrolment_Courses`) RETURN DISTINCT T1.course_name
NLQ         : What are all the course names of the courses which ever have students enrolled in?
Schema      : | student_transcripts_tracking | `student_transcripts_tracking.Addresses` : city , line_2 , state_province_county , country , address_id , zip_postcode , line_1 | `student_transcripts_tracking.Courses` : course_description , course_id , course_name | `student_transcripts_tracking.Departments` : department_description , department_name , department_id | `student_transcripts_tracking.Degree_Programs` : degree_summary_name , degree_program_id , department_id , degree_summary_description | `student_transcripts_tracking.Sections` : section_id , course_id , section_name , section_description | `student_transcripts_tracking.Semesters` : semester_id , semester_description , semester_name | `student_transcripts_tracking.Students` : ssn , cell_mobile_number , last_name , first_name , date_first_registered , current_address_id , middle_name , email_address , date_left , student_id , other_student_details , permanent_address_id | `student_transcripts_tracking.Student_Enrolment` : semester_id , degree_program_id , student_enrolment_id , student_id | `student_transcripts_tracking.Student_Enrolment_Courses` : student_course_id , course_id , student_enrolment_id | `student_transcripts_tracking.Transcripts` : transcript_date , transcript_id | `student_transcripts_tracking.Transcript_Contents` : student_course_id , transcript_id | `student_transcripts_tracking.degree_programs_HAS_student_transcripts_tracking.departments` :  | `student_transcripts_tracking.sections_HAS_student_transcripts_tracking.courses` :  | `student_transcripts_tracking.students_HAS_student_transcripts_tracking.addresses` :  | `student_transcripts_tracking.student_enrolment_HAS_student_transcripts_tracking.students` :  | `student_transcripts_tracking.student_enrolment_courses_HAS_student_transcripts_tracking.student_enrolment` :


index       : 351
baseline pre: MATCH (T1:`student_transcripts_tracking.Courses`)-[T2:`student_transcripts_tracking.Student_Enrolment_Courses ` ]-() RETURN T1.course_name
model1 pred : MATCH (T1:`student_transcripts_tracking.Courses`)-[T2:`student_transcripts_tracking.Student_Enrolment_Courses ` ]-() RETURN T1.course_name
ground query: MATCH (T1:`student_transcripts_tracking.Courses`)-[]-(T2:`student_transcripts_tracking.Student_Enrolment_Courses`) RETURN DISTINCT T1.course_name
NLQ         : What are the names of all courses that have some students enrolled?
Schema      : | student_transcripts_tracking | `student_transcripts_tracking.Addresses` : city , line_2 , state_province_county , country , address_id , zip_postcode , line_1 | `student_transcripts_tracking.Courses` : course_description , course_id , course_name | `student_transcripts_tracking.Departments` : department_description , department_name , department_id | `student_transcripts_tracking.Degree_Programs` : degree_summary_name , degree_program_id , department_id , degree_summary_description | `student_transcripts_tracking.Sections` : section_id , course_id , section_name , section_description | `student_transcripts_tracking.Semesters` : semester_id , semester_description , semester_name | `student_transcripts_tracking.Students` : ssn , cell_mobile_number , last_name , first_name , date_first_registered , current_address_id , middle_name , email_address , date_left , student_id , other_student_details , permanent_address_id | `student_transcripts_tracking.Student_Enrolment` : semester_id , degree_program_id , student_enrolment_id , student_id | `student_transcripts_tracking.Student_Enrolment_Courses` : student_course_id , course_id , student_enrolment_id | `student_transcripts_tracking.Transcripts` : transcript_date , transcript_id | `student_transcripts_tracking.Transcript_Contents` : student_course_id , transcript_id | `student_transcripts_tracking.degree_programs_HAS_student_transcripts_tracking.departments` :  | `student_transcripts_tracking.sections_HAS_student_transcripts_tracking.courses` :  | `student_transcripts_tracking.students_HAS_student_transcripts_tracking.addresses` :  | `student_transcripts_tracking.student_enrolment_HAS_student_transcripts_tracking.students` :  | `student_transcripts_tracking.student_enrolment_courses_HAS_student_transcripts_tracking.student_enrolment` :


index       : 353
baseline pre: MATCH (students:`student_transcripts_tracking.Students`) WHERE students.first_name = 'Timmothy' AND students.last_name = 'Ward' RETURN students.cell_mobile_number
model1 pred : MATCH (students:`student_transcripts_tracking.Students`) WHERE students.first_name = 'Timmothy' AND students.last_name = 'Ward' RETURN students.cell_mobile_number
ground query: MATCH (students:`student_transcripts_tracking.Students`) WHERE students.first_name = 'timmothy' AND students.last_name = 'ward' RETURN students.cell_mobile_number
NLQ         : What is the mobile phone number of the student named Timmothy Ward ?
Schema      : | student_transcripts_tracking | `student_transcripts_tracking.Addresses` : city , line_2 , state_province_county , country , address_id , zip_postcode , line_1 | `student_transcripts_tracking.Courses` : course_description , course_id , course_name | `student_transcripts_tracking.Departments` : department_description , department_name , department_id | `student_transcripts_tracking.Degree_Programs` : degree_summary_name , degree_program_id , department_id , degree_summary_description | `student_transcripts_tracking.Sections` : section_id , course_id , section_name , section_description | `student_transcripts_tracking.Semesters` : semester_id , semester_description , semester_name | `student_transcripts_tracking.Students` : ssn , cell_mobile_number , last_name ( Ward ) , first_name ( Timmothy ) , date_first_registered , current_address_id , middle_name , email_address , date_left , student_id , other_student_details , permanent_address_id | `student_transcripts_tracking.Student_Enrolment` : semester_id , degree_program_id , student_enrolment_id , student_id | `student_transcripts_tracking.Student_Enrolment_Courses` : student_course_id , course_id , student_enrolment_id | `student_transcripts_tracking.Transcripts` : transcript_date , transcript_id | `student_transcripts_tracking.Transcript_Contents` : student_course_id , transcript_id | `student_transcripts_tracking.degree_programs_HAS_student_transcripts_tracking.departments` :  | `student_transcripts_tracking.sections_HAS_student_transcripts_tracking.courses` :  | `student_transcripts_tracking.students_HAS_student_transcripts_tracking.addresses` :  | `student_transcripts_tracking.student_enrolment_HAS_student_transcripts_tracking.students` :  | `student_transcripts_tracking.student_enrolment_courses_HAS_student_transcripts_tracking.student_enrolment` :


index       : 354
baseline pre: MATCH (students:`student_transcripts_tracking.Student_Enrolment`) RETURN students.first_name,students.middle_name,students.last_name
model1 pred : MATCH (students:`student_transcripts_tracking.Students`) RETURN students.first_name,students.middle_name,students.last_name
ground query: MATCH (students:`student_transcripts_tracking.Students`) RETURN students.first_name,students.middle_name,students.last_name ORDER BY students.date_first_registered ASC LIMIT 1
NLQ         : Who is the first student to register? List the first name, middle name and last name.
Schema      : | student_transcripts_tracking | `student_transcripts_tracking.Addresses` : city , line_2 , state_province_county , country , address_id , zip_postcode , line_1 | `student_transcripts_tracking.Courses` : course_description , course_id , course_name | `student_transcripts_tracking.Departments` : department_description , department_name , department_id | `student_transcripts_tracking.Degree_Programs` : degree_summary_name , degree_program_id , department_id , degree_summary_description | `student_transcripts_tracking.Sections` : section_id , course_id , section_name , section_description | `student_transcripts_tracking.Semesters` : semester_id , semester_description , semester_name | `student_transcripts_tracking.Students` : ssn , cell_mobile_number , last_name , first_name , date_first_registered , current_address_id , middle_name , email_address , date_left , student_id , other_student_details , permanent_address_id | `student_transcripts_tracking.Student_Enrolment` : semester_id , degree_program_id , student_enrolment_id , student_id | `student_transcripts_tracking.Student_Enrolment_Courses` : student_course_id , course_id , student_enrolment_id | `student_transcripts_tracking.Transcripts` : transcript_date , transcript_id | `student_transcripts_tracking.Transcript_Contents` : student_course_id , transcript_id | `student_transcripts_tracking.degree_programs_HAS_student_transcripts_tracking.departments` :  | `student_transcripts_tracking.sections_HAS_student_transcripts_tracking.courses` :  | `student_transcripts_tracking.students_HAS_student_transcripts_tracking.addresses` :  | `student_transcripts_tracking.student_enrolment_HAS_student_transcripts_tracking.students` :  | `student_transcripts_tracking.student_enrolment_courses_HAS_student_transcripts_tracking.student_enrolment` :


index       : 355
baseline pre: MATCH (students:`student_transcripts_tracking.Students`) RETURN students.first_name,students.middle_name,students.last_name ORDER BY students.date_first_registered DESC LIMIT 1
model1 pred : MATCH (students:`student_transcripts_tracking.Students`) RETURN students.first_name,students.middle_name,students.last_name
ground query: MATCH (students:`student_transcripts_tracking.Students`) RETURN students.first_name,students.middle_name,students.last_name ORDER BY students.date_first_registered ASC LIMIT 1
NLQ         : What is the first, middle, and last name of the first student to register?
Schema      : | student_transcripts_tracking | `student_transcripts_tracking.Addresses` : city , line_2 , state_province_county , country , address_id , zip_postcode , line_1 | `student_transcripts_tracking.Courses` : course_description , course_id , course_name | `student_transcripts_tracking.Departments` : department_description , department_name , department_id | `student_transcripts_tracking.Degree_Programs` : degree_summary_name , degree_program_id , department_id , degree_summary_description | `student_transcripts_tracking.Sections` : section_id , course_id , section_name , section_description | `student_transcripts_tracking.Semesters` : semester_id , semester_description , semester_name | `student_transcripts_tracking.Students` : ssn , cell_mobile_number , last_name , first_name , date_first_registered , current_address_id , middle_name , email_address , date_left , student_id , other_student_details , permanent_address_id | `student_transcripts_tracking.Student_Enrolment` : semester_id , degree_program_id , student_enrolment_id , student_id | `student_transcripts_tracking.Student_Enrolment_Courses` : student_course_id , course_id , student_enrolment_id | `student_transcripts_tracking.Transcripts` : transcript_date , transcript_id | `student_transcripts_tracking.Transcript_Contents` : student_course_id , transcript_id | `student_transcripts_tracking.degree_programs_HAS_student_transcripts_tracking.departments` :  | `student_transcripts_tracking.sections_HAS_student_transcripts_tracking.courses` :  | `student_transcripts_tracking.students_HAS_student_transcripts_tracking.addresses` :  | `student_transcripts_tracking.student_enrolment_HAS_student_transcripts_tracking.students` :  | `student_transcripts_tracking.student_enrolment_courses_HAS_student_transcripts_tracking.student_enrolment` :


index       : 356
baseline pre: MATCH (students:`student_transcripts_tracking.Students`) RETURN students.first_name,students.middle_name,students.last_name ORDER BY students.date_first_registered LIMIT 1
model1 pred : MATCH (students:`student_transcripts_tracking.Students`) RETURN students.first_name,students.middle_name,students.last_name ORDER BY students.date_first_registered LIMIT 1
ground query: MATCH (students:`student_transcripts_tracking.Students`) RETURN students.first_name,students.middle_name,students.last_name ORDER BY students.date_left ASC LIMIT 1
NLQ         : Who is the earliest graduate of the school? List the first name, middle name and last name.
Schema      : | student_transcripts_tracking | `student_transcripts_tracking.Addresses` : city , line_2 , state_province_county , country , address_id , zip_postcode , line_1 | `student_transcripts_tracking.Courses` : course_description , course_id , course_name | `student_transcripts_tracking.Departments` : department_description , department_name , department_id | `student_transcripts_tracking.Degree_Programs` : degree_summary_name , degree_program_id , department_id , degree_summary_description | `student_transcripts_tracking.Sections` : section_id , course_id , section_name , section_description | `student_transcripts_tracking.Semesters` : semester_id , semester_description , semester_name | `student_transcripts_tracking.Students` : ssn , cell_mobile_number , last_name , first_name , date_first_registered , current_address_id , middle_name , email_address , date_left , student_id , other_student_details , permanent_address_id | `student_transcripts_tracking.Student_Enrolment` : semester_id , degree_program_id , student_enrolment_id , student_id | `student_transcripts_tracking.Student_Enrolment_Courses` : student_course_id , course_id , student_enrolment_id | `student_transcripts_tracking.Transcripts` : transcript_date , transcript_id | `student_transcripts_tracking.Transcript_Contents` : student_course_id , transcript_id | `student_transcripts_tracking.degree_programs_HAS_student_transcripts_tracking.departments` :  | `student_transcripts_tracking.sections_HAS_student_transcripts_tracking.courses` :  | `student_transcripts_tracking.students_HAS_student_transcripts_tracking.addresses` :  | `student_transcripts_tracking.student_enrolment_HAS_student_transcripts_tracking.students` :  | `student_transcripts_tracking.student_enrolment_courses_HAS_student_transcripts_tracking.student_enrolment` :


index       : 357
baseline pre: MATCH (students:`student_transcripts_tracking.Students`) RETURN students.first_name,students.middle_name,students.last_name ORDER BY students.date_first_registered LIMIT 1
model1 pred : MATCH (students:`student_transcripts_tracking.Students`) RETURN students.first_name,students.middle_name,students.last_name ORDER BY students.date_first_registered LIMIT 1
ground query: MATCH (students:`student_transcripts_tracking.Students`) RETURN students.first_name,students.middle_name,students.last_name ORDER BY students.date_left ASC LIMIT 1
NLQ         : What is the first, middle, and last name of the earliest school graduate?
Schema      : | student_transcripts_tracking | `student_transcripts_tracking.Addresses` : city , line_2 , state_province_county , country , address_id , zip_postcode , line_1 | `student_transcripts_tracking.Courses` : course_description , course_id , course_name | `student_transcripts_tracking.Departments` : department_description , department_name , department_id | `student_transcripts_tracking.Degree_Programs` : degree_summary_name , degree_program_id , department_id , degree_summary_description | `student_transcripts_tracking.Sections` : section_id , course_id , section_name , section_description | `student_transcripts_tracking.Semesters` : semester_id , semester_description , semester_name | `student_transcripts_tracking.Students` : ssn , cell_mobile_number , last_name , first_name , date_first_registered , current_address_id , middle_name , email_address , date_left , student_id , other_student_details , permanent_address_id | `student_transcripts_tracking.Student_Enrolment` : semester_id , degree_program_id , student_enrolment_id , student_id | `student_transcripts_tracking.Student_Enrolment_Courses` : student_course_id , course_id , student_enrolment_id | `student_transcripts_tracking.Transcripts` : transcript_date , transcript_id | `student_transcripts_tracking.Transcript_Contents` : student_course_id , transcript_id | `student_transcripts_tracking.degree_programs_HAS_student_transcripts_tracking.departments` :  | `student_transcripts_tracking.sections_HAS_student_transcripts_tracking.courses` :  | `student_transcripts_tracking.students_HAS_student_transcripts_tracking.addresses` :  | `student_transcripts_tracking.student_enrolment_HAS_student_transcripts_tracking.students` :  | `student_transcripts_tracking.student_enrolment_courses_HAS_student_transcripts_tracking.student_enrolment` :


index       : 358
baseline pre: MATCH (addresses:`student_transcripts_tracking.Addresses`) WHERE addresses.permanent_address_id  < address_id RETURN addresses.first_name
model1 pred : MATCH (addresses:`student_transcripts_tracking.Addresses`) WITH avg(addresses.permanent_address_id) AS permanent_address_id MATCH (addresses:`student_transcripts_tracking.Addresses`) WHERE addresses.permanent_address_id ` permanent_address_id RETURN addresses.first_name
ground query: MATCH (students:`student_transcripts_tracking.Students`) WHERE students.current_address_id <> students.permanent_address_id RETURN students.first_name
NLQ         : Whose permanent address is different from his or her current address? List his or her first name.
Schema      : | student_transcripts_tracking | `student_transcripts_tracking.Addresses` : city , line_2 , state_province_county , country , address_id , zip_postcode , line_1 | `student_transcripts_tracking.Courses` : course_description , course_id , course_name | `student_transcripts_tracking.Departments` : department_description , department_name , department_id | `student_transcripts_tracking.Degree_Programs` : degree_summary_name , degree_program_id , department_id , degree_summary_description | `student_transcripts_tracking.Sections` : section_id , course_id , section_name , section_description | `student_transcripts_tracking.Semesters` : semester_id , semester_description , semester_name | `student_transcripts_tracking.Students` : ssn , cell_mobile_number , last_name , first_name , date_first_registered , current_address_id , middle_name , email_address , date_left , student_id , other_student_details , permanent_address_id | `student_transcripts_tracking.Student_Enrolment` : semester_id , degree_program_id , student_enrolment_id , student_id | `student_transcripts_tracking.Student_Enrolment_Courses` : student_course_id , course_id , student_enrolment_id | `student_transcripts_tracking.Transcripts` : transcript_date , transcript_id | `student_transcripts_tracking.Transcript_Contents` : student_course_id , transcript_id | `student_transcripts_tracking.degree_programs_HAS_student_transcripts_tracking.departments` :  | `student_transcripts_tracking.sections_HAS_student_transcripts_tracking.courses` :  | `student_transcripts_tracking.students_HAS_student_transcripts_tracking.addresses` :  | `student_transcripts_tracking.student_enrolment_HAS_student_transcripts_tracking.students` :  | `student_transcripts_tracking.student_enrolment_courses_HAS_student_transcripts_tracking.student_enrolment` :


index       : 359
baseline pre: MATCH (students:`student_transcripts_tracking.Students`) WHERE students.permanent_address_id  < current_address_id RETURN students.first_name
model1 pred : MATCH (students:`student_transcripts_tracking.Students`) WITH avg(students.permanent_address_id) AS permanent_address_id MATCH (students:`student_transcripts_tracking.Students`) WHERE students.permanent_address_id ` permanent_address_id RETURN students.first_name
ground query: MATCH (students:`student_transcripts_tracking.Students`) WHERE students.current_address_id <> students.permanent_address_id RETURN students.first_name
NLQ         : What is the first name of the student whose permanent address is different from his or her current one?
Schema      : | student_transcripts_tracking | `student_transcripts_tracking.Addresses` : city , line_2 , state_province_county , country , address_id , zip_postcode , line_1 | `student_transcripts_tracking.Courses` : course_description , course_id , course_name | `student_transcripts_tracking.Departments` : department_description , department_name , department_id | `student_transcripts_tracking.Degree_Programs` : degree_summary_name , degree_program_id , department_id , degree_summary_description | `student_transcripts_tracking.Sections` : section_id , course_id , section_name , section_description | `student_transcripts_tracking.Semesters` : semester_id , semester_description , semester_name | `student_transcripts_tracking.Students` : ssn , cell_mobile_number , last_name , first_name , date_first_registered , current_address_id , middle_name , email_address , date_left , student_id , other_student_details , permanent_address_id | `student_transcripts_tracking.Student_Enrolment` : semester_id , degree_program_id , student_enrolment_id , student_id | `student_transcripts_tracking.Student_Enrolment_Courses` : student_course_id , course_id , student_enrolment_id | `student_transcripts_tracking.Transcripts` : transcript_date , transcript_id | `student_transcripts_tracking.Transcript_Contents` : student_course_id , transcript_id | `student_transcripts_tracking.degree_programs_HAS_student_transcripts_tracking.departments` :  | `student_transcripts_tracking.sections_HAS_student_transcripts_tracking.courses` :  | `student_transcripts_tracking.students_HAS_student_transcripts_tracking.addresses` :  | `student_transcripts_tracking.student_enrolment_HAS_student_transcripts_tracking.students` :  | `student_transcripts_tracking.student_enrolment_courses_HAS_student_transcripts_tracking.student_enrolment` :


index       : 360
baseline pre: MATCH (T1:`student_transcripts_tracking.Addresses`)-[]-(T2:`student_transcripts_tracking.Student_Enrolment`) WITH count(T1.address_id) AS cnt, T2 RETURN T2.address_id,T2.line_2 ORDER BY cnt DESC LIMIT 1
model1 pred : MATCH (addresses:`student_transcripts_tracking.Addresses`) RETURN addresses.address_id,addresses.line_1 ORDER BY addresses.current_address_id DESC LIMIT 1
ground query: MATCH (T1:`student_transcripts_tracking.Addresses`)-[]-(T2:`student_transcripts_tracking.Students`) WITH count(T1.address_id) AS cnt, T1 RETURN T1.address_id,T1.line_1,T1.line_2 ORDER BY cnt DESC LIMIT 1
NLQ         : Which address holds the most number of students currently? List the address id and all lines.
Schema      : | student_transcripts_tracking | `student_transcripts_tracking.Addresses` : city , line_2 , state_province_county , country , address_id , zip_postcode , line_1 | `student_transcripts_tracking.Courses` : course_description , course_id , course_name | `student_transcripts_tracking.Departments` : department_description , department_name , department_id | `student_transcripts_tracking.Degree_Programs` : degree_summary_name , degree_program_id , department_id , degree_summary_description | `student_transcripts_tracking.Sections` : section_id , course_id , section_name , section_description | `student_transcripts_tracking.Semesters` : semester_id , semester_description , semester_name | `student_transcripts_tracking.Students` : ssn , cell_mobile_number , last_name , first_name , date_first_registered , current_address_id , middle_name , email_address , date_left , student_id , other_student_details , permanent_address_id | `student_transcripts_tracking.Student_Enrolment` : semester_id , degree_program_id , student_enrolment_id , student_id | `student_transcripts_tracking.Student_Enrolment_Courses` : student_course_id , course_id , student_enrolment_id | `student_transcripts_tracking.Transcripts` : transcript_date , transcript_id | `student_transcripts_tracking.Transcript_Contents` : student_course_id , transcript_id | `student_transcripts_tracking.degree_programs_HAS_student_transcripts_tracking.departments` :  | `student_transcripts_tracking.sections_HAS_student_transcripts_tracking.courses` :  | `student_transcripts_tracking.students_HAS_student_transcripts_tracking.addresses` :  | `student_transcripts_tracking.student_enrolment_HAS_student_transcripts_tracking.students` :  | `student_transcripts_tracking.student_enrolment_courses_HAS_student_transcripts_tracking.student_enrolment` :


index       : 361
baseline pre: MATCH (addresses:`student_transcripts_tracking.Addresses`) RETURN addresses.address_id,addresses.line_1,addresses.line_2 ORDER BY addresses.line_id DESC LIMIT 1
model1 pred : MATCH (addresses:`student_transcripts_tracking.Addresses`) RETURN addresses.address_id,addresses.line_1,addresses.line_2 ORDER BY addresses.line_id DESC LIMIT 1
ground query: MATCH (T1:`student_transcripts_tracking.Addresses`)-[]-(T2:`student_transcripts_tracking.Students`) WITH count(T1.address_id) AS cnt, T1 RETURN T1.address_id,T1.line_1,T1.line_2 ORDER BY cnt DESC LIMIT 1
NLQ         : What is the id, line 1, and line 2 of the address with the most students?
Schema      : | student_transcripts_tracking | `student_transcripts_tracking.Addresses` : city , line_2 , state_province_county , country , address_id , zip_postcode , line_1 | `student_transcripts_tracking.Courses` : course_description , course_id , course_name | `student_transcripts_tracking.Departments` : department_description , department_name , department_id | `student_transcripts_tracking.Degree_Programs` : degree_summary_name , degree_program_id , department_id , degree_summary_description | `student_transcripts_tracking.Sections` : section_id , course_id , section_name , section_description | `student_transcripts_tracking.Semesters` : semester_id , semester_description , semester_name | `student_transcripts_tracking.Students` : ssn , cell_mobile_number , last_name , first_name , date_first_registered , current_address_id , middle_name , email_address , date_left , student_id , other_student_details , permanent_address_id | `student_transcripts_tracking.Student_Enrolment` : semester_id , degree_program_id , student_enrolment_id , student_id | `student_transcripts_tracking.Student_Enrolment_Courses` : student_course_id , course_id , student_enrolment_id | `student_transcripts_tracking.Transcripts` : transcript_date , transcript_id | `student_transcripts_tracking.Transcript_Contents` : student_course_id , transcript_id | `student_transcripts_tracking.degree_programs_HAS_student_transcripts_tracking.departments` :  | `student_transcripts_tracking.sections_HAS_student_transcripts_tracking.courses` :  | `student_transcripts_tracking.students_HAS_student_transcripts_tracking.addresses` :  | `student_transcripts_tracking.student_enrolment_HAS_student_transcripts_tracking.students` :  | `student_transcripts_tracking.student_enrolment_courses_HAS_student_transcripts_tracking.student_enrolment` :


index       : 362
baseline pre: MATCH (transcripts:`student_transcripts_tracking.Transcripts`) RETURN transcripts.transcript_date,transcripts.other_student_details
model1 pred : MATCH (transcripts:`student_transcripts_tracking.Transcripts`) RETURN transcripts.transcript_date,transcripts.student_details
ground query: MATCH (transcripts:`student_transcripts_tracking.Transcripts`) RETURN transcripts.transcript_date,transcripts.other_details ORDER BY transcripts.transcript_date ASC LIMIT 1
NLQ         : When is the first transcript released? List the date and details.
Schema      : | student_transcripts_tracking | `student_transcripts_tracking.Addresses` : city , line_2 , state_province_county , country , address_id , zip_postcode , line_1 | `student_transcripts_tracking.Courses` : course_description , course_id , course_name | `student_transcripts_tracking.Departments` : department_description , department_name , department_id | `student_transcripts_tracking.Degree_Programs` : degree_summary_name , degree_program_id , department_id , degree_summary_description | `student_transcripts_tracking.Sections` : section_id , course_id , section_name , section_description | `student_transcripts_tracking.Semesters` : semester_id , semester_description , semester_name | `student_transcripts_tracking.Students` : ssn , cell_mobile_number , last_name , first_name , date_first_registered , current_address_id , middle_name , email_address , date_left , student_id , other_student_details , permanent_address_id | `student_transcripts_tracking.Student_Enrolment` : semester_id , degree_program_id , student_enrolment_id , student_id | `student_transcripts_tracking.Student_Enrolment_Courses` : student_course_id , course_id , student_enrolment_id | `student_transcripts_tracking.Transcripts` : transcript_date , transcript_id | `student_transcripts_tracking.Transcript_Contents` : student_course_id , transcript_id | `student_transcripts_tracking.degree_programs_HAS_student_transcripts_tracking.departments` :  | `student_transcripts_tracking.sections_HAS_student_transcripts_tracking.courses` :  | `student_transcripts_tracking.students_HAS_student_transcripts_tracking.addresses` :  | `student_transcripts_tracking.student_enrolment_HAS_student_transcripts_tracking.students` :  | `student_transcripts_tracking.student_enrolment_courses_HAS_student_transcripts_tracking.student_enrolment` :


index       : 363
baseline pre: MATCH (transcripts:`student_transcripts_tracking.Transcripts`) RETURN transcripts.transcript_date,transcripts.other_student_details ORDER BY transcripts.transcript_date LIMIT 1
model1 pred : MATCH (transcripts:`student_transcripts_tracking.Transcripts`) RETURN transcripts.transcript_date,transcripts.other_student_details ORDER BY transcripts.transcript_date LIMIT 1
ground query: MATCH (transcripts:`student_transcripts_tracking.Transcripts`) RETURN transcripts.transcript_date,transcripts.other_details ORDER BY transcripts.transcript_date ASC LIMIT 1
NLQ         : What is the earliest date of a transcript release, and what details can you tell me?
Schema      : | student_transcripts_tracking | `student_transcripts_tracking.Addresses` : city , line_2 , state_province_county , country , address_id , zip_postcode , line_1 | `student_transcripts_tracking.Courses` : course_description , course_id , course_name | `student_transcripts_tracking.Departments` : department_description , department_name , department_id | `student_transcripts_tracking.Degree_Programs` : degree_summary_name , degree_program_id , department_id , degree_summary_description | `student_transcripts_tracking.Sections` : section_id , course_id , section_name , section_description | `student_transcripts_tracking.Semesters` : semester_id , semester_description , semester_name | `student_transcripts_tracking.Students` : ssn , cell_mobile_number , last_name , first_name , date_first_registered , current_address_id , middle_name , email_address , date_left , student_id , other_student_details , permanent_address_id | `student_transcripts_tracking.Student_Enrolment` : semester_id , degree_program_id , student_enrolment_id , student_id | `student_transcripts_tracking.Student_Enrolment_Courses` : student_course_id , course_id , student_enrolment_id | `student_transcripts_tracking.Transcripts` : transcript_date , transcript_id | `student_transcripts_tracking.Transcript_Contents` : student_course_id , transcript_id | `student_transcripts_tracking.degree_programs_HAS_student_transcripts_tracking.departments` :  | `student_transcripts_tracking.sections_HAS_student_transcripts_tracking.courses` :  | `student_transcripts_tracking.students_HAS_student_transcripts_tracking.addresses` :  | `student_transcripts_tracking.student_enrolment_HAS_student_transcripts_tracking.students` :  | `student_transcripts_tracking.student_enrolment_courses_HAS_student_transcripts_tracking.student_enrolment` :


index       : 369
baseline pre: MATCH (addresses:`student_transcripts_tracking.Addresses`) RETURN DISTINCT addresses.address_id
model1 pred : MATCH (addresses:`student_transcripts_tracking.Addresses`) RETURN DISTINCT addresses.address_id
ground query: MATCH (students:`student_transcripts_tracking.Students`) RETURN count(DISTINCT students.current_address_id)
NLQ         : What are the different addresses that have students living there?
Schema      : | student_transcripts_tracking | `student_transcripts_tracking.Addresses` : city , line_2 , state_province_county , country , address_id , zip_postcode , line_1 | `student_transcripts_tracking.Courses` : course_description , course_id , course_name | `student_transcripts_tracking.Departments` : department_description , department_name , department_id | `student_transcripts_tracking.Degree_Programs` : degree_summary_name , degree_program_id , department_id , degree_summary_description | `student_transcripts_tracking.Sections` : section_id , course_id , section_name , section_description | `student_transcripts_tracking.Semesters` : semester_id , semester_description , semester_name | `student_transcripts_tracking.Students` : ssn , cell_mobile_number , last_name , first_name , date_first_registered , current_address_id , middle_name , email_address , date_left , student_id , other_student_details , permanent_address_id | `student_transcripts_tracking.Student_Enrolment` : semester_id , degree_program_id , student_enrolment_id , student_id | `student_transcripts_tracking.Student_Enrolment_Courses` : student_course_id , course_id , student_enrolment_id | `student_transcripts_tracking.Transcripts` : transcript_date , transcript_id | `student_transcripts_tracking.Transcript_Contents` : student_course_id , transcript_id | `student_transcripts_tracking.degree_programs_HAS_student_transcripts_tracking.departments` :  | `student_transcripts_tracking.sections_HAS_student_transcripts_tracking.courses` :  | `student_transcripts_tracking.students_HAS_student_transcripts_tracking.addresses` :  | `student_transcripts_tracking.student_enrolment_HAS_student_transcripts_tracking.students` :  | `student_transcripts_tracking.student_enrolment_courses_HAS_student_transcripts_tracking.student_enrolment` :


index       : 370
baseline pre: MATCH (students:`student_transcripts_tracking.Students`) RETURN students.other_student_details ORDER BY students.other_student_details
model1 pred : MATCH (student_details:`student_transcripts_tracking.Student_Details`) RETURN student_details.student_details ORDER BY student_details.student_details RETURN student_details.student_details ORDER BY student_details.student_details RETURN student_details ORDER BY student_details.student_details
ground query: MATCH (students:`student_transcripts_tracking.Students`) RETURN students.other_student_details ORDER BY students.other_student_details DESC
NLQ         : List all the student details in reversed lexicographical order.
Schema      : | student_transcripts_tracking | `student_transcripts_tracking.Addresses` : city , line_2 , state_province_county , country , address_id , zip_postcode , line_1 | `student_transcripts_tracking.Courses` : course_description , course_id , course_name | `student_transcripts_tracking.Departments` : department_description , department_name , department_id | `student_transcripts_tracking.Degree_Programs` : degree_summary_name , degree_program_id , department_id , degree_summary_description | `student_transcripts_tracking.Sections` : section_id , course_id , section_name , section_description | `student_transcripts_tracking.Semesters` : semester_id , semester_description , semester_name | `student_transcripts_tracking.Students` : ssn , cell_mobile_number , last_name , first_name , date_first_registered , current_address_id , middle_name , email_address , date_left , student_id , other_student_details , permanent_address_id | `student_transcripts_tracking.Student_Enrolment` : semester_id , degree_program_id , student_enrolment_id , student_id | `student_transcripts_tracking.Student_Enrolment_Courses` : student_course_id , course_id , student_enrolment_id | `student_transcripts_tracking.Transcripts` : transcript_date , transcript_id | `student_transcripts_tracking.Transcript_Contents` : student_course_id , transcript_id | `student_transcripts_tracking.degree_programs_HAS_student_transcripts_tracking.departments` :  | `student_transcripts_tracking.sections_HAS_student_transcripts_tracking.courses` :  | `student_transcripts_tracking.students_HAS_student_transcripts_tracking.addresses` :  | `student_transcripts_tracking.student_enrolment_HAS_student_transcripts_tracking.students` :  | `student_transcripts_tracking.student_enrolment_courses_HAS_student_transcripts_tracking.student_enrolment` :


index       : 371
baseline pre: MATCH (students:`student_transcripts_tracking.Students`) RETURN students.other_student_details ORDER BY students.other_details
model1 pred : MATCH (students:`student_transcripts_tracking.Students`) RETURN students.other_student_details ORDER BY students.other_student_details DESC
ground query: MATCH (students:`student_transcripts_tracking.Students`) RETURN students.other_student_details ORDER BY students.other_student_details DESC
NLQ         : What other details can you tell me about students in reverse alphabetical order?
Schema      : | student_transcripts_tracking | `student_transcripts_tracking.Addresses` : city , line_2 , state_province_county , country , address_id , zip_postcode , line_1 | `student_transcripts_tracking.Courses` : course_description , course_id , course_name | `student_transcripts_tracking.Departments` : department_description , department_name , department_id | `student_transcripts_tracking.Degree_Programs` : degree_summary_name , degree_program_id , department_id , degree_summary_description | `student_transcripts_tracking.Sections` : section_id , course_id , section_name , section_description | `student_transcripts_tracking.Semesters` : semester_id , semester_description , semester_name | `student_transcripts_tracking.Students` : ssn , cell_mobile_number , last_name , first_name , date_first_registered , current_address_id , middle_name , email_address , date_left , student_id , other_student_details , permanent_address_id | `student_transcripts_tracking.Student_Enrolment` : semester_id , degree_program_id , student_enrolment_id , student_id | `student_transcripts_tracking.Student_Enrolment_Courses` : student_course_id , course_id , student_enrolment_id | `student_transcripts_tracking.Transcripts` : transcript_date , transcript_id | `student_transcripts_tracking.Transcript_Contents` : student_course_id , transcript_id | `student_transcripts_tracking.degree_programs_HAS_student_transcripts_tracking.departments` :  | `student_transcripts_tracking.sections_HAS_student_transcripts_tracking.courses` :  | `student_transcripts_tracking.students_HAS_student_transcripts_tracking.addresses` :  | `student_transcripts_tracking.student_enrolment_HAS_student_transcripts_tracking.students` :  | `student_transcripts_tracking.student_enrolment_courses_HAS_student_transcripts_tracking.student_enrolment` :


index       : 372
baseline pre: MATCH (sections:`student_transcripts_tracking.Sections`) WHERE sections.section_id = 'h' RETURN sections.section_name
model1 pred : MATCH (sections:`student_transcripts_tracking.Sections`) WHERE sections.section_name = 'h' RETURN sections.section_description
ground query: MATCH (sections:`student_transcripts_tracking.Sections`) WHERE sections.section_name = 'h' RETURN sections.section_description
NLQ         : Describe the section h.
Schema      : | student_transcripts_tracking | `student_transcripts_tracking.Addresses` : city , line_2 , state_province_county , country , address_id , zip_postcode , line_1 | `student_transcripts_tracking.Courses` : course_description , course_id , course_name | `student_transcripts_tracking.Departments` : department_description , department_name , department_id | `student_transcripts_tracking.Degree_Programs` : degree_summary_name , degree_program_id , department_id , degree_summary_description | `student_transcripts_tracking.Sections` : section_id , course_id , section_name , section_description | `student_transcripts_tracking.Semesters` : semester_id , semester_description , semester_name | `student_transcripts_tracking.Students` : ssn , cell_mobile_number , last_name , first_name , date_first_registered , current_address_id , middle_name , email_address , date_left , student_id , other_student_details , permanent_address_id | `student_transcripts_tracking.Student_Enrolment` : semester_id , degree_program_id , student_enrolment_id , student_id | `student_transcripts_tracking.Student_Enrolment_Courses` : student_course_id , course_id , student_enrolment_id | `student_transcripts_tracking.Transcripts` : transcript_date , transcript_id | `student_transcripts_tracking.Transcript_Contents` : student_course_id , transcript_id | `student_transcripts_tracking.degree_programs_HAS_student_transcripts_tracking.departments` :  | `student_transcripts_tracking.sections_HAS_student_transcripts_tracking.courses` :  | `student_transcripts_tracking.students_HAS_student_transcripts_tracking.addresses` :  | `student_transcripts_tracking.student_enrolment_HAS_student_transcripts_tracking.students` :  | `student_transcripts_tracking.student_enrolment_courses_HAS_student_transcripts_tracking.student_enrolment` :


index       : 374
baseline pre: MATCH (students:`student_transcripts_tracking.Students`) WHERE students.country = 'Haiti' OR students.cell_mobile_number = 09700166582 RETURN students.first_name
model1 pred : MATCH (students:`student_transcripts_tracking.Students`) WHERE students.country = 'Haiti' OR students.cell_mobile_number = 09700166582 RETURN students.first_name
ground query: MATCH (t1:`student_transcripts_tracking.Students`)-[]-(t2:`student_transcripts_tracking.Addresses`) WHERE t2.country = 'haiti' OR t1.cell_mobile_number = '09700166582' RETURN t1.first_name
NLQ         : Find the first name of the students who permanently live in the country Haiti or have the cell phone number 09700166582 .
Schema      : | student_transcripts_tracking | `student_transcripts_tracking.Addresses` : city , line_2 , state_province_county , country ( Haiti ) , address_id , zip_postcode , line_1 | `student_transcripts_tracking.Courses` : course_description , course_id , course_name | `student_transcripts_tracking.Departments` : department_description , department_name , department_id | `student_transcripts_tracking.Degree_Programs` : degree_summary_name , degree_program_id , department_id , degree_summary_description | `student_transcripts_tracking.Sections` : section_id , course_id , section_name , section_description | `student_transcripts_tracking.Semesters` : semester_id , semester_description , semester_name | `student_transcripts_tracking.Students` : ssn , cell_mobile_number , last_name , first_name , date_first_registered , current_address_id , middle_name , email_address , date_left , student_id , other_student_details , permanent_address_id | `student_transcripts_tracking.Student_Enrolment` : semester_id , degree_program_id , student_enrolment_id , student_id | `student_transcripts_tracking.Student_Enrolment_Courses` : student_course_id , course_id , student_enrolment_id | `student_transcripts_tracking.Transcripts` : transcript_date , transcript_id | `student_transcripts_tracking.Transcript_Contents` : student_course_id , transcript_id | `student_transcripts_tracking.degree_programs_HAS_student_transcripts_tracking.departments` :  | `student_transcripts_tracking.sections_HAS_student_transcripts_tracking.courses` :  | `student_transcripts_tracking.students_HAS_student_transcripts_tracking.addresses` :  | `student_transcripts_tracking.student_enrolment_HAS_student_transcripts_tracking.students` :  | `student_transcripts_tracking.student_enrolment_courses_HAS_student_transcripts_tracking.student_enrolment` :


index       : 375
baseline pre: MATCH (students:`student_transcripts_tracking.Students`) WHERE students.country = 'Haiti' OR students.cell_mobile_number = 09700166582 RETURN students.first_name
model1 pred : MATCH (students:`student_transcripts_tracking.Students`) WHERE students.country = 'Haiti' OR students.cell_mobile_number = 09700166582 RETURN students.first_name
ground query: MATCH (t1:`student_transcripts_tracking.Students`)-[]-(t2:`student_transcripts_tracking.Addresses`) WHERE t2.country = 'haiti' OR t1.cell_mobile_number = '09700166582' RETURN t1.first_name
NLQ         : What are the first names of the students who live in Haiti permanently or have the cell phone number 09700166582 ?
Schema      : | student_transcripts_tracking | `student_transcripts_tracking.Addresses` : city , line_2 , state_province_county , country ( Haiti ) , address_id , zip_postcode , line_1 | `student_transcripts_tracking.Courses` : course_description , course_id , course_name | `student_transcripts_tracking.Departments` : department_description , department_name , department_id | `student_transcripts_tracking.Degree_Programs` : degree_summary_name , degree_program_id , department_id , degree_summary_description | `student_transcripts_tracking.Sections` : section_id , course_id , section_name , section_description | `student_transcripts_tracking.Semesters` : semester_id , semester_description , semester_name | `student_transcripts_tracking.Students` : ssn , cell_mobile_number , last_name , first_name , date_first_registered , current_address_id , middle_name , email_address , date_left , student_id , other_student_details , permanent_address_id | `student_transcripts_tracking.Student_Enrolment` : semester_id , degree_program_id , student_enrolment_id , student_id | `student_transcripts_tracking.Student_Enrolment_Courses` : student_course_id , course_id , student_enrolment_id | `student_transcripts_tracking.Transcripts` : transcript_date , transcript_id | `student_transcripts_tracking.Transcript_Contents` : student_course_id , transcript_id | `student_transcripts_tracking.degree_programs_HAS_student_transcripts_tracking.departments` :  | `student_transcripts_tracking.sections_HAS_student_transcripts_tracking.courses` :  | `student_transcripts_tracking.students_HAS_student_transcripts_tracking.addresses` :  | `student_transcripts_tracking.student_enrolment_HAS_student_transcripts_tracking.students` :  | `student_transcripts_tracking.student_enrolment_courses_HAS_student_transcripts_tracking.student_enrolment` :


index       : 377
baseline pre: MATCH (cartoon:`tvshow.Cartoon`) RETURN cartoon.Title ORDER BY cartoon.Title ASC
model1 pred : MATCH (cartoon:`tvshow.Cartoon`) RETURN cartoon.Title ORDER BY cartoon.Title
ground query: MATCH (cartoon:`tvshow.Cartoon`) RETURN cartoon.Title ORDER BY cartoon.Title
NLQ         : What are the titles of the cartoons sorted alphabetically?
Schema      : | tvshow | `tvshow.TV_Channel` : Country , id , series_name , Package_Option , Hight_definition_TV , Language , Pixel_aspect_ratio_PAR , Content , Pay_per_view_PPV | `tvshow.TV_series` : id , Share , Air_Date , 18_49_Rating_Share , Viewers_m , Rating , Weekly_Rank , Episode , Channel | `tvshow.Cartoon` : id , Written_by , Directed_by , Production_code , Title , Original_air_date , Channel | `tvshow.tv_series_HAS_tvshow.tv_channel` :  | `tvshow.cartoon_HAS_tvshow.tv_channel` :


index       : 378
baseline pre: MATCH (cartoon:`tvshow.Cartoon`) WHERE cartoon.Directed_by = 'Ben Jones' RETURN cartoon.Channel
model1 pred : MATCH (cartoon:`tvshow.Cartoon`) WHERE cartoon.Directed_by = 'Ben Jones' RETURN cartoon.Title
ground query: MATCH (cartoon:`tvshow.Cartoon`) WHERE cartoon.Directed_by = 'Ben Jones' RETURN cartoon.Title
NLQ         : List all cartoon directed by "Ben Jones".
Schema      : | tvshow | `tvshow.TV_Channel` : Country , id , series_name , Package_Option , Hight_definition_TV , Language , Pixel_aspect_ratio_PAR , Content , Pay_per_view_PPV | `tvshow.TV_series` : id , Share , Air_Date , 18_49_Rating_Share , Viewers_m , Rating , Weekly_Rank , Episode , Channel | `tvshow.Cartoon` : id , Written_by , Directed_by ( Ben Jones ) , Production_code , Title , Original_air_date , Channel | `tvshow.tv_series_HAS_tvshow.tv_channel` :  | `tvshow.cartoon_HAS_tvshow.tv_channel` :


index       : 379
baseline pre: MATCH (cartoon:`tvshow.Cartoon`) WHERE cartoon.Directed_by = 'Ben Jones' RETURN cartoon.Series_name
model1 pred : MATCH (cartoon:`tvshow.Cartoon`) WHERE cartoon.Directed_by = 'Ben Jones' RETURN cartoon.Title
ground query: MATCH (cartoon:`tvshow.Cartoon`) WHERE cartoon.Directed_by = 'Ben Jones' RETURN cartoon.Title
NLQ         : What are the names of all cartoons directed by Ben Jones?
Schema      : | tvshow | `tvshow.TV_Channel` : Country , id , series_name , Package_Option , Hight_definition_TV , Language , Pixel_aspect_ratio_PAR , Content , Pay_per_view_PPV | `tvshow.TV_series` : id , Share , Air_Date , 18_49_Rating_Share , Viewers_m , Rating , Weekly_Rank , Episode , Channel | `tvshow.Cartoon` : id , Written_by , Directed_by ( Ben Jones ) , Production_code , Title , Original_air_date , Channel | `tvshow.tv_series_HAS_tvshow.tv_channel` :  | `tvshow.cartoon_HAS_tvshow.tv_channel` :


index       : 386
baseline pre: MATCH (TV_channel:`tvshow.TV_Channel`) WHERE TV_channel.series_name = 'Sky Radio' RETURN TV_channel.Content
model1 pred : MATCH (TV_channel:`tvshow.TV_Channel`) WHERE TV_Channel.series_name = 'Sky Radio' RETURN TV_Channel.Content
ground query: MATCH (tv_channel:`tvshow.TV_Channel`) WHERE tv_channel.series_name = 'Sky Radio' RETURN tv_channel.Content
NLQ         : What is the content of TV Channel with serial name "Sky Radio"?
Schema      : | tvshow | `tvshow.TV_Channel` : Country , id , series_name ( Sky Radio ) , Package_Option , Hight_definition_TV , Language , Pixel_aspect_ratio_PAR , Content , Pay_per_view_PPV | `tvshow.TV_series` : id , Share , Air_Date , 18_49_Rating_Share , Viewers_m , Rating , Weekly_Rank , Episode , Channel | `tvshow.Cartoon` : id , Written_by , Directed_by , Production_code , Title , Original_air_date , Channel | `tvshow.tv_series_HAS_tvshow.tv_channel` :  | `tvshow.cartoon_HAS_tvshow.tv_channel` :


index       : 387
baseline pre: MATCH (TV_Channel:`tvshow.TV_Channel`) WHERE TV_Channel.series_name = 'Sky Radio' RETURN TV_Channel.Content
model1 pred : MATCH (TV_series:`tvshow.TV_Series`) WHERE TV_series.series_name = 'Sky Radio' RETURN TV_series.Content
ground query: MATCH (tv_channel:`tvshow.TV_Channel`) WHERE tv_channel.series_name = 'Sky Radio' RETURN tv_channel.Content
NLQ         : What is the content of the series Sky Radio?
Schema      : | tvshow | `tvshow.TV_Channel` : Country , id , series_name ( Sky Radio ) , Package_Option , Hight_definition_TV , Language , Pixel_aspect_ratio_PAR , Content , Pay_per_view_PPV | `tvshow.TV_series` : id , Share , Air_Date , 18_49_Rating_Share , Viewers_m , Rating , Weekly_Rank , Episode , Channel | `tvshow.Cartoon` : id , Written_by , Directed_by , Production_code , Title , Original_air_date , Channel | `tvshow.tv_series_HAS_tvshow.tv_channel` :  | `tvshow.cartoon_HAS_tvshow.tv_channel` :


index       : 388
baseline pre: MATCH (TV_channel:`tvshow.TV_Channel`) WHERE TV_channel.series_name = 'Sky Radio' RETURN TV_channel.Package_Option
model1 pred : MATCH (TV_channel:`tvshow.TV_Channel`) WHERE TV_channel.series_name = 'Sky Radio' RETURN TV_channel.Package_Option
ground query: MATCH (tv_channel:`tvshow.TV_Channel`) WHERE tv_channel.series_name = 'Sky Radio' RETURN tv_channel.Package_Option
NLQ         : What is the Package Option of TV Channel with serial name "Sky Radio"?
Schema      : | tvshow | `tvshow.TV_Channel` : Country , id , series_name ( Sky Radio ) , Package_Option ( Option ) , Hight_definition_TV , Language , Pixel_aspect_ratio_PAR , Content , Pay_per_view_PPV | `tvshow.TV_series` : id , Share , Air_Date , 18_49_Rating_Share , Viewers_m , Rating , Weekly_Rank , Episode , Channel | `tvshow.Cartoon` : id , Written_by , Directed_by , Production_code , Title , Original_air_date , Channel | `tvshow.tv_series_HAS_tvshow.tv_channel` :  | `tvshow.cartoon_HAS_tvshow.tv_channel` :


index       : 389
baseline pre: MATCH (TV_channel:`tvshow.TV_Channel`) WHERE TV_channel.series_name = 'Sky Radio' RETURN TV_channel.Package_Option
model1 pred : MATCH (TV_channel:`tvshow.TV_Channel`) WHERE TV_channel.series_name = 'Sky Radio' RETURN TV_channel.Package_Option
ground query: MATCH (tv_channel:`tvshow.TV_Channel`) WHERE tv_channel.series_name = 'Sky Radio' RETURN tv_channel.Package_Option
NLQ         : What are the Package Options of the TV Channels whose series names are Sky Radio?
Schema      : | tvshow | `tvshow.TV_Channel` : Country , id , series_name ( Sky Radio ) , Package_Option ( Option ) , Hight_definition_TV , Language , Pixel_aspect_ratio_PAR , Content , Pay_per_view_PPV | `tvshow.TV_series` : id , Share , Air_Date , 18_49_Rating_Share , Viewers_m , Rating , Weekly_Rank , Episode , Channel | `tvshow.Cartoon` : id , Written_by , Directed_by , Production_code , Title , Original_air_date , Channel | `tvshow.tv_series_HAS_tvshow.tv_channel` :  | `tvshow.cartoon_HAS_tvshow.tv_channel` :


index       : 390
baseline pre: MATCH (TV_channel:`tvshow.TV_Channel`) WHERE TV_channel.Language = 'English' RETURN count(*)
model1 pred : MATCH (TV_channel:`tvshow.TV_Channel`) WHERE TV_channel.Language = 'English' RETURN count(*)
ground query: MATCH (tv_channel:`tvshow.TV_Channel`) WHERE tv_channel.Language = 'English' RETURN count(*)
NLQ         : How many TV Channel using language English?
Schema      : | tvshow | `tvshow.TV_Channel` : Country , id , series_name , Package_Option , Hight_definition_TV , Language ( English ) , Pixel_aspect_ratio_PAR , Content , Pay_per_view_PPV | `tvshow.TV_series` : id , Share , Air_Date , 18_49_Rating_Share , Viewers_m , Rating , Weekly_Rank , Episode , Channel | `tvshow.Cartoon` : id , Written_by , Directed_by , Production_code , Title , Original_air_date , Channel | `tvshow.tv_series_HAS_tvshow.tv_channel` :  | `tvshow.cartoon_HAS_tvshow.tv_channel` :


index       : 391
baseline pre: MATCH (TV_channel:`tvshow.TV_Channel`) WHERE TV_channel.Language = 'English' RETURN count(*)
model1 pred : MATCH (TV_channel:`tvshow.TV_Channel`) WHERE TV_channel.Language = 'English' RETURN count(*)
ground query: MATCH (tv_channel:`tvshow.TV_Channel`) WHERE tv_channel.Language = 'English' RETURN count(*)
NLQ         : How many TV Channels use the English language?
Schema      : | tvshow | `tvshow.TV_Channel` : Country , id , series_name , Package_Option , Hight_definition_TV , Language ( English ) , Pixel_aspect_ratio_PAR , Content , Pay_per_view_PPV | `tvshow.TV_series` : id , Share , Air_Date , 18_49_Rating_Share , Viewers_m , Rating , Weekly_Rank , Episode , Channel | `tvshow.Cartoon` : id , Written_by , Directed_by , Production_code , Title , Original_air_date , Channel | `tvshow.tv_series_HAS_tvshow.tv_channel` :  | `tvshow.cartoon_HAS_tvshow.tv_channel` :


index       : 392
baseline pre: MATCH (TV_channel:`tvshow.TV_Channel`) RETURN TV_channel.Language,count(*) ORDER BY TV_channel.Language ASC LIMIT 1
model1 pred : MATCH (TV_channel:`tvshow.TV_Channel`) RETURN TV_channel.Language,count(*) ORDER BY TV_channel.Language ASC LIMIT 1
ground query: MATCH (tv_channel:`tvshow.TV_Channel`) RETURN tv_channel.Language,count(*) ORDER BY tv_channel.Language ASC LIMIT 1
NLQ         : List the language used least number of TV Channel. List language and number of TV Channel.
Schema      : | tvshow | `tvshow.TV_Channel` : Country , id , series_name , Package_Option , Hight_definition_TV , Language , Pixel_aspect_ratio_PAR , Content , Pay_per_view_PPV | `tvshow.TV_series` : id , Share , Air_Date , 18_49_Rating_Share , Viewers_m , Rating , Weekly_Rank , Episode , Channel | `tvshow.Cartoon` : id , Written_by , Directed_by , Production_code , Title , Original_air_date , Channel | `tvshow.tv_series_HAS_tvshow.tv_channel` :  | `tvshow.cartoon_HAS_tvshow.tv_channel` :


index       : 393
baseline pre: MATCH (TV_channel:`tvshow.TV_Channel`) RETURN TV_channel.Language ORDER BY TV_channel.Language ASC LIMIT 1
model1 pred : MATCH (TV_channel:`tvshow.TV_Channel`) RETURN TV_Channel.Language ORDER BY TV_Channel.Language ASC LIMIT 1
ground query: MATCH (tv_channel:`tvshow.TV_Channel`) RETURN tv_channel.Language,count(*) ORDER BY tv_channel.Language ASC LIMIT 1
NLQ         : What are the languages used by the least number of TV Channels and how many channels use it?
Schema      : | tvshow | `tvshow.TV_Channel` : Country , id , series_name , Package_Option , Hight_definition_TV , Language , Pixel_aspect_ratio_PAR , Content , Pay_per_view_PPV | `tvshow.TV_series` : id , Share , Air_Date , 18_49_Rating_Share , Viewers_m , Rating , Weekly_Rank , Episode , Channel | `tvshow.Cartoon` : id , Written_by , Directed_by , Production_code , Title , Original_air_date , Channel | `tvshow.tv_series_HAS_tvshow.tv_channel` :  | `tvshow.cartoon_HAS_tvshow.tv_channel` :


index       : 394
baseline pre: MATCH (TV_channel:`tvshow.TV_Channel`) RETURN TV_channel.Language,count(*)
model1 pred : MATCH (TV_channel:`tvshow.TV_Channel`) RETURN TV_channel.Language,count(*)
ground query: MATCH (tv_channel:`tvshow.TV_Channel`) RETURN tv_channel.Language,count(*)
NLQ         : List each language and the number of TV Channels using it.
Schema      : | tvshow | `tvshow.TV_Channel` : Country , id , series_name , Package_Option , Hight_definition_TV , Language , Pixel_aspect_ratio_PAR , Content , Pay_per_view_PPV | `tvshow.TV_series` : id , Share , Air_Date , 18_49_Rating_Share , Viewers_m , Rating , Weekly_Rank , Episode , Channel | `tvshow.Cartoon` : id , Written_by , Directed_by , Production_code , Title , Original_air_date , Channel | `tvshow.tv_series_HAS_tvshow.tv_channel` :  | `tvshow.cartoon_HAS_tvshow.tv_channel` :


index       : 395
baseline pre: MATCH (TV_channel:`tvshow.TV_Channel`) RETURN TV_channel.Language,count(*)
model1 pred : MATCH (TV_channel:`tvshow.TV_Channel`) RETURN TV_channel.Language,count(*)
ground query: MATCH (tv_channel:`tvshow.TV_Channel`) RETURN tv_channel.Language,count(*)
NLQ         : For each language, list the number of TV Channels that use it.
Schema      : | tvshow | `tvshow.TV_Channel` : Country , id , series_name , Package_Option , Hight_definition_TV , Language , Pixel_aspect_ratio_PAR , Content , Pay_per_view_PPV | `tvshow.TV_series` : id , Share , Air_Date , 18_49_Rating_Share , Viewers_m , Rating , Weekly_Rank , Episode , Channel | `tvshow.Cartoon` : id , Written_by , Directed_by , Production_code , Title , Original_air_date , Channel | `tvshow.tv_series_HAS_tvshow.tv_channel` :  | `tvshow.cartoon_HAS_tvshow.tv_channel` :


index       : 396
baseline pre: MATCH (T1:`tvshow.Cartoon`)-[]-(T2:`tvshow.TV_Channel`) WHERE T2.Title = 'The Rise of the Blue Beetle' RETURN T1.Channel
model1 pred : MATCH (TV_channel:`tvshow.TV_Channel`) WHERE TV_channel.Title = 'The Rise of the Blue Beetle!' RETURN TV_channel.series_name
ground query: MATCH (T1:`tvshow.TV_Channel`)-[]-(T2:`tvshow.Cartoon`) WHERE T2.Title = 'The Rise of the Blue Beetle!' RETURN T1.series_name
NLQ         : What is the TV Channel that shows the cartoon "The Rise of the Blue Beetle!"? List the TV Channel's series name.
Schema      : | tvshow | `tvshow.TV_Channel` : Country , id , series_name , Package_Option , Hight_definition_TV , Language , Pixel_aspect_ratio_PAR , Content , Pay_per_view_PPV | `tvshow.TV_series` : id , Share , Air_Date , 18_49_Rating_Share , Viewers_m , Rating , Weekly_Rank , Episode , Channel | `tvshow.Cartoon` : id , Written_by , Directed_by , Production_code , Title ( The Rise of the Blue Beetle! ) , Original_air_date , Channel | `tvshow.tv_series_HAS_tvshow.tv_channel` :  | `tvshow.cartoon_HAS_tvshow.tv_channel` :


index       : 397
baseline pre: MATCH (T1:`tvshow.Cartoon`)-[]-(T2:`tvshow.TV_Channel`) WHERE T2.Title = 'The Rise of the Blue Beetle' RETURN T2.series_name
model1 pred : MATCH (T1:`tvshow.Cartoon`)-[]-(T2:`tvshow.TV_Channel`) WHERE T2.Title = 'The Rise of the Blue Beetle!' RETURN T1.series_name
ground query: MATCH (T1:`tvshow.TV_Channel`)-[]-(T2:`tvshow.Cartoon`) WHERE T2.Title = 'The Rise of the Blue Beetle!' RETURN T1.series_name
NLQ         : What is the series name of the TV Channel that shows the cartoon "The Rise of the Blue Beetle"?
Schema      : | tvshow | `tvshow.TV_Channel` : Country , id , series_name , Package_Option , Hight_definition_TV , Language , Pixel_aspect_ratio_PAR , Content , Pay_per_view_PPV | `tvshow.TV_series` : id , Share , Air_Date , 18_49_Rating_Share , Viewers_m , Rating , Weekly_Rank , Episode , Channel | `tvshow.Cartoon` : id , Written_by , Directed_by , Production_code , Title ( The Rise of the Blue Beetle! ) , Original_air_date , Channel | `tvshow.tv_series_HAS_tvshow.tv_channel` :  | `tvshow.cartoon_HAS_tvshow.tv_channel` :


index       : 398
baseline pre: MATCH (T1:`tvshow.Cartoon`)-[]-(T2:`tvshow.TV_Channel`) WHERE T2.series_name = 'Sky Radio' RETURN T1.Title
model1 pred : MATCH (T1:`tvshow.Cartoon`)-[]-(T2:`tvshow.TV_Channel`) WHERE T2.series_name = 'Sky Radio' RETURN T1.Title
ground query: MATCH (T1:`tvshow.TV_Channel`)-[]-(T2:`tvshow.Cartoon`) WHERE T1.series_name = 'Sky Radio' RETURN T2.Title
NLQ         : List the title of all  Cartoons showed on TV Channel with series name "Sky Radio".
Schema      : | tvshow | `tvshow.TV_Channel` : Country , id , series_name ( Sky Radio ) , Package_Option , Hight_definition_TV , Language , Pixel_aspect_ratio_PAR , Content , Pay_per_view_PPV | `tvshow.TV_series` : id , Share , Air_Date , 18_49_Rating_Share , Viewers_m , Rating , Weekly_Rank , Episode , Channel | `tvshow.Cartoon` : id , Written_by , Directed_by , Production_code , Title , Original_air_date , Channel | `tvshow.tv_series_HAS_tvshow.tv_channel` :  | `tvshow.cartoon_HAS_tvshow.tv_channel` :


index       : 399
baseline pre: MATCH (T1:`tvshow.Cartoon`)-[]-(T2:`tvshow.TV_Channel`) WHERE T2.series_name = 'Sky Radio' RETURN T1.Title
model1 pred : MATCH (T1:`tvshow.Cartoon`)-[]-(T2:`tvshow.TV_Channel`) WHERE T2.series_name = 'Sky Radio' RETURN T1.Title
ground query: MATCH (T1:`tvshow.TV_Channel`)-[]-(T2:`tvshow.Cartoon`) WHERE T1.series_name = 'Sky Radio' RETURN T2.Title
NLQ         : What is the title of all the cartools that are on the TV Channel with the series name "Sky Radio"?
Schema      : | tvshow | `tvshow.TV_Channel` : Country , id , series_name ( Sky Radio ) , Package_Option , Hight_definition_TV , Language , Pixel_aspect_ratio_PAR , Content , Pay_per_view_PPV | `tvshow.TV_series` : id , Share , Air_Date , 18_49_Rating_Share , Viewers_m , Rating , Weekly_Rank , Episode , Channel | `tvshow.Cartoon` : id , Written_by , Directed_by , Production_code , Title , Original_air_date , Channel | `tvshow.tv_series_HAS_tvshow.tv_channel` :  | `tvshow.cartoon_HAS_tvshow.tv_channel` :


index       : 400
baseline pre: MATCH (TV_series:`tvshow.TV_series`) RETURN TV_series.Episode ORDER BY TV_series.Rating
model1 pred : MATCH (TV_series:`tvshow.TV_series`) RETURN TV_series.Episode ORDER BY TV_series.Rating
ground query: MATCH (tv_series:`tvshow.TV_series`) RETURN tv_series.Episode ORDER BY tv_series.Rating
NLQ         : List the Episode of all TV series sorted by rating.
Schema      : | tvshow | `tvshow.TV_Channel` : Country , id , series_name , Package_Option , Hight_definition_TV , Language , Pixel_aspect_ratio_PAR , Content , Pay_per_view_PPV | `tvshow.TV_series` : id , Share , Air_Date , 18_49_Rating_Share , Viewers_m , Rating , Weekly_Rank , Episode , Channel | `tvshow.Cartoon` : id , Written_by , Directed_by , Production_code , Title , Original_air_date , Channel | `tvshow.tv_series_HAS_tvshow.tv_channel` :  | `tvshow.cartoon_HAS_tvshow.tv_channel` :


index       : 401
baseline pre: MATCH (TV_series:`tvshow.TV_series`) RETURN TV_series.Episode ORDER BY TV_series.Rating
model1 pred : MATCH (TV_series:`tvshow.TV_series`) RETURN TV_series.Episode ORDER BY TV_series.Rating
ground query: MATCH (tv_series:`tvshow.TV_series`) RETURN tv_series.Episode ORDER BY tv_series.Rating
NLQ         : What are all of the episodes ordered by ratings?
Schema      : | tvshow | `tvshow.TV_Channel` : Country , id , series_name , Package_Option , Hight_definition_TV , Language , Pixel_aspect_ratio_PAR , Content , Pay_per_view_PPV | `tvshow.TV_series` : id , Share , Air_Date , 18_49_Rating_Share , Viewers_m , Rating , Weekly_Rank , Episode , Channel | `tvshow.Cartoon` : id , Written_by , Directed_by , Production_code , Title , Original_air_date , Channel | `tvshow.tv_series_HAS_tvshow.tv_channel` :  | `tvshow.cartoon_HAS_tvshow.tv_channel` :


index       : 402
baseline pre: MATCH (TV_series:`tvshow.TV_series`) RETURN TV_series.Episode,TV_series.Rating ORDER BY TV_series.Rating DESC LIMIT 3
model1 pred : MATCH (TV_series:`tvshow.TV_series`) RETURN TV_series.Episode,TV_series.Rating ORDER BY TV_series.Rating DESC LIMIT 3
ground query: MATCH (tv_series:`tvshow.TV_series`) RETURN tv_series.Episode,tv_series.Rating ORDER BY tv_series.Rating DESC LIMIT 3
NLQ         : List top 3 highest Rating  TV series. List the TV series's Episode and Rating.
Schema      : | tvshow | `tvshow.TV_Channel` : Country , id , series_name , Package_Option , Hight_definition_TV , Language , Pixel_aspect_ratio_PAR , Content , Pay_per_view_PPV | `tvshow.TV_series` : id , Share , Air_Date , 18_49_Rating_Share , Viewers_m , Rating , Weekly_Rank , Episode , Channel | `tvshow.Cartoon` : id , Written_by , Directed_by , Production_code , Title , Original_air_date , Channel | `tvshow.tv_series_HAS_tvshow.tv_channel` :  | `tvshow.cartoon_HAS_tvshow.tv_channel` :


index       : 403
baseline pre: MATCH (TV_series:`tvshow.TV_series`) RETURN TV_series.Episode,TV_series.Rating ORDER BY TV_series.Rating DESC LIMIT 3
model1 pred : MATCH (TV_series:`tvshow.TV_series`) RETURN TV_series.Episode,TV_series.Rating ORDER BY TV_series.Rating DESC LIMIT 3
ground query: MATCH (tv_series:`tvshow.TV_series`) RETURN tv_series.Episode,tv_series.Rating ORDER BY tv_series.Rating DESC LIMIT 3
NLQ         : What are 3 most highly rated episodes in the TV series table and what were those ratings?
Schema      : | tvshow | `tvshow.TV_Channel` : Country , id , series_name , Package_Option , Hight_definition_TV , Language , Pixel_aspect_ratio_PAR , Content , Pay_per_view_PPV | `tvshow.TV_series` : id , Share , Air_Date , 18_49_Rating_Share , Viewers_m , Rating , Weekly_Rank , Episode , Channel | `tvshow.Cartoon` : id , Written_by , Directed_by , Production_code , Title , Original_air_date , Channel | `tvshow.tv_series_HAS_tvshow.tv_channel` :  | `tvshow.cartoon_HAS_tvshow.tv_channel` :


index       : 404
baseline pre: MATCH (TV_series:`tvshow.TV_series`) RETURN min(TV_series.Share),max(TV_series.Share)
model1 pred : MATCH (TV_series:`tvshow.TV_series`) RETURN min(TV_series.Share),max(TV_series.Share)
ground query: MATCH (tv_series:`tvshow.TV_series`) RETURN max(tv_series.Share),min(tv_series.Share)
NLQ         : What is minimum and maximum share of TV series?
Schema      : | tvshow | `tvshow.TV_Channel` : Country , id , series_name , Package_Option , Hight_definition_TV , Language , Pixel_aspect_ratio_PAR , Content , Pay_per_view_PPV | `tvshow.TV_series` : id , Share , Air_Date , 18_49_Rating_Share , Viewers_m , Rating , Weekly_Rank , Episode , Channel | `tvshow.Cartoon` : id , Written_by , Directed_by , Production_code , Title , Original_air_date , Channel | `tvshow.tv_series_HAS_tvshow.tv_channel` :  | `tvshow.cartoon_HAS_tvshow.tv_channel` :


index       : 405
baseline pre: MATCH (TV_series:`tvshow.TV_series`) RETURN max(TV_series.Share),min(TV_series.Share)
model1 pred : MATCH (TV_series:`tvshow.TV_series`) RETURN max(TV_series.Share),min(TV_series.Share)
ground query: MATCH (tv_series:`tvshow.TV_series`) RETURN max(tv_series.Share),min(tv_series.Share)
NLQ         : What is the maximum and minimum share for the TV series?
Schema      : | tvshow | `tvshow.TV_Channel` : Country , id , series_name , Package_Option , Hight_definition_TV , Language , Pixel_aspect_ratio_PAR , Content , Pay_per_view_PPV | `tvshow.TV_series` : id , Share , Air_Date , 18_49_Rating_Share , Viewers_m , Rating , Weekly_Rank , Episode , Channel | `tvshow.Cartoon` : id , Written_by , Directed_by , Production_code , Title , Original_air_date , Channel | `tvshow.tv_series_HAS_tvshow.tv_channel` :  | `tvshow.cartoon_HAS_tvshow.tv_channel` :


index       : 406
baseline pre: MATCH (TV_series:`tvshow.TV_series`) WHERE TV_series.Episode = 'A Love of a Lifetime' RETURN TV_series.Air_Date
model1 pred : MATCH (TV_series:`tvshow.TV_series`) WHERE TV_series.Episode = 'A Love of a Lifetime' RETURN TV_series.Air_Date
ground query: MATCH (tv_series:`tvshow.TV_series`) WHERE tv_series.Episode = 'A Love of a Lifetime' RETURN tv_series.Air_Date
NLQ         : What is the air date of TV series with Episode "A Love of a Lifetime"?
Schema      : | tvshow | `tvshow.TV_Channel` : Country , id , series_name , Package_Option , Hight_definition_TV , Language , Pixel_aspect_ratio_PAR , Content , Pay_per_view_PPV | `tvshow.TV_series` : id , Share , Air_Date , 18_49_Rating_Share , Viewers_m , Rating , Weekly_Rank , Episode ( A Love of a Lifetime ) , Channel | `tvshow.Cartoon` : id , Written_by , Directed_by , Production_code , Title , Original_air_date , Channel | `tvshow.tv_series_HAS_tvshow.tv_channel` :  | `tvshow.cartoon_HAS_tvshow.tv_channel` :


index       : 407
baseline pre: MATCH (TV_series:`tvshow.TV_series`) WHERE TV_series.Episode = 'A Love of a Lifetime' RETURN TV_series.Air_Date
model1 pred : MATCH (TV_series:`tvshow.TV_series`) WHERE TV_series.Episode = 'A Love of a Lifetime' RETURN TV_series.Air_Date
ground query: MATCH (tv_series:`tvshow.TV_series`) WHERE tv_series.Episode = 'A Love of a Lifetime' RETURN tv_series.Air_Date
NLQ         : When did the episode "A Love of a Lifetime" air?
Schema      : | tvshow | `tvshow.TV_Channel` : Country , id , series_name , Package_Option , Hight_definition_TV , Language , Pixel_aspect_ratio_PAR , Content , Pay_per_view_PPV | `tvshow.TV_series` : id , Share , Air_Date , 18_49_Rating_Share , Viewers_m , Rating , Weekly_Rank , Episode ( A Love of a Lifetime ) , Channel | `tvshow.Cartoon` : id , Written_by , Directed_by , Production_code , Title , Original_air_date , Channel | `tvshow.tv_series_HAS_tvshow.tv_channel` :  | `tvshow.cartoon_HAS_tvshow.tv_channel` :


index       : 408
baseline pre: MATCH (TV_series:`tvshow.TV_series`) WHERE TV_series.Episode = 'A Love of a Lifetime' RETURN TV_series.Weekly_Rank
model1 pred : MATCH (TV_series:`tvshow.TV_series`) WHERE TV_series.Episode = 'A Love of a Lifetime' RETURN TV_series.Weekly_Rank
ground query: MATCH (tv_series:`tvshow.TV_series`) WHERE tv_series.Episode = 'A Love of a Lifetime' RETURN tv_series.Weekly_Rank
NLQ         : What is Weekly Rank of TV series with Episode "A Love of a Lifetime"?
Schema      : | tvshow | `tvshow.TV_Channel` : Country , id , series_name , Package_Option , Hight_definition_TV , Language , Pixel_aspect_ratio_PAR , Content , Pay_per_view_PPV | `tvshow.TV_series` : id , Share , Air_Date , 18_49_Rating_Share , Viewers_m , Rating , Weekly_Rank , Episode ( A Love of a Lifetime ) , Channel | `tvshow.Cartoon` : id , Written_by , Directed_by , Production_code , Title , Original_air_date , Channel | `tvshow.tv_series_HAS_tvshow.tv_channel` :  | `tvshow.cartoon_HAS_tvshow.tv_channel` :


index       : 409
baseline pre: MATCH (TV_series:`tvshow.TV_series`) WHERE TV_series.Episode = 'A Love of a Lifetime' RETURN TV_series.Weekly_Rank
model1 pred : MATCH (TV_series:`tvshow.TV_series`) WHERE TV_series.Episode = 'A Love of a Lifetime' RETURN TV_series.Weekly_Rank
ground query: MATCH (tv_series:`tvshow.TV_series`) WHERE tv_series.Episode = 'A Love of a Lifetime' RETURN tv_series.Weekly_Rank
NLQ         : What is the weekly rank for the episode "A Love of a Lifetime"?
Schema      : | tvshow | `tvshow.TV_Channel` : Country , id , series_name , Package_Option , Hight_definition_TV , Language , Pixel_aspect_ratio_PAR , Content , Pay_per_view_PPV | `tvshow.TV_series` : id , Share , Air_Date , 18_49_Rating_Share , Viewers_m , Rating , Weekly_Rank , Episode ( A Love of a Lifetime ) , Channel | `tvshow.Cartoon` : id , Written_by , Directed_by , Production_code , Title , Original_air_date , Channel | `tvshow.tv_series_HAS_tvshow.tv_channel` :  | `tvshow.cartoon_HAS_tvshow.tv_channel` :


index       : 410
baseline pre: MATCH (TV_series:`tvshow.TV_series`) WHERE TV_series.Episode = 'A Love of a Lifetime' RETURN TV_channel.Channel
model1 pred : MATCH (TV_series:`tvshow.TV_series`) WHERE TV_series.Episode = 'A Love of a Lifetime' RETURN TV_series.Series_name
ground query: MATCH (T1:`tvshow.TV_Channel`)-[]-(T2:`tvshow.TV_series`) WHERE T2.Episode = 'A Love of a Lifetime' RETURN T1.series_name
NLQ         : What is the TV Channel of TV series with Episode "A Love of a Lifetime"? List the TV Channel's series name.
Schema      : | tvshow | `tvshow.TV_Channel` : Country , id , series_name , Package_Option , Hight_definition_TV , Language , Pixel_aspect_ratio_PAR , Content , Pay_per_view_PPV | `tvshow.TV_series` : id , Share , Air_Date , 18_49_Rating_Share , Viewers_m , Rating , Weekly_Rank , Episode ( A Love of a Lifetime ) , Channel | `tvshow.Cartoon` : id , Written_by , Directed_by , Production_code , Title , Original_air_date , Channel | `tvshow.tv_series_HAS_tvshow.tv_channel` :  | `tvshow.cartoon_HAS_tvshow.tv_channel` :


index       : 411
baseline pre: MATCH (TV_series:`tvshow.TV_series`) WHERE TV_series.Episode = 'A Love of a Lifetime' RETURN TV_series.series_name
model1 pred : MATCH (TV_series:`tvshow.TV_series`) WHERE TV_series.Episode = 'A Love of a Lifetime' RETURN TV_series.series_name
ground query: MATCH (T1:`tvshow.TV_Channel`)-[]-(T2:`tvshow.TV_series`) WHERE T2.Episode = 'A Love of a Lifetime' RETURN T1.series_name
NLQ         : What is the name of the series that has the episode "A Love of a Lifetime"?
Schema      : | tvshow | `tvshow.TV_Channel` : Country , id , series_name , Package_Option , Hight_definition_TV , Language , Pixel_aspect_ratio_PAR , Content , Pay_per_view_PPV | `tvshow.TV_series` : id , Share , Air_Date , 18_49_Rating_Share , Viewers_m , Rating , Weekly_Rank , Episode ( A Love of a Lifetime ) , Channel | `tvshow.Cartoon` : id , Written_by , Directed_by , Production_code , Title , Original_air_date , Channel | `tvshow.tv_series_HAS_tvshow.tv_channel` :  | `tvshow.cartoon_HAS_tvshow.tv_channel` :


index       : 412
baseline pre: MATCH (TV_channel:`tvshow.TV_Channel`) WHERE TV_channel.series_name = 'Sky Radio' RETURN TV_channel.Episode
model1 pred : MATCH (TV_series:`tvshow.TV_series`) WHERE TV_Channel.series_name = 'Sky Radio' RETURN TV_series.Episode
ground query: MATCH (T1:`tvshow.TV_Channel`)-[]-(T2:`tvshow.TV_series`) WHERE T1.series_name = 'Sky Radio' RETURN T2.Episode
NLQ         : List the Episode of all  TV series showed on TV Channel with series name "Sky Radio".
Schema      : | tvshow | `tvshow.TV_Channel` : Country , id , series_name ( Sky Radio ) , Package_Option , Hight_definition_TV , Language , Pixel_aspect_ratio_PAR , Content , Pay_per_view_PPV | `tvshow.TV_series` : id , Share , Air_Date , 18_49_Rating_Share , Viewers_m , Rating , Weekly_Rank , Episode , Channel | `tvshow.Cartoon` : id , Written_by , Directed_by , Production_code , Title , Original_air_date , Channel | `tvshow.tv_series_HAS_tvshow.tv_channel` :  | `tvshow.cartoon_HAS_tvshow.tv_channel` :


index       : 413
baseline pre: MATCH (TV_Channel:`tvshow.TV_Channel`) WHERE TV_Channel.series_name = 'Sky Radio' RETURN TV_Channel.Episode
model1 pred : MATCH (TV_series:`tvshow.TV_series`) WHERE TV_series.series_name = 'Sky Radio' RETURN TV_series.Episode
ground query: MATCH (T1:`tvshow.TV_Channel`)-[]-(T2:`tvshow.TV_series`) WHERE T1.series_name = 'Sky Radio' RETURN T2.Episode
NLQ         : What is the episode for the TV series named "Sky Radio"?
Schema      : | tvshow | `tvshow.TV_Channel` : Country , id , series_name ( Sky Radio ) , Package_Option , Hight_definition_TV , Language , Pixel_aspect_ratio_PAR , Content , Pay_per_view_PPV | `tvshow.TV_series` : id , Share , Air_Date , 18_49_Rating_Share , Viewers_m , Rating , Weekly_Rank , Episode , Channel | `tvshow.Cartoon` : id , Written_by , Directed_by , Production_code , Title , Original_air_date , Channel | `tvshow.tv_series_HAS_tvshow.tv_channel` :  | `tvshow.cartoon_HAS_tvshow.tv_channel` :


index       : 414
baseline pre: MATCH (cartoon:`tvshow.Cartoon`) RETURN cartoon.Directed_by,count(*)
model1 pred : MATCH (cartoon:`tvshow.Cartoon`) RETURN cartoon.Directed_by,count(*)
ground query: MATCH (cartoon:`tvshow.Cartoon`) RETURN count(*),cartoon.Directed_by
NLQ         : Find the number of cartoons directed by each of the listed directors.
Schema      : | tvshow | `tvshow.TV_Channel` : Country , id , series_name , Package_Option , Hight_definition_TV , Language , Pixel_aspect_ratio_PAR , Content , Pay_per_view_PPV | `tvshow.TV_series` : id , Share , Air_Date , 18_49_Rating_Share , Viewers_m , Rating , Weekly_Rank , Episode , Channel | `tvshow.Cartoon` : id , Written_by , Directed_by , Production_code , Title , Original_air_date , Channel | `tvshow.tv_series_HAS_tvshow.tv_channel` :  | `tvshow.cartoon_HAS_tvshow.tv_channel` :


index       : 415
baseline pre: MATCH (cartoon:`tvshow.Cartoon`) RETURN cartoon.Directed_by,count(*)
model1 pred : MATCH (cartoon:`tvshow.Cartoon`) RETURN cartoon.Directed_by,count(*)
ground query: MATCH (cartoon:`tvshow.Cartoon`) RETURN count(*),cartoon.Directed_by
NLQ         : How many cartoons did each director create?
Schema      : | tvshow | `tvshow.TV_Channel` : Country , id , series_name , Package_Option , Hight_definition_TV , Language , Pixel_aspect_ratio_PAR , Content , Pay_per_view_PPV | `tvshow.TV_series` : id , Share , Air_Date , 18_49_Rating_Share , Viewers_m , Rating , Weekly_Rank , Episode , Channel | `tvshow.Cartoon` : id , Written_by , Directed_by , Production_code , Title , Original_air_date , Channel | `tvshow.tv_series_HAS_tvshow.tv_channel` :  | `tvshow.cartoon_HAS_tvshow.tv_channel` :


index       : 417
baseline pre: MATCH (cartoon:`tvshow.Cartoon`) RETURN cartoon.Prodution_code,cartoon.Channel ORDER BY cartoon.Original_air_date DESC LIMIT 1
model1 pred : MATCH (cartoon:`tvshow.Cartoon`) RETURN cartoon.Produdction_code,cartoon.Channel ORDER BY cartoon.Original_air_date DESC LIMIT 1
ground query: MATCH (cartoon:`tvshow.Cartoon`) RETURN cartoon.Production_code,cartoon.Channel ORDER BY cartoon.Original_air_date DESC LIMIT 1
NLQ         : What is the produdction code and channel of the most recent cartoon ?
Schema      : | tvshow | `tvshow.TV_Channel` : Country , id , series_name , Package_Option , Hight_definition_TV , Language , Pixel_aspect_ratio_PAR , Content , Pay_per_view_PPV | `tvshow.TV_series` : id , Share , Air_Date , 18_49_Rating_Share , Viewers_m , Rating , Weekly_Rank , Episode , Channel | `tvshow.Cartoon` : id , Written_by , Directed_by , Production_code , Title , Original_air_date , Channel | `tvshow.tv_series_HAS_tvshow.tv_channel` :  | `tvshow.cartoon_HAS_tvshow.tv_channel` :


index       : 418
baseline pre: MATCH (TV_channel:`tvshow.TV_Channel`) WHERE TV_channel.Hight_definition_TV = 'Y' RETURN TV_channel.Package_Option,TV_channel.series_name
model1 pred : MATCH (TV_channel:`tvshow.TV_Channel`) WHERE TV_channel.Hight_definition_TV = 'TV' RETURN TV_channel.Package_Option,tv_channel.series_name
ground query: MATCH (tv_channel:`tvshow.TV_Channel`) WHERE tv_channel.Hight_definition_TV = 'yes' RETURN tv_channel.Package_Option,tv_channel.series_name
NLQ         : Find the package choice and series name of the TV channel that has high definition TV.
Schema      : | tvshow | `tvshow.TV_Channel` : Country , id , series_name , Package_Option , Hight_definition_TV , Language , Pixel_aspect_ratio_PAR , Content , Pay_per_view_PPV | `tvshow.TV_series` : id , Share , Air_Date , 18_49_Rating_Share , Viewers_m , Rating , Weekly_Rank , Episode , Channel | `tvshow.Cartoon` : id , Written_by , Directed_by , Production_code , Title , Original_air_date , Channel | `tvshow.tv_series_HAS_tvshow.tv_channel` :  | `tvshow.cartoon_HAS_tvshow.tv_channel` :


index       : 419
baseline pre: MATCH (TV_Channel:`tvshow.TV_Channel`) WHERE TV_Channel.Hight_definition_TV = 'Yes' RETURN TV_Channel.Package_Option,TV_Channel.series_name
model1 pred : MATCH (TV_channel:`tvshow.TV_Channel`) WHERE TV_channel.Hight_definition_TV = 'Option' RETURN TV_channel.Package_Option,tv_series.series_name
ground query: MATCH (tv_channel:`tvshow.TV_Channel`) WHERE tv_channel.Hight_definition_TV = 'yes' RETURN tv_channel.Package_Option,tv_channel.series_name
NLQ         : What are the package options and the name of the series for the TV Channel that supports high definition TV?
Schema      : | tvshow | `tvshow.TV_Channel` : Country , id , series_name , Package_Option ( Option ) , Hight_definition_TV , Language , Pixel_aspect_ratio_PAR , Content , Pay_per_view_PPV | `tvshow.TV_series` : id , Share , Air_Date , 18_49_Rating_Share , Viewers_m , Rating , Weekly_Rank , Episode , Channel | `tvshow.Cartoon` : id , Written_by , Directed_by , Production_code , Title , Original_air_date , Channel | `tvshow.tv_series_HAS_tvshow.tv_channel` :  | `tvshow.cartoon_HAS_tvshow.tv_channel` :


index       : 420
baseline pre: MATCH (T1:`tvshow.Cartoon`)-[]-(T2:`tvshow.TV_Channel`) WHERE T2.Written_by = 'Todd Casey' RETURN T2.Country
model1 pred : MATCH (T1:`tvshow.Cartoon`)-[]-(T2:`tvshow.TV_Channel`) WHERE T2.Written_by = 'Todd Casey' RETURN T2.Country
ground query: MATCH (T1:`tvshow.TV_Channel`)-[]-(T2:`tvshow.Cartoon`) WHERE T2.Written_by = 'Todd Casey' RETURN T1.Country
NLQ         : which countries' tv channels are playing some cartoon written by Todd Casey?
Schema      : | tvshow | `tvshow.TV_Channel` : Country , id , series_name , Package_Option , Hight_definition_TV , Language , Pixel_aspect_ratio_PAR , Content , Pay_per_view_PPV | `tvshow.TV_series` : id , Share , Air_Date , 18_49_Rating_Share , Viewers_m , Rating , Weekly_Rank , Episode , Channel | `tvshow.Cartoon` : id , Written_by ( Todd Casey ) , Directed_by , Production_code , Title , Original_air_date , Channel | `tvshow.tv_series_HAS_tvshow.tv_channel` :  | `tvshow.cartoon_HAS_tvshow.tv_channel` :


index       : 421
baseline pre: MATCH (T1:`tvshow.Cartoon`)-[]-(T2:`tvshow.TV_Channel`) WHERE T2.Written_by = 'Todd Casey' RETURN T2.Country
model1 pred : MATCH (cartoon:`tvshow.Cartoon`) WHERE cartoon.Written_by = 'Todd Casey' RETURN cartoon.Country
ground query: MATCH (T1:`tvshow.TV_Channel`)-[]-(T2:`tvshow.Cartoon`) WHERE T2.Written_by = 'Todd Casey' RETURN T1.Country
NLQ         : What are the countries that have cartoons on TV that were written by Todd Casey?
Schema      : | tvshow | `tvshow.TV_Channel` : Country , id , series_name , Package_Option , Hight_definition_TV , Language , Pixel_aspect_ratio_PAR , Content , Pay_per_view_PPV | `tvshow.TV_series` : id , Share , Air_Date , 18_49_Rating_Share , Viewers_m , Rating , Weekly_Rank , Episode , Channel | `tvshow.Cartoon` : id , Written_by ( Todd Casey ) , Directed_by , Production_code , Title , Original_air_date , Channel | `tvshow.tv_series_HAS_tvshow.tv_channel` :  | `tvshow.cartoon_HAS_tvshow.tv_channel` :


index       : 422
baseline pre: MATCH (tv_channel:`tvshow.TV_Channel`) WHERE tv_channel.Language  < > 'English' RETURN tv_channel.Pixel_aspect_ratio_PAR,tv_channel.Country
model1 pred : MATCH (tv_channel:`tvshow.TV_Channel`) WHERE tv_channel.Language ` > 'English' RETURN tv_channel.Pixel_aspect_ratio_PAR,tv_channel.Country
ground query: MATCH (tv_channel:`tvshow.TV_Channel`) WHERE tv_channel.Language <> 'English' RETURN tv_channel.Pixel_aspect_ratio_PAR,tv_channel.Country
NLQ         : find the pixel aspect ratio and nation of the tv channels that do not use English.
Schema      : | tvshow | `tvshow.TV_Channel` : Country , id , series_name , Package_Option , Hight_definition_TV , Language ( English ) , Pixel_aspect_ratio_PAR , Content , Pay_per_view_PPV | `tvshow.TV_series` : id , Share , Air_Date , 18_49_Rating_Share , Viewers_m , Rating , Weekly_Rank , Episode , Channel | `tvshow.Cartoon` : id , Written_by , Directed_by , Production_code , Title , Original_air_date , Channel | `tvshow.tv_series_HAS_tvshow.tv_channel` :  | `tvshow.cartoon_HAS_tvshow.tv_channel` :


index       : 423
baseline pre: MATCH (TV_channel:`tvshow.TV_Channel`) WHERE TV_channel.Language  < > 'English' RETURN TV_channel.Pixel_aspect_ratio_PAR,TV_channel.Country
model1 pred : MATCH (TV_channel:`tvshow.TV_Channel`) WHERE TV_channel.Language ` > 'English' RETURN TV_channel.Pixel_aspect_ratio_PAR,tv_channel.Country
ground query: MATCH (tv_channel:`tvshow.TV_Channel`) WHERE tv_channel.Language <> 'English' RETURN tv_channel.Pixel_aspect_ratio_PAR,tv_channel.Country
NLQ         : What is the pixel aspect ratio and country of origin for all TV channels that do not use English?
Schema      : | tvshow | `tvshow.TV_Channel` : Country , id , series_name , Package_Option , Hight_definition_TV , Language ( English ) , Pixel_aspect_ratio_PAR , Content , Pay_per_view_PPV | `tvshow.TV_series` : id , Share , Air_Date , 18_49_Rating_Share , Viewers_m , Rating , Weekly_Rank , Episode , Channel | `tvshow.Cartoon` : id , Written_by , Directed_by , Production_code , Title , Original_air_date , Channel | `tvshow.tv_series_HAS_tvshow.tv_channel` :  | `tvshow.cartoon_HAS_tvshow.tv_channel` :


index       : 428
baseline pre: MATCH (poker_player:`poker_player.poker_player`) RETURN poker_player.Final_Table_Made,poker_player.Best_Finish ORDER BY poker_player.Best_Finish DESC LIMIT 1
model1 pred : MATCH (poker_player:`poker_player.poker_player`) RETURN poker_player.Final_Table_Made,poker_player.Best_Finish ORDER BY poker_player.Final_Table_Made DESC LIMIT 1
ground query: MATCH (poker_player:`poker_player.poker_player`) RETURN poker_player.Final_Table_Made,poker_player.Best_Finish
NLQ         : List the final tables made and the best finishes of poker players.
Schema      : | poker_player | `poker_player.poker_player` : Money_Rank , People_ID , Final_Table_Made , Best_Finish , Poker_Player_ID , Earnings | `poker_player.people` : Name , Birth_Date , People_ID , Nationality , Height | `poker_player.poker_player_HAS_poker_player.people` :


index       : 434
baseline pre: MATCH (poker_player:`poker_player.poker_player`) WHERE poker_player.Earnings  < 200000 RETURN max(poker_player.Final_Table_Made)
model1 pred : MATCH (poker_player:`poker_player.poker_player`) WHERE poker_player.Earnings ` 200000 RETURN max(poker_player.Final_Table_Made)
ground query: MATCH (poker_player:`poker_player.poker_player`) WHERE poker_player.Earnings < 200000 RETURN max(poker_player.Final_Table_Made)
NLQ         : What is the maximum number of final tables made among poker players with earnings less than 200000?
Schema      : | poker_player | `poker_player.poker_player` : Money_Rank , People_ID , Final_Table_Made , Best_Finish , Poker_Player_ID , Earnings | `poker_player.people` : Name , Birth_Date , People_ID , Nationality , Height | `poker_player.poker_player_HAS_poker_player.people` :


index       : 435
baseline pre: MATCH (poker_player:`poker_player.poker_player`) WHERE poker_player.Earnings  < 200000 RETURN max(poker_player.Final_Table_Made)
model1 pred : MATCH (poker_player:`poker_player.poker_player`) WHERE poker_player.Earnings ` 200000 RETURN max(poker_player.Final_Table_Made)
ground query: MATCH (poker_player:`poker_player.poker_player`) WHERE poker_player.Earnings < 200000 RETURN max(poker_player.Final_Table_Made)
NLQ         : Return the maximum final tables made across all poker players who have earnings below 200000.
Schema      : | poker_player | `poker_player.poker_player` : Money_Rank , People_ID , Final_Table_Made , Best_Finish , Poker_Player_ID , Earnings | `poker_player.people` : Name , Birth_Date , People_ID , Nationality , Height | `poker_player.poker_player_HAS_poker_player.people` :


index       : 440
baseline pre: MATCH (poker_player:`poker_player.poker_player`) RETURN poker_player.Name ORDER BY poker_player.Final_Table_Made ASC
model1 pred : MATCH (poker_player:`poker_player.poker_player`) RETURN poker_player.Name ORDER BY poker_player.Final_Table_Made ASC
ground query: MATCH (T1:`poker_player.people`)-[]-(T2:`poker_player.poker_player`) RETURN T1.Name ORDER BY T2.Final_Table_Made
NLQ         : List the names of poker players ordered by the final tables made in ascending order.
Schema      : | poker_player | `poker_player.poker_player` : Money_Rank , People_ID , Final_Table_Made , Best_Finish , Poker_Player_ID , Earnings | `poker_player.people` : Name , Birth_Date , People_ID , Nationality , Height | `poker_player.poker_player_HAS_poker_player.people` :


index       : 441
baseline pre: MATCH (T1:`poker_player.people`)-[]-(T2:`poker_player.poker_player`) RETURN T1.Name ORDER BY T2.Final_Table_Made ASC
model1 pred : MATCH (poker_player:`poker_player.poker_player`) RETURN poker_player.Name ORDER BY poker_player.Final_Table_Made ASC
ground query: MATCH (T1:`poker_player.people`)-[]-(T2:`poker_player.poker_player`) RETURN T1.Name ORDER BY T2.Final_Table_Made
NLQ         : What are the names of poker players, ordered ascending by the number of final tables they have made?
Schema      : | poker_player | `poker_player.poker_player` : Money_Rank , People_ID , Final_Table_Made , Best_Finish , Poker_Player_ID , Earnings | `poker_player.people` : Name , Birth_Date , People_ID , Nationality , Height | `poker_player.poker_player_HAS_poker_player.people` :


index       : 442
baseline pre: MATCH (T1:`poker_player.people`)-[]-(T2:`poker_player.poker_player`) RETURN T1.Birth_Date ORDER BY T2.Earnings LIMIT 1
model1 pred : MATCH (T1:`poker_player.people`)-[]-(T2:`poker_player.poker_player`) WITH count(T1.Poker_Player_ID) AS cnt, T1 RETURN T1.Birth_Date ORDER BY cnt LIMIT 1
ground query: MATCH (T1:`poker_player.people`)-[]-(T2:`poker_player.poker_player`) RETURN T1.Birth_Date ORDER BY T2.Earnings ASC LIMIT 1
NLQ         : What is the birth date of the poker player with the lowest earnings?
Schema      : | poker_player | `poker_player.poker_player` : Money_Rank , People_ID , Final_Table_Made , Best_Finish , Poker_Player_ID , Earnings | `poker_player.people` : Name , Birth_Date , People_ID , Nationality , Height | `poker_player.poker_player_HAS_poker_player.people` :


index       : 443
baseline pre: MATCH (T1:`poker_player.people`)-[]-(T2:`poker_player.poker_player`) RETURN T1.Birth_Date ORDER BY T2.Earnings LIMIT 1
model1 pred : MATCH (T1:`poker_player.people`)-[]-(T2:`poker_player.poker_player`) WITH count(T1.Poker_Player_ID) AS cnt, T1 RETURN T1.Birth_Date ORDER BY cnt LIMIT 1
ground query: MATCH (T1:`poker_player.people`)-[]-(T2:`poker_player.poker_player`) RETURN T1.Birth_Date ORDER BY T2.Earnings ASC LIMIT 1
NLQ         : Return the birth date of the poker player with the lowest earnings.
Schema      : | poker_player | `poker_player.poker_player` : Money_Rank , People_ID , Final_Table_Made , Best_Finish , Poker_Player_ID , Earnings | `poker_player.people` : Name , Birth_Date , People_ID , Nationality , Height | `poker_player.poker_player_HAS_poker_player.people` :


index       : 444
baseline pre: MATCH (T1:`poker_player.poker_player`)-[]-(T2:`poker_player.people`) RETURN T2.Money_Rank ORDER BY T2.Height DESC LIMIT 1
model1 pred : MATCH (T1:`poker_player.poker_player`)-[]-(T2:`poker_player.people`) RETURN T2.Money_Rank ORDER BY T2.Height DESC LIMIT 1
ground query: MATCH (T1:`poker_player.people`)-[]-(T2:`poker_player.poker_player`) RETURN T2.Money_Rank ORDER BY T1.Height DESC LIMIT 1
NLQ         : What is the money rank of the tallest poker player?
Schema      : | poker_player | `poker_player.poker_player` : Money_Rank , People_ID , Final_Table_Made , Best_Finish , Poker_Player_ID , Earnings | `poker_player.people` : Name , Birth_Date , People_ID , Nationality , Height | `poker_player.poker_player_HAS_poker_player.people` :


index       : 445
baseline pre: MATCH (T1:`poker_player.poker_player`)-[]-(T2:`poker_player.people`) RETURN T2.Money_Rank ORDER BY T2.Height DESC LIMIT 1
model1 pred : MATCH (T1:`poker_player.poker_player`)-[]-(T2:`poker_player.people`) RETURN T1.Money_Rank ORDER BY T2.Height DESC LIMIT 1
ground query: MATCH (T1:`poker_player.people`)-[]-(T2:`poker_player.poker_player`) RETURN T2.Money_Rank ORDER BY T1.Height DESC LIMIT 1
NLQ         : Return the money rank of the poker player with the greatest height.
Schema      : | poker_player | `poker_player.poker_player` : Money_Rank , People_ID , Final_Table_Made , Best_Finish , Poker_Player_ID , Earnings | `poker_player.people` : Name , Birth_Date , People_ID , Nationality , Height | `poker_player.poker_player_HAS_poker_player.people` :


index       : 447
baseline pre: MATCH (poker_player:`poker_player.poker_player`) RETURN poker_player.Name ORDER BY poker_player.Earnings DESC
model1 pred : MATCH (T1:`poker_player.people`)-[]-(T2:`poker_player.poker_player`) RETURN T1.Name ORDER BY T2.Earnings DESC
ground query: MATCH (T1:`poker_player.people`)-[]-(T2:`poker_player.poker_player`) RETURN T1.Name ORDER BY T2.Earnings DESC
NLQ         : Return the names of poker players sorted by their earnings descending.
Schema      : | poker_player | `poker_player.poker_player` : Money_Rank , People_ID , Final_Table_Made , Best_Finish , Poker_Player_ID , Earnings | `poker_player.people` : Name , Birth_Date , People_ID , Nationality , Height | `poker_player.poker_player_HAS_poker_player.people` :


index       : 452
baseline pre: MATCH (people:`poker_player.people`) WITH count(*) AS count, people.Nationality AS Nationality WHERE count >= 2 RETURN Nationality
model1 pred : MATCH (people:`poker_player.people`) WITH count(*) AS count, people.Nationality AS Nationality WHERE count >= 2 RETURN Nationality
ground query: MATCH (people:`poker_player.people`) WITH people.Nationality AS Nationality, count(*) AS count WHERE count  >= 2 RETURN Nationality
NLQ         : What are the nationalities that are shared by at least two people?
Schema      : | poker_player | `poker_player.poker_player` : Money_Rank , People_ID , Final_Table_Made , Best_Finish , Poker_Player_ID , Earnings | `poker_player.people` : Name , Birth_Date , People_ID , Nationality , Height | `poker_player.poker_player_HAS_poker_player.people` :


index       : 453
baseline pre: MATCH (people:`poker_player.people`) WITH count(*) AS count, people.Nationality AS Nationality WHERE count >= 2 RETURN Nationality
model1 pred : MATCH (people:`poker_player.people`) WITH count(*) AS count, people.Nationality AS Nationality WHERE count >= 2 RETURN Nationality
ground query: MATCH (people:`poker_player.people`) WITH people.Nationality AS Nationality, count(*) AS count WHERE count  >= 2 RETURN Nationality
NLQ         : Return the nationalities for which there are two or more people.
Schema      : | poker_player | `poker_player.poker_player` : Money_Rank , People_ID , Final_Table_Made , Best_Finish , Poker_Player_ID , Earnings | `poker_player.people` : Name , Birth_Date , People_ID , Nationality , Height | `poker_player.poker_player_HAS_poker_player.people` :


index       : 456
baseline pre: MATCH (people:`poker_player.people`) WHERE people.Nationality  < > 'Russia' RETURN people.Name
model1 pred : MATCH (people:`poker_player.people`) WHERE people.Nationality ` > 'Russia' RETURN people.Name
ground query: MATCH (people:`poker_player.people`) WHERE people.Nationality <> 'Russia' RETURN people.Name
NLQ         : Show names of people whose nationality is not "Russia".
Schema      : | poker_player | `poker_player.poker_player` : Money_Rank , People_ID , Final_Table_Made , Best_Finish , Poker_Player_ID , Earnings | `poker_player.people` : Name , Birth_Date , People_ID , Nationality ( Russia ) , Height | `poker_player.poker_player_HAS_poker_player.people` :


index       : 457
baseline pre: MATCH (people:`poker_player.people`) WHERE people.Nationality  < > 'Russia' RETURN people.Name
model1 pred : MATCH (people:`poker_player.people`) WHERE people.Nationality ` > 'Russia' RETURN people.Name
ground query: MATCH (people:`poker_player.people`) WHERE people.Nationality <> 'Russia' RETURN people.Name
NLQ         : What are the names of people who are not from Russia?
Schema      : | poker_player | `poker_player.poker_player` : Money_Rank , People_ID , Final_Table_Made , Best_Finish , Poker_Player_ID , Earnings | `poker_player.people` : Name , Birth_Date , People_ID , Nationality ( Russia ) , Height | `poker_player.poker_player_HAS_poker_player.people` :


index       : 458
baseline pre: MATCH (people:`poker_player.people`) WHERE NOT (people)-[]-(:`poker_player.poker_player`) RETURN people.Name
model1 pred : MATCH (people:`poker_player.people`) WHERE NOT (people)-[]-(:`poker_player.poker_player`) RETURN people.Name
ground query: MATCH (people:`poker_player.people`) WHERE NOT (people)-[]-(:`poker_player.poker_player`)     RETURN people.Name
NLQ         : List the names of people that are not poker players.
Schema      : | poker_player | `poker_player.poker_player` : Money_Rank , People_ID , Final_Table_Made , Best_Finish , Poker_Player_ID , Earnings | `poker_player.people` : Name , Birth_Date , People_ID , Nationality , Height | `poker_player.poker_player_HAS_poker_player.people` :


index       : 459
baseline pre: MATCH (people:`poker_player.people`) WHERE NOT (people)-[]-(:`poker_player.poker_player`) RETURN people.Name
model1 pred : MATCH (people:`poker_player.people`) WHERE NOT (people)-[]-(:`poker_player.poker_player`) RETURN people.Name
ground query: MATCH (people:`poker_player.people`) WHERE NOT (people)-[]-(:`poker_player.poker_player`)     RETURN people.Name
NLQ         : What are the names of people who do not play poker?
Schema      : | poker_player | `poker_player.poker_player` : Money_Rank , People_ID , Final_Table_Made , Best_Finish , Poker_Player_ID , Earnings | `poker_player.people` : Name , Birth_Date , People_ID , Nationality , Height | `poker_player.poker_player_HAS_poker_player.people` :


index       : 465
baseline pre: MATCH (AREA_CODE_STATE:`voter_1.AREA_CODE_STATE`) RETURN max(AREA_CODE_STATE.area_code),min(AREA_CODE_STATE.area_code)
model1 pred : MATCH (area_code:`voter_1.AREA_CODE_STATE`) RETURN max(area_code.area_code),min(area_code.area_code)
ground query: MATCH (area_code_state:`voter_1.AREA_CODE_STATE`) RETURN max(area_code_state.area_code),min(area_code_state.area_code)
NLQ         : What are the maximum and minimum values of area codes?
Schema      : | voter_1 | `voter_1.AREA_CODE_STATE` : area_code , state | `voter_1.CONTESTANTS` : contestant_number , contestant_name | `voter_1.VOTES` : contestant_number , created , state , vote_id , phone_number | `voter_1.votes_HAS_voter_1.contestants` :


index       : 466
baseline pre: MATCH (votes:`voter_1.VOTES`) WHERE votes.state = 'CA' RETURN votes.created
model1 pred : MATCH (votes:`voter_1.VOTES`) WHERE votes.state = 'CA' RETURN votes.created
ground query: MATCH (votes:`voter_1.VOTES`) WHERE votes.state = 'CA' RETURN max(votes.created)
NLQ         : What is last date created of votes from the state 'CA'?
Schema      : | voter_1 | `voter_1.AREA_CODE_STATE` : area_code , state ( CA ) | `voter_1.CONTESTANTS` : contestant_number , contestant_name | `voter_1.VOTES` : contestant_number , created , state ( CA ) , vote_id , phone_number | `voter_1.votes_HAS_voter_1.contestants` :


index       : 467
baseline pre: MATCH (contestants:`voter_1.CONTESTANTS`) WHERE contestants.contestant_name  < > 'Jessie Alloway' RETURN contestants.contestant_name
model1 pred : MATCH (contestants:`voter_1.CONTESTANTS`) WHERE contestants.contestant_name ` > 'Jessie Alloway' RETURN contestants.contestant_name
ground query: MATCH (contestants:`voter_1.CONTESTANTS`) WHERE contestants.contestant_name <> 'Jessie Alloway' RETURN contestants.contestant_name
NLQ         : What are the names of the contestants whose names are not 'Jessie Alloway'
Schema      : | voter_1 | `voter_1.AREA_CODE_STATE` : area_code , state | `voter_1.CONTESTANTS` : contestant_number , contestant_name ( Jessie Alloway ) | `voter_1.VOTES` : contestant_number , created , state , vote_id , phone_number | `voter_1.votes_HAS_voter_1.contestants` :


index       : 468
baseline pre: MATCH (votes:`voter_1.VOTES`) RETURN DISTINCT votes.state,votes.create
model1 pred : MATCH (votes:`voter_1.VOTES`) RETURN DISTINCT votes.state,votes.created
ground query: MATCH (votes:`voter_1.VOTES`) RETURN DISTINCT votes.state,votes.created
NLQ         : What are the distinct states and create time of all votes?
Schema      : | voter_1 | `voter_1.AREA_CODE_STATE` : area_code , state | `voter_1.CONTESTANTS` : contestant_number , contestant_name | `voter_1.VOTES` : contestant_number , created , state , vote_id , phone_number | `voter_1.votes_HAS_voter_1.contestants` :


index       : 469
baseline pre: MATCH (T1:`voter_1.CONTESTANTS`)-[]-(T2:`voter_1.VOTES`) WITH count(*) AS count, T1.contestant_number AS contestant_number WHERE count >= 2 RETURN contestant_number,contestant_name
model1 pred : MATCH (T1:`voter_1.CONTESTANTS`)-[]-(T2:`voter_1.VOTES`) WITH count(*) AS count, T1.contestant_name AS contestant_name, T1.contestant_number AS contestant_number WHERE count >= 2 RETURN contestant_number,contestant_name
ground query: MATCH (T1:`voter_1.CONTESTANTS`)-[]-(T2:`voter_1.VOTES`) WITH count(*) AS count, T1.contestant_number AS contestant_number, T1.contestant_name AS contestant_name WHERE count  >= 2 RETURN contestant_number,contestant_name
NLQ         : What are the contestant numbers and names of the contestants who had at least two votes?
Schema      : | voter_1 | `voter_1.AREA_CODE_STATE` : area_code , state | `voter_1.CONTESTANTS` : contestant_number , contestant_name | `voter_1.VOTES` : contestant_number , created , state , vote_id , phone_number | `voter_1.votes_HAS_voter_1.contestants` :


index       : 470
baseline pre: MATCH (T1:`voter_1.CONTESTANTS`)-[]-(T2:`voter_1.VOTES`) WITH count(T1.contestant_number) AS cnt, T2 RETURN T2.contestant_number,T2.contestant_name ORDER BY cnt LIMIT 1
model1 pred : MATCH (T1:`voter_1.CONTESTANTS`)-[]-(T2:`voter_1.VOTES`) WITH count(T1.contestant_number) AS cnt, T1 RETURN T1.contestant_number,T1.contestant_name ORDER BY cnt LIMIT 1
ground query: MATCH (T1:`voter_1.CONTESTANTS`)-[]-(T2:`voter_1.VOTES`) WITH T1, count(T1.contestant_number) AS cnt RETURN T1.contestant_number,T1.contestant_name ORDER BY cnt ASC LIMIT 1
NLQ         : Of all the contestants who got voted, what is the contestant number and name of the contestant who got least votes?
Schema      : | voter_1 | `voter_1.AREA_CODE_STATE` : area_code , state | `voter_1.CONTESTANTS` : contestant_number , contestant_name | `voter_1.VOTES` : contestant_number , created , state , vote_id , phone_number | `voter_1.votes_HAS_voter_1.contestants` :


index       : 472
baseline pre: MATCH (T1:`voter_1.CONTESTANTS`)-[]-(T2:`voter_1.VOTES`) WHERE T2.contestant_name = 'Tabatha Gehling' RETURN T1.create,T2.state,T1.phone_number
model1 pred : MATCH (T1:`voter_1.CONTESTANTS`)-[]-(T2:`voter_1.VOTES`) WHERE T1.contestant_name = 'Tabatha Gehling' RETURN T1.created,T1.state,T1.phone_number
ground query: MATCH (T1:`voter_1.CONTESTANTS`)-[]-(T2:`voter_1.VOTES`) WHERE T1.contestant_name = 'Tabatha Gehling' RETURN T2.created,T2.state,T2.phone_number
NLQ         : What are the create dates, states, and phone numbers of the votes that were for the contestant named 'Tabatha Gehling'?
Schema      : | voter_1 | `voter_1.AREA_CODE_STATE` : area_code , state | `voter_1.CONTESTANTS` : contestant_number , contestant_name ( Tabatha Gehling ) | `voter_1.VOTES` : contestant_number , created , state , vote_id , phone_number | `voter_1.votes_HAS_voter_1.contestants` :


index       : 476
baseline pre: MATCH (conductor:`orchestra.conductor`) RETURN conductor.Name ORDER BY conductor.Age
model1 pred : MATCH (conductor:`orchestra.conductor`) RETURN conductor.Name ORDER BY conductor.Age
ground query: MATCH (conductor:`orchestra.conductor`) RETURN conductor.Name ORDER BY conductor.Age ASC
NLQ         : What are the names of conductors, ordered by age?
Schema      : | orchestra | `orchestra.conductor` : Age , Name , Conductor_ID , Nationality , Year_of_Work | `orchestra.orchestra` : Orchestra , Conductor_ID , Major_Record_Format , Record_Company , Year_of_Founded , Orchestra_ID | `orchestra.performance` : Type , Date , Share , Performance_ID , Weekly_rank , Official_ratings_(millions) , Orchestra_ID | `orchestra.show` : Performance_ID , Show_ID , If_first_show , Attendance , Result | `orchestra.orchestra_HAS_orchestra.conductor` :  | `orchestra.performance_HAS_orchestra.orchestra` :  | `orchestra.show_HAS_orchestra.performance` :


index       : 477
baseline pre: MATCH (conductor:`orchestra.conductor`) WHERE conductor.Nationality  < > 'USA' RETURN conductor.Name
model1 pred : MATCH (conductor:`orchestra.conductor`) WHERE conductor.Nationality ` > 'USA' RETURN conductor.Name
ground query: MATCH (conductor:`orchestra.conductor`) WHERE conductor.Nationality <> 'USA' RETURN conductor.Name
NLQ         : What are the names of conductors whose nationalities are not "USA"?
Schema      : | orchestra | `orchestra.conductor` : Age , Name , Conductor_ID , Nationality ( USA ) , Year_of_Work | `orchestra.orchestra` : Orchestra , Conductor_ID , Major_Record_Format , Record_Company , Year_of_Founded , Orchestra_ID | `orchestra.performance` : Type , Date , Share , Performance_ID , Weekly_rank , Official_ratings_(millions) , Orchestra_ID | `orchestra.show` : Performance_ID , Show_ID , If_first_show , Attendance , Result | `orchestra.orchestra_HAS_orchestra.conductor` :  | `orchestra.performance_HAS_orchestra.orchestra` :  | `orchestra.show_HAS_orchestra.performance` :


index       : 478
baseline pre: MATCH (conductor:`orchestra.conductor`) WHERE conductor.Nationality  < > 'USA' RETURN conductor.Name
model1 pred : MATCH (conductor:`orchestra.conductor`) WHERE conductor.Nationality ` > 'USA' RETURN conductor.Name
ground query: MATCH (conductor:`orchestra.conductor`) WHERE conductor.Nationality <> 'USA' RETURN conductor.Name
NLQ         : Return the names of conductors that do not have the nationality "USA".
Schema      : | orchestra | `orchestra.conductor` : Age , Name , Conductor_ID , Nationality ( USA ) , Year_of_Work | `orchestra.orchestra` : Orchestra , Conductor_ID , Major_Record_Format , Record_Company , Year_of_Founded , Orchestra_ID | `orchestra.performance` : Type , Date , Share , Performance_ID , Weekly_rank , Official_ratings_(millions) , Orchestra_ID | `orchestra.show` : Performance_ID , Show_ID , If_first_show , Attendance , Result | `orchestra.orchestra_HAS_orchestra.conductor` :  | `orchestra.performance_HAS_orchestra.orchestra` :  | `orchestra.show_HAS_orchestra.performance` :


index       : 483
baseline pre: MATCH (performance:`orchestra.performance`) WHERE performance.Type  < > 'Live final' RETURN max(performance.Share),min(performance.Share)
model1 pred : MATCH (performance:`orchestra.performance`) WHERE performance.Type ` > 'Live final' RETURN max(performance.Share),min(performance.Share)
ground query: MATCH (performance:`orchestra.performance`) WHERE performance.Type <> 'Live final' RETURN max(performance.Share),min(performance.Share)
NLQ         : What are the maximum and minimum share of performances whose type is not "Live final".
Schema      : | orchestra | `orchestra.conductor` : Age , Name , Conductor_ID , Nationality , Year_of_Work | `orchestra.orchestra` : Orchestra , Conductor_ID , Major_Record_Format , Record_Company , Year_of_Founded , Orchestra_ID | `orchestra.performance` : Type ( Live final ) , Date , Share , Performance_ID , Weekly_rank , Official_ratings_(millions) , Orchestra_ID | `orchestra.show` : Performance_ID , Show_ID , If_first_show , Attendance , Result | `orchestra.orchestra_HAS_orchestra.conductor` :  | `orchestra.performance_HAS_orchestra.orchestra` :  | `orchestra.show_HAS_orchestra.performance` :


index       : 484
baseline pre: MATCH (performance:`orchestra.performance`) WHERE performance.Type  < > 'Live final' RETURN max(performance.Share),min(performance.Share)
model1 pred : MATCH (performance:`orchestra.performance`) WHERE performance.Type ` > 'Live final' RETURN max(performance.Share),min(performance.Share)
ground query: MATCH (performance:`orchestra.performance`) WHERE performance.Type <> 'Live final' RETURN max(performance.Share),min(performance.Share)
NLQ         : Return the maximum and minimum shares for performances that do not have the type "Live final".
Schema      : | orchestra | `orchestra.conductor` : Age , Name , Conductor_ID , Nationality , Year_of_Work | `orchestra.orchestra` : Orchestra , Conductor_ID , Major_Record_Format , Record_Company , Year_of_Founded , Orchestra_ID | `orchestra.performance` : Type ( Live final ) , Date , Share , Performance_ID , Weekly_rank , Official_ratings_(millions) , Orchestra_ID | `orchestra.show` : Performance_ID , Show_ID , If_first_show , Attendance , Result | `orchestra.orchestra_HAS_orchestra.conductor` :  | `orchestra.performance_HAS_orchestra.orchestra` :  | `orchestra.show_HAS_orchestra.performance` :


index       : 489
baseline pre: MATCH (t1:`orchestra.conductor`)-[]-(t2:`orchestra.orchestra`) RETURN t1.Name ORDER BY t2.Year_of_Work DESC LIMIT 1
model1 pred : MATCH (conductor:`orchestra.conductor`) RETURN conductor.Name ORDER BY conductor.Year_of_Work DESC LIMIT 1
ground query: MATCH (conductor:`orchestra.conductor`) RETURN conductor.Name ORDER BY conductor.Year_of_Work DESC LIMIT 1
NLQ         : List the name of the conductor with the most years of work.
Schema      : | orchestra | `orchestra.conductor` : Age , Name , Conductor_ID , Nationality , Year_of_Work | `orchestra.orchestra` : Orchestra , Conductor_ID , Major_Record_Format , Record_Company , Year_of_Founded , Orchestra_ID | `orchestra.performance` : Type , Date , Share , Performance_ID , Weekly_rank , Official_ratings_(millions) , Orchestra_ID | `orchestra.show` : Performance_ID , Show_ID , If_first_show , Attendance , Result | `orchestra.orchestra_HAS_orchestra.conductor` :  | `orchestra.performance_HAS_orchestra.orchestra` :  | `orchestra.show_HAS_orchestra.performance` :


index       : 490
baseline pre: MATCH (T1:`orchestra.conductor`)-[]-(T2:`orchestra.orchestra`) WITH count(T1.Owner_of_Work) AS cnt, T2 RETURN T2.Name ORDER BY cnt DESC LIMIT 1
model1 pred : MATCH (conductor:`orchestra.conductor`) RETURN conductor.Name ORDER BY conductor.Year_of_Work DESC LIMIT 1
ground query: MATCH (conductor:`orchestra.conductor`) RETURN conductor.Name ORDER BY conductor.Year_of_Work DESC LIMIT 1
NLQ         : What is the name of the conductor who has worked the greatest number of years?
Schema      : | orchestra | `orchestra.conductor` : Age , Name , Conductor_ID , Nationality , Year_of_Work | `orchestra.orchestra` : Orchestra , Conductor_ID , Major_Record_Format , Record_Company , Year_of_Founded , Orchestra_ID | `orchestra.performance` : Type , Date , Share , Performance_ID , Weekly_rank , Official_ratings_(millions) , Orchestra_ID | `orchestra.show` : Performance_ID , Show_ID , If_first_show , Attendance , Result | `orchestra.orchestra_HAS_orchestra.conductor` :  | `orchestra.performance_HAS_orchestra.orchestra` :  | `orchestra.show_HAS_orchestra.performance` :


index       : 491
baseline pre: MATCH (T1:`orchestra.orchestra`)-[]-(T2:`orchestra.conductor`) RETURN T2.Name,T2.Orchestral
model1 pred : MATCH (T1:`orchestra.conductor`)-[]-(T2:`orchestra.orchestra`) RETURN T1.Name,T2.Organic
ground query: MATCH (T1:`orchestra.conductor`)-[]-(T2:`orchestra.orchestra`) RETURN T1.Name,T2.Orchestra
NLQ         : Show the names of conductors and the orchestras they have conducted.
Schema      : | orchestra | `orchestra.conductor` : Age , Name , Conductor_ID , Nationality , Year_of_Work | `orchestra.orchestra` : Orchestra , Conductor_ID , Major_Record_Format , Record_Company , Year_of_Founded , Orchestra_ID | `orchestra.performance` : Type , Date , Share , Performance_ID , Weekly_rank , Official_ratings_(millions) , Orchestra_ID | `orchestra.show` : Performance_ID , Show_ID , If_first_show , Attendance , Result | `orchestra.orchestra_HAS_orchestra.conductor` :  | `orchestra.performance_HAS_orchestra.orchestra` :  | `orchestra.show_HAS_orchestra.performance` :


index       : 492
baseline pre: MATCH (T1:`orchestra.orchestra`)-[]-(T2:`orchestra.conductor`) RETURN T1.Name,T2.Name
model1 pred : MATCH (T1:`orchestra.conductor`)-[]-(T2:`orchestra.orchestra`) WHERE T1.Name ='.*[I|i]rresonding.*' RETURN T1.Name,T2.Organic
ground query: MATCH (T1:`orchestra.conductor`)-[]-(T2:`orchestra.orchestra`) RETURN T1.Name,T2.Orchestra
NLQ         : What are the names of conductors as well as the corresonding orchestras that they have conducted?
Schema      : | orchestra | `orchestra.conductor` : Age , Name , Conductor_ID , Nationality , Year_of_Work | `orchestra.orchestra` : Orchestra , Conductor_ID , Major_Record_Format , Record_Company , Year_of_Founded , Orchestra_ID | `orchestra.performance` : Type , Date , Share , Performance_ID , Weekly_rank , Official_ratings_(millions) , Orchestra_ID | `orchestra.show` : Performance_ID , Show_ID , If_first_show , Attendance , Result | `orchestra.orchestra_HAS_orchestra.conductor` :  | `orchestra.performance_HAS_orchestra.orchestra` :  | `orchestra.show_HAS_orchestra.performance` :


index       : 493
baseline pre: MATCH (T1:`orchestra.conductor`)-[]-(T2:`orchestra.orchestra`) WITH count(*) AS count, T1.Name AS Name WHERE count > 1 RETURN Name
model1 pred : MATCH (T1:`orchestra.conductor`)-[]-(T2:`orchestra.orchestra`) WITH count(*) AS count, T1.Name AS Name WHERE count > 1 RETURN Name
ground query: MATCH (T1:`orchestra.conductor`)-[]-(T2:`orchestra.orchestra`) WITH T1.Name AS Name, count(*) AS count WHERE count  > 1 RETURN Name
NLQ         : Show the names of conductors that have conducted more than one orchestras.
Schema      : | orchestra | `orchestra.conductor` : Age , Name , Conductor_ID , Nationality , Year_of_Work | `orchestra.orchestra` : Orchestra , Conductor_ID , Major_Record_Format , Record_Company , Year_of_Founded , Orchestra_ID | `orchestra.performance` : Type , Date , Share , Performance_ID , Weekly_rank , Official_ratings_(millions) , Orchestra_ID | `orchestra.show` : Performance_ID , Show_ID , If_first_show , Attendance , Result | `orchestra.orchestra_HAS_orchestra.conductor` :  | `orchestra.performance_HAS_orchestra.orchestra` :  | `orchestra.show_HAS_orchestra.performance` :


index       : 494
baseline pre: MATCH (T1:`orchestra.conductor`)-[]-(T2:`orchestra.orchestra`) WITH count(*) AS count, T1.Name AS Name WHERE count > 1 RETURN Name
model1 pred : MATCH (T1:`orchestra.conductor`)-[]-(T2:`orchestra.orchestra`) WITH count(*) AS count, T1.Name AS Name WHERE count > 1 RETURN Name
ground query: MATCH (T1:`orchestra.conductor`)-[]-(T2:`orchestra.orchestra`) WITH T1.Name AS Name, count(*) AS count WHERE count  > 1 RETURN Name
NLQ         : What are the names of conductors who have conducted at more than one orchestra?
Schema      : | orchestra | `orchestra.conductor` : Age , Name , Conductor_ID , Nationality , Year_of_Work | `orchestra.orchestra` : Orchestra , Conductor_ID , Major_Record_Format , Record_Company , Year_of_Founded , Orchestra_ID | `orchestra.performance` : Type , Date , Share , Performance_ID , Weekly_rank , Official_ratings_(millions) , Orchestra_ID | `orchestra.show` : Performance_ID , Show_ID , If_first_show , Attendance , Result | `orchestra.orchestra_HAS_orchestra.conductor` :  | `orchestra.performance_HAS_orchestra.orchestra` :  | `orchestra.show_HAS_orchestra.performance` :


index       : 499
baseline pre: MATCH (orchestra:`orchestra.orchestra`) RETURN orchestra.Major_Record_Format ORDER BY orchestra.Record_Format ASC
model1 pred : MATCH (orchestra:`orchestra.orchestra`) RETURN orchestra.Major_Record_Format ORDER BY orchestra.Record_Format ASC
ground query: MATCH (orchestra:`orchestra.orchestra`) RETURN orchestra.Major_Record_Format ORDER BY orchestra.Major_Record_Format ASC
NLQ         : Please show the record formats of orchestras in ascending order of count.
Schema      : | orchestra | `orchestra.conductor` : Age , Name , Conductor_ID , Nationality , Year_of_Work | `orchestra.orchestra` : Orchestra , Conductor_ID , Major_Record_Format , Record_Company , Year_of_Founded , Orchestra_ID | `orchestra.performance` : Type , Date , Share , Performance_ID , Weekly_rank , Official_ratings_(millions) , Orchestra_ID | `orchestra.show` : Performance_ID , Show_ID , If_first_show , Attendance , Result | `orchestra.orchestra_HAS_orchestra.conductor` :  | `orchestra.performance_HAS_orchestra.orchestra` :  | `orchestra.show_HAS_orchestra.performance` :


index       : 500
baseline pre: MATCH (orchestra:`orchestra.orchestra`) RETURN orchestra.Major_Record_Format ORDER BY orchestra.Major_Record_Format
model1 pred : MATCH (orchestra:`orchestra.orchestra`) RETURN orchestra.Major_Record_Format ORDER BY orchestra.Major_Record_Format DESC
ground query: MATCH (orchestra:`orchestra.orchestra`) RETURN orchestra.Major_Record_Format ORDER BY orchestra.Major_Record_Format ASC
NLQ         : What are the major record formats of orchestras, sorted by their frequency?
Schema      : | orchestra | `orchestra.conductor` : Age , Name , Conductor_ID , Nationality , Year_of_Work | `orchestra.orchestra` : Orchestra , Conductor_ID , Major_Record_Format , Record_Company , Year_of_Founded , Orchestra_ID | `orchestra.performance` : Type , Date , Share , Performance_ID , Weekly_rank , Official_ratings_(millions) , Orchestra_ID | `orchestra.show` : Performance_ID , Show_ID , If_first_show , Attendance , Result | `orchestra.orchestra_HAS_orchestra.conductor` :  | `orchestra.performance_HAS_orchestra.orchestra` :  | `orchestra.show_HAS_orchestra.performance` :


index       : 501
baseline pre: MATCH (orchestra:`orchestra.orchestra`) WHERE NOT (orchestra)-[]-(:`orchestra.performance`) RETURN orchestra.Other Orchestra
model1 pred : MATCH (orchestra:`orchestra.orchestra`) WHERE NOT (orchestra)-[]-(:`orchestra.performance`) RETURN orchestra.Name
ground query: MATCH (orchestra:`orchestra.orchestra`) WHERE NOT (orchestra)-[]-(:`orchestra.performance`)     RETURN orchestra.Orchestra
NLQ         : List the names of orchestras that have no performance.
Schema      : | orchestra | `orchestra.conductor` : Age , Name , Conductor_ID , Nationality , Year_of_Work | `orchestra.orchestra` : Orchestra , Conductor_ID , Major_Record_Format , Record_Company , Year_of_Founded , Orchestra_ID | `orchestra.performance` : Type , Date , Share , Performance_ID , Weekly_rank , Official_ratings_(millions) , Orchestra_ID | `orchestra.show` : Performance_ID , Show_ID , If_first_show , Attendance , Result | `orchestra.orchestra_HAS_orchestra.conductor` :  | `orchestra.performance_HAS_orchestra.orchestra` :  | `orchestra.show_HAS_orchestra.performance` :


index       : 502
baseline pre: MATCH (orchestra:`orchestra.orchestra`) WHERE NOT (orchestra)-[]-(:`orchestra.performance`) RETURN orchestra.Orchestration
model1 pred : MATCH (orchestra:`orchestra.orchestra`) WHERE NOT (orchestra)-[]-(:`orchestra.performance`) RETURN orchestra.Orchestration
ground query: MATCH (orchestra:`orchestra.orchestra`) WHERE NOT (orchestra)-[]-(:`orchestra.performance`)     RETURN orchestra.Orchestra
NLQ         : What are the orchestras that do not have any performances?
Schema      : | orchestra | `orchestra.conductor` : Age , Name , Conductor_ID , Nationality , Year_of_Work | `orchestra.orchestra` : Orchestra , Conductor_ID , Major_Record_Format , Record_Company , Year_of_Founded , Orchestra_ID | `orchestra.performance` : Type , Date , Share , Performance_ID , Weekly_rank , Official_ratings_(millions) , Orchestra_ID | `orchestra.show` : Performance_ID , Show_ID , If_first_show , Attendance , Result | `orchestra.orchestra_HAS_orchestra.conductor` :  | `orchestra.performance_HAS_orchestra.orchestra` :  | `orchestra.show_HAS_orchestra.performance` :


index       : 509
baseline pre: MATCH (highschooler:`network_1.Highschooler`) RETURN DISTINCT highschooler.grade
model1 pred : MATCH (highschooler:`network_1.Highschooler`) RETURN DISTINCT highschooler.grade
ground query: MATCH (highschooler:`network_1.Highschooler`) RETURN highschooler.grade
NLQ         : Show all the grades of the high schoolers.
Schema      : | network_1 | `network_1.Highschooler` : name , ID , grade | `network_1.Friend` : friend_id , student_id | `network_1.Likes` : liked_id , student_id


index       : 510
baseline pre: MATCH (highschooler:`network_1.Highschooler`) RETURN DISTINCT highschooler.grade
model1 pred : MATCH (highschooler:`network_1.Highschooler`) RETURN highschooler.grade,count(*)
ground query: MATCH (highschooler:`network_1.Highschooler`) RETURN highschooler.grade
NLQ         : What is the grade of each high schooler?
Schema      : | network_1 | `network_1.Highschooler` : name , ID , grade | `network_1.Friend` : friend_id , student_id | `network_1.Likes` : liked_id , student_id


index       : 516
baseline pre: MATCH (highschooler:`network_1.Highschooler`) WHERE student.name = 'Kyle' RETURN student.ID
model1 pred : MATCH (highschooler:`network_1.Highschooler`) WHERE highschooler.name = 'Kyle' RETURN highschooler.ID
ground query: MATCH (highschooler:`network_1.Highschooler`) WHERE highschooler.name = 'Kyle' RETURN highschooler.ID
NLQ         : What is Kyle's id?
Schema      : | network_1 | `network_1.Highschooler` : name ( Kyle ) , ID , grade | `network_1.Friend` : friend_id , student_id | `network_1.Likes` : liked_id , student_id


index       : 519
baseline pre: MATCH (highschooler:`network_1.Highschooler`) RETURN count(*),highschooler.grade
model1 pred : MATCH (highschooler:`network_1.Highschooler`) RETURN highschooler.grade,count(*)
ground query: MATCH (highschooler:`network_1.Highschooler`) RETURN highschooler.grade,count(*)
NLQ         : Show the number of high schoolers for each grade.
Schema      : | network_1 | `network_1.Highschooler` : name , ID , grade | `network_1.Friend` : friend_id , student_id | `network_1.Likes` : liked_id , student_id


index       : 520
baseline pre: MATCH (highschooler:`network_1.Highschooler`) RETURN count(*),highschooler.grade
model1 pred : MATCH (highschooler:`network_1.Highschooler`) RETURN highschooler.grade,count(*)
ground query: MATCH (highschooler:`network_1.Highschooler`) RETURN highschooler.grade,count(*)
NLQ         : How many high schoolers are in each grade?
Schema      : | network_1 | `network_1.Highschooler` : name , ID , grade | `network_1.Friend` : friend_id , student_id | `network_1.Likes` : liked_id , student_id


index       : 523
baseline pre: MATCH (highschooler:`network_1.Highschooler`) WITH count(*) AS count, highschooler.grade AS grade WHERE count >= 4 RETURN grade
model1 pred : MATCH (highschooler:`network_1.Highschooler`) WITH count(*) AS count, highschooler.grade AS grade WHERE count >= 4 RETURN grade
ground query: MATCH (highschooler:`network_1.Highschooler`) WITH highschooler.grade AS grade, count(*) AS count WHERE count  >= 4 RETURN grade
NLQ         : Show me all grades that have at least 4 students.
Schema      : | network_1 | `network_1.Highschooler` : name , ID , grade | `network_1.Friend` : friend_id , student_id | `network_1.Likes` : liked_id , student_id


index       : 524
baseline pre: MATCH (highschooler:`network_1.Highschooler`) WITH count(*) AS count, highschooler.grade AS grade WHERE count >= 4 RETURN grade
model1 pred : MATCH (highschooler:`network_1.Highschooler`) WITH count(highschooler.grade) AS count, highschooler.grade AS grade WHERE count >= 4 RETURN grade
ground query: MATCH (highschooler:`network_1.Highschooler`) WITH highschooler.grade AS grade, count(*) AS count WHERE count  >= 4 RETURN grade
NLQ         : Which grades have 4 or more high schoolers?
Schema      : | network_1 | `network_1.Highschooler` : name , ID , grade | `network_1.Friend` : friend_id , student_id | `network_1.Likes` : liked_id , student_id


index       : 525
baseline pre: MATCH (T1:`network_1.Highschooler`)-[T2:`network_1.Likes ` ]-() WITH count(*) AS count, T1.name AS name WHERE count >= 2 RETURN name
model1 pred : MATCH (T1:`network_1.Highschooler`)-[T2:`network_1.Likes ` ]-() WITH count(*) AS count, T1.name AS name WHERE count >= 2 RETURN name
ground query: MATCH (T1:`network_1.Likes`)-[]-(T2:`network_1.Highschooler`) WITH count(*) AS count, T2.name AS name WHERE count  >= 2 RETURN name
NLQ         : Show the names of students who have at least 2 likes.
Schema      : | network_1 | `network_1.Highschooler` : name , ID , grade | `network_1.Friend` : friend_id , student_id | `network_1.Likes` : liked_id , student_id


index       : 526
baseline pre: MATCH (T1:`network_1.Highschooler`)-[T2:`network_1.Likes ` ]-() WITH count(*) AS count, T1.name AS name WHERE count >= 2 RETURN name
model1 pred : MATCH (T1:`network_1.Highschooler`)-[T2:`network_1.Likes ` ]-() WITH count(*) AS count, T1.name AS name WHERE count >= 2 RETURN name
ground query: MATCH (T1:`network_1.Likes`)-[]-(T2:`network_1.Highschooler`) WITH count(*) AS count, T2.name AS name WHERE count  >= 2 RETURN name
NLQ         : What are the names of students who have 2 or more likes?
Schema      : | network_1 | `network_1.Highschooler` : name , ID , grade | `network_1.Friend` : friend_id , student_id | `network_1.Likes` : liked_id , student_id


index       : 527
baseline pre: MATCH (T1:`dog_kennels.Professionals`)-[]-(T2:`dog_kennels.Treatments`) WITH count(*) AS count, T1.first_name AS first_name, T1.professional_id AS professional_id WHERE count >= 2 RETURN professional_id,first_name,first_name
model1 pred : MATCH (T1:`dog_kennels.Professionals`)-[]-(T2:`dog_kennels.Treatments`) WITH count(*) AS count, T1.professional_id AS professional_id, T1.role_code AS role_code, T1.first_name AS first_name WHERE count >= 2 RETURN professional_id,role_code,first_name
ground query: MATCH (T1:`dog_kennels.Professionals`)-[]-(T2:`dog_kennels.Treatments`) WITH count(*) AS count, T1.role_code AS role_code, T1.first_name AS first_name, T1.professional_id AS professional_id WHERE count  >= 2 RETURN professional_id,role_code,first_name
NLQ         : Which professionals have done at least two treatments? List the professional's id, role, and first name.
Schema      : | dog_kennels | `dog_kennels.Breeds` : breed_code , breed_name | `dog_kennels.Charges` : charge_amount , charge_type , charge_id | `dog_kennels.Sizes` : size_code , size_description | `dog_kennels.Treatment_Types` : treatment_type_description , treatment_type_code | `dog_kennels.Owners` : city , state , street , home_phone , last_name , first_name , cell_number , zip_code , email_address , owner_id | `dog_kennels.Dogs` : name , abandoned_yn , age , breed_code , dog_id , size_code , weight , date_arrived , date_departed , gender , date_adopted , date_of_birth , owner_id | `dog_kennels.Professionals` : city , state , street , home_phone , last_name , first_name , role_code , cell_number , professional_id , zip_code , email_address | `dog_kennels.Treatments` : date_of_treatment , treatment_id , dog_id , professional_id , cost_of_treatment , treatment_type_code | `dog_kennels.dogs_HAS_dog_kennels.owners` :  | `dog_kennels.treatments_HAS_dog_kennels.dogs` :


index       : 528
baseline pre: MATCH (T1:`dog_kennels.Professionals`)-[]-(T2:`dog_kennels.Treatments`) WITH count(*) AS count, T1.first_name AS first_name, T1.role_code AS role_code WHERE count >= 2 RETURN professional_id,role_code,first_name
model1 pred : MATCH (T1:`dog_kennels.Professionals`)-[]-(T2:`dog_kennels.Treatments`) WITH count(*) AS count, T2.first_name AS first_name, T1.professional_id AS professional_id, T1.role_code AS role_code WHERE count >= 2 RETURN professional_id,role_code,first_name
ground query: MATCH (T1:`dog_kennels.Professionals`)-[]-(T2:`dog_kennels.Treatments`) WITH count(*) AS count, T1.role_code AS role_code, T1.first_name AS first_name, T1.professional_id AS professional_id WHERE count  >= 2 RETURN professional_id,role_code,first_name
NLQ         : What are the id, role, and first name of the professionals who have performed two or more treatments?
Schema      : | dog_kennels | `dog_kennels.Breeds` : breed_code , breed_name | `dog_kennels.Charges` : charge_amount , charge_type , charge_id | `dog_kennels.Sizes` : size_code , size_description | `dog_kennels.Treatment_Types` : treatment_type_description , treatment_type_code | `dog_kennels.Owners` : city , state , street , home_phone , last_name , first_name , cell_number , zip_code , email_address , owner_id | `dog_kennels.Dogs` : name , abandoned_yn , age , breed_code , dog_id , size_code , weight , date_arrived , date_departed , gender , date_adopted , date_of_birth , owner_id | `dog_kennels.Professionals` : city , state , street , home_phone , last_name , first_name , role_code , cell_number , professional_id , zip_code , email_address | `dog_kennels.Treatments` : date_of_treatment , treatment_id , dog_id , professional_id , cost_of_treatment , treatment_type_code | `dog_kennels.dogs_HAS_dog_kennels.owners` :  | `dog_kennels.treatments_HAS_dog_kennels.dogs` :


index       : 529
baseline pre: MATCH (dogs:`dog_kennels.Dogs`) RETURN dogs.breed_name ORDER BY dogs.breed_code DESC LIMIT 1
model1 pred : MATCH (T1:`dog_kennels.Breeds`)-[]-(T2:`dog_kennels.Dogs`) WITH count(T1.breed_code) AS cnt, T1 RETURN T1.breed_name ORDER BY cnt DESC LIMIT 1
ground query: MATCH (T1:`dog_kennels.Breeds`)-[]-(T2:`dog_kennels.Dogs`) WITH count(T1.breed_name) AS cnt, T1 RETURN T1.breed_name ORDER BY cnt DESC LIMIT 1
NLQ         : What is the name of the breed with the most dogs?
Schema      : | dog_kennels | `dog_kennels.Breeds` : breed_code , breed_name | `dog_kennels.Charges` : charge_amount , charge_type , charge_id | `dog_kennels.Sizes` : size_code , size_description | `dog_kennels.Treatment_Types` : treatment_type_description , treatment_type_code | `dog_kennels.Owners` : city , state , street , home_phone , last_name , first_name , cell_number , zip_code , email_address , owner_id | `dog_kennels.Dogs` : name , abandoned_yn , age , breed_code , dog_id , size_code , weight , date_arrived , date_departed , gender , date_adopted , date_of_birth , owner_id | `dog_kennels.Professionals` : city , state , street , home_phone , last_name , first_name , role_code , cell_number , professional_id , zip_code , email_address | `dog_kennels.Treatments` : date_of_treatment , treatment_id , dog_id , professional_id , cost_of_treatment , treatment_type_code | `dog_kennels.dogs_HAS_dog_kennels.owners` :  | `dog_kennels.treatments_HAS_dog_kennels.dogs` :


index       : 530
baseline pre: MATCH (dogs:`dog_kennels.Dogs`) RETURN dogs.breed_name ORDER BY dogs.breed_name DESC LIMIT 1
model1 pred : MATCH (dogs:`dog_kennels.Dogs`) RETURN dogs.breed_name ORDER BY dogs.breed_name DESC LIMIT 1
ground query: MATCH (T1:`dog_kennels.Breeds`)-[]-(T2:`dog_kennels.Dogs`) WITH count(T1.breed_name) AS cnt, T1 RETURN T1.breed_name ORDER BY cnt DESC LIMIT 1
NLQ         : Which breed do the most dogs have? Give me the breed name.
Schema      : | dog_kennels | `dog_kennels.Breeds` : breed_code , breed_name | `dog_kennels.Charges` : charge_amount , charge_type , charge_id | `dog_kennels.Sizes` : size_code , size_description | `dog_kennels.Treatment_Types` : treatment_type_description , treatment_type_code | `dog_kennels.Owners` : city , state , street , home_phone , last_name , first_name , cell_number , zip_code , email_address , owner_id | `dog_kennels.Dogs` : name , abandoned_yn , age , breed_code , dog_id , size_code , weight , date_arrived , date_departed , gender , date_adopted , date_of_birth , owner_id | `dog_kennels.Professionals` : city , state , street , home_phone , last_name , first_name , role_code , cell_number , professional_id , zip_code , email_address | `dog_kennels.Treatments` : date_of_treatment , treatment_id , dog_id , professional_id , cost_of_treatment , treatment_type_code | `dog_kennels.dogs_HAS_dog_kennels.owners` :  | `dog_kennels.treatments_HAS_dog_kennels.dogs` :


index       : 531
baseline pre: MATCH (T1:`dog_kennels.Owners`)-[]-(T2:`dog_kennels.Treatments`) WITH count(T1.owner_id) AS cnt, T2 RETURN T2.owner_id,T2.last_name ORDER BY cnt DESC LIMIT 1
model1 pred : MATCH (T1:`dog_kennels.Owners`)-[]-(T2:`dog_kennels.Treatments`) WITH count(T1.owner_id) AS cnt, T1 RETURN T1.owner_id,T1.last_name ORDER BY cnt DESC LIMIT 1
ground query: MATCH (T1:`dog_kennels.Owners`)-[]-(T2:`dog_kennels.Dogs`)-[]-(T3:`dog_kennels.Treatments`) WITH count(T1.owner_id) AS cnt, T1 RETURN T1.owner_id,T1.last_name ORDER BY cnt DESC LIMIT 1
NLQ         : Which owner has paid for the most treatments on his or her dogs? List the owner id and last name.
Schema      : | dog_kennels | `dog_kennels.Breeds` : breed_code , breed_name | `dog_kennels.Charges` : charge_amount , charge_type , charge_id | `dog_kennels.Sizes` : size_code , size_description | `dog_kennels.Treatment_Types` : treatment_type_description , treatment_type_code | `dog_kennels.Owners` : city , state , street , home_phone , last_name , first_name , cell_number , zip_code , email_address , owner_id | `dog_kennels.Dogs` : name , abandoned_yn , age , breed_code , dog_id , size_code , weight , date_arrived , date_departed , gender , date_adopted , date_of_birth , owner_id | `dog_kennels.Professionals` : city , state , street , home_phone , last_name , first_name , role_code , cell_number , professional_id , zip_code , email_address | `dog_kennels.Treatments` : date_of_treatment , treatment_id , dog_id , professional_id , cost_of_treatment , treatment_type_code | `dog_kennels.dogs_HAS_dog_kennels.owners` :  | `dog_kennels.treatments_HAS_dog_kennels.dogs` :


index       : 532
baseline pre: MATCH (T1:`dog_kennels.Owners`)-[]-(T2:`dog_kennels.Treatments`) WITH T1, count(T1.owner_id) AS cnt RETURN T1.owner_id,T1.last_name ORDER BY cnt DESC LIMIT 1
model1 pred : MATCH (T1:`dog_kennels.Owners`)-[]-(T2:`dog_kennels.Treatments`) WITH T1, count(T1.owner_id) AS cnt RETURN T1.owner_id,T1.last_name ORDER BY cnt DESC LIMIT 1
ground query: MATCH (T1:`dog_kennels.Owners`)-[]-(T2:`dog_kennels.Dogs`)-[]-(T3:`dog_kennels.Treatments`) WITH count(T1.owner_id) AS cnt, T1 RETURN T1.owner_id,T1.last_name ORDER BY cnt DESC LIMIT 1
NLQ         : Tell me the owner id and last name of the owner who spent the most on treatments of his or her dogs.
Schema      : | dog_kennels | `dog_kennels.Breeds` : breed_code , breed_name | `dog_kennels.Charges` : charge_amount , charge_type , charge_id | `dog_kennels.Sizes` : size_code , size_description | `dog_kennels.Treatment_Types` : treatment_type_description , treatment_type_code | `dog_kennels.Owners` : city , state , street , home_phone , last_name , first_name , cell_number , zip_code , email_address , owner_id | `dog_kennels.Dogs` : name , abandoned_yn , age , breed_code , dog_id , size_code , weight , date_arrived , date_departed , gender , date_adopted , date_of_birth , owner_id | `dog_kennels.Professionals` : city , state , street , home_phone , last_name , first_name , role_code , cell_number , professional_id , zip_code , email_address | `dog_kennels.Treatments` : date_of_treatment , treatment_id , dog_id , professional_id , cost_of_treatment , treatment_type_code | `dog_kennels.dogs_HAS_dog_kennels.owners` :  | `dog_kennels.treatments_HAS_dog_kennels.dogs` :


index       : 533
baseline pre: MATCH (treatment_types:`dog_kennels.Treatments`) WITH count(*) AS count, treatment_types.professional_id AS professional_id WHERE count >= 2 RETURN professional_id,professional_phone
model1 pred : MATCH (T1:`dog_kennels.Professionals`)-[]-(T2:`dog_kennels.Treatments`) WITH count(*) AS count, T1.professional_id AS professional_id, T1.cell_phone AS cell_phone WHERE count >= 2 RETURN professional_id,cell_phone
ground query: MATCH (T1:`dog_kennels.Professionals`)-[]-(T2:`dog_kennels.Treatments`) WITH count(*) AS count, T1.professional_id AS professional_id, T1.cell_number AS cell_number WHERE count  >= 2 RETURN professional_id,cell_number
NLQ         : Which professionals have done at least two types of treatments? List the professional id and cell phone.
Schema      : | dog_kennels | `dog_kennels.Breeds` : breed_code , breed_name | `dog_kennels.Charges` : charge_amount , charge_type , charge_id | `dog_kennels.Sizes` : size_code , size_description | `dog_kennels.Treatment_Types` : treatment_type_description , treatment_type_code | `dog_kennels.Owners` : city , state , street , home_phone , last_name , first_name , cell_number , zip_code , email_address , owner_id | `dog_kennels.Dogs` : name , abandoned_yn , age , breed_code , dog_id , size_code , weight , date_arrived , date_departed , gender , date_adopted , date_of_birth , owner_id | `dog_kennels.Professionals` : city , state , street , home_phone , last_name , first_name , role_code , cell_number , professional_id , zip_code , email_address | `dog_kennels.Treatments` : date_of_treatment , treatment_id , dog_id , professional_id , cost_of_treatment , treatment_type_code | `dog_kennels.dogs_HAS_dog_kennels.owners` :  | `dog_kennels.treatments_HAS_dog_kennels.dogs` :


index       : 534
baseline pre: MATCH (T1:`dog_kennels.Professionals`)-[]-(T2:`dog_kennels.Treatments`) WITH T1.home_phone AS home_phone, count(*) AS count, T1.professional_id AS professional_id WHERE count >= 2 RETURN professional_id,home_phone
model1 pred : MATCH (T1:`dog_kennels.Professionals`)-[]-(T2:`dog_kennels.Treatments`) WITH count(*) AS count, T1.professional_id AS professional_id, T1.cell_phone AS cell_phone WHERE count >= 2 RETURN professional_id,cell_phone
ground query: MATCH (T1:`dog_kennels.Professionals`)-[]-(T2:`dog_kennels.Treatments`) WITH count(*) AS count, T1.professional_id AS professional_id, T1.cell_number AS cell_number WHERE count  >= 2 RETURN professional_id,cell_number
NLQ         : Find the id and cell phone of the professionals who operate two or more types of treatments.
Schema      : | dog_kennels | `dog_kennels.Breeds` : breed_code , breed_name | `dog_kennels.Charges` : charge_amount , charge_type , charge_id | `dog_kennels.Sizes` : size_code , size_description | `dog_kennels.Treatment_Types` : treatment_type_description , treatment_type_code | `dog_kennels.Owners` : city , state , street , home_phone , last_name , first_name , cell_number , zip_code , email_address , owner_id | `dog_kennels.Dogs` : name , abandoned_yn , age , breed_code , dog_id , size_code , weight , date_arrived , date_departed , gender , date_adopted , date_of_birth , owner_id | `dog_kennels.Professionals` : city , state , street , home_phone , last_name , first_name , role_code , cell_number , professional_id , zip_code , email_address | `dog_kennels.Treatments` : date_of_treatment , treatment_id , dog_id , professional_id , cost_of_treatment , treatment_type_code | `dog_kennels.dogs_HAS_dog_kennels.owners` :  | `dog_kennels.treatments_HAS_dog_kennels.dogs` :


index       : 535
baseline pre: MATCH (T1:`dog_kennels.Professionals`)-[]-(T2:`dog_kennels.Treatments`) RETURN T1.date_of_treatment,T1.first_name
model1 pred : MATCH (T1:`dog_kennels.Treatments`)-[]-(T2:`dog_kennels.Professionals`) RETURN T1.date_of_treatment,T2.first_name,T1.date_of_treatment
ground query: MATCH (T1:`dog_kennels.Treatments`)-[]-(T2:`dog_kennels.Professionals`) RETURN T1.date_of_treatment,T2.first_name
NLQ         : List the date of each treatment, together with the first name of the professional who operated it.
Schema      : | dog_kennels | `dog_kennels.Breeds` : breed_code , breed_name | `dog_kennels.Charges` : charge_amount , charge_type , charge_id | `dog_kennels.Sizes` : size_code , size_description | `dog_kennels.Treatment_Types` : treatment_type_description , treatment_type_code | `dog_kennels.Owners` : city , state , street , home_phone , last_name , first_name , cell_number , zip_code , email_address , owner_id | `dog_kennels.Dogs` : name , abandoned_yn , age , breed_code , dog_id , size_code , weight , date_arrived , date_departed , gender , date_adopted , date_of_birth , owner_id | `dog_kennels.Professionals` : city , state , street , home_phone , last_name , first_name , role_code , cell_number , professional_id , zip_code , email_address | `dog_kennels.Treatments` : date_of_treatment , treatment_id , dog_id , professional_id , cost_of_treatment , treatment_type_code | `dog_kennels.dogs_HAS_dog_kennels.owners` :  | `dog_kennels.treatments_HAS_dog_kennels.dogs` :


index       : 536
baseline pre: MATCH (T1:`dog_kennels.Professionals`)-[]-(T2:`dog_kennels.Treatments`) RETURN T1.date_of_treatment,T1.first_name
model1 pred : MATCH (T1:`dog_kennels.Treatments`)-[]-(T2:`dog_kennels.Owners`) RETURN T1.date_of_treatment,T2.first_name
ground query: MATCH (T1:`dog_kennels.Treatments`)-[]-(T2:`dog_kennels.Professionals`) RETURN T1.date_of_treatment,T2.first_name
NLQ         : What are the date and the operating professional's first name of each treatment?
Schema      : | dog_kennels | `dog_kennels.Breeds` : breed_code , breed_name | `dog_kennels.Charges` : charge_amount , charge_type , charge_id | `dog_kennels.Sizes` : size_code , size_description | `dog_kennels.Treatment_Types` : treatment_type_description , treatment_type_code | `dog_kennels.Owners` : city , state , street , home_phone , last_name , first_name , cell_number , zip_code , email_address , owner_id | `dog_kennels.Dogs` : name , abandoned_yn , age , breed_code , dog_id , size_code , weight , date_arrived , date_departed , gender , date_adopted , date_of_birth , owner_id | `dog_kennels.Professionals` : city , state , street , home_phone , last_name , first_name , role_code , cell_number , professional_id , zip_code , email_address | `dog_kennels.Treatments` : date_of_treatment , treatment_id , dog_id , professional_id , cost_of_treatment , treatment_type_code | `dog_kennels.dogs_HAS_dog_kennels.owners` :  | `dog_kennels.treatments_HAS_dog_kennels.dogs` :


index       : 537
baseline pre: MATCH (treatments:`dog_kennels.Treatments`) RETURN treatments.cost_of_treatment,treatments.treatment_type_description
model1 pred : MATCH (treatments:`dog_kennels.Treatments`) RETURN treatments.cost_of_treatment,treatments.treatment_type_description
ground query: MATCH (T1:`dog_kennels.Treatments`)-[]-(T2:`dog_kennels.Treatment_Types`) RETURN T1.cost_of_treatment,T2.treatment_type_description
NLQ         : List the cost of each treatment and the corresponding treatment type description.
Schema      : | dog_kennels | `dog_kennels.Breeds` : breed_code , breed_name | `dog_kennels.Charges` : charge_amount , charge_type , charge_id | `dog_kennels.Sizes` : size_code , size_description | `dog_kennels.Treatment_Types` : treatment_type_description , treatment_type_code | `dog_kennels.Owners` : city , state , street , home_phone , last_name , first_name , cell_number , zip_code , email_address , owner_id | `dog_kennels.Dogs` : name , abandoned_yn , age , breed_code , dog_id , size_code , weight , date_arrived , date_departed , gender , date_adopted , date_of_birth , owner_id | `dog_kennels.Professionals` : city , state , street , home_phone , last_name , first_name , role_code , cell_number , professional_id , zip_code , email_address | `dog_kennels.Treatments` : date_of_treatment , treatment_id , dog_id , professional_id , cost_of_treatment , treatment_type_code | `dog_kennels.dogs_HAS_dog_kennels.owners` :  | `dog_kennels.treatments_HAS_dog_kennels.dogs` :


index       : 538
baseline pre: MATCH (treatments:`dog_kennels.Treatments`) RETURN treatments.cost_of_treatment,treatments.treatment_type_description
model1 pred : MATCH (treatments:`dog_kennels.Treatments`) RETURN treatments.cost_of_treatment,treatments.treatment_type_description
ground query: MATCH (T1:`dog_kennels.Treatments`)-[]-(T2:`dog_kennels.Treatment_Types`) RETURN T1.cost_of_treatment,T2.treatment_type_description
NLQ         : What are the cost and treatment type description of each treatment?
Schema      : | dog_kennels | `dog_kennels.Breeds` : breed_code , breed_name | `dog_kennels.Charges` : charge_amount , charge_type , charge_id | `dog_kennels.Sizes` : size_code , size_description | `dog_kennels.Treatment_Types` : treatment_type_description , treatment_type_code | `dog_kennels.Owners` : city , state , street , home_phone , last_name , first_name , cell_number , zip_code , email_address , owner_id | `dog_kennels.Dogs` : name , abandoned_yn , age , breed_code , dog_id , size_code , weight , date_arrived , date_departed , gender , date_adopted , date_of_birth , owner_id | `dog_kennels.Professionals` : city , state , street , home_phone , last_name , first_name , role_code , cell_number , professional_id , zip_code , email_address | `dog_kennels.Treatments` : date_of_treatment , treatment_id , dog_id , professional_id , cost_of_treatment , treatment_type_code | `dog_kennels.dogs_HAS_dog_kennels.owners` :  | `dog_kennels.treatments_HAS_dog_kennels.dogs` :


index       : 539
baseline pre: MATCH (T1:`dog_kennels.Owners`)-[]-(T2:`dog_kennels.Sizes`) WHERE T2.name = 'Dog' RETURN T1.first_name,T1.last_name,T2.size_code
model1 pred : MATCH (T1:`dog_kennels.Owners`)-[]-(T2:`dog_kennels.Dogs`) RETURN T1.first_name,T2.last_name,T1.size_code
ground query: MATCH (T1:`dog_kennels.Owners`)-[]-(T2:`dog_kennels.Dogs`) RETURN T1.first_name,T1.last_name,T2.size_code
NLQ         : List each owner's first name, last name, and the size of his for her dog.
Schema      : | dog_kennels | `dog_kennels.Breeds` : breed_code , breed_name | `dog_kennels.Charges` : charge_amount , charge_type , charge_id | `dog_kennels.Sizes` : size_code , size_description | `dog_kennels.Treatment_Types` : treatment_type_description , treatment_type_code | `dog_kennels.Owners` : city , state , street , home_phone , last_name , first_name , cell_number , zip_code , email_address , owner_id | `dog_kennels.Dogs` : name , abandoned_yn , age , breed_code , dog_id , size_code , weight , date_arrived , date_departed , gender , date_adopted , date_of_birth , owner_id | `dog_kennels.Professionals` : city , state , street , home_phone , last_name , first_name , role_code , cell_number , professional_id , zip_code , email_address | `dog_kennels.Treatments` : date_of_treatment , treatment_id , dog_id , professional_id , cost_of_treatment , treatment_type_code | `dog_kennels.dogs_HAS_dog_kennels.owners` :  | `dog_kennels.treatments_HAS_dog_kennels.dogs` :


index       : 540
baseline pre: MATCH (dogs:`dog_kennels.Dogs`) RETURN dogs.first_name,dogs.last_name,dogs.size_code
model1 pred : MATCH (T1:`dog_kennels.Owners`)-[]-(T2:`dog_kennels.Dogs`) RETURN T1.first_name,T2.last_name,T1.size_code
ground query: MATCH (T1:`dog_kennels.Owners`)-[]-(T2:`dog_kennels.Dogs`) RETURN T1.first_name,T1.last_name,T2.size_code
NLQ         : What are each owner's first name, last name, and the size of their dog?
Schema      : | dog_kennels | `dog_kennels.Breeds` : breed_code , breed_name | `dog_kennels.Charges` : charge_amount , charge_type , charge_id | `dog_kennels.Sizes` : size_code , size_description | `dog_kennels.Treatment_Types` : treatment_type_description , treatment_type_code | `dog_kennels.Owners` : city , state , street , home_phone , last_name , first_name , cell_number , zip_code , email_address , owner_id | `dog_kennels.Dogs` : name , abandoned_yn , age , breed_code , dog_id , size_code , weight , date_arrived , date_departed , gender , date_adopted , date_of_birth , owner_id | `dog_kennels.Professionals` : city , state , street , home_phone , last_name , first_name , role_code , cell_number , professional_id , zip_code , email_address | `dog_kennels.Treatments` : date_of_treatment , treatment_id , dog_id , professional_id , cost_of_treatment , treatment_type_code | `dog_kennels.dogs_HAS_dog_kennels.owners` :  | `dog_kennels.treatments_HAS_dog_kennels.dogs` :


index       : 541
baseline pre: MATCH (dogs:`dog_kennels.Dogs`) RETURN dogs.first_name,dogs.last_name
model1 pred : MATCH (T1:`dog_kennels.Owners`)-[]-(T2:`dog_kennels.Dogs`) RETURN T1.first_name,T2.first_name
ground query: MATCH (T1:`dog_kennels.Owners`)-[]-(T2:`dog_kennels.Dogs`) RETURN T1.first_name,T2.name
NLQ         : List pairs of the owner's first name and the dogs's name.
Schema      : | dog_kennels | `dog_kennels.Breeds` : breed_code , breed_name | `dog_kennels.Charges` : charge_amount , charge_type , charge_id | `dog_kennels.Sizes` : size_code , size_description | `dog_kennels.Treatment_Types` : treatment_type_description , treatment_type_code | `dog_kennels.Owners` : city , state , street , home_phone , last_name , first_name , cell_number , zip_code , email_address , owner_id | `dog_kennels.Dogs` : name , abandoned_yn , age , breed_code , dog_id , size_code , weight , date_arrived , date_departed , gender , date_adopted , date_of_birth , owner_id | `dog_kennels.Professionals` : city , state , street , home_phone , last_name , first_name , role_code , cell_number , professional_id , zip_code , email_address | `dog_kennels.Treatments` : date_of_treatment , treatment_id , dog_id , professional_id , cost_of_treatment , treatment_type_code | `dog_kennels.dogs_HAS_dog_kennels.owners` :  | `dog_kennels.treatments_HAS_dog_kennels.dogs` :


index       : 542
baseline pre: MATCH (T1:`dog_kennels.Owners`)-[]-(T2:`dog_kennels.Dogs`) RETURN T1.first_name,T1.last_name
model1 pred : MATCH (T1:`dog_kennels.Owners`)-[]-(T2:`dog_kennels.Dogs`) RETURN T1.first_name,T1.first_name
ground query: MATCH (T1:`dog_kennels.Owners`)-[]-(T2:`dog_kennels.Dogs`) RETURN T1.first_name,T2.name
NLQ         : What are each owner's first name and their dogs's name?
Schema      : | dog_kennels | `dog_kennels.Breeds` : breed_code , breed_name | `dog_kennels.Charges` : charge_amount , charge_type , charge_id | `dog_kennels.Sizes` : size_code , size_description | `dog_kennels.Treatment_Types` : treatment_type_description , treatment_type_code | `dog_kennels.Owners` : city , state , street , home_phone , last_name , first_name , cell_number , zip_code , email_address , owner_id | `dog_kennels.Dogs` : name , abandoned_yn , age , breed_code , dog_id , size_code , weight , date_arrived , date_departed , gender , date_adopted , date_of_birth , owner_id | `dog_kennels.Professionals` : city , state , street , home_phone , last_name , first_name , role_code , cell_number , professional_id , zip_code , email_address | `dog_kennels.Treatments` : date_of_treatment , treatment_id , dog_id , professional_id , cost_of_treatment , treatment_type_code | `dog_kennels.dogs_HAS_dog_kennels.owners` :  | `dog_kennels.treatments_HAS_dog_kennels.dogs` :


index       : 543
baseline pre: MATCH (T1:`dog_kennels.Owners`)-[]-(T2:`dog_kennels.Dogs`) WHERE T1.state = 'Virgin' RETURN T1.first_name,T2.name
model1 pred : MATCH (t1:`dog_kennels.Owners`)-[]-(t2:`dog_kennels.Dogs`) WHERE t2.state = 'Virgin' RETURN t1.first_name,t1.name
ground query: MATCH (T1:`dog_kennels.Owners`)-[]-(T2:`dog_kennels.Dogs`) WHERE T1.state = 'Virginia' RETURN T1.first_name,T2.name
NLQ         : Which dogs are owned by someone who lives in Virginia? List the owner's first name and the dog's name.
Schema      : | dog_kennels | `dog_kennels.Breeds` : breed_code , breed_name | `dog_kennels.Charges` : charge_amount , charge_type , charge_id | `dog_kennels.Sizes` : size_code , size_description | `dog_kennels.Treatment_Types` : treatment_type_description , treatment_type_code | `dog_kennels.Owners` : city , state ( Virginia ) , street , home_phone , last_name , first_name , cell_number , zip_code , email_address , owner_id | `dog_kennels.Dogs` : name , abandoned_yn , age , breed_code , dog_id , size_code , weight , date_arrived , date_departed , gender , date_adopted , date_of_birth , owner_id | `dog_kennels.Professionals` : city , state , street , home_phone , last_name , first_name , role_code , cell_number , professional_id , zip_code , email_address | `dog_kennels.Treatments` : date_of_treatment , treatment_id , dog_id , professional_id , cost_of_treatment , treatment_type_code | `dog_kennels.dogs_HAS_dog_kennels.owners` :  | `dog_kennels.treatments_HAS_dog_kennels.dogs` :


index       : 544
baseline pre: MATCH (T1:`dog_kennels.Owners`)-[]-(T2:`dog_kennels.Dogs`) WHERE T1.state = 'Virgin' RETURN T1.first_name,T2.last_name
model1 pred : MATCH (T1:`dog_kennels.Owners`)-[]-(T2:`dog_kennels.Dogs`) WHERE T2.state = 'Virgin' AND T2.name = 'Dogs' RETURN T1.first_name,T1.name
ground query: MATCH (T1:`dog_kennels.Owners`)-[]-(T2:`dog_kennels.Dogs`) WHERE T1.state = 'Virginia' RETURN T1.first_name,T2.name
NLQ         : Find the first names of owners living in Virginia and the names of dogs they own.
Schema      : | dog_kennels | `dog_kennels.Breeds` : breed_code , breed_name | `dog_kennels.Charges` : charge_amount , charge_type , charge_id | `dog_kennels.Sizes` : size_code , size_description | `dog_kennels.Treatment_Types` : treatment_type_description , treatment_type_code | `dog_kennels.Owners` : city , state ( Virginia ) , street , home_phone , last_name , first_name , cell_number , zip_code , email_address , owner_id | `dog_kennels.Dogs` : name , abandoned_yn , age , breed_code , dog_id , size_code , weight , date_arrived , date_departed , gender , date_adopted , date_of_birth , owner_id | `dog_kennels.Professionals` : city , state , street , home_phone , last_name , first_name , role_code , cell_number , professional_id , zip_code , email_address | `dog_kennels.Treatments` : date_of_treatment , treatment_id , dog_id , professional_id , cost_of_treatment , treatment_type_code | `dog_kennels.dogs_HAS_dog_kennels.owners` :  | `dog_kennels.treatments_HAS_dog_kennels.dogs` :


index       : 545
baseline pre: MATCH (T1:`dog_kennels.Dogs`)-[]-(T2:`dog_kennels.Treatments`) RETURN T1.date_arrived,T1.date_departed
model1 pred : MATCH (T1:`dog_kennels.Dogs`)-[]-(T2:`dog_kennels.Treatments`) RETURN T1.date_arrived,T2.date_departed
ground query: MATCH (T1:`dog_kennels.Dogs`)-[]-(T2:`dog_kennels.Treatments`) RETURN DISTINCT T1.date_arrived,T1.date_departed
NLQ         : What are the arriving date and the departing date of the dogs who have gone through a treatment?
Schema      : | dog_kennels | `dog_kennels.Breeds` : breed_code , breed_name | `dog_kennels.Charges` : charge_amount , charge_type , charge_id | `dog_kennels.Sizes` : size_code , size_description | `dog_kennels.Treatment_Types` : treatment_type_description , treatment_type_code | `dog_kennels.Owners` : city , state , street , home_phone , last_name , first_name , cell_number , zip_code , email_address , owner_id | `dog_kennels.Dogs` : name , abandoned_yn , age , breed_code , dog_id , size_code , weight , date_arrived , date_departed , gender , date_adopted , date_of_birth , owner_id | `dog_kennels.Professionals` : city , state , street , home_phone , last_name , first_name , role_code , cell_number , professional_id , zip_code , email_address | `dog_kennels.Treatments` : date_of_treatment , treatment_id , dog_id , professional_id , cost_of_treatment , treatment_type_code | `dog_kennels.dogs_HAS_dog_kennels.owners` :  | `dog_kennels.treatments_HAS_dog_kennels.dogs` :


index       : 546
baseline pre: MATCH (T1:`dog_kennels.Dogs`)-[]-(T2:`dog_kennels.Treatments`) RETURN T1.date_arrived,T1.date_departed
model1 pred : MATCH (T1:`dog_kennels.Dogs`)-[]-(T2:`dog_kennels.Treatments`) RETURN T1.date_arrived,T2.date_departed
ground query: MATCH (T1:`dog_kennels.Dogs`)-[]-(T2:`dog_kennels.Treatments`) RETURN DISTINCT T1.date_arrived,T1.date_departed
NLQ         : Find the arriving date and the departing date of the dogs that received a treatment.
Schema      : | dog_kennels | `dog_kennels.Breeds` : breed_code , breed_name | `dog_kennels.Charges` : charge_amount , charge_type , charge_id | `dog_kennels.Sizes` : size_code , size_description | `dog_kennels.Treatment_Types` : treatment_type_description , treatment_type_code | `dog_kennels.Owners` : city , state , street , home_phone , last_name , first_name , cell_number , zip_code , email_address , owner_id | `dog_kennels.Dogs` : name , abandoned_yn , age , breed_code , dog_id , size_code , weight , date_arrived , date_departed , gender , date_adopted , date_of_birth , owner_id | `dog_kennels.Professionals` : city , state , street , home_phone , last_name , first_name , role_code , cell_number , professional_id , zip_code , email_address | `dog_kennels.Treatments` : date_of_treatment , treatment_id , dog_id , professional_id , cost_of_treatment , treatment_type_code | `dog_kennels.dogs_HAS_dog_kennels.owners` :  | `dog_kennels.treatments_HAS_dog_kennels.dogs` :


index       : 551
baseline pre: MATCH (T1:`dog_kennels.Dogs`)-[]-(T2:`dog_kennels.Treatments`) RETURN count(*)
model1 pred : MATCH (T1:`dog_kennels.Dogs`)-[]-(T2:`dog_kennels.Treatments`) RETURN count(DISTINCT T1.dog_id)
ground query: MATCH (treatments:`dog_kennels.Treatments`) RETURN count(DISTINCT treatments.dog_id)
NLQ         : How many dogs went through any treatments?
Schema      : | dog_kennels | `dog_kennels.Breeds` : breed_code , breed_name | `dog_kennels.Charges` : charge_amount , charge_type , charge_id | `dog_kennels.Sizes` : size_code , size_description | `dog_kennels.Treatment_Types` : treatment_type_description , treatment_type_code | `dog_kennels.Owners` : city , state , street , home_phone , last_name , first_name , cell_number , zip_code , email_address , owner_id | `dog_kennels.Dogs` : name , abandoned_yn , age , breed_code , dog_id , size_code , weight , date_arrived , date_departed , gender , date_adopted , date_of_birth , owner_id | `dog_kennels.Professionals` : city , state , street , home_phone , last_name , first_name , role_code , cell_number , professional_id , zip_code , email_address | `dog_kennels.Treatments` : date_of_treatment , treatment_id , dog_id , professional_id , cost_of_treatment , treatment_type_code | `dog_kennels.dogs_HAS_dog_kennels.owners` :  | `dog_kennels.treatments_HAS_dog_kennels.dogs` :


index       : 552
baseline pre: MATCH (T1:`dog_kennels.Dogs`)-[]-(T2:`dog_kennels.Treatments`) RETURN count(*)
model1 pred : MATCH (T1:`dog_kennels.Dogs`)-[]-(T2:`dog_kennels.Treatments`) RETURN count(DISTINCT T1.dog_id)
ground query: MATCH (treatments:`dog_kennels.Treatments`) RETURN count(DISTINCT treatments.dog_id)
NLQ         : Count the number of dogs that went through a treatment.
Schema      : | dog_kennels | `dog_kennels.Breeds` : breed_code , breed_name | `dog_kennels.Charges` : charge_amount , charge_type , charge_id | `dog_kennels.Sizes` : size_code , size_description | `dog_kennels.Treatment_Types` : treatment_type_description , treatment_type_code | `dog_kennels.Owners` : city , state , street , home_phone , last_name , first_name , cell_number , zip_code , email_address , owner_id | `dog_kennels.Dogs` : name , abandoned_yn , age , breed_code , dog_id , size_code , weight , date_arrived , date_departed , gender , date_adopted , date_of_birth , owner_id | `dog_kennels.Professionals` : city , state , street , home_phone , last_name , first_name , role_code , cell_number , professional_id , zip_code , email_address | `dog_kennels.Treatments` : date_of_treatment , treatment_id , dog_id , professional_id , cost_of_treatment , treatment_type_code | `dog_kennels.dogs_HAS_dog_kennels.owners` :  | `dog_kennels.treatments_HAS_dog_kennels.dogs` :


index       : 553
baseline pre: MATCH (T1:`dog_kennels.Professionals`)-[]-(T2:`dog_kennels.Treatments`) RETURN count(*)
model1 pred : MATCH (T1:`dog_kennels.Professionals`)-[]-(T2:`dog_kennels.Treatments`) RETURN count(DISTINCT T1.professional_id)
ground query: MATCH (treatments:`dog_kennels.Treatments`) RETURN count(DISTINCT treatments.professional_id)
NLQ         : How many professionals have performed any treatment to dogs?
Schema      : | dog_kennels | `dog_kennels.Breeds` : breed_code , breed_name | `dog_kennels.Charges` : charge_amount , charge_type , charge_id | `dog_kennels.Sizes` : size_code , size_description | `dog_kennels.Treatment_Types` : treatment_type_description , treatment_type_code | `dog_kennels.Owners` : city , state , street , home_phone , last_name , first_name , cell_number , zip_code , email_address , owner_id | `dog_kennels.Dogs` : name , abandoned_yn , age , breed_code , dog_id , size_code , weight , date_arrived , date_departed , gender , date_adopted , date_of_birth , owner_id | `dog_kennels.Professionals` : city , state , street , home_phone , last_name , first_name , role_code , cell_number , professional_id , zip_code , email_address | `dog_kennels.Treatments` : date_of_treatment , treatment_id , dog_id , professional_id , cost_of_treatment , treatment_type_code | `dog_kennels.dogs_HAS_dog_kennels.owners` :  | `dog_kennels.treatments_HAS_dog_kennels.dogs` :


index       : 554
baseline pre: MATCH (T1:`dog_kennels.Professionals`)-[]-(T2:`dog_kennels.Treatments`) RETURN count(*)
model1 pred : MATCH (T1:`dog_kennels.Professionals`)-[]-(T2:`dog_kennels.Treatments`) RETURN count(DISTINCT T1.professional_id)
ground query: MATCH (treatments:`dog_kennels.Treatments`) RETURN count(DISTINCT treatments.professional_id)
NLQ         : Find the number of professionals who have ever treated dogs.
Schema      : | dog_kennels | `dog_kennels.Breeds` : breed_code , breed_name | `dog_kennels.Charges` : charge_amount , charge_type , charge_id | `dog_kennels.Sizes` : size_code , size_description | `dog_kennels.Treatment_Types` : treatment_type_description , treatment_type_code | `dog_kennels.Owners` : city , state , street , home_phone , last_name , first_name , cell_number , zip_code , email_address , owner_id | `dog_kennels.Dogs` : name , abandoned_yn , age , breed_code , dog_id , size_code , weight , date_arrived , date_departed , gender , date_adopted , date_of_birth , owner_id | `dog_kennels.Professionals` : city , state , street , home_phone , last_name , first_name , role_code , cell_number , professional_id , zip_code , email_address | `dog_kennels.Treatments` : date_of_treatment , treatment_id , dog_id , professional_id , cost_of_treatment , treatment_type_code | `dog_kennels.dogs_HAS_dog_kennels.owners` :  | `dog_kennels.treatments_HAS_dog_kennels.dogs` :


index       : 555
baseline pre: MATCH (professionals:`dog_kennels.Professionals`) WHERE professionals.street = 'West' RETURN professionals.role_code,professionals.city,professionals.state
model1 pred : MATCH (professionals:`dog_kennels.Professionals`) WHERE professionals.role_code ='.*[W]onder.*' RETURN professionals.role_code,professionals.city,professionals.city,professionals.state
ground query: MATCH (professionals:`dog_kennels.Professionals`) WHERE professionals.city =~'.*[W|w]est.*' RETURN professionals.role_code,professionals.street,professionals.city,professionals.state
NLQ         : Which professionals live in a city containing the substring 'West'? List his or her role, street, city and state.
Schema      : | dog_kennels | `dog_kennels.Breeds` : breed_code , breed_name | `dog_kennels.Charges` : charge_amount , charge_type , charge_id | `dog_kennels.Sizes` : size_code , size_description | `dog_kennels.Treatment_Types` : treatment_type_description , treatment_type_code | `dog_kennels.Owners` : city , state , street , home_phone , last_name , first_name , cell_number , zip_code , email_address , owner_id | `dog_kennels.Dogs` : name , abandoned_yn , age , breed_code , dog_id , size_code , weight , date_arrived , date_departed , gender , date_adopted , date_of_birth , owner_id | `dog_kennels.Professionals` : city , state , street , home_phone , last_name , first_name , role_code , cell_number , professional_id , zip_code , email_address | `dog_kennels.Treatments` : date_of_treatment , treatment_id , dog_id , professional_id , cost_of_treatment , treatment_type_code | `dog_kennels.dogs_HAS_dog_kennels.owners` :  | `dog_kennels.treatments_HAS_dog_kennels.dogs` :


index       : 556
baseline pre: MATCH (professionals:`dog_kennels.Professionals`) WHERE professionals.city = 'West' RETURN professionals.role_code,professionals.street,professionals.city,professionals.state
model1 pred : MATCH (professionals:`dog_kennels.Professionals`) WHERE professionals.substring = 'West' RETURN professionals.role_code,professionals.street,professionals.city,professionals.state
ground query: MATCH (professionals:`dog_kennels.Professionals`) WHERE professionals.city =~'.*[W|w]est.*' RETURN professionals.role_code,professionals.street,professionals.city,professionals.state
NLQ         : Find the role, street, city and state of the professionals living in a city that contains the substring 'West'.
Schema      : | dog_kennels | `dog_kennels.Breeds` : breed_code , breed_name | `dog_kennels.Charges` : charge_amount , charge_type , charge_id | `dog_kennels.Sizes` : size_code , size_description | `dog_kennels.Treatment_Types` : treatment_type_description , treatment_type_code | `dog_kennels.Owners` : city , state , street , home_phone , last_name , first_name , cell_number , zip_code , email_address , owner_id | `dog_kennels.Dogs` : name , abandoned_yn , age , breed_code , dog_id , size_code , weight , date_arrived , date_departed , gender , date_adopted , date_of_birth , owner_id | `dog_kennels.Professionals` : city , state , street , home_phone , last_name , first_name , role_code , cell_number , professional_id , zip_code , email_address | `dog_kennels.Treatments` : date_of_treatment , treatment_id , dog_id , professional_id , cost_of_treatment , treatment_type_code | `dog_kennels.dogs_HAS_dog_kennels.owners` :  | `dog_kennels.treatments_HAS_dog_kennels.dogs` :


index       : 557
baseline pre: MATCH (owners:`dog_kennels.Owners`) WHERE owners.city = 'North' RETURN owners.first_name,owners.last_name,owners.email_address
model1 pred : MATCH (owners:`dog_kennels.Owners`) WHERE owners.name ='.*[N|n]on.*' RETURN owners.first_name,owners.last_name,owners.email_address
ground query: MATCH (owners:`dog_kennels.Owners`) WHERE owners.state =~'.*[N|n]orth.*' RETURN owners.first_name,owners.last_name,owners.email_address
NLQ         : Which owners live in the state whose name contains the substring 'North'? List his first name, last name and email.
Schema      : | dog_kennels | `dog_kennels.Breeds` : breed_code , breed_name | `dog_kennels.Charges` : charge_amount , charge_type , charge_id | `dog_kennels.Sizes` : size_code , size_description | `dog_kennels.Treatment_Types` : treatment_type_description , treatment_type_code | `dog_kennels.Owners` : city , state , street , home_phone , last_name , first_name , cell_number , zip_code , email_address , owner_id | `dog_kennels.Dogs` : name , abandoned_yn , age , breed_code , dog_id , size_code , weight , date_arrived , date_departed , gender , date_adopted , date_of_birth , owner_id | `dog_kennels.Professionals` : city , state , street , home_phone , last_name , first_name , role_code , cell_number , professional_id , zip_code , email_address | `dog_kennels.Treatments` : date_of_treatment , treatment_id , dog_id , professional_id , cost_of_treatment , treatment_type_code | `dog_kennels.dogs_HAS_dog_kennels.owners` :  | `dog_kennels.treatments_HAS_dog_kennels.dogs` :


index       : 558
baseline pre: MATCH (owners:`dog_kennels.Owners`) WHERE owners.city = 'North' RETURN owners.first_name,owners.last_name,owners.email_address
model1 pred : MATCH (owners:`dog_kennels.Owners`) WHERE owners.state = 'North' RETURN owners.first_name,owners.last_name,owners.email_address
ground query: MATCH (owners:`dog_kennels.Owners`) WHERE owners.state =~'.*[N|n]orth.*' RETURN owners.first_name,owners.last_name,owners.email_address
NLQ         : Return the first name, last name and email of the owners living in a state whose name contains the substring 'North'.
Schema      : | dog_kennels | `dog_kennels.Breeds` : breed_code , breed_name | `dog_kennels.Charges` : charge_amount , charge_type , charge_id | `dog_kennels.Sizes` : size_code , size_description | `dog_kennels.Treatment_Types` : treatment_type_description , treatment_type_code | `dog_kennels.Owners` : city , state , street , home_phone , last_name , first_name , cell_number , zip_code , email_address , owner_id | `dog_kennels.Dogs` : name , abandoned_yn , age , breed_code , dog_id , size_code , weight , date_arrived , date_departed , gender , date_adopted , date_of_birth , owner_id | `dog_kennels.Professionals` : city , state , street , home_phone , last_name , first_name , role_code , cell_number , professional_id , zip_code , email_address | `dog_kennels.Treatments` : date_of_treatment , treatment_id , dog_id , professional_id , cost_of_treatment , treatment_type_code | `dog_kennels.dogs_HAS_dog_kennels.owners` :  | `dog_kennels.treatments_HAS_dog_kennels.dogs` :


index       : 561
baseline pre: MATCH (dogs:`dog_kennels.Dogs`) RETURN dogs.age ORDER BY dogs.age LIMIT 1
model1 pred : MATCH (dogs:`dog_kennels.Dogs`) RETURN dogs.age ORDER BY dogs.age DESC LIMIT 1
ground query: MATCH (dogs:`dog_kennels.Dogs`) RETURN max(dogs.age)
NLQ         : What is the age of the oldest dog?
Schema      : | dog_kennels | `dog_kennels.Breeds` : breed_code , breed_name | `dog_kennels.Charges` : charge_amount , charge_type , charge_id | `dog_kennels.Sizes` : size_code , size_description | `dog_kennels.Treatment_Types` : treatment_type_description , treatment_type_code | `dog_kennels.Owners` : city , state , street , home_phone , last_name , first_name , cell_number , zip_code , email_address , owner_id | `dog_kennels.Dogs` : name , abandoned_yn , age , breed_code , dog_id , size_code , weight , date_arrived , date_departed , gender , date_adopted , date_of_birth , owner_id | `dog_kennels.Professionals` : city , state , street , home_phone , last_name , first_name , role_code , cell_number , professional_id , zip_code , email_address | `dog_kennels.Treatments` : date_of_treatment , treatment_id , dog_id , professional_id , cost_of_treatment , treatment_type_code | `dog_kennels.dogs_HAS_dog_kennels.owners` :  | `dog_kennels.treatments_HAS_dog_kennels.dogs` :


index       : 562
baseline pre: MATCH (dogs:`dog_kennels.Dogs`) RETURN dogs.age ORDER BY dogs.age DESC LIMIT 1
model1 pred : MATCH (dogs:`dog_kennels.Dogs`) RETURN dogs.age ORDER BY dogs.age DESC LIMIT 1
ground query: MATCH (dogs:`dog_kennels.Dogs`) RETURN max(dogs.age)
NLQ         : Tell me the age of the oldest dog.
Schema      : | dog_kennels | `dog_kennels.Breeds` : breed_code , breed_name | `dog_kennels.Charges` : charge_amount , charge_type , charge_id | `dog_kennels.Sizes` : size_code , size_description | `dog_kennels.Treatment_Types` : treatment_type_description , treatment_type_code | `dog_kennels.Owners` : city , state , street , home_phone , last_name , first_name , cell_number , zip_code , email_address , owner_id | `dog_kennels.Dogs` : name , abandoned_yn , age , breed_code , dog_id , size_code , weight , date_arrived , date_departed , gender , date_adopted , date_of_birth , owner_id | `dog_kennels.Professionals` : city , state , street , home_phone , last_name , first_name , role_code , cell_number , professional_id , zip_code , email_address | `dog_kennels.Treatments` : date_of_treatment , treatment_id , dog_id , professional_id , cost_of_treatment , treatment_type_code | `dog_kennels.dogs_HAS_dog_kennels.owners` :  | `dog_kennels.treatments_HAS_dog_kennels.dogs` :


index       : 565
baseline pre: MATCH (charges:`dog_kennels.Charges`) RETURN charges.charge_type ORDER BY charges.charge_amount DESC LIMIT 1
model1 pred : MATCH (charges:`dog_kennels.Charges`) RETURN charges.charge_type ORDER BY charges.charge_amount DESC LIMIT 1
ground query: MATCH (charges:`dog_kennels.Charges`) RETURN max(charges.charge_amount)
NLQ         : How much does the most expensive charge type costs?
Schema      : | dog_kennels | `dog_kennels.Breeds` : breed_code , breed_name | `dog_kennels.Charges` : charge_amount , charge_type , charge_id | `dog_kennels.Sizes` : size_code , size_description | `dog_kennels.Treatment_Types` : treatment_type_description , treatment_type_code | `dog_kennels.Owners` : city , state , street , home_phone , last_name , first_name , cell_number , zip_code , email_address , owner_id | `dog_kennels.Dogs` : name , abandoned_yn , age , breed_code , dog_id , size_code , weight , date_arrived , date_departed , gender , date_adopted , date_of_birth , owner_id | `dog_kennels.Professionals` : city , state , street , home_phone , last_name , first_name , role_code , cell_number , professional_id , zip_code , email_address | `dog_kennels.Treatments` : date_of_treatment , treatment_id , dog_id , professional_id , cost_of_treatment , treatment_type_code | `dog_kennels.dogs_HAS_dog_kennels.owners` :  | `dog_kennels.treatments_HAS_dog_kennels.dogs` :


index       : 566
baseline pre: MATCH (charges:`dog_kennels.Charges`) RETURN charges.charge_amount ORDER BY charges.charge_type DESC LIMIT 1
model1 pred : MATCH (charges:`dog_kennels.Charges`) RETURN charges.charge_amount ORDER BY charges.cost_of_treatment DESC LIMIT 1
ground query: MATCH (charges:`dog_kennels.Charges`) RETURN max(charges.charge_amount)
NLQ         : What is the charge amount of the most expensive charge type?
Schema      : | dog_kennels | `dog_kennels.Breeds` : breed_code , breed_name | `dog_kennels.Charges` : charge_amount , charge_type , charge_id | `dog_kennels.Sizes` : size_code , size_description | `dog_kennels.Treatment_Types` : treatment_type_description , treatment_type_code | `dog_kennels.Owners` : city , state , street , home_phone , last_name , first_name , cell_number , zip_code , email_address , owner_id | `dog_kennels.Dogs` : name , abandoned_yn , age , breed_code , dog_id , size_code , weight , date_arrived , date_departed , gender , date_adopted , date_of_birth , owner_id | `dog_kennels.Professionals` : city , state , street , home_phone , last_name , first_name , role_code , cell_number , professional_id , zip_code , email_address | `dog_kennels.Treatments` : date_of_treatment , treatment_id , dog_id , professional_id , cost_of_treatment , treatment_type_code | `dog_kennels.dogs_HAS_dog_kennels.owners` :  | `dog_kennels.treatments_HAS_dog_kennels.dogs` :


index       : 569
baseline pre: MATCH (dogs:`dog_kennels.Dogs`) RETURN dogs.breed_type,dogs.size_code
model1 pred : MATCH (T1:`dog_kennels.Breeds`)-[]-(T2:`dog_kennels.Sizes`) RETURN DISTINCT T1.breed_code,T1.size_code
ground query: MATCH (dogs:`dog_kennels.Dogs`) RETURN DISTINCT dogs.breed_code,dogs.size_code
NLQ         : What are all the possible breed type and size type combinations?
Schema      : | dog_kennels | `dog_kennels.Breeds` : breed_code , breed_name | `dog_kennels.Charges` : charge_amount , charge_type , charge_id | `dog_kennels.Sizes` : size_code , size_description | `dog_kennels.Treatment_Types` : treatment_type_description , treatment_type_code | `dog_kennels.Owners` : city , state , street , home_phone , last_name , first_name , cell_number , zip_code , email_address , owner_id | `dog_kennels.Dogs` : name , abandoned_yn , age , breed_code , dog_id , size_code , weight , date_arrived , date_departed , gender , date_adopted , date_of_birth , owner_id | `dog_kennels.Professionals` : city , state , street , home_phone , last_name , first_name , role_code , cell_number , professional_id , zip_code , email_address | `dog_kennels.Treatments` : date_of_treatment , treatment_id , dog_id , professional_id , cost_of_treatment , treatment_type_code | `dog_kennels.dogs_HAS_dog_kennels.owners` :  | `dog_kennels.treatments_HAS_dog_kennels.dogs` :


index       : 571
baseline pre: MATCH (T1:`dog_kennels.Professionals`)-[]-(T2:`dog_kennels.Treatments`) RETURN T1.first_name,T2.date_of_treatment
model1 pred : MATCH (T1:`dog_kennels.Professionals`)-[]-(T2:`dog_kennels.Treatments`) RETURN T1.first_name,T2.treatment_type_description
ground query: MATCH (T1:`dog_kennels.Professionals`)-[]-(T2:`dog_kennels.Treatments`)-[]-(T3:`dog_kennels.Treatment_Types`) RETURN DISTINCT T1.first_name,T3.treatment_type_description
NLQ         : List the first name of all the professionals along with the description of the treatment they have done.
Schema      : | dog_kennels | `dog_kennels.Breeds` : breed_code , breed_name | `dog_kennels.Charges` : charge_amount , charge_type , charge_id | `dog_kennels.Sizes` : size_code , size_description | `dog_kennels.Treatment_Types` : treatment_type_description , treatment_type_code | `dog_kennels.Owners` : city , state , street , home_phone , last_name , first_name , cell_number , zip_code , email_address , owner_id | `dog_kennels.Dogs` : name , abandoned_yn , age , breed_code , dog_id , size_code , weight , date_arrived , date_departed , gender , date_adopted , date_of_birth , owner_id | `dog_kennels.Professionals` : city , state , street , home_phone , last_name , first_name , role_code , cell_number , professional_id , zip_code , email_address | `dog_kennels.Treatments` : date_of_treatment , treatment_id , dog_id , professional_id , cost_of_treatment , treatment_type_code | `dog_kennels.dogs_HAS_dog_kennels.owners` :  | `dog_kennels.treatments_HAS_dog_kennels.dogs` :


index       : 572
baseline pre: MATCH (T1:`dog_kennels.Professionals`)-[]-(T2:`dog_kennels.Treatments`) RETURN T1.first_name,T2.treatment_type_description
model1 pred : MATCH (T1:`dog_kennels.Professionals`)-[]-(T2:`dog_kennels.Treatments`) RETURN T1.first_name,T1.treatment_type_description
ground query: MATCH (T1:`dog_kennels.Professionals`)-[]-(T2:`dog_kennels.Treatments`)-[]-(T3:`dog_kennels.Treatment_Types`) RETURN DISTINCT T1.first_name,T3.treatment_type_description
NLQ         : What are each professional's first name and description of the treatment they have performed?
Schema      : | dog_kennels | `dog_kennels.Breeds` : breed_code , breed_name | `dog_kennels.Charges` : charge_amount , charge_type , charge_id | `dog_kennels.Sizes` : size_code , size_description | `dog_kennels.Treatment_Types` : treatment_type_description , treatment_type_code | `dog_kennels.Owners` : city , state , street , home_phone , last_name , first_name , cell_number , zip_code , email_address , owner_id | `dog_kennels.Dogs` : name , abandoned_yn , age , breed_code , dog_id , size_code , weight , date_arrived , date_departed , gender , date_adopted , date_of_birth , owner_id | `dog_kennels.Professionals` : city , state , street , home_phone , last_name , first_name , role_code , cell_number , professional_id , zip_code , email_address | `dog_kennels.Treatments` : date_of_treatment , treatment_id , dog_id , professional_id , cost_of_treatment , treatment_type_code | `dog_kennels.dogs_HAS_dog_kennels.owners` :  | `dog_kennels.treatments_HAS_dog_kennels.dogs` :


index       : 579
baseline pre: MATCH (singer:`singer.singer`) WHERE singer.Citizenship  < > 'France' RETURN singer.Name
model1 pred : MATCH (singer:`singer.singer`) WHERE singer.Citizenship ` > 'France' RETURN singer.Name
ground query: MATCH (singer:`singer.singer`) WHERE singer.Citizenship <> 'France' RETURN singer.Name
NLQ         : List the name of singers whose citizenship is not "France".
Schema      : | singer | `singer.singer` : Name , Citizenship ( France ) , Net_Worth_Millions , Birth_Year , Singer_ID | `singer.song` : Highest_Position , Title , Sales , Song_ID , Singer_ID | `singer.song_HAS_singer.singer` :


index       : 580
baseline pre: MATCH (singer:`singer.singer`) WHERE singer.Citizenship  < > 'France' RETURN singer.Name
model1 pred : MATCH (singer:`singer.singer`) WHERE singer.Citizenship ` > 'France' RETURN singer.Name
ground query: MATCH (singer:`singer.singer`) WHERE singer.Citizenship <> 'France' RETURN singer.Name
NLQ         : What are the names of the singers who are not French citizens?
Schema      : | singer | `singer.singer` : Name , Citizenship , Net_Worth_Millions , Birth_Year , Singer_ID | `singer.song` : Highest_Position , Title , Sales , Song_ID , Singer_ID | `singer.song_HAS_singer.singer` :


index       : 591
baseline pre: MATCH (T1:`singer.singer`)-[]-(T2:`singer.song`) RETURN T2.Title,T2.Name
model1 pred : MATCH (T1:`singer.singer`)-[]-(T2:`singer.song`) RETURN T1.Title,T2.Name
ground query: MATCH (T1:`singer.singer`)-[]-(T2:`singer.song`) RETURN T2.Title,T1.Name
NLQ         : Show titles of songs and names of singers.
Schema      : | singer | `singer.singer` : Name , Citizenship , Net_Worth_Millions , Birth_Year , Singer_ID | `singer.song` : Highest_Position , Title , Sales , Song_ID , Singer_ID | `singer.song_HAS_singer.singer` :


index       : 592
baseline pre: MATCH (T1:`singer.singer`)-[]-(T2:`singer.song`) RETURN T2.Title,T2.Name
model1 pred : MATCH (T1:`singer.singer`)-[]-(T2:`singer.song`) RETURN T1.Title,T2.Name
ground query: MATCH (T1:`singer.singer`)-[]-(T2:`singer.song`) RETURN T2.Title,T1.Name
NLQ         : What are the song titles and singer names?
Schema      : | singer | `singer.singer` : Name , Citizenship , Net_Worth_Millions , Birth_Year , Singer_ID | `singer.song` : Highest_Position , Title , Sales , Song_ID , Singer_ID | `singer.song_HAS_singer.singer` :


index       : 595
baseline pre: MATCH (T1:`singer.singer`)-[]-(T2:`singer.song`) WITH count(*) AS count, T1.Name AS Name WHERE count > 1 RETURN Name
model1 pred : MATCH (T1:`singer.singer`)-[]-(T2:`singer.song`) WITH count(*) AS count, T1.Name AS Name WHERE count > 1 RETURN Name
ground query: MATCH (T1:`singer.singer`)-[]-(T2:`singer.song`) WITH T1.Name AS Name, count(*) AS count WHERE count  > 1 RETURN Name
NLQ         : Show the names of singers that have more than one song.
Schema      : | singer | `singer.singer` : Name , Citizenship , Net_Worth_Millions , Birth_Year , Singer_ID | `singer.song` : Highest_Position , Title , Sales , Song_ID , Singer_ID | `singer.song_HAS_singer.singer` :


index       : 596
baseline pre: MATCH (T1:`singer.singer`)-[]-(T2:`singer.song`) WITH count(*) AS count, T1.Name AS Name WHERE count > 1 RETURN Name
model1 pred : MATCH (T1:`singer.singer`)-[]-(T2:`singer.song`) WITH count(*) AS count, T1.Name AS Name WHERE count > 1 RETURN Name
ground query: MATCH (T1:`singer.singer`)-[]-(T2:`singer.song`) WITH T1.Name AS Name, count(*) AS count WHERE count  > 1 RETURN Name
NLQ         : What are the names of the singers that have more than one songs?
Schema      : | singer | `singer.singer` : Name , Citizenship , Net_Worth_Millions , Birth_Year , Singer_ID | `singer.song` : Highest_Position , Title , Sales , Song_ID , Singer_ID | `singer.song_HAS_singer.singer` :


index       : 597
baseline pre: MATCH (singer:`singer.singer`) WHERE NOT (singer)-[]-(:`singer.song`) RETURN singer.Name
model1 pred : MATCH (singer:`singer.singer`) WHERE NOT (singer)-[]-(:`singer.song`) RETURN singer.Name
ground query: MATCH (singer:`singer.singer`) WHERE NOT (singer)-[]-(:`singer.song`)     RETURN singer.Name
NLQ         : List the name of singers that do not have any song.
Schema      : | singer | `singer.singer` : Name , Citizenship , Net_Worth_Millions , Birth_Year , Singer_ID | `singer.song` : Highest_Position , Title , Sales , Song_ID , Singer_ID | `singer.song_HAS_singer.singer` :


index       : 598
baseline pre: MATCH (singer:`singer.singer`) WHERE NOT (singer)-[]-(:`singer.song`) RETURN singer.Name
model1 pred : MATCH (singer:`singer.singer`) WHERE NOT (singer)-[]-(:`singer.song`) RETURN singer.Name
ground query: MATCH (singer:`singer.singer`) WHERE NOT (singer)-[]-(:`singer.song`)     RETURN singer.Name
NLQ         : What is the sname of every sing that does not have any song?
Schema      : | singer | `singer.singer` : Name , Citizenship , Net_Worth_Millions , Birth_Year , Singer_ID | `singer.song` : Highest_Position , Title , Sales , Song_ID , Singer_ID | `singer.song_HAS_singer.singer` :


index       : 600
baseline pre: MATCH (T1:`real_estate_properties.Properties`)-[]-(T2:`real_estate_properties.Ref_Property_Types`) RETURN T1.property_type_description
model1 pred : MATCH (T1:`real_estate_properties.Ref_Property_Types`)-[]-(T2:`real_estate_properties.Properties`) RETURN T1.property_type_description
ground query: MATCH (T1:`real_estate_properties.Properties`)-[]-(T2:`real_estate_properties.Ref_Property_Types`) RETURN T2.property_type_description
NLQ         : Show the property type descriptions of properties belonging to that code.
Schema      : | real_estate_properties | `real_estate_properties.Ref_Feature_Types` : feature_type_name , feature_type_code | `real_estate_properties.Ref_Property_Types` : property_type_description , property_type_code | `real_estate_properties.Other_Available_Features` : feature_name , feature_type_code , feature_id , feature_description | `real_estate_properties.Properties` : property_address , property_id , room_count , date_on_market , apt_feature_2 , date_sold , property_type_code , buyer_offered_price , property_name , apt_feature_1 , vendor_requested_price , agreed_selling_price | `real_estate_properties.Other_Property_Features` : property_id , property_feature_description , feature_id | `real_estate_properties.other_available_features_HAS_real_estate_properties.ref_feature_types` :  | `real_estate_properties.properties_HAS_real_estate_properties.ref_property_types` :


index       : 601
baseline pre: MATCH (properties:`real_estate_properties.Properties`) WHERE properties.house = 'Apartment' OR properties.room_count > 1 RETURN properties.property_name
model1 pred : MATCH (properties:`real_estate_properties.Properties`) WHERE properties.property_type_code = 'House' OR properties.property_type_code = 'Apartment' WITH count(*) AS count, properties.property_name AS property_name WHERE count > 1 RETURN property_name
ground query: MATCH (properties:`real_estate_properties.Properties`) WHERE properties.property_type_code = 'House' RETURN properties.property_name  AS property_name  UNION MATCH (properties:`real_estate_properties.Properties`) WHERE properties.property_type_code = 'Apartment' AND properties.room_count > 1 RETURN properties.property_name  AS property_name
NLQ         : What are the names of properties that are either houses or apartments with more than 1 room?
Schema      : | real_estate_properties | `real_estate_properties.Ref_Feature_Types` : feature_type_name , feature_type_code | `real_estate_properties.Ref_Property_Types` : property_type_description , property_type_code ( Apartment , House ) | `real_estate_properties.Other_Available_Features` : feature_name , feature_type_code , feature_id , feature_description | `real_estate_properties.Properties` : property_address , property_id , room_count , date_on_market , apt_feature_2 , date_sold , property_type_code ( Apartment , House ) , buyer_offered_price , property_name , apt_feature_1 , vendor_requested_price , agreed_selling_price | `real_estate_properties.Other_Property_Features` : property_id , property_feature_description , feature_id | `real_estate_properties.other_available_features_HAS_real_estate_properties.ref_feature_types` :  | `real_estate_properties.properties_HAS_real_estate_properties.ref_property_types` :



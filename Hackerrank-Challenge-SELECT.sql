--Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table.**
select  (count(CITY)- count(distinct CITY)) from STATION;

--========================================================================================================
--Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates.**
SELECT DISTINCT city FROM   station
WHERE  city  LIKE '%a'
or city Like '%e'
or city Like '%i'
or city Like '%o'
or city Like '%u';

--========================================================================================================
--Query the two cities in STATION with the shortest and longest *CITY* names, as well as their respective lengths**
SELECT city, length(city) FROM STATION group by city order by length(city) asc, city ASC limit 1;
SELECT city, length(city) FROM STATION group by city order by length(city) desc limit 1;


--========================================================================================================
**Query the list of *CITY* names from STATION which have vowels (i.e., *a*, *e*, *i*, *o*, and *u*) as both their first *and* last characters. Your result cannot contain duplicates.**

SELECT DISTINCT CITY FROM STATION WHERE LOWER(SUBSTR(CITY,1,1)) IN ('a','e','i','o','u') and (CITY LIKE '%a' OR CITY LIKE '%e' OR CITY LIKE '%i' OR CITY LIKE '%o' OR CITY LIKE '%u');

--========================================================================================================
--Query the list of *CITY* names from STATION that *do not start* with vowels. Your result cannot contain duplicates.**

SELECT CITY FROM STATION WHERE LEFT(CITY,1) NOT IN('A','E','I','O','U') GROUP BY CITY;

--OPOSTO--

SELECT CITY FROM STATION WHERE RIGHT(CITY,1) NOT IN('a','e','i','o','u') GROUP BY CITY;

--========================================================================================================
--Query the list of *CITY* names from STATION that either do not start with vowels or do not end with vowels. Your result cannot contain duplicates.**

SELECT DISTINCT(CITY) FROM STATION WHERE LEFT(CITY,1) NOT IN ('A','E','I','O','U') OR RIGHT(CITY,1) NOT IN ('a','e','i','o','u') GROUP BY CITY;

--========================================================================================================
--Query the *Name* of any student in STUDENTS who scored higher than  *Marks*. Order your output by the *last three characters* of each name. If two or more students both have names ending in the same last three characters (i.e.: Bobby, Robby, etc.), secondary sort them by ascending *ID*.**

SELECT NAME FROM STUDENTS WHERE MARKS > '75' ORDER BY RIGHT(NAME,3),ID ASC;

--========================================================================================================
--# ADVANCED SELECT
--========================================================================================================

--**Write a query identifying the *type* of each record in the TRIANGLES table using its three side lengths. Output one of the following statements for each record in the table:**

-- **Equilateral:** It's a triangle with  sides of equal length.
-- **Isosceles:** It's a triangle with  sides of equal length.
-- **Scalene:** It's a triangle with  sides of differing lengths.
-- **Not A Triangle:** The given values of *A*, *B*, and *C* don't form a triangle.

SELECT CASE
WHEN (A+B<=C) THEN 'Not A Triangle'
WHEN (A=B) AND (B=C) THEN 'Equilateral'
WHEN (A=B) OR (B=C) OR (A=C) THEN 'Isosceles'
ELSE 'Scalene'
END
FROM triangles;

--========================================================================================================
--1.  Query an *alphabetically ordered* list of all names in OCCUPATIONS, immediately followed by the first letter of each profession as a parenthetical (i.e.: enclosed in parentheses). For example: `AnActorName(A)`, `ADoctorName(D)`, `AProfessorName(P)`, and `ASingerName(S)`.**
--2.  Query the number of ocurrences of each occupation in OCCUPATIONS. Sort the occurrences in *ascending order*, and output them in the following format:**
--    
--    ```
--    **There are a total of [occupation_count] [occupation]s.
--    ```
--    
--    where `[occupation_count]` is the number of occurrences of an occupation in OCCUPATIONS and `[occupation]` is the *lowercase* occupation name. If more than one *Occupation* has the same `[occupation_count]`, they should be ordered alphabetically.**
--    Note: There will be at least two entries in the table for each type of occupation.**

SELECT CASE
WHEN Name!='' THEN CONCAT(Name,'(',LEFT(Occupation,1),')')
END
FROM OCCUPATIONS ORDER BY Name;

SELECT CASE
WHEN Occupation ='Doctor' THEN CONCAT('There are a total of ',COUNT(Occupation),' doctors.')
WHEN Occupation ='Actor' THEN CONCAT('There are a total of ',COUNT(Occupation),' actors.')
WHEN Occupation ='Professor' THEN CONCAT('There are a total of ',COUNT(Occupation),' professors.')
WHEN Occupation ='Singer' THEN CONCAT('There are a total of ',COUNT(Occupation),' singers.')
END
FROM OCCUPATIONS GROUP BY Occupation ORDER BY COUNT(Occupation);

--========================================================================================================
--PIVOT the *Occupation* column in OCCUPATIONS so that each *Name* is sorted alphabetically and displayed underneath its corresponding *Occupation*. The output column headers should be *Doctor*, *Professor*, *Singer*, and *Actor*, respectively.**
--Note: Print NULL when there are no more names corresponding to an occupation.**

SELECT
MAX(CASE WHEN occupation = 'Doctor' THEN Name END) AS Doctor,
MAX(Case WHEN occupation = 'Professor' THEN Name END) AS Professor,
MAX(CASE WHEN occupation = 'Singer' THEN Name END) AS Singer,
MAX(CASE WHEN occupation = 'Actor' THEN Name END) AS Actor
FROM
(SELECT *, ROW_NUMBER() OVER (PARTITION BY Occupation ORDER BY Name) AS rn FROM occupations) p
GROUP BY rn;

--========================================================================================================
--Given the CITY and COUNTRY tables, query the names of all the continents (COUNTRY.Continent) and their respective average city populations (CITY.Population) rounded down to the nearest integer.

Note: CITY.CountryCode and COUNTRY.Code are matching key columns.
SELECT COUNTRY.CONTINENT,FLOOR(AVG(CITY.POPULATION)) FROM CITY 
INNER JOIN
COUNTRY 
ON CITY.COUNTRYCODE=COUNTRY.CODE
GROUP BY COUNTRY.CONTINENT

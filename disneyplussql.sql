--schema
create table disney(
	show_id varchar(500),
	type	 varchar(500),
	title	 varchar(500),
	director	 varchar(500),
	casts	 varchar(500),
	country	 varchar(500),
	date_added	 varchar(500),
	release_year	int,
	rating	 varchar(500),
	duration	 varchar(500),
	listed_in	 varchar(500),
	description  varchar(500)
)


delete from disney
where show_id is null
	or 
	type	is null
	or 
	title	is null
	or
	director is null
	or
	casts	is null
	or 
	country	is null
	or
	date_added	is null
	or
	release_year	is null
	or 
	rating	is null
	or 
	duration	is null
	or 
	listed_in	is null
	or
	description is null


select *from disney


--Count the total number of movies available on Disney+
select type,count(type) from disney
group by type 


--Find the most common content rating among movies
select type,rating,count(rating) from disney
group by 1,2
order by 2 desc


--List all movies released in 2020
select *from disney
where release_year=2020;


--Find the top 5 countries with the highest number of movies
select country,count(type) as noofmovies
from disney
group by 1
order by 2 desc
limit 5;


--Identify the longest movie
select title, type, duration from disney
order by cast(replace(duration, ' min', '')as int) desc
limit 1;


--Find all movies added in the last 5 years
select *from disney
where TO_DATE(date_added, 'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 years';


--Find all movies directed by 'John Lasseter'
select *from disney
where director ilike 'John Lasseter'


--Find the top 10 directors with the highest number of movies
select director,count(*) from disney
group by 1
order by 2 desc
limit 10;


--Find the top 5 release years with the highest number of movies
select release_year,count(*) from disney
group by 1
order by 2 desc
limit 5

--List all documentary movies
select *from disney
where listed_in ilike '%Documentary%';

--Find all movies where the director information is missing
select *from disney 
where director is null;


--Find the top 10 actors who have appeared in the highest number of movies
SELECT
    TRIM(x) AS actor,
    COUNT(*) AS total_movies
FROM disney,
UNNEST(STRING_TO_ARRAY(casts, ',')) x
WHERE casts IS NOT NULL
GROUP BY x
ORDER BY total_movies DESC
LIMIT 10;

--Find the average movie duration for each content rating
select rating ,
round(avg(cast(replace(duration, ' min', '')as numeric)),2) as avg_duration
from disney
group by rating
order by avg_duration desc;


--Categorize movies based on keywords in the description
select 
case 
	when description ilike '%magic%'
	or description ilike '%adventure%'
	or description ilike '%friendship%'
	or description ilike '%hero%'
	then 'Family'
	else 'Other'
end as category,
count(*) as total_movies
from disney
group by category;


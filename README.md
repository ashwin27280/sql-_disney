# Disney+ SQL Data Analysis Project

## Overview
- This project involves a comprehensive analysis of the Disney+ Titles dataset using SQL.
- The dataset contains information about movies and TV shows, including title, director, cast, country, release year, rating, duration, genre, and description.
- The primary goal is to extract meaningful business insights and answer real-world business questions using SQL.
- The project demonstrates data exploration, cleaning, and analytical techniques to uncover trends and patterns within the Disney+ content library.

## Objectives
- Analyze the distribution of Movies and TV Shows.
- Identify the most common content ratings.
- Explore content trends based on release year and date added.
- Analyze content distribution across different countries.
- Examine movie durations and TV show seasons.
- Identify the most featured actors and directors.
- Categorize content based on keywords in descriptions.
- Apply SQL concepts such as aggregate functions, string functions, CTEs, subqueries, and window functions to solve business problems.

## Business Problems and SQL Solutions

### 1. Count the total number of Movies available on Disney+
```sql
SELECT type, COUNT(type)
FROM disney
GROUP BY type;
```

### 2. Find the most common content rating among Movies
```sql
SELECT type, rating, COUNT(rating)
FROM disney
GROUP BY 1,2
ORDER BY 2 DESC;
```

### 3. List all Movies released in 2020
```sql
SELECT *
FROM disney
WHERE release_year = 2020;
```

### 4. Find the top 5 countries with the highest number of Movies
```sql
SELECT country, COUNT(type) AS noofmovies
FROM disney
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;
```

### 5. Identify the longest Movie
```sql
SELECT title, type, duration
FROM disney
ORDER BY CAST(REPLACE(duration, ' min', '') AS INT) DESC
LIMIT 1;
```

### 6. Find all Movies added in the last 5 years
```sql
SELECT *
FROM disney
WHERE TO_DATE(date_added, 'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 years';
```

### 7. Find all Movies directed by 'John Lasseter'
```sql
SELECT *
FROM disney
WHERE director ILIKE 'John Lasseter';
```

### 8. Find the top 10 directors with the highest number of Movies
```sql
SELECT director, COUNT(*)
FROM disney
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;
```

### 9. Find the top 5 release years with the highest number of Movies
```sql
SELECT release_year, COUNT(*)
FROM disney
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;
```

### 10. List all Documentary Movies
```sql
SELECT *
FROM disney
WHERE listed_in ILIKE '%Documentary%';
```

### 11. Find all Movies where the director information is missing
```sql
SELECT *
FROM disney
WHERE director IS NULL;
```

### 12. Find the top 10 actors who have appeared in the highest number of Movies
```sql
SELECT
    TRIM(x) AS actor,
    COUNT(*) AS total_movies
FROM disney,
UNNEST(STRING_TO_ARRAY(casts, ',')) x
WHERE casts IS NOT NULL
GROUP BY x
ORDER BY total_movies DESC
LIMIT 10;
```

### 13. Find the average Movie duration for each content rating
```sql
SELECT
    rating,
    ROUND(AVG(CAST(REPLACE(duration, ' min', '') AS NUMERIC)), 2) AS avg_duration
FROM disney
GROUP BY rating
ORDER BY avg_duration DESC;
```

### 14. Categorize Movies based on keywords in the description
```sql
SELECT
CASE
    WHEN description ILIKE '%magic%'
      OR description ILIKE '%adventure%'
      OR description ILIKE '%friendship%'
      OR description ILIKE '%hero%'
    THEN 'Family'
    ELSE 'Other'
END AS category,
COUNT(*) AS total_movies
FROM disney
GROUP BY category;
```

-- Note, SET A and SET B denote the required list of queries as part of the Assignment
-- Create movie_ratings table in hive 
Create EXTERNAL table movie_ratings(userid INT,
                                  rating DOUBLE,
                                  movieId INT,
                                  title STRING,
                                  year INT,
                                  genres STRING)
                                  ROW FORMAT DELIMITED  
                                  fields terminated BY '\t'
                                  LOCATION 'output/movies_and_ratings';;


/*SET A*/
/*QUERY 1*/
SELECT title, count(*) AS num_ratings
FROM movie_ratings
GROUP BY title
ORDER BY num_ratings DESC
LIMIT 1;

/*QUERY 2*/
WITH above_4_star_ratings AS (
    SELECT 
        movieId,
        title, 
        COUNT(*) AS user_count 
    FROM movie_ratings
    GROUP BY 
        movieId, title
    HAVING COUNT(*) = SUM(CASE WHEN rating >= 4 THEN 1 ELSE 0 END)),
majority_five_stars AS (
    SELECT 
        movieId, 
        title, 
        count(*) AS user_count  
    FROM movie_ratings
    GROUP BY 
        movieId,
        title
    HAVING (COUNT(*) * 0.5) <= SUM(CASE WHEN rating = 5 Then 1 ELSE 0 END) 
)
SELECT 
    COALESCE(asr.title,mfs.title) AS title,
    COALESCE(asr.user_count,mfs.user_count) AS user_count
FROM above_4_star_ratings  asr
FULL OUTER JOIN  majority_five_stars mfs
ON asr.movieId = mfs.movieId 
ORDER BY user_count DESC
LIMIT 1;


/*QUERY 3*/
SELECT 
    userid,
    AVG(rating) AS avg_rating
FROM movie_ratings
GROUP BY userid
ORDER BY avg_rating DESC
LIMIT 1;

/*SET B*/
/*QUERY 1*/ 
SELECT 
    rating,
    count(*) AS  num
FROM movie_ratings
GROUP BY rating;

/*QUERY 2*/ 
SELECT
    rating,
    count(*) AS  num
FROM movie_ratings
GROUP BY rating
ORDER BY num DESC
LIMIT 1;

/*QUERY 3*/
WITH parenthesis_removed AS (
    SELECT
        year,
        title,
        movieId,
        rating,
        regexp_replace(genres,'\\(|\\)','') AS genres
    FROM movie_ratings 
),
genres_exploaded AS (
    SELECT 
        year,
        title,
        movieId,
        rating,
        genre
    FROM parenthesis_removed lateral view explode(split(genres,',')) genres AS genre  
),
ratings_and_users_grouped_by_genre_decade AS (
    SELECT
        (FLOOR(year / 10) * 10) AS decade,
        genre,
        count(*) AS user_count,
        avg(rating) AS averge_rating,
        stddev(rating) AS std_rating
    from genres_exploaded
    GROUP by 
        (FLOOR(year / 10) * 10), 
        genre
)
SELECT * FROM ratings_and_users_grouped_by_genre_decade;

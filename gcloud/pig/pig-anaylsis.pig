-- Define the CSVExcelStorage alias
DEFINE CSVLoader org.apache.pig.piggybank.storage.CSVExcelStorage('\t', 'NO_MULTILINE', 'UNIX');
-- Define our created UDF to filter the most liked movies
REGISTER gs://ca4015-assignment-1/python_udf.py using org.apache.pig.scripting.jython.JythonScriptEngine as myfunc;

-- Load in movie-ratings Pig relation
movie_ratings_joined = LOAD 'output/movies_and_ratings'  USING CSVLoader() as (
                                                                            userId:int, 
                                                                            rating:double, 
                                                                            movieId:int, 
                                                                            title:chararray,  
                                                                            year:int, 
                                                                            genres:chararray);

--QUERY 1
movie_ratings_grouped = GROUP movie_ratings_joined BY title;
movie_ratings_grouped_count = FOREACH movie_ratings_grouped GENERATE group as title, COUNT($1) AS num_ratings;
movie_ratings_count_ordered = ORDER movie_ratings_grouped_count BY num_ratings DESC;
movie_ratings_ordered_limit = LIMIT  movie_ratings_count_ordered 1;
DUMP movie_ratings_ordered_limit;

--QUERY 2
movie_ratings_reduced = FOREACH movie_ratings_joined GENERATE title, rating;
movie_ratings_grouped = GROUP movie_ratings_reduced BY title;
movie_ratings_bag_to_string = FOREACH movie_ratings_grouped GENERATE group AS title, COUNT($1) AS num_ratings, BagToString(movie_ratings_reduced.rating, '|') as ratings_grouped;
most_liked_movies =  FILTER movie_ratings_bag_to_string BY myfunc.most_liked_condition(ratings_grouped);
most_liked_movies_ordered =  ORDER most_liked_movies BY num_ratings DESC;
most_liked_movie = LIMIT most_liked_movies_ordered 1;
DUMP most_liked_movie;


--QUERY 3:
movie_ratings_user_grouped = GROUP movie_ratings_joined BY userId;
user_avg_rating = FOREACH movie_ratings_user_grouped GENERATE group AS userId, AVG(movie_ratings_joined.rating) AS avg_rating;
user_avg_rating_ordered = ORDER user_avg_rating BY avg_rating DESC;
user_avg_rating_limit = LIMIT user_avg_rating_ordered 1;
DUMP user_avg_rating_limit;


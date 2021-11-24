-- Register the piggybank.jar 
DEFINE CSVLoader org.apache.pig.piggybank.storage.CSVExcelStorage(',', 'NO_MULTILINE', 'UNIX', 'SKIP_INPUT_HEADER');
DEFINE CSVStorer org.apache.pig.piggybank.storage.CSVExcelStorage('\t', 'NO_MULTILINE', 'UNIX');

-- load in ratings, tag, movies and links CSV file
ratings = LOAD 'gs://ca4015-assignment-1/ratings.csv' USING CSVLoader() AS (userId:int, movieId:int, rating:double, timestamp:int);
tags = LOAD 'gs://ca4015-assignment-1/tags.csv' USING CSVLoader() AS (userId:int, movieId:int, tag:chararray, timestamp:int);
movies = LOAD 'gs://ca4015-assignment-1/movies.csv' USING CSVLoader() AS (movieId:int, title:chararray, genres:chararray);
links = LOAD 'gs://ca4015-assignment-1/links.csv' USING CSVLoader() AS (movieId:int, imdbId:int, tmdbId:int);

-- fix incorrect year format,extract year from title and split genres
movies_incorrect_year_fixed = FOREACH movies GENERATE movieId, REPLACE(title, '(2006–2007)', '(2006)') AS title, genres;
movies_title_year_extracted = FOREACH movies_incorrect_year_fixed GENERATE  movieId, 
                                                                            TRIM(REPLACE(title, '\\((\\d\\d\\d\\d)\\)', '')) AS title,  
                                                                            REGEX_EXTRACT(title,'\\((\\d\\d\\d\\d)\\)',1) AS year, 
                                                                            STRSPLIT(genres, '\\|') AS genres;
--drop timestamp column from ratings                                                                            
ratings_timestamp_droped = FOREACH ratings GENERATE userId, movieId, rating;
--drop timestamp column from tags                                                                            
tags = FOREACH tags GENERATE userId, movieId, tag;

-- Join movies and ratings tables
movies_ratings_joined = JOIN ratings_timestamp_droped BY movieId, movies_title_year_extracted BY movieId;
-- drop duplicate Movie ID
movies_rating_movieid_dropped = FOREACH movies_ratings_joined GENERATE $0, $2, $3, $4, $5, $6;
-- export pig relation to CSV
STORE movies_rating_movieid_dropped INTO 'output/movies_and_ratings' USING CSVStorer();

-- save tags for unigram processing in Hive
STORE movies_rating_movieid_dropped INTO 'output/tags' USING CSVStorer();

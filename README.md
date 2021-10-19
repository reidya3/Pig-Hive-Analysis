<h1 align="center">
  <img alt="Iowa Gambling logo" src="./images/pig-hive-logo.png" height="115px" />
  <br/>
  <br/>
  MovieLens Analysis Using Pig and Hive (CA4022)
</h1>
<h3 align="center">
  Anthony Reidy, 18369643
  <br/><br/><br/>
</h3>

## Table of Contents
- [Preamble](#preamble)
- [HDFS](#hdfs)
- [Report](#report)
- [File Structure](#file-structure)
- [Github Link](#github-link)

## Preamble
Movie Lens is a web-based movie recommendation service developed by researchers at the University of Minnesota.  The service contains about 11 million ratings for about 8500 movies.  They provide a zipfolder, `Ml-latest-small` , to foster research on personalised recommendations.  The datasets, generated onSeptember 26, 2018, detail 100836 ratings and 3683 tag applications across 9742 movies.  Here, is a brief overview of the CSV files and their associated features.
- **Ratings.csv**:  userId, movieId, rating, timestamp
- **Tags.csv**:  userId, movieId, tags, timestamp
- **Movies.csv**:  movieId, title, generes
- **Links.csv**:  movieId, imdbId, tmdbId

In  this  repository,  we  seek  to  use  Pig  and  Hive  to  clean  and  analyse  the  described  datasets.

## HDFS
Although, Pig has the option to run using a local host and file system, we load and process the data in the Hadoop File System (HDFS). The Pig relations and Hive tables are provided in the [data](data) folder merely for verification purposes. 

## Report 
A report detailing this investigation can be accessed [here](report.pdf). Although the report is above the maximum number of pages allocated, this is due to the large amount of Pig and Hive output images as well as latex's formatting requirements. 

## File Structure
| File/Folder      | Description |
| ----------- | ----------- |
| report.pdf      | details the process, analysis and outcomes of this investigation     |
| prerequistes.sh      | describes the required Hadoop bash commands to copy the CSV files from local storage to HDFS   |
| data-cleaning.pig   | displays the Pig operators used to clean the data        |
| pig-anaylsis.pig   | displays the commands required for the first set of queries on the [lab-sheet](https://github.com/CA4022/Lab3-HivePigMovielens#tasks) |
| python_udf.py   |  is a user defined function to aid the retrieval of most liked movies in Pig |
|  hive-anaylsis.sql  | contains the Hive queries for both sets of queries detailed on the [lab-sheet](https://github.com/CA4022/Lab3-HivePigMovielens#tasks)       |
| data_visualation.ipynb  | is  a jupyter notebook that creates plots for in-depth analysis       |
| data folder   | contains saved Pig relations and Hive tables in TSV format       |
| images folder   | contains all the images used in the report      |


## Github link
The github link of this repo is https://github.com/reidya3/Pig-Hive-Analysis .

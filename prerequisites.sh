$HADOOP_HOME/sbin/start-all.sh
$HADOOP_HOME/bin/hdfs dfs -mkdir input/movielens/
$HADOOP_HOME/bin/hdfs dfs -put  /home/reidya3/ml-latest-small/ratings.csv  input/movielens/
$HADOOP_HOME/bin/hdfs dfs -put  /home/reidya3/ml-latest-small/tags.csv  input/movielens/
$HADOOP_HOME/bin/hdfs dfs -put  /home/reidya3/ml-latest-small/movies.csv  input/movielens
$HADOOP_HOME/bin/hdfs dfs -put  /home/reidya3/ml-latest-small/links.csv  input/movielens/
$HADOOP_HOME/bin/hdfs dfs -ls  input/movielens/

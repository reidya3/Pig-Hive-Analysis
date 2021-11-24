export GOOGLE_APPLICATION_CREDENTIALS="/home/reidya3/Pig-Hive-Analysis/gcloud/electric-facet-333022-4916265e5115.json"

#pig jobs
gcloud dataproc jobs submit pig --cluster=cluster-311c --file=gcloud/pig/data-cleaning.pig --region=us-west4

gcloud dataproc jobs submit pig --cluster=cluster-311c --file=gcloud/pig/pig-anaylsis.pig --region=us-west4


## N.B. HIVE quries are run in the Google cloud UI  via the query text option
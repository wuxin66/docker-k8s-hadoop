docker build -t gcr.io/caci-main/hdfs-spark-base hdfs-spark-base && \
docker build -t gcr.io/caci-main/spark-master spark-master && \
docker build -t gcr.io/caci-main/spark-worker spark-worker && \
docker build -t gcr.io/caci-main/zeppelin zeppelin
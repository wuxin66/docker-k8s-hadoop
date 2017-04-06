docker login cacidocker-caciuk.azurecr.io -u <username> -p <password>

docker push gcr.io/caci-main/hdfs-spark-base:latest && \
docker push gcr.io/caci-main/spark-master:latest && \
docker push gcr.io/caci-main/spark-worker:latest && \
docker push gcr.io/caci-main/zeppelin:latest

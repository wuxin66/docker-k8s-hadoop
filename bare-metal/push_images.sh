docker login cacidocker-caciuk.azurecr.io -u <username> -p <password>

docker push cacidocker-caciuk.azurecr.io/caci-main/hdfs-spark-base:latest && \
docker push cacidocker-caciuk.azurecr.io/caci-main/spark-master:latest && \
docker push cacidocker-caciuk.azurecr.io/caci-main/spark-worker:latest && \
docker push cacidocker-caciuk.azurecr.io/caci-main/zeppelin:latest

docker build -t cacidocker-caciuk.azurecr.io/caci-main/hdfs-spark-base hdfs-spark-base && \
docker build -t cacidocker-caciuk.azurecr.io/caci-main/spark-master spark-master && \
docker build -t cacidocker-caciuk.azurecr.io/caci-main/spark-worker spark-worker && \
docker build -t cacidocker-caciuk.azurecr.io/caci-main/zeppelin zeppelin
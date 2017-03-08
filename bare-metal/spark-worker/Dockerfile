FROM cacidocker-caciuk.azurecr.io/caci-main/hdfs-spark-base:latest
MAINTAINER Dimitrios Traskas <dtraskas@caci.co.uk>

WORKDIR $SPARK_HOME

CMD /hadoop/sbin/hadoop-daemon.sh --config $HADOOP_CONF_DIR --script hdfs start datanode && \
    $SPARK_HOME/sbin/start-slave.sh spark://spark-master:7077 && \
    tail -100f $SPARK_HOME/logs/spark--org.apache.spark.deploy.worker.Worker-1-$(hostname).out
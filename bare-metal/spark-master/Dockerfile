FROM cacidocker-caciuk.azurecr.io/caci-main/hdfs-spark-base:latest
MAINTAINER Dimitrios Traskas <dtraskas@caci.co.uk>

WORKDIR $SPARK_HOME

EXPOSE 9000
EXPOSE 7078

ENV FORMAT_HDFS false

COPY run.sh /
CMD ["/run.sh"]
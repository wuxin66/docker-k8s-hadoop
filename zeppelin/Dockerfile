FROM gcr.io/caci-main/hdfs-spark-base:latest
MAINTAINER Dimitrios Traskas <dtraskas@caci.co.uk>

ARG ZEPPELIN_VERSION="branch-0.6"
ARG SPARK_ZEPPELIN_VERSION="2.1"
ARG MAJOR_HADOOP_VERSION="2.7"

WORKDIR /zeppelin

ENV SPARK_HIVE true
ENV ZEPPELIN_HOME /zeppelin

RUN apt-get update \
  && apt-get install -y git 

RUN git clone --depth 1 --branch ${ZEPPELIN_VERSION} https://github.com/apache/zeppelin.git /zeppelin && \
    apt-get update && \
    apt-get install -y maven && \
    dev/change_scala_version.sh 2.11 && \
    mvn  -Pscala-2.11 -Pspark-${SPARK_ZEPPELIN_VERSION} -Phadoop-${MAJOR_HADOOP_VERSION} -Psparkr -Pyarn -Ppyspark -DskipTests -Pvendor-repo clean package && \
    apt-get install -y python-matplotlib && \
    echo "tail -F /zeppelin/logs/*" >> bin/zeppelin-daemon.sh && \
    mkdir ~/.config/matplotlib && \
    echo "backend : Agg" >> ~/.config/matplotlib/matplotlibrc

EXPOSE 8080 7077

CMD ["/zeppelin/bin/zeppelin-daemon.sh","start"]
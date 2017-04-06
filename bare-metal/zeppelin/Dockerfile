FROM gcr.io/caci-main/hdfs-spark-base hdfs-spark-base:latest
MAINTAINER Dimitrios Traskas <dtraskas@caci.co.uk>

# zeppelin
RUN mkdir -p /opt && \
    cd /opt && \
    curl http://www.us.apache.org/dist/zeppelin/zeppelin-0.7.0/zeppelin-0.7.0-bin-all.tgz | \
        tar -zx && \
    ln -s zeppelin-0.7.0-bin-all zeppelin    

ADD zeppelin-log4j.properties /opt/zeppelin/conf/log4j.properties
ADD zeppelin-env.sh /opt/zeppelin/conf/zeppelin-env.sh

EXPOSE 8080

ENV ZEPPELIN_HOME=/opt/zeppelin
ENV ZEPPELIN_CONF_DIR="${ZEPPELIN_HOME}/conf"

WORKDIR $ZEPPELIN_HOME
CMD ["/opt/zeppelin/bin/zeppelin.sh", "${ZEPPELIN_CONF_DIR}"]
FROM gcr.io/caci-main/hdfs-spark-base:latest
MAINTAINER Dimitrios Traskas <dtraskas@caci.co.uk>

# zeppelin
RUN mkdir -p /opt && \
    cd /opt && \
    curl http://www.us.apache.org/dist/zeppelin/zeppelin-0.6.2/zeppelin-0.6.2-bin-all.tgz | \
        tar -zx && \
    ln -s zeppelin-0.6.2-bin-all zeppelin    

ADD zeppelin-log4j.properties /opt/zeppelin/conf/log4j.properties
ADD zeppelin-env.sh /opt/zeppelin/conf/zeppelin-env.sh
ADD docker-zeppelin.sh /opt/zeppelin/bin/docker-zeppelin.sh

EXPOSE 8080
ENTRYPOINT ["/opt/zeppelin/bin/docker-zeppelin.sh"]
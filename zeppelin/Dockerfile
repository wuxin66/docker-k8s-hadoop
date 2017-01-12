FROM gcr.io/caci-main/hdfs-spark-base:latest
MAINTAINER Dimitrios Traskas <dtraskas@caci.co.uk>

# zeppelin
RUN wget http://www.apache.org/dist/zeppelin/zeppelin-0.6.2/zeppelin-0.6.2-bin-all.tgz
RUN tar xzvf zeppelin-0.6.2-bin-all.tgz
CMD ["bin/zeppelin.sh", "start"]
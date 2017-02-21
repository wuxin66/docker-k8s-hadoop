FROM debian:latest
MAINTAINER Dimitrios Traskas <dtraskas@caci.co.uk>

RUN apt-get update \
 && apt-get install -y locales \
 && dpkg-reconfigure -f noninteractive locales \
 && locale-gen C.UTF-8 \
 && /usr/sbin/update-locale LANG=C.UTF-8 \
 && echo "en_GB.UTF-8 UTF-8" >> /etc/locale.gen \
 && locale-gen \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

ENV LANG en_GB.UTF-8
ENV LANGUAGE en_GB:en
ENV LC_ALL en_GB.UTF-8

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl unzip python python-openssl ssh wget
RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# JAVA
ARG JAVA_MAJOR_VERSION=8
ARG JAVA_UPDATE_VERSION=112
ARG JAVA_BUILD_NUMBER=15
ENV JAVA_HOME /usr/jdk1.${JAVA_MAJOR_VERSION}.0_${JAVA_UPDATE_VERSION}

ENV PATH $PATH:$JAVA_HOME/bin
RUN curl -sL --retry 3 --insecure \
  --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
  "http://download.oracle.com/otn-pub/java/jdk/${JAVA_MAJOR_VERSION}u${JAVA_UPDATE_VERSION}-b${JAVA_BUILD_NUMBER}/server-jre-${JAVA_MAJOR_VERSION}u${JAVA_UPDATE_VERSION}-linux-x64.tar.gz" \
  | gunzip \
  | tar x -C /usr/ \
  && ln -s $JAVA_HOME /usr/java \
  && rm -rf $JAVA_HOME/man

#HDFS
WORKDIR /
RUN wget http://archive.apache.org/dist/hadoop/common/hadoop-3.0.0-alpha2/hadoop-3.0.0-alpha2.tar.gz
RUN tar xzf hadoop-3.0.0-alpha2.tar.gz
RUN mkdir hadoop-3.0.0-alpha2/logs
RUN chown -R root:root hadoop-3.0.0-alpha2
RUN ln -s hadoop-3.0.0-alpha2 hadoop
RUN rm hadoop-3.0.0-alpha2.tar.gz

ENV HADOOP_PREFIX /hadoop
ENV HADOOP_COMMON_HOME /hadoop
ENV HADOOP_HDFS_HOME /hadoop
ENV HADOOP_MAPRED_HOME /hadoop
ENV HADOOP_YARN_HOME /hadoop
ENV HADOOP_CONF_DIR /hadoop/etc/hadoop
ENV YARN_CONF_DIR $HADOOP_PREFIX/etc/hadoop

ADD core-site.xml /hadoop/etc/hadoop/.
ADD hdfs-site.xml /hadoop/etc/hadoop/.
ADD hadoop-env.sh /hadoop/etc/hadoop/.

# SPARK
ENV SPARK_DIR spark
ENV SPARK_HOME /$SPARK_DIR
RUN echo "${SPARK_MASTER_SERVICE_HOST} spark-master" >> /etc/hosts
RUN wget http://archive.apache.org/dist/spark/spark-2.1.0/spark-2.1.0-bin-without-hadoop.tgz
RUN tar xzf spark-2.1.0-bin-without-hadoop.tgz
RUN ln -s spark-2.1.0-bin-without-hadoop $SPARK_DIR
RUN rm spark-2.1.0-bin-without-hadoop.tgz

EXPOSE 8080 4040 7077 7078

WORKDIR $SPARK_HOME/conf
RUN touch spark-env.sh
RUN touch spark-defaults.conf
RUN echo SPARK_WORKER_PORT=7078 >> spark-env.sh
RUN echo spark.master spark://spark-master:7077 >> spark-defaults.conf

ENV PATH $PATH:$HADOOP_COMMON_HOME/bin:$SPARK_HOME/bin:$SPARK_HOME/sbin

WORKDIR /
RUN mkdir data

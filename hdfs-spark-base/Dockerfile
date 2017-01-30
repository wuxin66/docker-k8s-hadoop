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

# Install the Google Cloud SDK.
ENV HOME /
ENV CLOUDSDK_PYTHON_SITEPACKAGES 1
RUN wget --no-check-certificate https://dl.google.com/dl/cloudsdk/channels/rapid/google-cloud-sdk.zip && unzip google-cloud-sdk.zip && rm google-cloud-sdk.zip
RUN google-cloud-sdk/install.sh --usage-reporting=true --path-update=true --bash-completion=true --rc-path=/.bashrc --additional-components app-engine-java app-engine-python app kubectl alpha beta gcd-emulator pubsub-emulator cloud-datastore-emulator app-engine-go bigtable

# Disable updater check for the whole installation.
# Users won't be bugged with notifications to update to the latest version of gcloud.
RUN google-cloud-sdk/bin/gcloud config set --installation component_manager/disable_update_check true

# Disable updater completely.
# Running `gcloud components update` doesn't really do anything in a union FS.
# Changes are lost on a subsequent run.
RUN sed -i -- 's/\"disable_updater\": false/\"disable_updater\": true/g' /google-cloud-sdk/lib/googlecloudsdk/core/config.json


RUN mkdir /.ssh
ENV PATH /google-cloud-sdk/bin:$PATH
VOLUME ["/.config"]

#HDFS
WORKDIR /
ENV HADOOP_VERSION 2.7.3
RUN wget http://archive.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz
RUN tar xzf hadoop-$HADOOP_VERSION.tar.gz
RUN mkdir hadoop-$HADOOP_VERSION/logs
RUN chown -R root:root hadoop-$HADOOP_VERSION
RUN ln -s hadoop-$HADOOP_VERSION hadoop
RUN rm hadoop-$HADOOP_VERSION.tar.gz

ENV HADOOP_PREFIX /hadoop
ENV HADOOP_COMMON_HOME /hadoop
ENV HADOOP_HDFS_HOME /hadoop
ENV HADOOP_MAPRED_HOME /hadoop
ENV HADOOP_YARN_HOME /hadoop
ENV HADOOP_CONF_DIR /hadoop/etc/hadoop
ENV YARN_CONF_DIR $HADOOP_PREFIX/etc/hadoop

ADD core-site.xml /hadoop/etc/hadoop/.
ADD hdfs-site.xml /hadoop/etc/hadoop/.

# SPARK
ENV SPARK_VERSION 2.0.0
ENV HADOOP_MAJOR 2.7
ENV SPARK_DIR spark
ENV SPARK_HOME /$SPARK_DIR
RUN echo "${SPARK_MASTER_SERVICE_HOST} spark-master" >> /etc/hosts
RUN wget http://archive.apache.org/dist/spark/spark-$SPARK_VERSION/spark-$SPARK_VERSION-bin-hadoop$HADOOP_MAJOR.tgz
RUN tar xzf spark-$SPARK_VERSION-bin-hadoop$HADOOP_MAJOR.tgz
RUN ln -s spark-$SPARK_VERSION-bin-hadoop$HADOOP_MAJOR $SPARK_DIR
RUN rm spark-$SPARK_VERSION-bin-hadoop$HADOOP_MAJOR.tgz

EXPOSE 8080 4040 7077 7078

WORKDIR $SPARK_HOME/conf
RUN touch spark-env.sh
RUN touch spark-defaults.conf
RUN echo SPARK_WORKER_PORT=7078 >> spark-env.sh
RUN echo spark.master spark://spark-master:7077 >> spark-defaults.conf

ENV PATH $PATH:$HADOOP_COMMON_HOME/bin:$SPARK_HOME/bin:$SPARK_HOME/sbin

WORKDIR /
RUN mkdir data

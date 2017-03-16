#!/bin/sh

echo $(hostname -i) spark-master >> /etc/hosts 
export SPARK_MASTER_IP=spark-master 
export SPARK_MASTER_PORT=7077 

if $FORMAT_HDFS; then
    /hadoop/bin/hdfs namenode -format 
fi  
 
/hadoop/sbin/hadoop-daemon.sh --config $HADOOP_CONF_DIR --script hdfs start namenode 
$SPARK_HOME/sbin/start-master.sh -h spark-master 
bin/spark-shell --master spark://spark-master:7077 
tail -100f $SPARK_HOME/logs/spark--org.apache.spark.deploy.master.Master-1-$(hostname).out
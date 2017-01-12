export MASTER="spark://spark-master:7077"
export SPARK_HOME=/spark
export ZEPPELIN_JAVA_OPTS="-Dspark.jars=/spark/lib/gcs-connector-latest-hadoop2.jar"
# TODO(zmerlynn): Setting global CLASSPATH *should* be unnecessary,
# but ZEPPELIN_JAVA_OPTS isn't enough here. :(
export CLASSPATH="/spark/lib/gcs-connector-latest-hadoop2.jar"
export ZEPPELIN_NOTEBOOK_DIR="${ZEPPELIN_HOME}/notebook"
export ZEPPELIN_MEM=-Xmx1024m
export ZEPPELIN_PORT=8080
export PYTHONPATH="${SPARK_HOME}/python:${SPARK_HOME}/python/lib/py4j-0.8.2.1-src.zip"
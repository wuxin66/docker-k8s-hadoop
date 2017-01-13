FROM quay.io/pires/docker-elasticsearch:5.1.1_2
MAINTAINER Dimitrios Traskas <dtraskas@caci.co.uk>

# Override config, otherwise plug-in install will fail
ADD config /elasticsearch/config

# Set environment
ENV NAMESPACE default
ENV DISCOVERY_SERVICE elasticsearch-discovery
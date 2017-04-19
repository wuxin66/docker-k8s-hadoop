FROM jupyterhub/jupyterhub

RUN apt-get update && apt-get install -y curl
RUN pip install git+git://github.com/bjolivot/jupyterhub-kubernetes_spawner.git

USER root
COPY startup.sh /startup.sh
RUN chmod +x /startup.sh

CMD ["/startup.sh"]
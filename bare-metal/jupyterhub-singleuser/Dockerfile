FROM jupyterhub/singleuser

RUN conda install -c conda-forge jupyterlab

USER root
ADD startup.sh startup.sh
RUN chmod +x startup.sh

CMD ["/startup.sh"]
FROM jupyter/tensorflow-notebook:hub-2.3.1

LABEL maintainer="Vincent Prevosto <prevosto@mit.edu>"

COPY --from=tensorflow/tensorflow:latest-gpu-py3-jupyter /tf/tensorflow-tutorials /media/tensorflow-tutorials
COPY --from=jupyter/base-notebook /usr/local/bin/fix-permissions /usr/local/bin/fix-permissions

USER root
# APT packages
RUN apt update && \
    apt install -y --no-install-recommends \
    sshfs \
    fonts-dejavu && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN fix-permissions /home/$NB_USER

#Add user to jhub_users group, to get wr permissions to shared folder 
RUN groupadd jhub_users 
RUN usermod -aG jhub_users ${NB_USER}

#Switch to user
USER $NB_UID


# Conda installs
# update Anaconda and install pip 
RUN conda update -y conda && \
     conda install -y pip bokeh

RUN conda config --set channel_priority flexible && \
    conda install -y -c conda-forge nb_conda_kernels \
    jupyter_contrib_nbextensions \
    jupyterlab-git

RUN conda config --set channel_priority strict && \
    conda install -y -c conda-forge \
    jupyterlab-nvdashboard \
    pynvml \
    jupyterlab_execute_time && \
    conda clean -tipsy

#RUN rm -rf packages

# Make sure to switch back to user (avoid running ui containers as root)
#USER $NB_UID

FROM jupyter/scipy-notebook:hub-4.0.2

LABEL maintainer="Vincent Prevosto <prevosto@mit.edu>"

COPY --from=jupyter/base-notebook /usr/local/bin/fix-permissions /usr/local/bin/fix-permissions

USER root
# APT packages
RUN apt update && \
    apt install -y --no-install-recommends \
    sshfs \
    nano \
    fonts-dejavu && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN fix-permissions $CONDA_DIR && \
fix-permissions /home/$NB_USER

# update Anaconda and install pip and bokeh
RUN conda update -y conda && \
    conda install -y pip bokeh && \
    conda clean -tipy

# Install minian: clone the repo and create the environment with the yml file
WORKDIR /srv
RUN git clone https://github.com/denisecailab/minian.git
RUN fix-permissions /srv/minian
USER $NB_UID
WORKDIR /srv/minian
RUN conda env create -f environment.yml

SHELL ["conda","run","-n","minian","/bin/bash","-c"]
RUN conda install -y -c conda-forge minian
RUN minian-install --notebooks && \
    minian-install --demo
RUN conda install -y -c conda-forge ipykernel && \
    python -m ipykernel install --user --name minian --display-name "Minian" && \
    conda clean -tipy

# Make dir /data and fix permissions
USER root
RUN mkdir /data && \
    fix-permissions /data
USER $NB_UID
# soft link /data to /home/jovyan/data
RUN ln -s /data /home/$NB_USER/data
# soft link /srv/minian to /home/jovyan/minian
RUN ln -s /srv/minian /home/$NB_USER/minian

WORKDIR /home/$NB_USER

# ENTRYPOINT []
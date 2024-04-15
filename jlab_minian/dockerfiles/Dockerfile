FROM jupyter/scipy-notebook:hub-4.0.2

LABEL maintainer="Vincent Prevosto <prevosto@mit.edu>"

COPY --from=jupyter/base-notebook /usr/local/bin/fix-permissions /usr/local/bin/fix-permissions

USER root
# APT packages
RUN apt update && \
    apt install -y --no-install-recommends \
    libegl1-mesa libgl1-mesa-glx libgl1-mesa-dev \
    sshfs \
    nano \
    fonts-dejavu && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

#  Add $NB_USER to user group that we fix permissions for
RUN usermod -aG users $NB_USER

# Install Miniconda version that matches minian's environment.yml file
ENV PYTHON_VERSION=38
ENV MINICONDA_VERSION=23.3.1-0
ENV CONDA_DIR=/home/miniconda3
ENV LATEST_CONDA_SCRIPT="Miniconda3-py${PYTHON_VERSION}_${MINICONDA_VERSION}-Linux-x86_64.sh"

RUN wget --quiet https://repo.anaconda.com/miniconda/$LATEST_CONDA_SCRIPT -O ~/miniconda.sh && \
    bash ~/miniconda.sh -b -p $CONDA_DIR && \
    rm ~/miniconda.sh

# Set new $CONDA_DIR in PATH and in /etc/environment
ENV PATH=$CONDA_DIR/bin:$PATH
RUN echo "CONDA_DIR=$CONDA_DIR" >> /etc/environment

RUN conda update conda && \
    conda install conda-build && \
    # The jupyter server needs to start with the proper version of pyviz_comms to avoid the frame display issue (see https://github.com/denisecailab/minian/issues/263). 
    # It's worth installing it here to avoid that issue, unless the minian environment is activated (= set as default environment in the container) 
    conda install -y -c conda-forge pyviz_comms=2.2.1

# Fix dangling symlinks in $CONDA_DIR and /home/$NB_USER, then fix permissions
RUN find $CONDA_DIR -xtype l -delete && \
    find /home/$NB_USER -xtype l -delete
RUN fix-permissions $CONDA_DIR && \
fix-permissions /home/$NB_USER

# update Anaconda and install pip and bokeh
RUN conda update -y conda && \
    conda install -y pip bokeh && \
    conda install -y -c conda-forge jupyterlab && \
    conda clean -tipy

# Install minian - part 1: clone the repo and create the environment with the yml file
WORKDIR /srv
RUN git clone https://github.com/denisecailab/minian.git
RUN fix-permissions /srv/minian
USER $NB_UID
WORKDIR /srv/minian
# Copy the environment.yml file to the container. Comment that line if using minian repo's environment.yml file
# COPY packages/environment.yml /srv/minian/environment.yml
RUN conda env create -f environment.yml

# Clean up unnecessary files
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

SHELL ["conda","run","-n","minian","/bin/bash","-c"]
# Install minian - part 2: install the minian package and its dependencies
# Copy the requirements-base.txt file to the container. Comment that line if using minian repo's requirements-base.txt file
# COPY packages/requirements-base.txt /srv/minian/requirements/requirements-base.txt
RUN pip install -e .

# Copy Panel installed in site packages in envs -> minian to site packages in Lib (see Issue https://github.com/denisecailab/minian/issues/266)
RUN conda install -y panel
RUN cp -r /home/miniconda3/envs/minian/lib/python3.8/site-packages/panel /home/miniconda3/lib/python3.8/site-packages/

# Install minian - part 3: install minian's jupyter extension and demo
RUN minian-install --notebooks && \
    minian-install --demo

# Install jupyterlab and set up the kernel
RUN conda install -y -c conda-forge ipykernel jupyterlab pyviz_comms=2.2.1 && \
    python -m ipykernel install --user --name minian --display-name "Minian" && \
    # -c pyviz 
    conda clean -tipy

# Make dir /data and fix permissions
USER root
RUN mkdir /data && \
    fix-permissions /data
# Also change the owner of /srv/minian/dask-worker-space
# RUN chown -R jovyan:users /srv/minian/dask-worker-space

# USER $NB_UID
# soft link /data to /home/jovyan/data
RUN ln -s /data /home/$NB_USER/data
# soft link /srv/minian to /home/jovyan/minian
RUN ln -s /srv/minian /home/$NB_USER/minian

WORKDIR /home/$NB_USER

# ENTRYPOINT []
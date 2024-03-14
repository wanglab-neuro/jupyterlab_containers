FROM jupyter/tensorflow-notebook:hub-4.0.2

LABEL maintainer="Vincent Prevosto <prevosto@mit.edu>"

COPY --from=jupyter/base-notebook /usr/local/bin/fix-permissions /usr/local/bin/fix-permissions
COPY link_package_files.sh /media/link_package_files.sh
ADD content /usr/share/content

USER root
# APT packages
RUN apt update && \
    apt install -y --no-install-recommends \
    sshfs \
    mesa-vulkan-drivers \
    libjpeg-turbo8 \
    nano \
    fonts-dejavu && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN fix-permissions $CONDA_DIR && \
fix-permissions /home/$NB_USER

#Add user to jhub_users group, to get wr permissions to shared folder 
RUN groupadd jhub_users 
RUN usermod -aG jhub_users ${NB_USER}

#Switch to user
USER $NB_UID

RUN mkdir -p /tmp/xdgr
ENV XDG_RUNTIME_DIR /tmp/xdgr

# Conda installs
# update Anaconda and install pip and bokeh
RUN conda update -y conda 
RUN conda install -y pip bokeh

RUN conda config --set channel_priority flexible && \
    conda install -y -c conda-forge \
    jupyterlab-git \
    nb_conda_kernels \
    jupyter_contrib_nbextensions \    
# 
# RUN conda config --set channel_priority strict && \
#     conda install -y -c conda-forge \
    jupyterlab-nvdashboard \
    pynvml \
    jupyterlab_execute_time && \
    conda clean -tipy

# RUN mamba create -y -n caiman -c conda-forge mesmerize-core
# # caiman is a dependency of mesmerize-core
# SHELL ["conda","run","-n","caiman","/bin/bash","-c"]
# RUN python -m ipykernel install --user --name caiman --display-name "CaImAn"
RUN pip install fastplotlib simplejpeg
RUN conda install -y -c conda-forge mesmerize-core
RUN caimanmanager.py install


WORKDIR /home/$NB_USER
# Clone source repos 
RUN mkdir source && cd source && \
git clone https://github.com/flatironinstitute/CaImAn.git && \
git clone https://github.com/nel-lab/mesmerize-core.git && \
git clone https://github.com/kushalkolar/fastplotlib.git

# The section below is a workaround to make those directories available 
# to jupyterhub users, in the case where they do not control 
# if a volume is mounted to the home directory (and WORKDIR superseded)
USER root
RUN cp -R caiman_data /media/caiman_data && \
    fix-permissions /media/caiman_data && \
    cp -R source/CaImAn /media/CaImAn && \
    fix-permissions /media/CaImAn && \
    cp -R source/mesmerize-core /media/mesmerize-core && \
    fix-permissions /media/mesmerize-core && \
    cp -R source/fastplotlib /media/fastplotlib && \
    fix-permissions /media/fastplotlib
RUN ["chmod", "+x", "/media/link_package_files.sh"]

# Make sure to switch back to user (avoid running ui containers as root)
USER $NB_UID
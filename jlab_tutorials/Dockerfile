FROM wanglabneuro/jlab_multi:latest
# FROM jupyter/datascience-notebook:hub-2.3.1

LABEL maintainer="Vincent Prevosto <prevosto@mit.edu>"

COPY --from=jupyter/base-notebook /usr/local/bin/fix-permissions /usr/local/bin/fix-permissions

USER root

# RUN fix-permissions /home/$NB_USER/packages/

# If it isn't done yet, add user to jhub_users group, to get wr permissions to shared folder 
# RUN groupadd jhub_users 
# RUN usermod -aG jhub_users ${NB_USER}

#Switch to user
USER $NB_UID

RUN conda update --all --quiet --yes

# -- add packages available in conda
#    (relies on earlier-configured conda channels: first conda-forge, then defaults)
RUN conda install --quiet --yes \
    jupyter_contrib_nbextensions \
    jupyterlab \
    && conda clean -tipy

RUN git clone "https://github.com/jakevdp/PythonDataScienceHandbook.git" "Python-Data-Science-Handbook"
RUN git clone "https://github.com/patrickmineault/research_code" "Writing-Good-Research-Code"
RUN git clone "https://github.com/NeurodataWithoutBorders/nwb_tutorial.git" "Neurodata-Without-Borders"

RUN NEUROPIXELS_DIR="Visual-Coding-Neuropixels" && \
    mkdir $NEUROPIXELS_DIR && cd "$_" && \
    wget https://allensdk.readthedocs.io/en/latest/_static/examples/nb/ecephys_quickstart.ipynb && \
    wget https://allensdk.readthedocs.io/en/latest/_static/examples/nb/ecephys_session.ipynb


# run with `docker run -it --rm --gpus all -p 8888:8888 jlab_tutorials`
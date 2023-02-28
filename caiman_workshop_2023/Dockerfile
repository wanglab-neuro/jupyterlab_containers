FROM wanglabneuro/jlab_caiman

WORKDIR /home/$NB_USER
RUN git clone https://github.com/EricThomson/CCN_caiman_mesmerize_workshop_2023.git workshop

USER root
RUN cp -R workshop /media/workshop && fix-permissions /media/workshop

WORKDIR /home/$NB_USER/workshop

USER $NB_UID


# Run with: 
# docker run --rm -it --gpus all -e XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR -p 8888:8888/tcp wanglabneuro/jlab_caiman-workshop23:latest

# -v $XDG_RUNTIME_DIR:$XDG_RUNTIME_DIR
FROM wanglabneuro/jlab_caiman

WORKDIR /home/$NB_USER
RUN git clone https://github.com/EricThomson/CCN_caiman_mesmerize_workshop_2023.git workshop

USER root
RUN cp -R workshop /media/workshop && fix-permissions /media/workshop

WORKDIR /home/$NB_USER/workshop

USER $NB_UID

# Need to set XDG_RUNTIME_DIR first if it doesn't exist (e.g., not set by default on WSL), and mount it as `-v $XDG_RUNTIME_DIR:$XDG_RUNTIME_DIR` or define it like, `-e XDG_RUNTIME_DIR=/tmp -v $XDG_RUNTIME_DIR:/tmp`

# Then run with: 
# docker run --rm -it --gpus all -p 127.0.0.1:1234:8888/tcp wanglabneuro/jlab_caiman-workshop23:latest

# docker run --rm -it --gpus all -p 127.0.0.1:8888:8888/tcp wanglabneuro/jlab_caiman:debug


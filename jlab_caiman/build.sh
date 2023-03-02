#!/bin/bash
docker build -t wanglabneuro/jlab_caiman:latest -t wanglabneuro/jlab_caiman:0.2 -f dockerfiles/Dockerfile context
# docker build -t wanglabneuro/jlab_caiman:debug -f dockerfiles/Dockerfile_debug context
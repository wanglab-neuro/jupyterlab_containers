#!/bin/bash
# docker build -t wanglabneuro/jlab_matlab:latest -t wanglabneuro/jlab_matlab:2021b -f dockerfiles/Dockerfile context

docker build -t wanglabneuro/jlab_matlab:latest -f dockerfiles/Dockerfile_test context
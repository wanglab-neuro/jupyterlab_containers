#!/bin/bash
docker build -t wanglabneuro/jlab_minian:latest -t wanglabneuro/jlab_minian:0.0.3 -f dockerfiles/Dockerfile context

# Versions
# 0.0.3: fixes Panel issue
# 0.0.2: Initial working version - with Panel issue (https://github.com/denisecailab/minian/issues/266)
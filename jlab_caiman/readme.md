## Use the caiman container
* Start the notebook server  
`docker run --rm -it --gpus all -v <data directory>:/data -p 8888:8888 wanglabneuro/jlab_caiman`

* Open the browser
`localhost:8888\lab` 

## Build the container image  
Make the script executable, then call `./build.sh`

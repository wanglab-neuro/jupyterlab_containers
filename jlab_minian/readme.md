## Use the minian container
* Start the notebook server  
`docker run --rm -it --gpus all -v <data directory>:/data -p 8888:8888 wanglabneuro/jlab_minian`

e.g., from a Windows terminal:  
`docker run --rm -it --gpus all -v D:\Nitsan:/data -p 8888:8888 wanglabneuro/jlab_minian`
Some notes:
* To preserve the container after it stops, remove the `--rm` flag.
* To make it restart automatically, add the `--restart always` flag
* To make it run in the background, add the `-d` flag.
* To use only GPU 1, use `--gpus device=1` instead of `--gpus all`.
e.g.,  
`docker run -d --restart always -it --gpus device=1 -v D:\Nitsan:/data -p 8888:8888 wanglabneuro/jlab_minian`  

* Open the browser
`localhost:8888\lab` 

## Build the container image  
Make the script executable, then call `./build.sh`

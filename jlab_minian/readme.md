## Use the minian container
* Start the notebook server  
`docker run --rm -it --gpus all -v <data directory>:/data -p 8888:8888 wanglabneuro/jlab_minian`

e.g., from a Windows terminal:  
`docker run --rm -it --gpus all -v D:\Nitsan:/data -p 8888:8888 wanglabneuro/jlab_minian`
Some notes:
* To preserve the container after it stops, remove the `--rm` flag.
* To make it restart automatically, add the `--restart always` flag
* To make it run in the background, add the `-d` flag, and remove the `-it` flag.
* To use only GPU 1, use `--gpus device=1` instead of `--gpus all`.
* To name the container, add the `--name` flag.
e.g.,
`docker run -d --restart always --gpus device=1 -v D:\Nitsan:/data -p 8888:8888 --name minian wanglabneuro/jlab_minian`

* Note that when starting in detached mode (`-d`), the server link with the token is not displayed.  
To set or get the jupyter server token, here are several options:  
    * Add the `--NotebookApp.token` flag, e.g.,  
`docker run --rm -d --gpus all -v D:\Nitsan:/data -p 8888:8888 wanglabneuro/jlab_minian --Notebook App.token='mytoken'`. `mytoken` is the token you want to use. You can create a random one with `openssl rand -hex 32`. 
    * You can set the token in the `jupyter_notebook_config.py` file, and then copy it to the container with the `-v` flag. e.g.,
`docker run --rm -d --gpus all -v D:\Nitsan:/data -v D:\Code\jupyter_notebook_config.py:/root/.jupyter/jupyter_notebook_config.py -p 8888:8888 wanglabneuro/jlab_minian`.  
    * You can print the logs containing the token to the console with `docker logs <container name>`. e.g., `docker logs minian`.  

* Open the browser
`localhost:8888\lab` 

## Build the container image  
Make the script executable, then call `./build.sh`

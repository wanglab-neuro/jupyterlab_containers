Container for running the [minian](https://github.com/denisecailab/minian) pipeline.  
Instruction to use the pipeline are found in the [minian documentation](https://minian.readthedocs.io/en/stable/).  
  
This container's code is hosted in the [Wang lab jupyterlab containers repository](https://github.com/wanglab-neuro/jupyterlab_containers/tree/main).  

## Using the minian container
### Start the notebook server
  
`docker run --rm -it --gpus all -v <data directory>:/data -p 8888:8888 wanglabneuro/jlab_minian`
`--rm` removes the container when it stops.  
`-it` starts the container in interactive mode.  
`--gpus all` allows the container to use all available GPUs.  
`-v <data directory>:/data` mounts the data directory to the container's `/data` directory.  
`-p 8888:8888` maps the container's port 8888 to the host's port 8888.  
`wanglabneuro/jlab_minian` is the name of the container. Docker will download it if it is not found locally. You need Docker installed and running to use this command. To install Docker, see the [Docker installation guide](https://docs.docker.com/get-docker/).  

  e.g., from a Windows terminal:  
  ```
  docker run --rm -it --gpus all -v D:\Nitsan:/data -p 8888:8888 wanglabneuro/jlab_minian
  ```  

**Some information**:  
  * To preserve the container after it stops, remove the `--rm` flag.  
  * To preserve modification to the code, mount the code directory with the `-v` flag. This will overwrite the container's default code directory.
  * To make it restart automatically, add the `--restart always` flag
  * To make it run in the background, add the `-d` flag, and remove the `-it` flag.
  * To use only GPU 1, use `--gpus device=1` instead of `--gpus all`.
  * To name the container, add the `--name` flag.

  e.g., in a Windows cmd terminal:    
  ```bash
  docker run -d ^
  --restart always ^
  --gpus device=1 ^
  -v D:\Nitsan:/data ^
  -v D:\Code\minian:/home/jovyan/minian ^
  -p 8888:8888 ^
  --name minian ^
  wanglabneuro/jlab_minian
  ```

### Open the jupyter notebook server in a browser
  
Connect to `localhost:8888\lab` in a browser, then enter the token password.  
Or log directly with the token added to the address, e.g.:  
`http://127.0.0.1:8888/lab?token=fbb78861ae6613c6514fae064815f9f45e2b27cd41b5ffd3`.  

**Note**: when starting in detached mode (`-d`), the server link with the token is not displayed.  
To set or get the jupyter server token, there are several options:  
  * Add the `--NotebookApp.token` flag, e.g.,  
`docker run --rm -d --gpus all -v D:\Nitsan:/data -p 8888:8888 wanglabneuro/jlab_minian start-notebook.sh --NotebookApp.token='mytoken'`. `mytoken` is the token you want to use. You can create a random one with `openssl rand -hex 24`. 
  * You can set the token in the `jupyter_notebook_config.py` file, and then copy it to the container with the `-v` flag. e.g.,
`docker run --rm -d --gpus all -v D:\Nitsan:/data -v D:\Code\jupyter_notebook_config.py:/root/.jupyter/jupyter_notebook_config.py -p 8888:8888 wanglabneuro/jlab_minian`.  
  * You can print the logs containing the token to the console with `docker logs <container name>`. e.g., `docker logs minian`.  

## Build the container image  
Make the script executable, then call `./build.sh`.

## Jupyterlab containers
A collection of Jupyter containers for neuro-data processing and analysis.  
The containers can be used on Jupyterhub instances or remote workstation / computing clusters.   
For an example deployment on a Jupyterhub server, see [this companion repository](https://github.com/wanglab-neuro/jupyterlab_server).  

To start a Jupyterlab container, launch it with:   
`docker run --rm -it -p 8000:8000/tcp wanglabneuro/<container name>`

**Additional flags**  
Mount data directories with the [`-v` flag](https://docs.docker.com/engine/reference/commandline/run/#volume).  
Add GPU access with `--gpus all`.  

**Notes**  
Containerized notebook servers do not open in a browser automatically (however, one can write a scritp to do that). Instead, use an IDE such as VS Code and click on the linked address, or just copy and paste the address in a new window.  
The port number can be changed to any unused port higher than 1024.  

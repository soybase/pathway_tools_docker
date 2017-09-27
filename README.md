# pathway_tools_docker
Docker files and instructions for setting up a web install of Pathway tools

Download and install pathway tools on a comparable machine you wish to run the service.  We installed pathway tools on CentOS using an interactive login node of the Genepool cluster at NERSC.

In the Dockerfiles here, this installation is copied into the container.  You have to install and copy Pathway Tools due this way because it has a GUI in the installer.

# The User's manual is  here:
pathway-tools/aic-export/pathway-tools/ptools/21.0/doc/manuals

# Chapter 10 has web setup

# Some instructions for headless x-server
http://bioinformatics.ai.sri.com/ptools/web-logout.html

Basically, install pathway tools on a machine and run the web server with

```
pathway_tools -www
```

This will launch a webservice and an x-server.  The webservice will use port 1555.  When you run the Dockerfile, map this port to a standard port like 80.

```
docker run -p 1555:80 -v <your_pgdbs_folder>:/pathway_tools/aic_export/pgdbs/ -t <container_tag>
```


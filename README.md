# pathway_tools_docker
Docker files and instructions for setting up a web install of Pathway tools

The Docker image is based on **Ubuntu:16.04**, updated to have the required support libraries. Currently, the Dockerfile assumes that it is installing version 21.0 of the pathway tools, and expects you to provide the **pathway-tools-21.0-linux-64-tier1-install** installer in the current directory.

There's an installation script which feeds the answers to the tool installer, **install-pathway-tools.sh**. This is run by Docker when it builds the image. It also has the name of the installer hard-coded.

Build the container with the following command:

```
docker build -t pathway:21.0 .
```

The container will use a script for running the service automatically, **run-pathway-tools.sh**. It uses **Xvfb** to provide a headless X11 display to satisfy the bizarre need for X11 in a server process. You can run the container with this command:

```
docker run --volume `pwd`:/mnt --publish 1555:1555 --rm --name pathway -it pathway:21.0
```

Then, if you visit **http://localhost:1555** on your host machine, you should see the pathway tools website.

Change the **pttools-init.dat** file if you need to modify the configuration, then rebuild the container.

# The User's manual...
...is installed into /opt/pathway-tools/pathway-tools/aic-export/pathway-tools/ptools/21.0/doc/manuals in the container. It's also included in this repository, for good measure.

# Chapter 10 has web setup

# Some instructions for headless x-server
http://bioinformatics.ai.sri.com/ptools/web-logout.html

Basically, install pathway tools in the container and run the web server with

```
pathway_tools -www
```

This will launch a webservice and an x-server.  The webservice will use port 1555.  When you run the Dockerfile, map this port to a standard port like 80.

```
docker run -p 1555:80 -v <your_pgdbs_folder>:/pathway_tools/aic_export/pgdbs/ -t <container_tag>
```


# To run on Spin:

First, tag the image for the Spin registry, then push it. You may need to log into the registry first:

```
docker login registry.spin.nersc.gov
docker tag pathway:21.0 registry.spin.nersc.gov/wildish/pathway:21.0
docker push registry.spin.nersc.gov/wildish/pathway:21.0
```

You can create a stack in Spin using the *docker-compose.yml* file in this repository. Ask Cory Snavely and the Spin team for help with that.

# To make a PGDB from a genbank file...

### Step 1: Getting a genbank file from img

Starting from img genome:
https://img.jgi.doe.gov/cgi-bin/mer/main.cgi?section=TaxonDetail&page=taxonDetail&taxon_oid=2626542074

Click on NCBI Taxon ID

Click on the number by the "Genome" in the upper right corner: https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?id=1619043

Click on "Go to nucleotide: GenBank" from here: https://www.ncbi.nlm.nih.gov/genome/?term=txid1619043[Organism:noexp]

https://www.ncbi.nlm.nih.gov/nuccore/818881831?report=genbank
Click on upper right "Send to: File"

### PathoLogic Batch Mode See section 7.6 of the user's manual

### Use the python package 'annot2pathologic' to build inputs for pathway tools
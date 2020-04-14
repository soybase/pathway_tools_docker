# pathway_tools_docker
Docker files and instructions for setting up a web install of Pathway tools

The Docker image is based on **Ubuntu:18.04**, updated to have the required support libraries.
The pathway-tools-VERSION-linux-install-64-tier1-install installer must exist in the ptools-install/ directory.
The Dockerfile has been tested with Pathway Tools 23.5.

## Quick Start (Docker Compose)

To build and run, execute the following command from the pathway_tools_docker/ directory:

```
DOCKER_BUILDKIT=1 COMPOSE_DOCKER_CLI_BUILD=1 docker-compose up --build
```

After the following message is displayed, Pathway Tools is accessible at http://localhost:1555

```
...
pathway_1  | Opening Navigator window.
...
pathway_1  | Starting AllegroServe on port 1555
```

If using Docker Machine, instead check the output of `docker-machine ip`, and visit http://DOCKER_MACHINE_IP:1555.

## Building Pathway Tools Container Image

Build the container with the following command:

```
docker build [--build-arg without_biocyc=1] -t pathway:23.5 .
```

The container will use a script for running the service automatically, **run-pathway-tools.sh**. It uses **Xvfb** to provide a headless X11 display to satisfy the bizarre need for X11 in a server process. You can run the container with this command:

Additional pathway-tools command-line arguments (see "2.3 Running Pathway Tools from the Command Line" in the User Guide) can be specified by appending them to the `docker run` command; e.g., to only publish a specific organism:

```
docker run --publish 1555:1555 --rm pathway:23.5 -org ${ORGANISM_ID} -www-publish ${ORGANISM_ID}
```

To bind-mount a host directory (e.g., ./ptools-local) at /opt/ptools-local in the container:

```
mkdir -p ./ptools-local/pgdbs/user ./ptools-local/html
cp /path/to/ptools-init.dat ./ptools-local
cp -Rp my_pgdb ./ptools-local/pgdbs/user
docker run --publish 1555:1555 --volume ./ptools-local:/opt/ptools-local --rm pathway:23.5
```
To use a data volume container that specifies a volume at /opt/ptools-local (e.g., the Dockerfile for image ptools-local:TAG specifies "VOLUME /opt/ptools-local")

```
docker create -n ptools-local ptools-local:TAG
docker run --publish 1555:1555 --volumes-from ptools-local --rm pathway:23.5
```

To override the default **/opt/ptools-local/ptools-init.dat** file without bind mounting a directory from the host, or using a data volume container:

```
docker create --publish 1555:1555 --name pathway pathway:23.5
docker cp ptools-init.dat pathway:/opt/ptools-local
docker start pathway
# or instead create a new image:
docker stop pathway && docker commit pathway pathway-mod:23.5
```

# To make a PGDB from a genbank file...

### Step 1: Getting a genbank file from img

Starting from img genome:
https://img.jgi.doe.gov/cgi-bin/mer/main.cgi?section=TaxonDetail&page=taxonDetail&taxon_oid=2626542074

Click on NCBI Taxon ID

Click on the number by the "Genome" in the upper right corner: https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?id=1619043

Click on "Go to nucleotide: GenBank" from here: https://www.ncbi.nlm.nih.gov/genome/?term=txid1619043[Organism:noexp]

https://www.ncbi.nlm.nih.gov/nuccore/818881831?report=genbank
Click on upper right "Send to: File"

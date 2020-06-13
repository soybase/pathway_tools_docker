# pathway_tools_docker
Docker files and instructions for setting up a web install of Pathway Tools 24.0

### Building a Container Image

1. Put the pathway-tools-24.0-linux-install-64-tier1-install installer in the pathway-tools/ directory

2. From the command line, set the current working directory to the pathway_tools_docker directory, and build the image with the following command (the DOCKER_BUILDKIT and COMPOSE_DOCKER_CLI_BUILD environment variables are optional, but recommended):

```
DOCKER_BUILDKIT=1 COMPOSE_DOCKER_CLI_BUILD=1 docker-compose build
```

### Starting Pathway Tools

Put any PGDBs in `ptools-local/pgdbs/user` , any custom html in `ptools-local/pgdbs/html`, and make any desired edits to `ptools-local/ptools-init.dat`, then start a Pathway Tools container:
```
docker-compose up
```

After the following message is displayed, Pathway Tools is accessible at http://localhost:1555

```
...
pathway_1  | Opening Navigator window.
...
pathway_1  | Starting AllegroServe on port 1555
```

To stop, hit CTRL-C in your terminal, then:
```
docker-compose down
```

Additional pathway-tools command-line arguments (see "2.3 Running Pathway Tools from the Command Line" in the User Guide) can be specified by adding them to the **command** configuration option in docker-compose.yml.

### Production

```
DOCKER_BUILDKIT=1 COMPOSE_DOCKER_CLI_BUILD=1 docker-compose -f docker-compose.prod.yml build --parallel
docker-compose -f docker-compose.prod.yml up -d
```

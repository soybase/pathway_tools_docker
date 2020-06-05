# pathway_tools_docker
Docker files and instructions for setting up a web install of Pathway tools

The Docker image is based on **Ubuntu:18.04**, updated to have the required support libraries.
The pathway-tools-24.0-linux-install-64-tier1-install installer must exist in the ptools-install/ directory.
The Dockerfile has been tested with Pathway Tools 24.0.

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

Additional pathway-tools command-line arguments (see "2.3 Running Pathway Tools from the Command Line" in the User Guide) can be specified by adding them to the **command** configuration option in docker-compose.yml.

To bind-mount a host directory (e.g., ./ptools-local) at /opt/ptools-local in the container, uncomment the **volumes** configuration option in docker-compose.yml.

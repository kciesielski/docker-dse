DSE (DataStax Search Enterprise) 4.8.2 docker image.
===================================================
**For testing purposes only!**
This container starts DSE and populates it with the "wikipedia demo" data. It also creates necessary Solr metadata and indexes.
The container launches supervisord before running Cassandra in order to start a background task which should enable Solr capabilities, populate database with sample data and generate indexes.
This script is defined in init-data.sh.

1. Building the image
First, make sure that you have a copy of the binary `dse-4.8.2-bin.tar.gz` available in the same directory where your Dockerfile and all other scripts are located.  
Execute `docker build -t dse .`

2. Running a container
If your `dse` image is built, you can start a container with 
`./launch-dse.sh dse 1 -s`

Parameters:  
- `dse`: your image name
- `1`: single node
- `-s`: with SolR support

Your Solr admin console should be available under `http://docker-host:8983/solr/`

CAUTION!
This image is not secured for production usage.

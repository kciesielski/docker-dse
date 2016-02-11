#!/bin/sh
IP=`hostname --ip-address`
echo "Initializing wikipedia demo"
while ! curl -m 10 http://$IP:8983/solr/ >> /dev/null
do
  echo "$(date) - waiting for DSE to be up"
  sleep 1
done
echo "$(date) - DSE is up and running"

$DSE_HOME/demos/wikipedia/1-add-schema.sh
$DSE_HOME/demos/wikipedia/2-index.sh --wikifile $DSE_HOME/demos/wikipedia/wikipedia-sample.bz2

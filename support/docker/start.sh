#!/bin/bash

# Confirm data directory in container is clear to boot fresh
rm -rf /opt/jboss/fuse/jboss-fuse-6.1.0.redhat-379/instances/c1/data/*

# Start DV
/opt/jboss/dv/jboss-eap-6.1/bin/standalone.sh -c standalone.xml -b 0.0.0.0 -bmanagement 0.0.0.0 > /dev/null 2>&1 &

# Start Fuse
echo "Starting Fuse root and child containers. Please wait..."
/opt/jboss/fuse/jboss-fuse-6.1.0.redhat-379/bin/start

# Wait for Root container to come up and start child Container
/opt/jboss/fuse/jboss-fuse-6.1.0.redhat-379/bin/client -u admin -p admin "wait-for-service -t 300000 io.fabric8.api.FabricService" -r 60
/opt/jboss/fuse/jboss-fuse-6.1.0.redhat-379/bin/client -u admin -p admin "fabric:container-start c1" -r 60

exec "$@"

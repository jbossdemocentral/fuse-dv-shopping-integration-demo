#/bin/sh
#
# Builds demo projects, deploys profiles, creates container containing profiles.
#
# author: cojan.van.ballegooijen@redhat.com, andy.block@gmail.com
#

set -e

FUSE_DIR=/opt/jboss/fuse/jboss-fuse-6.1.0.redhat-379
DV_DIR=/opt/jboss/dv/jboss-eap-6.1
KARAF_LOG=$FUSE_DIR/data/log/karaf.log
if [ -f "$KARAF_LOG" ]
then
	rm $KARAF_LOG </dev/null
	touch $KARAF_LOG </dev/null
fi

echo "Starting JBoss Fuse and wait for 30 seconds..." 
echo
$FUSE_DIR/bin/start  

sleep 30 

if [ ! -d "$FUSE_DIR/instances/c1" ]
then
	echo "Creating Fabric..." 
	echo
	$FUSE_DIR/bin/client -u admin -p admin "fabric:create --wait-for-provisioning" -r 60
	mvn -f /opt/jboss/projects/usecase1/pom.xml -s /opt/jboss/settings.xml clean install -DskipTests 
	mvn -f /opt/jboss/projects/usecase1/pom.xml -s /opt/jboss/settings.xml fabric8:deploy -DskipTests
	mvn -f /opt/jboss/projects/usecase2/pom.xml -s /opt/jboss/settings.xml clean install -DskipTests 
	mvn -f /opt/jboss/projects/usecase2/pom.xml -s /opt/jboss/settings.xml fabric8:deploy -DskipTests
	mvn -f /opt/jboss/projects/usecase4/pom.xml -s /opt/jboss/settings.xml clean install -DskipTests 
	mvn -f /opt/jboss/projects/usecase4/pom.xml -s /opt/jboss/settings.xml fabric8:deploy -DskipTests


	echo "Creating profiles and child container"
	$FUSE_DIR/bin/client -u admin -p admin "profile-edit --bundles wrap:file://$DV_DIR/dataVirtualization/jdbc/teiid-8.4.1-redhat-7-jdbc.jar usecase1 1.0" -r 10 
	$FUSE_DIR/bin/client -u admin -p admin "profile-edit --bundles wrap:file://$DV_DIR/dataVirtualization/jdbc/teiid-8.4.1-redhat-7-jdbc.jar usecase2 1.0" -r 10
	$FUSE_DIR/bin/client -u admin -p admin "profile-edit --bundles wrap:file://$DV_DIR/dataVirtualization/jdbc/teiid-8.4.1-redhat-7-jdbc.jar usecase4 1.0" -r 10
	$FUSE_DIR/bin/client -u admin -p admin "fabric:container-create-child --profile usecase1 --profile usecase2 --profile usecase4 --profile jboss-fuse-minimal root c1" -r 10
fi

# Some wait code. Wait till the system is ready. 
STARTUP_WAIT=60
count=0
launched=false

until [ $count -gt $STARTUP_WAIT ]
do
    grep 'Broker root has started' $KARAF_LOG > /dev/null
    if [ $? -eq 0 ] ; then
      launched=true
      break
    fi
    sleep 1
    let count=$count+1;
done

echo "Stopping child and root containers..."
$FUSE_DIR/bin/client -u admin -p admin "fabric:container-stop --force" -r 10
$FUSE_DIR/bin/stop

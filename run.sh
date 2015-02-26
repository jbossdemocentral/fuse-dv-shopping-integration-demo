#/bin/sh
#
# Start a JBoss Data Virtualization & JBoss Fuse environment.
#
# This script expects JBoss Fuse to be running in order to start the c1 container
#
# author: cojan.van.ballegooijen@redhat.com
#
FUSE_DIR=$PWD/target/fuse/jboss-fuse-6.1.1.redhat-412
DV_DIR=$PWD/target/dv/jboss-eap-6.1
KARAF_LOG=$FUSE_DIR/data/log/karaf.log
if [ -f "$KARAF_LOG" ]
then
	rm $KARAF_LOG </dev/null
	touch $KARAF_LOG </dev/null
fi
echo 
$FUSE_DIR/bin/start  
echo "Starting JBoss Fuse and wait for 30 seconds" 
echo

$FUSE_DIR/bin/start  
sleep 30 
echo 
echo "Starting JBoss Data Virtualization"
echo
nohup $DV_DIR/bin/standalone.sh > dv.log 2>&1 </dev/null & 

if [ ! -d "$FUSE_DIR/instances/c1" ]
then
	$FUSE_DIR/bin/client -u admin -p admin "fabric:create --wait-for-provisioning" -r 3
	cd projects/shopping-demo-application/application-interface
	mvn clean install -DskipTests 
	mvn fabric8:deploy -DskipTests    
	cd ../application
	mvn clean install -DskipTests 
	mvn fabric8:deploy -DskipTests  
	cd ../..
	$FUSE_DIR/bin/client -u admin -p admin "profile-edit --bundles wrap:file://$DV_DIR/dataVirtualization/jdbc/teiid-8.4.1-redhat-7-jdbc.jar application 1.0" -r 3 
	$FUSE_DIR/bin/client -u admin -p admin "fabric:container-create-child --profile application-interface --profile application --profile jboss-fuse-minimal root c1" -r 3  
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
$FUSE_DIR/bin/client -u admin -p admin "fabric:container-start -f c1"

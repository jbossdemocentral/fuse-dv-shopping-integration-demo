#/bin/sh
#
# Start a JBoss Data Virtualization & JBoss Fuse environment.
#
# This script expects JBoss Fuse to be running in order to start the shopping application
#
# author: ankit.b.verma@accenture.com
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

	cd projects/shopping-demo-application
	mvn clean install -DskipTests      
	cd ..
	$FUSE_DIR/bin/client -u admin -p admin "osgi:install -s war:mvn:com.redhat/application-interface/1.0.0-SNAPSHOT/war?Web-ContextPath=shoppingApplication" -r 3
	$FUSE_DIR/bin/client -u admin -p admin "osgi:install  -s wrap:mvn:mysql/mysql-connector-java/5.0.5" -r 3
	$FUSE_DIR/bin/client -u admin -p admin "osgi:install -s wrap:mvn:commons-dbcp/commons-dbcp/1.4" -r 3
	$FUSE_DIR/bin/client -u admin -p admin "features:install camel-sql" -r 3
	$FUSE_DIR/bin/client -u admin -p admin "features:install camel-twitter" -r 3
	$FUSE_DIR/bin/client -u admin -p admin "features:install camel-jackson" -r 3
	$FUSE_DIR/bin/client -u admin -p admin "features:install camel-salesforce" -r 3
	$FUSE_DIR/bin/client -u admin -p admin "osgi:install -s wrap:file://$DV_DIR/dataVirtualization/jdbc/teiid-8.4.1-redhat-7-jdbc.jar" -r 3 
	$FUSE_DIR/bin/client -u admin -p admin "osgi:install -s wrap:mvn:com.redhat/application/1.0.0-SNAPSHOT" -r 3  

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
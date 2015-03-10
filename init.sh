#!/bin/sh 
DEMO="Fuse API Best Practices:Shopping Application Demo" 
AUTHORS="Accenture-Ankit Verma"
PROJECT="https://github.com/jbossdemocentral/fuse-dv-shopping-integration-demo.git"
PRODUCT="Fuse API Best Practices:Shopping Application Demo"
JBOSS_HOME=./target/jboss-eap-6.1
JBOSS_HOME_DV=./target/dv/jboss-eap-6.1
JBOSS_HOME_FUSE=./target/fuse/jboss-fuse-6.1.1.redhat-412
SERVER_DIR=$JBOSS_HOME/standalone/deployments/
SERVER_CONF=$JBOSS_HOME/standalone/configuration/
SERVER_BIN=$JBOSS_HOME/bin
SERVER_BIN_DV=$JBOSS_HOME_DV/bin
SERVER_BIN_FUSE=$JBOSS_HOME_FUSE/bin
SERVER_DIR=$JBOSS_HOME/standalone/deployments/
SERVER_CONF_DV=$JBOSS_HOME_DV/standalone/configuration/
SERVER_CONF_FUSE=$JBOSS_HOME_FUSE/etc
SRC_DIR=./software
DV_SUPPORT_DIR=./support/dv-support
FUSE_SUPPORT_DIR=./support/fuse-support
PRJ_DIR=./projects
FUSE=jboss-fuse-full-6.1.1.redhat-412.zip
DV=jboss-dv-installer-6.1.0.Beta-redhat-1.jar
FUSE_VERSION=6.1.1
DV_VERSION=6.0.0

# wipe screen.
clear 

echo  
echo "Setting up the ${DEMO}"  
echo    
echo "brought to you by,"   
echo "  ${AUTHORS}"
echo 
echo "  ${PROJECT}"
echo

command -v mvn -q >/dev/null 2>&1 || { echo >&2 "Maven is required but not installed yet... aborting."; exit 1; }

# make some checks first before proceeding.	
if [ -r $SRC_DIR/$DV ] || [ -L $SRC_DIR/$DV ]; then
	    echo JBoss product sources, $DV present...
		echo
else
		echo Need to download $DV package from the Customer Portal 
		echo and place it in the $SRC_DIR directory to proceed...
		echo
		exit
fi

# make some checks first before proceeding.	
if [ -r $SRC_DIR/$FUSE ] || [ -L $SRC_DIR/$FUSE ]; then
	    echo JBoss product sources, $FUSE present...
		echo
else
		echo Need to download $FUSE package from the Customer Portal 
		echo and place it in the $SRC_DIR directory to proceed...
		echo
		exit
fi

# Remove JBoss product installation if exists.
if [ -x target ]; then
	echo "  - existing JBoss product installation detected..."
	echo
	echo "  - removing existing JBoss product installation..."
	echo
	rm -rf target
fi

read -p "Starting DV Install <hit return or wait 5 seconds>" -t 2
echo

# Run DV installer.
echo Product installer running now...
echo

java -jar $SRC_DIR/$DV $DV_SUPPORT_DIR/InstallationScript.xml 

read -p "Post DV install configuration <hit return or wait 5 seconds>" -t 5
echo

if [ -x target ]; then
  # Unzip the JBoss Fuse instance.
  echo Installing JBoss Fuse $FUSE_VERSION
  echo
  unzip -q -d target/fuse $SRC_DIR/$FUSE
else
	echo
	echo Missing target directory, stopping installation.
	echo 
	exit
fi

echo "  - enabling demo accounts logins in users.properties file..."
echo
cp $FUSE_SUPPORT_DIR/users.properties $SERVER_CONF_FUSE

echo "  - enabling application properties file..."
echo
cp $FUSE_SUPPORT_DIR/com.redhat.application.cfg $SERVER_CONF_FUSE


echo
echo "  - install teiid security files..."
echo
cp $DV_SUPPORT_DIR/teiid* $SERVER_CONF_DV

echo
echo "  - move modules..."
echo
cp -R $DV_SUPPORT_DIR/modules/* $JBOSS_HOME_DV/modules

echo
echo "  - move virtual database..."
echo
cp -R $DV_SUPPORT_DIR/vdb $JBOSS_HOME_DV/standalone/deployments

echo "  - setting up dv standalone.xml configuration adjustments..."
echo
cp $DV_SUPPORT_DIR/standalone.dv.xml $SERVER_CONF_DV/standalone.xml


# Final instructions to user to start and run demo.                                                                  
echo
echo "See Readme for any additional steps"                   
echo "$DEMO Setup Complete."
echo


Shopping Application Demo
======================================
This demo project will get you started with automatically installing two server instances, one with JBoss Data Virtualization and the other with JBoss Fuse, and then configuring the application.
  
  NOTE:  Make sure the fabric server passwords for the Maven Plugin is in your ~/.m2/settings.xml file so that the maven plugin can login to the fabric.  See the example in the support/settings.xml file.  Also make sure JAVA_HOME is setup, such as - export JAVA_HOME="/etc/alternatives/java_sdk" - on Fedora.  
  
Local Install Option:  
---------------------    

1. [Download and unzip.](https://github.com/jbossdemocentral/fuse-dv-shopping-integration-demo/archive/master.zip).  If running on Windows, it is reccommended the project be extracted to a location near the root drive path due to limitations of length of file/path names.  
  
2. Add the DV and Fuse Products to the software directory.  
  
3. Run 'init.sh' or 'init.bat' to setup the environment locally. 'init.bat' must be run with Administrative privileges.  
  
4. Run 'run.sh' or 'run.bat' to start the servers, create the container and deploy the bundles.  
  
5. Sign onto the Fuse Management console and check the console log to see the output from the routes for the use cases.  You can also view the Camel Diagrams.  
Shopping Application Demo
======================================

This demo project will get you started with automatically installing two server instances, one with JBoss Data Virtualization and the other with JBoss Fuse, and then configuring the application.


Setting up your local environment
---------------------------------


1. [Pull the project down from github](#pull-the-project-down-from-github)

2. [Install MySQL](#install-mysql)

3. [Install PostreSQL](#Install-PostgreSQL)

4. [Install JBoss Data Virtualization](#Install-JBoss-Data-Virtualization). Note that this also installs EAP, so this is all you need to run the demos.  

5. [Install local development environment - JBoss Developer Studio](#Install-and-Setup-JBoss-Developer-Studio)

6. [Install JBoss Fuse](Install-JBoss-Fuse). Only required if it is desired to run on Fuse.

7. [Install SoapUI](#Install-SoapUI) to run the Web Service demo.

8. [Set up and run application](#Setup-and-run-the-application)


Running the demos
---------------------------------


Detailed Instructions for setting up your local environment
---------------------------------


### Pull the project down from github


[Download and unzip.](https://github.com/jbossdemocentral/fuse-dv-shopping-integration-demo/archive/master.zip).  If running on Windows, it is reccommended the project be extracted to a location near the root drive path due to limitations of length of file/path names.  Or just clone from git.

[Back to top](#setting-up-your-local-environment)

### Install MySQL

1. Install MySQL Database - http://dev.mysql.com/downloads/

2. Install MySQL Workbench - http://dev.mysql.com/downloads/workbench/

3. Start server using command 'sudo mysqld_safe &'

4. Open Workbench

5. Open SQL Tab to execute the content of the following query: [support/sql-support/init_mysql.sql](support/sql-support/init_mysql.sql)


### Install PostgreSQL

1. Install the PostgreSQL server (http://www.postgresql.org/download/). 

2. Open SQL Tab to execute the content of the following query: [support/sql-support/init_postgres.sql](support/sql-support/init_postgres.sql)



### Install JBoss Data Virtualization

Note that this also installs EAP, so this is all you need to run the demos.

1. Go to http://access.redhat.com

2. Download JBoss Data Virtualization 6.1 (jboss-dv-installer-6.1.0.redhat-3.jar). Put this in the software folder in your local environment.

3. Run this using:

        java -jar jboss-dv-installer-6.1.0.redhat-3.jar

4. Select the "target" folder (see [screenshot](/target/docs/img/dv-install-location.png)
	* Select all products
	* Choose passwords
	* Perform the default configuration
	* See [key options](/target/docs/img/dv-install-options.png)


### Install and Setup JBoss Developer Studio




### Install JBoss Fuse

Only required if it is desired to run on Fuse.


### Install SoapUI

### Setup and run the application


Once the databases are created we can move to the installation and deployment section

Configure the PROJECT.HOME/support/standalone.dv.xml file 
----------------------------------------------------------

The standalone.dv.xml holds the configuration of the datasources mapping to the JDV server. We have provided "postgres" as default username and password and for Postgres datasource and root as username and password for mysql. The user can change these values in standalone.dv xml found under /fuse-shoppng-aplication/support/dv-support.

Installing Jboss and Deploying the Application  
----------------------------------------------    

1. [Download and unzip.](https://github.com/jbossdemocentral/fuse-dv-shopping-integration-demo/archive/master.zip).  If running on Windows, it is reccommended the project be extracted to a location near the root drive path due to limitations of length of file/path names.  
  
2. Add the DV and Fuse Products to the software directory.  
  
3. Run 'init.sh' or 'init.bat' to setup the environment locally. 'init.bat' must be run with Administrative privileges.  
  
4. Run 'run.sh' or 'run.bat' to start the servers, create the container and deploy the bundles.  
  
5. Sign onto the Fuse Management console and check the console log to see the output from the routes for the use cases.  You can also view the Camel Diagrams.

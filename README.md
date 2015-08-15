Shopping Application Demo
======================================

This demo project will get you started with automatically installing two server instances, one with JBoss Data Virtualization and the other with JBoss Fuse, and then configuring the application.


Setting up your local environment
---------------------------------

1. [Pull the project down from github][install-project]

2. [Install MySQL][install-mysql]

3. [Install PostreSQL][install-postgres]

4. [Install JBoss Data Virtualization][install-dv]. Note that this also installs EAP, so this is all you need to run the demos.

5. [Install local development environment - JBoss Developer Studio][install-devstudio]

6. [Install JBoss Fuse][install-fuse]. Only required if it is desired to run on Fuse.

7. [Install SoapUI][install-soapui] to run the Web Service demo.

8. [Set up and run application][install-setup]


Running the demos
---------------------------------


Detailed Instructions for setting up your local environment
---------------------------------



### [install-project]: Pull the project down from github


[Download and unzip.](https://github.com/jbossdemocentral/fuse-dv-shopping-integration-demo/archive/master.zip).  If running on Windows, it is reccommended the project be extracted to a location near the root drive path due to limitations of length of file/path names.  Or just clone from git.


### [install-mysql]: MySQL Setup

1. Install MySQL Database - http://dev.mysql.com/downloads/

2. Install MySQL Workbench - http://dev.mysql.com/downloads/workbench/

3. Start server using command 'sudo mysqld_safe &'

4. Open Workbench

5. Open SQL Tab to execute the content of the following query: [support/sql-support/init_mysql.sql](support/sql-support/init_mysql.sql)


### [install-postgres]: PostgresSQL Setup

1. Install the PostgreSQL server (http://www.postgresql.org/download/). 

2. Open SQL Tab to execute the content of the following query: [support/sql-support/init_postgres.sql](support/sql-support/init_postgres.sql)



### [install-dv]: Install JBoss Data Virtualization.

Note that this also installs EAP, so this is all you need to run the demos.

1. Download

2. Unzip...



### [install-devstudio]: Install local development environment - JBoss Developer Studio




### [install-fuse]: Install JBoss Fuse

Only required if it is desired to run on Fuse.


### [install-soapui]: Install SoapUI

### [install-setup]: Setup and run the application


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

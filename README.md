Shopping Application Demo
======================================

This demo project will get you started with automatically installing two server instances, one with JBoss Data Virtualization and the other with JBoss Fuse, and then configuring the application.


Setting up your local environment
---------------------------------


1. [Pull the project down from github](#setup-1-pull-the-project-down-from-github)

2. [Install MySQL](#setup-2-install-mysql)

3. [Install PostreSQL](#setup-3-install-postgresql)

4. [Install JBoss Data Virtualization](#setup-4-install-jboss-data-virtualization). Note that this also installs EAP, which is what you need to run the demos.  

5. [Install JBoss A-MQ](#setup-5-install-jboss-amq). 

6. [Install local development environment - JBoss Developer Studio](#setup-6-install-and-setup-jboss-developer-studio)

7. [Install JBoss Fuse](#setup-7-install-jboss-fuse). Only required if it is desired to run on Fuse.

8. [Install SoapUI](#setup-8-install-soapui) to run the Web Service demo.

9. [Set up and run application](#setup-9-setup-and-run-the-application)


Running the demos
---------------------------------

1. [View the shopping application and show products](#view-the-shopping-application-and-show-products)

2. [Add products by calling a web service](#add-products-by-calling-a-web-service)

3. [See products added on twitter and salesforce](#see-products-added-on-twitter-and-salesforce)

4. [View REST services](#view-rest-services)

5. [Authenticate and buy products](#authenticate-and-buy-products)

6. [Consume API using a feedhenry project](#see-products-added-on-twitter-and-salesforce)


### Setup 1 Pull the project down from github


[Download and unzip](https://github.com/jbossdemocentral/fuse-dv-shopping-integration-demo/archive/master.zip) the archive file.  If running on Windows, it is recommended the project be extracted to a location near the root drive path due to limitations of length of file/path names.  Or just clone from git with 
	git clone https://github.com/jbossdemocentral/fuse-dv-shopping-integration-demo.git

[*Back to setup*](#setting-up-your-local-environment)

### Setup 2 Install MySQL

1. Install MySQL Database - http://dev.mysql.com/downloads/. Keep the admin password as root.

2. Install MySQL Workbench - http://dev.mysql.com/downloads/workbench/

3. Start server using command 'sudo mysqld_safe &'

4. Open Workbench

5. Open SQL Tab to execute the content of the following query: [support/sql-support/init_mysql.sql](support/sql-support/init_mysql.sql)

[*Back to setup*](#setting-up-your-local-environment)

### Setup 3 Install PostgreSQL

1. Install the PostgreSQL server (http://www.postgresql.org/download/). Keep the admin password as postgres.

2. Open SQL Tab to execute the content of the following query: [support/sql-support/init_postgres.sql](support/sql-support/init_postgres.sql)

[*Back to setup*](#setting-up-your-local-environment)

### Setup 4 Install JBoss Data Virtualization

Note that this also installs EAP, so this is all you need to run the demos.

1. Go to http://access.redhat.com

2. Download JBoss Data Virtualization 6.1 (jboss-dv-installer-6.1.0.redhat-3.jar). Put this in the software folder in your local environment.

3. Run this using:

        java -jar jboss-dv-installer-6.1.0.redhat-3.jar

4. Select the "target" folder (see [screenshot](/docs/img/dv-install-location.png)) and complete the installation
	* Select all products
	* Choose passwords and OData enabled
	* Perform the default configuration
	* See [key options](/docs/img/dv-install-options.png)

[*Back to setup*](#setting-up-your-local-environment)

### Setup 5 Install JBoss AMQ

1. Go to http://access.redhat.com

2. Download Red Hat JBoss A-MQ 6.2.0 (jboss-a-mq-6.2.0.redhat-133.zip). Put this in the software folder in your local environment.

3. Unzip this to the target folder.

4. Unzip target/jboss-a-mq-6.2.0.redhat-133/extras/apache-activemq-5.11.0.redhat-620133-bin.zip to /support

5. Copy /support/apache-activemq-5.11.0.redhat-620133/lib/optional/activemq-rar-5.11.0.redhat-620133.rar to /target/dv/standalone/deployments



[*Back to setup*](#setting-up-your-local-environment)  

### Setup 6 Install and Setup JBoss Developer Studio

1. Go to http://access.redhat.com

2. Download and install JBoss Developer Studio - we used version 7.1.1 for development of these examples. 

3. Download and install the Fuse plugin. Instructions are located at https://access.redhat.com/documentation/en-US/Red_Hat_JBoss_Fuse/6.1/html-single/Tooling_Installation_Guide/.

4. Install the data virtualization development plugin. Go to JBoss Central within dev studio to install. (see [screenshot](/docs/img/dev-studio-datai-virt.png))

5. Import the project into eclipse as a Maven project.

[*Back to setup*](#setting-up-your-local-environment)


### Setup 7 Install JBoss Fuse

Only required if it is desired to run on Fuse.

[*Back to setup*](#setting-up-your-local-environment)


### Setup 8 Install SoapUI

Go to http://www.soapui.org/. Download and follow the instructions to install.

[*Back to setup*](#setting-up-your-local-environment)


### Setup 9 Setup and run the application

The init.sh/init.bat files will be updated to complete these steps. To complete manually:

1. Install the teiid security files: copy support/dv-support/teiid-security-roles.properties AND teiid-security-users.properties to target/dv/standalone/configuration/

2. Install mysql and postgres JDBC drivers into EAP: copy support/dv-support/modules/\* to target/dv/modules

3. Install the users for A-MQ: copy support/amq-support/users.properties to jboss-a-mq-6.2.0.redhat-133/etc/

4. Install the configuration file for EAP: copy support/amq-support/standalone.dv.xml to target/dv/standalone/configuration/standalone.xml

4. Install the demo virtual database: copy support/dv-support/vdb to target/dv/standalone/deployments

5. Build the project: in the projects/shopping-demo-application run 
        mvn clean install

6. Install the WAR file into EAP: copy projects/shopping-demo-application/application-interface/target/v1.shoppingApplication.war to target/dv/standalone/deployments/shoppingApplication.war

7. Start the application server: run target/dv/bin/standalone.sh or standalone.bat

8. Start the AMQ server: run target/jboss-a-mq-6.2.0.redhat-133/bin/standalone.sh or standalone.bat



[*Back to setup*](#setting-up-your-local-environment)



### View the shopping application and show products

1. Goto http://localhost:8080/shoppingApplication/

2. The page should display

3. Click show products. This calls the camel show products route which pulls back all the products from the database and displays them.

[*Back to running*](#running-the-demos)

### Add products by calling a web service

1. Open up SoapUI

2. Create new project and add the wsdl by pointing it to http://localhost:8080/shoppingApplication/services/shoppingApplication/AddNewProductsService?wsdl.
Note that this is what sends the request through the Camel route. If you use the direct URL for the web service
(http://localhost:8080/shoppingApplication/AddNewProductsService) then this will NOT go through Camel and will hit AddNewProductsImpl directly instead.

3. Create a sample request

4. Paste in the path to the demo products file as a URL:
	<arg0>file:///C:/fuse-dv-shopping-integration-demo/projects/shopping-demo-application/application-interface/data/addProducts.xml</arg0>

5. Run the request

6. You should then be able to click show products within the application and see new products added (just look for
product names from the addProducts.xml). 

7. You can also see the status of the queues that process these requests in the console window for A-MQ. Use the command "activemq:dstat".

**NOTE:** Once you run this, it will fail on subsequent requests to add the same products. Just go to mysql and 
clear out the DB to rerun.


[*Back to running*](#running-the-demos)

### See products added on twitter and salesforce

1. You should start by running the (add products)[#add-products-by-calling-a-web-service].

2. You can then go to the twitter - https://twitter.com/shoppingapp037 - to see the products that were just added.

**NOTE:** this is a shared twitter account. You will get errors if you load the same products multiple times too quickly,
or if another user has recently added the same products, as twitter rejects duplicate timeline posts.
You can also create your own account and update the credentials in shoppingApplication.properties.

3. You can go to salesforce to see the products added as well. 

**NOTE:** this is a shared salesforce demo account and may not work reliably as credentials expire.
You should update to create your own account and update the credentials in for better usage.
To create an account:

Sign Up to : https://developer.salesforce.com/signup

Copy the clienId and clientSecret and other details of your account and paste it in the shoppingAppplication.properties file.

SalesForce component properties to connect

	salesforce.clientId=<clientId>
	
	salesforce.clientSecret=<secret>
	
	salesforce.userName=<userName>
	
	salesforce.password=<password>
	


[*Back to running*](#running-the-demos)


### View REST services

1. You can see the restful services by hitting them directly with the rest URL - for example: http://localhost:8080/shoppingApplication/services/rest/shoppingApplication/products/
is the URL for displaying all of the products using JSON.


[*Back to running*](#running-the-demos)

### Authenticate and Buy Products

The demo for this is not currently working as Google has deprecated OAUTH v1 so this component no longer functions.
The team is working on resolving this issue and releasing a new version. 

[*Back to running*](#running-the-demos)

### Using Red Hat Mobile to consume the API

Red Hat Mobile is a cloud based platform to create apps which can consume MW API's. There is a demo app and hosted currently in the cloud. Details on using this are documented in the whitepaper. If you have access to the cloud, you can clone the project as follows:

*Setting up Red Hat Mobile Project*

1. Install nodejs and npm 
2. Install fhc command line tool using npm: npm install -g fh-fhc
3. Set the target domain to the feedhenry cloud server - fhc target
4. Login to the server - fhc login <username> <password>
5. Add the ssh key:fhc keys add <ssh_key>
6. Clone the demo fuse project: fhc project clone pem6elr2gpzcnivweemw6glc //Project id of demo

[*Back to running*](#running-the-demos)



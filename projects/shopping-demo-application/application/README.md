Application Project
===================

This project has the shopping application core services and routes. The project provides routes for rest,web,twitter and salesforce integration in the shopping application.

Build
-----

To build this project use

    mvn clean install 

Deployment
----------

1) To run this project use the following Maven goal

     mvn camel:run

2) To deploy the project in an OSGI container please enter this in the Karaf Console:
	 
     osgi:install  -s wrap:mvn:mysql/mysql-connector-java/5.0.5
     osgi:install -s wrap:mvn:commons-dbcp/commons-dbcp/1.4
     features:install camel-sql
     features:install camel-twitter
     features:install  camel-jackson
     features:install camel-salesforce
     osgi:install -s wrap:mvn:com.redhat/application/1.0.0-SNAPSHOT
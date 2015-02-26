Application Interface Project
=============================

This is web based project which has the Application Controller and User Interface section. The project also uses camel-gae and camel-gauth components for google sign in.

Deployment
----------
Build, Install and Deploy it as OSGi bundle:

    mvn clean install

Then please enter this in the Karaf Console:

	osgi:install -s war:mvn:com.redhat/application-interface/1.0.0-SNAPSHOT/war?Web-ContextPath=shoppingApplication
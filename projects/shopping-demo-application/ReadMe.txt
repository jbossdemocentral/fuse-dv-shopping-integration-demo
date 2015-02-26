Deployment:

1) Running it inside an embedded Camel instance:

    mvn clean camel:run

2) Build, Install and Deploy it as OSGi bundle:

    mvn clean install

then please enter this in the Karaf Console:
	osgi:install -s war:mvn:com.redhat/application-interface/1.0.0-SNAPSHOT/war?Web-ContextPath=shoppingApplication
	osgi:install  -s wrap:mvn:mysql/mysql-connector-java/5.0.5
	osgi:install -s wrap:mvn:commons-dbcp/commons-dbcp/1.4
	features:install camel-sql
	features:install camel-twitter
	features:install  camel-jackson
	features:install camel-salesforce
    osgi:install -s wrap:mvn:com.redhat/application/1.0.0-SNAPSHOT

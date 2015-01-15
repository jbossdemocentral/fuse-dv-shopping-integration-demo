eployment:

1) Running it inside an embedded Camel instance:

    mvn clean camel:run

2) Build, Install and Deploy it as OSGi bundle:

    mvn clean install

then please enter this in the Karaf Console:
	osgi:install  -s wrap:mvn:mysql/mysql-connector-java/5.0.5
	osgi:install -s wrap:mvn:commons-dbcp/commons-dbcp/1.4
	features:install camel-sql
	features:install camel-gae
	features:install camel-twitter
	features:install  camel-jackson
    osgi:install -s mvn:com.redhat/shopping-demo-application/1.0.0-SNAPSHOT
    
contract-first-camel-eap
========================

Demo of contract-first web services on JBoss EAP

From my blog+video demo here: [http://www.christianposta.com/blog/?p=359](http://www.christianposta.com/blog/?p=359)

Basically, we use spring-web to bootstrap the Camel context. 

But you don't have to use spring if you dont want to: [Camel example on tomcat with no Spring](http://camel.apache.org/servlet-tomcat-no-spring-example.html)

### Build
Normal fat war:

    mvn clean install
    
Skinny war:

    mvn clean install -Pskinny
    
  

### Deploy
Deploy the WAR to your servlet container (EAP/Wildfly/Tomcat/Jetty), start the container, then try to hit this url
to see if the web service (SOAP) was deployed successfully:


    curl 'http://localhost:8080/contract-first/soap/order?wsdl'


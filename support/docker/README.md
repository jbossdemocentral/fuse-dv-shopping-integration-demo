Docker Integration
======================================

The following steps can be used to configure and run the demo in a docker container

1. [Download and unzip.](https://github.com/DataVirtualizationByExample/dv-fuse-integration-demo/archive/master.zip)

2. Add products to installs directory.

3. Copy .dockerignore and Dockerfile within the *support/docker* directory to the project root.

4. From the project root, build the demo image

	```
	docker build -t jbossdemocentral/dv-fuse-integration-demo .
	```

5. Start demo container

	```
	docker run -it --rm -p 8080:8080 -p 8181:8181 -p 8101:8101 -p 9990:9990 -p 9000:9000 jbossdemocentral/dv-fuse-integration-demo /bin/bash
	``` 

The docker *entrypoint* script will automatically start the Fuse root and child containers along with the JBoss DV platform. 

The deployed routes can be viewed by logging in to the Fuse Management Console (u:admin/p:admin). Open the c1 container to view route under 'Diagram' tab (use case 1 and 2 use timer; use case 4 use jetty container input). Select the log tab to view the output from the route

Additional information can also be found in the jbossdemocentral docker [developer repository](https://github.com/jbossdemocentral/docker-developer)
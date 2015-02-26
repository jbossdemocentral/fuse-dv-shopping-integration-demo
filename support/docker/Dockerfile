# Use jbossdemocentral/developer as the base
FROM jbossdemocentral/developer

# Maintainer details
MAINTAINER Andrew Block <andy.block@gmail.com>

# Environment Variables 
ENV DV_HOME /opt/jboss/dv
ENV DV_VERSION_MAJOR 6
ENV DV_VERSION_MINOR 0
ENV DV_VERSION_MICRO 0
ENV DV_VERSION_BUILD redhat-4

ENV FUSE_HOME /opt/jboss/fuse
ENV FUSE_VERSION_MAJOR 6
ENV FUSE_VERSION_MINOR 1
ENV FUSE_VERSION_MICRO 0
ENV FUSE_VERSION_BUILD redhat-379

ENV HOSTNAME dv-fuse-integration-demo

# ADD Installation Files
COPY support/dv-support/InstallationScript.xml software/jboss-dv-installer-$DV_VERSION_MAJOR.$DV_VERSION_MINOR.$DV_VERSION_MICRO.GA-$DV_VERSION_BUILD.jar software/jboss-fuse-full-$FUSE_VERSION_MAJOR.$FUSE_VERSION_MINOR.$FUSE_VERSION_MICRO.$FUSE_VERSION_BUILD.zip  /opt/jboss/

# Configure project prerequisites and run installer and cleanup installation components
RUN mkdir -p /opt/jboss/projects \
  && sed -i "s:<installpath>.*</installpath>:<installpath>$DV_HOME</installpath>:" /opt/jboss/InstallationScript.xml \
  && java -jar /opt/jboss/jboss-dv-installer-$DV_VERSION_MAJOR.$DV_VERSION_MINOR.$DV_VERSION_MICRO.GA-$DV_VERSION_BUILD.jar  /opt/jboss/InstallationScript.xml \
  && rm -rf /opt/jboss/jboss-dv-installer-$DV_VERSION_MAJOR.$DV_VERSION_MINOR.$DV_VERSION_MICRO.GA-$DV_VERSION_BUILD.jar /opt/jboss/InstallationScript.xml $DV_HOME/jboss-eap-6.1/standalone/configuration/standalone_xml_history/ \
  && unzip -q -d $FUSE_HOME /opt/jboss/jboss-fuse-full-$FUSE_VERSION_MAJOR.$FUSE_VERSION_MINOR.$FUSE_VERSION_MICRO.$FUSE_VERSION_BUILD.zip \
  && rm -rf /opt/jboss/jboss-fuse-full-$FUSE_VERSION_MAJOR.$FUSE_VERSION_MINOR.$FUSE_VERSION_MICRO.$FUSE_VERSION_BUILD.zip

# Copy demo, support files and helper script
COPY projects /opt/jboss/projects
COPY support/dv-support/teiid-security-roles.properties support/dv-support/teiid-security-users.properties  $DV_HOME/jboss-eap-6.1/standalone/configuration/
COPY support/dv-support/data/Customer.txt support/dv-support/data/CustomerHistory.xml $DV_HOME/jboss-eap-6.1/standalone/data/
COPY support/dv-support/vdb/.directory support/dv-support/vdb/CustomerContextVDB.vdb support/dv-support/vdb/CustomerContextVDB.vdb.dodeploy $DV_HOME/jboss-eap-6.1/standalone/deployments/
COPY support/dv-support/standalone.dv.xml $DV_HOME/jboss-eap-6.1/standalone/configuration/standalone.xml
COPY support/fuse-support/users.properties $FUSE_HOME/jboss-fuse-$FUSE_VERSION_MAJOR.$FUSE_VERSION_MINOR.$FUSE_VERSION_MICRO.$FUSE_VERSION_BUILD/etc/
COPY support/fuse-support/com.demo.usecase3.odata.cfg $FUSE_HOME/jboss-fuse-$FUSE_VERSION_MAJOR.$FUSE_VERSION_MINOR.$FUSE_VERSION_MICRO.$FUSE_VERSION_BUILD/etc/
COPY support/docker/start.sh /opt/jboss/
COPY support/docker/build-projects-container.sh /opt/jboss/
COPY support/docker/settings.xml /opt/jboss/


# Swtich back to root user to perform build and cleanup
USER root

# Adjust permissions and cleanup
RUN chown -R jboss:jboss $DV_HOME/jboss-eap-6.1/standalone/configuration/teiid-security-*.properties $DV_HOME/jboss-eap-6.1/standalone/configuration/standalone.xml $DV_HOME/jboss-eap-6.1/standalone/data/* $DV_HOME/jboss-eap-6.1/standalone/deployments/.directory $DV_HOME/jboss-eap-6.1/standalone/deployments/CustomerContextVDB.vdb $DV_HOME/jboss-eap-6.1/standalone/deployments/CustomerContextVDB.vdb.dodeploy $FUSE_HOME/jboss-fuse-$FUSE_VERSION_MAJOR.$FUSE_VERSION_MINOR.$FUSE_VERSION_MICRO.$FUSE_VERSION_BUILD/etc/users.properties $FUSE_HOME/jboss-fuse-$FUSE_VERSION_MAJOR.$FUSE_VERSION_MINOR.$FUSE_VERSION_MICRO.$FUSE_VERSION_BUILD/etc/com.demo.usecase3.odata.cfg /opt/jboss/start.sh /opt/jboss/projects \
  && chmod +x /opt/jboss/start.sh  

# Run as JBoss 
USER jboss

# Build projects and create fabric/profile/containers
RUN /opt/jboss/build-projects-container.sh && rm -rf $FUSE_HOME/instances/c1/data/* /opt/jboss/settings.xml /opt/jboss/build-projects-container.sh

# Expose Ports
EXPOSE 9990 9999 8080 8181 8101 9000

# Default Command
CMD ["/bin/bash"]

# Helper script
ENTRYPOINT ["/opt/jboss/start.sh"]

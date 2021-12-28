#!/bin/bash -e

###########################
# Build/download Keycloak java #
###########################
echo "Begin Build Keycloak Mobile Authetication"
# Install Git
microdnf install -y git
# Install Maven
cd /opt/jboss 
curl -s https://apache.uib.no/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.tar.gz | tar xz
mv apache-maven-3.5.4 /opt/jboss/maven
export M2_HOME=/opt/jboss/maven
# Install Mobile Autheticator
cd /opt/jboss 
# Clone service
git clone -b master https://github.com/vicorious/KeyCloakMobileAuthentication.git
# Move
mv KeyCloakMobileAuthentication /opt/jboss/mobile
#Mobile
cd /opt/jboss/mobile
#Build
$M2_HOME/bin/mvn -Dmaven.test.skip clean install
###################
# Set permissions #
###################
echo "jboss:x:0:root" >> /etc/group
echo "jboss:x:1000:0:JBoss user:/opt/jboss:/sbin/nologin" >> /etc/passwd
chown -R jboss:root /opt/jboss
chmod -R g+rwX /opt/jboss
echo "Finish Build Keycloak Mobile Authetication"
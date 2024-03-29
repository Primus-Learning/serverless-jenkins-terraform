FROM jenkins/jenkins:jdk17

# Skip the Jenkins setup wizard
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

# Set the default value for the Jenkins admin user and password.
ARG JENKINS_USER=admin
ARG JENKINS_PASS=password

# The default admin Jenkins user that we want auto-created
ENV JENKINS_USER=${JENKINS_USER}
ENV JENKINS_PASS=${JENKINS_PASS}
ENV TEST="TEST"

# Setting the location of the Jenkins Configuration
# as Code yaml file
ENV CASC_JENKINS_CONFIG /usr/share/jenkins/ref/jenkins.yaml

# Copying over the plugins.txt, default-user.groovy 
# and jenkins.yaml from our local machine
COPY plugins.txt /usr/share/jenkins/ref/
COPY default-user.groovy /usr/share/jenkins/ref/init.groovy.d/
COPY jenkins.yaml /usr/share/jenkins/ref/

# Replacing the JENKINS_USER and JENKINS_PASS values
# in the jenkins.yaml with our ENV variables specified
# towards the beginning of this Dockerfile
RUN sed -i "s/JENKINS_USER/${JENKINS_USER}/g" /usr/share/jenkins/ref/jenkins.yaml
RUN sed -i "s/JENKINS_PASS/${JENKINS_PASS}/g" /usr/share/jenkins/ref/jenkins.yaml

# Install the Jenkins plugins that are listed in plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt
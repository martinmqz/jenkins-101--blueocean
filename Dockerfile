FROM jenkins/jenkins:2.414.2-jdk11
USER root
COPY zscaler.crt /usr/local/share/ca-certificates
COPY jenkins_io.crt /usr/local/share/ca-certificates
COPY updates_jenkins_io.crt /usr/local/share/ca-certificates
COPY docker_com.crt /usr/local/share/ca-certificates
# COPY docker.crt /usr/local/share/ca-certificates

COPY updates_jenkins_io.crt /usr/share/ca-certificates

RUN update-ca-certificates
# RUN apt install ca-certificates

RUN apt-get update && apt-get install -y lsb-release python3-pip
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
  https://download.docker.com/linux/debian/gpg
RUN echo "deb [arch=$(dpkg --print-architecture) \
  signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list

# RUN apt-get update && apt-get install -y lsb-release python3-pip
# USER jenkins
# RUN jenkins-plugin-cli --plugins "blueocean:1.25.3 docker-workflow:1.28"

##### jenkins-plugin-cli --plugins skip-certificate-check:1.1

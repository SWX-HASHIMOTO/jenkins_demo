# Base image
FROM jenkins/jenkins:latest

# Change Root user
USER root

# Install tools
RUN apt-get update && apt-get install -y \
    curl unzip && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf aws awscliv2.zip && \
    apt-get clean

# Change Jenkins user
USER jenkins

# Add Jenkins plugin
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt

# Port
EXPOSE 8080
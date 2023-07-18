FROM ubuntu:18.04

RUN mkdir -p /var/jenkins_home /home/jenkins

RUN useradd jenkins && echo "jenkins:123456" | chpasswd

RUN chown -R jenkins:jenkins /var/jenkins_home && chown -R jenkins:jenkins /home/jenkins

RUN usermod -aG sudo jenkins 

WORKDIR /home/jenkins

RUN apt-get update && apt-get dist-upgrade -y && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y \
    git \
    apt-transport-https \
    curl \
    init \
    openssh-server openssh-client \
    docker.io \
    vim \
    gettext \
    sudo \
 && rm -rf /var/lib/apt/lists/*

#install helm
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
RUN chmod 700 get_helm.sh
RUN ./get_helm.sh 

#install kubectl
RUN apt update \
    && apt-get install gnupg gnupg1 gnupg2 -y
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
RUN touch /etc/apt/sources.list.d/kubernetes.list 
RUN echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list
RUN apt-get update
RUN apt-get install -y kubectl

# Install Java
RUN apt-get update && apt-get install -y openjdk-11-jdk && rm -rf /var/lib/apt/lists/*

# Install AWS-CLI
RUN apt update && apt install unzip
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install


RUN echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

EXPOSE 22

USER jenkins 

ENTRYPOINT ["/bin/sh", "-c", "sudo service ssh start && tail -f /dev/null"]
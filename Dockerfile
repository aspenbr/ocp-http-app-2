# Apache puro DockerFile 
#FROM docker.io/darksheer/centos:latest
#FROM ubi7/ubi:7.7
#FROM rhel7-minimal:latest
FROM registry.redhat.io/rhel7
#ENV GOPATH=/root/buildah 

RUN yum -y install \ 
     httpd \ 
     git \ 
     php \
     sudo
 
EXPOSE 80
ENV LogLevel "info" 
RUN echo 'apache ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/apache
USER apache 
COPY ./src/teste.* /var/www/html 
#RUN useradd -ms /bin/bash apache
#RUN gpassd -a  apache apache 
RUN sudo chmod -R 776 /var/www/html  
RUN sudo chgrp -R apache /var/www/html 
RUN sudo chown -R apache /var/www/html 
USER apache
ENTRYPOINT ["sudo", "/usr/sbin/httpd", "-D", "FOREGROUND"]


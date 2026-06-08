FROM ubuntu:latest
LABEL "Author"="hurairah"
LABEL "Project"="vora"
ENV DEBIAN_FRONTEND=noninteractive 
RUN apt update && apt install apache2 git -y
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
EXPOSE 80
WORKDIR /var/www/hyml
VOLUME /var/log/apache2
ADD vora.tar.gz /var/www/html
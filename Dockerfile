# ss-panel
#
# VERSION 3.0

# auto build from my github project: https://github.com/maxidea-com/ss-panel separate mysql

FROM ubuntu:14.04

# make sure the package repository is up to date
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update
#install mysql
RUN echo "mysql-server-5.6 mysql-server/root_password password pw123456" | sudo debconf-set-selections
RUN echo "mysql-server-5.6 mysql-server/root_password_again password pw123456" | sudo debconf-set-selections
RUN apt-get -y install mysql-server-5.6
RUN apt-get -y install supervisor

ADD shadowsocks.sql /opt/shadowsocks.sql
ADD db-160212.sql /opt/db-160212.sql
ADD mysql-init.sh /opt/mysql-init.sh
ADD supervisor.conf /etc/supervisor/conf.d/supervisor.conf

RUN service mysql start
RUN /bin/bash /opt/mysql-init.sh

RUN apt-get clean && apt-get autoclean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 3306
CMD ["/usr/bin/supervisord"]
# contact
MAINTAINER UncleDrew, unclegrewgo@gmail.com

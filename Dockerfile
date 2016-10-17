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
RUN mkdir /opt/ss-mysql
ADD shadowsocks.sql /opt/ss-mysql/shadowsocks.sql
ADD db-160212.sql /opt/ss-mysql/db-160212.sql
ADD my.cnf /etc/mysql/my.cnf
ADD mysql-init.sh /opt/ss-mysql/mysql-init.sh
ADD mysql-backup.sh /opt/ss-mysql/mysql-backup.sh
ADD mysql-import.sh /opt/ss-mysql/mysql-import.sh
ADD supervisor.conf /etc/supervisor/conf.d/supervisor.conf

RUN service mysql start
RUN /bin/bash /opt/ss-mysql/mysql-init.sh

RUN apt-get clean && apt-get autoclean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 3306
CMD ["/usr/bin/supervisord"]
# contact
MAINTAINER UncleDrew, unclegrewgo@gmail.com

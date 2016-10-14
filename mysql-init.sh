#! /bin/bash
sudo service mysql restart
if [ $? -eq 0 ]; then
	echo "mysql startup successful!"
else
	echo "mysql startup failed!"
	exit 1
fi

echo "create ss-panel database, user, password"
mysql -uroot -p'pw123456' -e "CREATE DATABASE sspanel character SET utf8; CREATE user 'ssuser'@'localhost' IDENTIFIED BY 'sspasswd'; GRANT ALL privileges ON sspanel.* TO 'ssuser'@'localhost'; FLUSH PRIVILEGES;"

echo "input shadowsocks sql init database"
mysql -u ssuser -psspasswd sspanel < /opt/shadowsocks.sql

echo "input ss-panel sql into database"
mysql -u ssuser -psspasswd sspanel < /opt/db-160212.sql

#!/bin/bash

# install 
yum -y install squid nano epel-release dropbear
chkconfig squid on

# disable ping flood
sed -i '$ a net.ipv4.icmp_echo_ignore_all = 1' /etc/sysctl.conf
sysctl -p

# set locale
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config
service sshd restart

# setting port ssh
sed -i '/Port 22/a Port 80' /etc/ssh/sshd_config
sed -i 's/#Port 22/Port  22/g' /etc/ssh/sshd_config
service sshd restart
chkconfig sshd on

# install dropbear
yum -y install dropbear
echo "OPTIONS=\"-p 443\"" > /etc/sysconfig/dropbear
echo "/bin/false" >> /etc/shells
service dropbear restart
chkconfig dropbear on

# install squid
yum -y install squid
wget -O /etc/squid/squid.conf "https://raw.githubusercontent.com/lanunquota/conf/master/squid-centos.conf"
MYIP=`curl -s ifconfig.me`;
MYIP2="s/xxxxxxxxx/$MYIP/g";
sed -i $MYIP2 /etc/squid/squid.conf;
chkconfig squid on
service squid restart

# install fail2ban
yum -y install fail2ban
service fail2ban restart
chkconfig fail2ban on

# remove unused
yum -y remove sendmail;
yum -y remove httpd;
yum -y remove cyrus-sasl

# downlaod script
cd /usr/bin
wget http://autoscriptnobita.tk/setupmenu && bash setupmenu

# finalisasi
service sshd restart
service squid restart
service dropbear restart
service fail2ban restart
service crond restart
chkconfig crond on

# info
clear
echo "Auto Installer by PerantauSepi (izam-lukman)" | tee log-install.txt
echo "===============================================" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "Service"  | tee -a log-install.txt
echo "-------"  | tee -a log-install.txt
echo "Fail2Ban : [on]"  | tee -a log-install.txt
echo "OpenSSH  : 80"  | tee -a log-install.txt
echo "DropBear : 443"  | tee -a log-install.txt
echo "Squid3   : 8080 (limit to IP SSH)"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "Script"  | tee -a log-install.txt
echo "------"  | tee -a log-install.txt
echo "./user-login.sh"  | tee -a log-install.txt
echo "./user-expired.sh"  | tee -a log-install.txt
echo "./user-add.sh"  | tee -a log-install.txt
echo "./user-trial.sh"  | tee -a log-install.txt
echo "./user-limit.sh"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "SILA REBOOT VPS ANDA ! shutdown -r now"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "==============================================="  | tee -a log-install.txt

# download script
cd /usr/bin
wget -O menu "https://raw.githubusercontent.com/KeningauVPS/setupall.sh/master/my.menu"
wget -O 1 "https://raw.githubusercontent.com/syahz86/autoscript/master/user-add.sh"
wget -O 2 "https://raw.githubusercontent.com/syahz86/autoscript/master/trial.sh"
wget -O 3 "https://raw.githubusercontent.com/syahz86/autoscript/master/user-gen.sh"
wget -O 4 "https://raw.githubusercontent.com/syahz86/autoscript/master/user-list.sh"
wget -O 5 "https://raw.githubusercontent.com/syahz86/autoscript/master/user-pass.sh"
wget -O 6 "https://raw.githubusercontent.com/syahz86/autoscript/master/user-renew.sh"
wget -O 7 "https://raw.githubusercontent.com/syahz86/autoscript/master/user-del.sh"
wget -O 8 "https://raw.githubusercontent.com/syahz86/autoscript/master/userexpired.sh"
wget -O 9 "https://raw.githubusercontent.com/syahz86/autoscript/master/user-expire-list.sh"
wget -O 10 "https://raw.githubusercontent.com/syahz86/autoscript/master/delete-user-expire.sh"
wget -O 11 "https://raw.githubusercontent.com/syahz86/autoscript/master/user-banned.sh"
wget -O 12 "https://raw.githubusercontent.com/syahz86/autoscript/master/user-unbanned.sh"
wget -O 13 "https://raw.githubusercontent.com/syahz86/autoscript/master/user-login.sh"
wget -O 14 "https://raw.githubusercontent.com/syahz86/autoscript/master/ps_mem.py"
wget -O 15 "https://raw.githubusercontent.com/syahz86/autoscript/master/resvis.sh"
wget -O 16 "https://raw.githubusercontent.com/syahz86/autoscript/master/speedtest_cli.py"
wget -O 17 "https://raw.githubusercontent.com/syahz86/autoscript/master/benchmark.sh"
wget -O 18 "https://raw.githubusercontent.com/syahz86/autoscript/master/info.sh"
wget -O 19 "https://raw.githubusercontent.com/syahz86/autoscript/master/about.sh"
wget -O 20 "https://raw.githubusercontent.com/syahz86/autoscript/master/rebootserver.sh"
wget -O userlimit.sh "https://raw.githubusercontent.com/syahz86/autoscript/master/userlimit.sh"
wget -O autokill.sh "https://raw.githubusercontent.com/syahz86/autoscript/master/autokill.sh"
wget -O userexpired.sh "https://raw.githubusercontent.com/syahz86/autoscript/master/userexpired.sh"

echo "@reboot root /usr/bin userexpired.sh" > /etc/cron.d/userexpired
echo "@reboot root /usr/bin userlimit.sh" > /etc/cron.d/userlimit
echo "0 0 * * * root /sbin/reboot" > /etc/cron.d/reboot
echo "@reboot root  /usr/bin/autokill.sh" > /etc/cron.d/autokill
#sed -i '$ i\screen -AmdS limit /root/userexpired.sh' /etc/rc.local
#sed -i '$ i\screen -AmdS limit /root/userlimit.sh' /etc/rc.local
sed -i '$ i\screen -AmdS check /usr/bin/autokill.sh' /etc/rc.local
sed -i '$ i\touch /var/lock/subsys/local' /etc/rc.local

chmod +x menu
chmod +x 1
chmod +x 2
chmod +x 3
chmod +x 4
chmod +x 5
chmod +x 6
chmod +x 7
chmod +x 8
chmod +x 9
chmod +x 10
chmod +x 11
chmod +x 12
chmod +x 13
chmod +x 14
chmod +x 15
chmod +x 16
chmod +x 17
chmod +x 18
chmod +x 19
chmod +x 20
chmod +x userlimit.sh
chmod +x autokill.sh
chmod +x userexpired.sh

# finalisasi
cd
chown -R www-data:www-data /home/vps/public_html
service cron restart
service nginx start
service php-fpm start
service vnstat restart
service openvpn restart
service snmpd restart
service ssh restart
service dropbear restart
service fail2ban restart
service squid3 restart
service webmin restart
rm -rf ~/.bash_history && history -c
echo "unset HISTFILE" >> /etc/profile

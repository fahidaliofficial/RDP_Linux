rm -rf guaca*
curl https://raw.githubusercontent.com/amitstudydude/RDP_Linux/main/scripts/rclonemount.sh | sudo bash &
sudo unlink /etc/localtime
sudo ln -s /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
printf "root\nroot" | sudo passwd runneradmin && printf "root\nroot" | sudo passwd runner && printf "root\nroot" | sudo passwd root 
sudo apt update && sudo apt install dolphin
sudo wget  https://raw.githubusercontent.com/amitstudydude/RDP_Linux/main/google.7z
curl https://raw.githubusercontent.com/amitstudydude/RDP_Linux/main/scripts/newinstall.sh | sudo bash 
yes Y | 7z x google.7z
rm *.7z



GUACVERSION="1.4.0"



SERVER="http://apache.org/dyn/closer.cgi?action=download&filename=guacamole/1.4.0"


wget -O guacamole-server-${GUACVERSION}.tar.gz ${SERVER}/source/guacamole-server-${GUACVERSION}.tar.gz

tar -xzf guacamole-server-${GUACVERSION}.tar.gz


wget -O guacamole-${GUACVERSION}.war ${SERVER}/binary/guacamole-${GUACVERSION}.war


rm -rf /etc/guacamole*
rm -rf /etc/guacamole/extensions/
mkdir -p /etc/guacamole/lib/
mkdir -p /etc/guacamole/extensions/

#mkdir -p /usr/sbin/.config/freerdp
#chown daemon:daemon /usr/sbin/.config/freerdp

mkdir -p /var/guacamole
#chown daemon:daemon /var/guacamole

cd guacamole-server-${GUACVERSION}/

export CFLAGS="-Wno-error"

./configure --with-systemd-dir=/etc/systemd/system  &>> Log.txt
make 
make install 
ldconfig

cd

mv -f guacamole-${GUACVERSION}.war /etc/guacamole/guacamole.war

ln -sf /etc/guacamole/guacamole.war /var/lib/tomcat9/webapps/
ln -s /etc/guacamole/ /usr/share/tomcat9/.guacamole
sudo mkdir /etc/guacamole/{extensions,lib}

sudo echo "GUACAMOLE_HOME=/etc/guacamole" >> /etc/default/tomcat9



wget -O /etc/guacamole/guacamole.properties https://raw.githubusercontent.com/amitstudydude/RDP_Linux/main/guaca  




wget -O  /etc/guacamole/user-mapping.xml https://raw.githubusercontent.com/amitstudydude/RDP_Linux/main/user-mapping.xml 







            
        


iptables -A INPUT -p tcp --dport 8080 --jump ACCEPT
ufw allow 8080/tcp comment 'allow tomcat'
sudo ufw enable && ufw allow 22 && ufw allow 8080 && ufw allow 80

echo -e "${BLUE}Installation Complete\n- Visit: http://localhost:8080/guacamole/\n- Default login (username/password): guacadmin/guacadmin\n***Be sure to change the password***.${NC}"
sudo mkdir -p /etc/guacamole/{extensions,lib}
sudo systemctl daemon-reload
sudo systemctl enable guacd
sudo systemctl enable tomcat9
sudo systemctl start guacd
sudo systemctl restart ssh xrdp tomcat9 guacd 

##curl https://raw.githubusercontent.com/amitstudydude/RDP_Linux/main/scripts/guacd.sh | bash







##

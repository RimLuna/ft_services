SSH_PASSWORD=communism

sed -i "s/SSH_PASSWORD/$SSH_PASSWORD/g" /passwd.sh

./passwd.sh
/usr/sbin/sshd && nginx && tail -f /dev/null
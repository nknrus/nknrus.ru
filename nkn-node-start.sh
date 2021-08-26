# Скрипт для запуска ноды для майнинга токенов NKN:

cat << "EOF"
================================================================================
Введите Ваш Адрес NKN кошелька.
Пример кошелька NKN: NKNWZs8cHhdsniNcjRgx3DFcNtjeWZDzc9si
================================================================================

Адрес кошелька NKN:
EOF
# Input beneficiary wallet adddress
read -r benaddress

apt -y update
apt -y upgrade
apt -y install unzip vnstat htop screen mc

username="nkn"
websource="https://nkn.org/ChainDB_pruned_latest.tar.gz"

useradd -m -p "pass" -s /bin/bash "$username" > /dev/null 2>&1
usermod -a -G sudo "$username" > /dev/null 2>&1

# Install
printf "NKNRUS.RU Установка майнера.................................... "
cd /home/$username > /dev/null 2>&1
wget --quiet --continue --show-progress https://commercial.nkn.org/downloads/nkn-commercial/linux-amd64.zip > /dev/null 2>&1
printf "Выполнено!\n"

printf "NKNRUS.RU Установка ОС......................................... "
unzip linux-amd64.zip > /dev/null 2>&1
mv linux-amd64 nkn-commercial > /dev/null 2>&1
chown -c $username:$username nkn-commercial/ > /dev/null 2>&1
/home/$username/nkn-commercial/nkn-commercial -b $benaddress -d /home/$username/nkn-commercial/ -u $username install > /dev/null 2>&1
printf "Выполнено!\n"
printf "Ждем 120 секунд"

sleep 120

DIR="/home/$username/nkn-commercial/services/nkn-node/"

                        systemctl stop nkn-commercial.service > /dev/null 2>&1
			sleep 20
                        cd $DIR > /dev/null 2>&1
                        rm -rf ChainDB/ > /dev/null 2>&1
  			wget -O - "$websource" -q --show-progress | tar -xzf -
                        chown -R $username:$username wallet.* > /dev/null 2>&1
                        chown -R $username:$username ChainDB/ > /dev/null 2>&1
                        printf "NKNRUS.ru.................................... Выполнено! Удачного майнинга!\n"
                        systemctl start nkn-commercial.service > /dev/null 2>&1

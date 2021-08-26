# Скрипт для запуска ноды для майнинга токенов NKN:

apt -y update
apt -y upgrade
apt -y install unzip vnstat htop screen mc

username="nkn"
benaddress="NKNWZs8cHhdsniNcjRgx3DFcNtjeWZDzc9si"
websource="https://nkn.org/ChainDB_pruned_latest.tar.gz"

useradd -m -p "pass" -s /bin/bash "$username" > /dev/null 2>&1
usermod -a -G sudo "$username" > /dev/null 2>&1

# Install
printf "NKNRUS.RU Установка майнера.................................... "
cd /home/$username > /dev/null 2>&1
wget --quiet --continue --show-progress https://commercial.nkn.org/downloads/nkn-commercial/linux-amd64.zip > /dev/null 2>&1
printf "DONE!\n"

printf "NKNRUS.RU Установка майнера.................................... "
unzip linux-amd64.zip > /dev/null 2>&1
mv linux-amd64 nkn-commercial > /dev/null 2>&1
chown -c $username:$username nkn-commercial/ > /dev/null 2>&1
/home/$username/nkn-commercial/nkn-commercial -b $benaddress -d /home/$username/nkn-commercial/ -u $username install > /dev/null 2>&1
printf "Выполнено!\n"
printf "sleep 180"

sleep 180

DIR="/home/$username/nkn-commercial/services/nkn-node/"

                        systemctl stop nkn-commercial.service > /dev/null 2>&1
			sleep 20
                        cd $DIR > /dev/null 2>&1
                        rm -rf ChainDB/ > /dev/null 2>&1
  			wget -O - "$websource" -q --show-progress | tar -xzf -
                        chown -R $username:$username wallet.* > /dev/null 2>&1
                        chown -R $username:$username ChainDB/ > /dev/null 2>&1
                        printf "NKNRUS.ru.......................................... Выполнено!\n"
                        systemctl start nkn-commercial.service > /dev/null 2>&1

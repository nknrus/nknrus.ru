# Скрипт для запуска ноды для майнинга токенов NKN:

apt -y update
apt -y upgrade
apt -y install unzip vnstat htop screen mc

username="nknrus"
benaddress="NKNWZs8cHhdsniNcjRgx3DFcNtjeWZDzc9si"

useradd -m -p "pass" -s /bin/bash "$username" > /dev/null 2>&1
usermod -a -G sudo "$username" > /dev/null 2>&1

printf "NKNRUS.RU - Загрузка ноды........................................... "
cd /home/$username > /dev/null 2>&1
wget --quiet --continue --show-progress https://commercial.nkn.org/downloads/nkn-commercial/linux-amd64.zip > /dev/null 2>&1
printf "DONE!\n"

printf "NKNRUS.RU - Установка ноды.......................................... "
unzip linux-amd64.zip > /dev/null 2>&1
mv linux-amd64 nkn-commercial > /dev/null 2>&1
chown -c $username:$username nkn-commercial/ > /dev/null 2>&1
/home/$username/nkn-commercial/nkn-commercial -b $benaddress -d /home/$username/nkn-commercial/ -u $username install > /dev/null 2>&1
printf "DONE!\n"
printf "sleep 180"

Ожидаем 180 секунд

DIR="/home/$username/nkn-commercial/services/nkn-node/"

                        systemctl stop nkn-commercial.service > /dev/null 2>&1
			sleep 20
                        cd $DIR > /dev/null 2>&1
                        rm -rf ChainDB/ > /dev/null 2>&1
                        chown -R $username:$username wallet.* > /dev/null 2>&1
                        chown -R $username:$username ChainDB/ > /dev/null 2>&1
                        printf "NKNRUS.RU - Скачивание файла................. Выполнено!\n"
                        systemctl start nkn-commercial.service > /dev/null 2>&1

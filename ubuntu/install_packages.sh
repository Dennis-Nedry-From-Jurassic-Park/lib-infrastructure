#!/bin/bash
set -x
# !! exec by root sudo -i !!
USER_NAME=nomad
USER_PASS='2'
# Global Ubuntu things
sudo deluser ${USER_NAME}
sudo deluser --remove-home ${USER_NAME}
sudo rm -rf /home/${USER_NAME}
# https://www.cyberciti.biz/tips/howto-write-shell-script-to-add-user.html
sudo useradd -m -p ${USER_PASS} -s /bin/bash ${USER_NAME}
#sudo adduser ${USER_NAME}
sudo usermod -aG sudo ${USER_NAME}
sudo echo "${USER_NAME} ALL=(ALL) ALL" >> /etc/sudoers
# sudo su -l user123
# disable locks
sudo rm /var/lib/dpkg/lock-frontend -f
sudo rm /var/cache/apt/archives/lock -f
cd ~ && sudo apt-get update && sudo apt update
# 'Installing curl+wget+ufw'
sudo apt-get install curl wget ufw -y
# 'Installing monitoring perfomance'
sudo apt-get install nmon htop -y
# 'Installing other packages'
sudo apt-get install -y git nano
sudo apt-get install -y vim zip unzip python3-pip python3.8-venv
# RSync
sudo apt-get install -y rsync
# 7Zip
sudo apt-get install -y p7zip-full p7zip-rar
# Yandex Cloud CLI tool (YC)
#curl -s -O https://storage.yandexcloud.net/yandexcloud-yc/install.sh
#chmod u+x install.sh
#sudo ./install.sh -a -i /usr/local/ 2>/dev/null
#rm -rf install.sh
sudo sed -i '$ a source /usr/local/completion.bash.inc' /etc/profile
# Missing PUB_KEY
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 7EA0A9C3F273FCD8
sudo apt-get update

# Docker (https://docs.docker.com/engine/install/ubuntu/ + https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-22-04)
sudo apt-get remove -y docker docker-engine docker.io containerd runc
sudo rm -rf /usr/share/keyrings/docker-keyring.gpg -f

sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --batch --yes --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --batch --yes --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

sudo apt-get update
sudo apt-cache policy docker-ce
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

#sudo mkdir -p /etc/apt/keyrings
#url -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/docker.gpg
#curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo chmod a+r /usr/share/keyrings/docker-archive-keyring.gpg |  sudo gpg --dearmor -o /usr/share/keyrings/docker-keyring.gpg
#curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu jammy stable
# https://askubuntu.com/questions/1347880/cant-install-docker-on-my-ubuntu-because-of-a-no-pubkey-7ea0a9c3f273fcd8-err
# https://stackoverflow.com/questions/60137344/docker-how-to-solve-the-public-key-error-in-ubuntu-while-installing-docker/68764068#68764068
#echo \
#  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
#  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

#echo deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
#sudo chmod a+r /etc/apt/keyrings/docker.gpg
#sudo apt-get update

#sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

sudo systemctl status docker

sudo usermod -aG docker ${USER_NAME}

#sudo service docker start
#sudo systemctl start docker
#sudo systemctl enable docker
#
#sudo chmod 666 /var/run/docker.sock
# sudo useradd -m -s /bin/bash -G docker ${USER_NAME}
# Docker-Compose
sudo mkdir -p ~/.docker/cli-plugins/
curl -SL https://github.com/docker/compose/releases/download/v2.11.2/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose
chmod +x ~/.docker/cli-plugins/docker-compose

# nvm + Nodejs + npm
sudo apt install -y build-essential checkinstall libssl-dev

if [ -d ~/.nvm ]; then
  curl https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
  source ~/.nvm/nvm.sh
  source ~/.profile
  source ~/.bashrc
  export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
  nvm install v18.12.1
  npm install --global yarn #sudo apt install nodejs
fi
# Rust + cargo
curl --proto '=https' --tlsv1.3 -sSf https://sh.rustup.rs | sh -s -- -y --default-host x86_64-unknown-linux-gnu --default-toolchain stable --profile complete
source "$HOME/.cargo/env"
# Golang
sudo apt-get remove golang-go -y
sudo apt-get remove --auto-remove golang-go -y
sudo rm -rvf /usr/local/go

wget https://dl.google.com/go/go1.19.4.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.19.4.linux-amd64.tar.gz

export PATH=$PATH:/usr/local/go/bin

source ~/.profile

go version
# doppler
# 1 ls -a /etc/apt/sources.list.d/
# 2 sudo rm  /etc/apt/sources.list.d/hashicorp.list
sudo apt-get update && sudo apt-get install -y apt-transport-https ca-certificates curl gnupg
curl -sLf --retry 3 --tlsv1.2 --proto "=https" 'https://packages.doppler.com/public/cli/gpg.DE2A7741A397C129.key' | sudo apt-key add -
echo "deb https://packages.doppler.com/public/cli/deb/debian any-version main" | sudo tee /etc/apt/sources.list.d/doppler-cli.list
sudo apt-get update && sudo apt-get install doppler



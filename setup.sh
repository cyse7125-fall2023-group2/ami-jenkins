#!/bin/bash

sudo apt update

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg

echo "##################################################################" \
     "####################INSTALLING Docker ##############################" \
    "###################################################################"
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y


echo "##################################################################" \
     "####################INSTALLING NODE ##############################" \
    "###################################################################"
curl -sL https://deb.nodesource.com/setup_16.x -o /tmp/nodesource_setup.sh
sudo bash /tmp/nodesource_setup.sh
sudo apt install nodejs -y
sudo node -v
sudo npm install -g semantic-release@17.4.4
sudo npm install -g @semantic-release/git@9.0.0
sudo npm install -g @semantic-release/exec@5.0.0
sudo npm install -g conventional-changelog-conventionalcommits
sudo npm install -g npm-cli-login


echo "##################################################################" \
     "####################INSTALLING Jenkins ##############################" \
    "###################################################################"
sudo apt install openjdk-17-jre -y 

curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
  


export JAVA_OPTS="-Djenkins.install.runSetupWizard=false"
sudo apt-get update
sudo apt-get install jenkins -y

sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list
sudo apt update
sudo apt install caddy -y
sudo cp /tmp/casc.yaml /var/lib/jenkins/casc.yaml
sudo cp /tmp/seedJob.groovy /var/lib/jenkins/seedJob.groovy

sudo cp /tmp/jenkins.service /usr/lib/systemd/system/jenkins.service
sudo cp /tmp/plugin.txt /usr/share/jenkins/plugins.txt

sudo rm -rf /tmp/jenkins.service



sudo systemctl daemon-reload

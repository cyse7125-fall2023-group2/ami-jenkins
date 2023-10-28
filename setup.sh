#!/bin/bash

sudo apt update

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg

echo "+-------------------------------------------------------------+"
echo "|                                                             |"
echo "|                    INSTALL Docker                           |"
echo "|                                                             |"
echo "+-------------------------------------------------------------+"
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


echo "+-------------------------------------------------------------+"
echo "|                                                             |"
echo "|                    INSTALL Node                             |"
echo "|                                                             |"
echo "+-------------------------------------------------------------+"
curl -sL https://deb.nodesource.com/setup_16.x -o /tmp/nodesource_setup.sh
sudo bash /tmp/nodesource_setup.sh
sudo apt install nodejs -y
sudo node -v
sudo npm install -g semantic-release@17.4.4
sudo npm install -g @semantic-release/git@9.0.0
sudo npm install -g @semantic-release/exec@5.0.0
sudo npm install -g conventional-changelog-conventionalcommits
sudo npm install -g npm-cli-login

echo "+-------------------------------------------------------------+"
echo "|                                                             |"
echo "|                    INSTALL HELM                             |"
echo "|                                                             |"
echo "+-------------------------------------------------------------+"
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
sudo apt-get install apt-transport-https --yes
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm
helm version

echo "+-------------------------------------------------------------+"
echo "|                                                             |"
echo "|                    INSTALL KubeCtl                          |"
echo "|                                                             |"
echo "+-------------------------------------------------------------+"
sudo apt-get install kubectl
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates gnupg curl sudo
echo "deb [signed-by=/usr/share/keyrings/cloud.google.asc] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt-get update && sudo apt-get install google-cloud-cli
sudo apt-get install google-cloud-sdk-gke-gcloud-auth-plugin



echo "+-------------------------------------------------------------+"
echo "|                                                             |"
echo "|                    INSTALL Jenkins                          |"
echo "|                                                             |"
echo "+-------------------------------------------------------------+"
sudo apt install openjdk-17-jre -y 

curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
  
sudo apt install gh -y



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

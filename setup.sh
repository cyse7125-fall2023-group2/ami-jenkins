#!/bin/bash

sudo apt update
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
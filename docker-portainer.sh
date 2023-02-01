#!/bin/bash
function update() {
    sudo apt-get update -y;
}

function upgrade() {
    sudo apt-get upgrade -y;
}

function docker() {
    sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release -y;

    sudo mkdir -p /etc/apt/keyrings;
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg;

    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null;

    sudo apt-get update -y;
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y;
    sudo service docker start;
}

function portainer() {
    sudo service docker restart;
    sudo docker pull portainer/portainer-ce;
    sudo docker volume create portainer_data;
    sudo docker run -d \
        -p 8000:8000 \
        -p 9443:9443 \
        --name portainer \
        --restart=always \
        -v /var/run/docker.sock:/var/run/docker.sock \
        -v portainer_data:/data \
    portainer/portainer-ce:latest;
}

function menu(){
clear
      echo
      read -p "Are you want to Install Docker? [y/n]: " input
      until [[ "$input" =~ ^[yYnN]*$ ]]; do
          echo "$input: invalid selection."
          read -p "Are you sure to Install Docker? [y/n]: " input
      done
      if [[ "$input" =~ ^[yY]$ ]]; then
          update
          read -p "Are you sure to upgrade ubuntu? (recommend upgrade) [y/n]: " input
          until [[ "$input" =~ ^[yYnN]*$ ]]; do
              echo "$input: invalid selection."
              read -p "Are you sure to upgrade ubuntu? (recommend upgrade) [y/n]: " input
          done
          if [[ "$input" =~ ^[yY]$ ]]; then
              upgrade
              echo 
              echo "Ubuntu has been upgraded"
              echo 
              docker
              echo
              echo "Docker has been installed"
              echo
              read -p "Are you want install portainer? [y/n]: " input
              until [[ "$input" =~ ^[yYnN]*$ ]]; do
                  echo "$input: invalid selection."
                  read -p "Are you want install portainer? [y/n]: " input
              done
              if [[ "$input" =~ ^[yY]$ ]]; then
                  portainer
                  echo
                  echo "Portainer has been installed"
              else
                  exit
              fi
          else
              docker
              echo
              echo "Docker has been installed"
              echo
              read -p "Are you want install portainer? [y/n]: " input
              until [[ "$input" =~ ^[yYnN]*$ ]]; do
                  echo "$input: invalid selection."
                  read -p "Are you want install portainer? [y/n]: " input
              done
              if [[ "$input" =~ ^[yY]$ ]]; then
                  portainer
                  echo
                  echo "Portainer has been installed"
              else
                  echo
                  echo "Install Portainer aborted!"
              fi
          fi
          exit
      else
          echo
          read -p "Are you want to install portainer? [y/n]: " input
           until [[ "$input" =~ ^[yYnN]*$ ]]; do
                  echo "$input: invalid selection."
                  read -p "Are you want install portainer? [y/n]: " input
              done
              if [[ "$input" =~ ^[yY]$ ]]; then
                  portainer
                  echo
                  echo "Portainer has been installed"
              else
                  echo
                  echo "Install Docker and Portainer aborted!"
      fi
          exit
}
menu

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
echo "What should i do?"
echo
echo "Select an options:"
echo "  1) Update Ubuntu"
echo "  2) Upgrade Ubuntu"
echo "  3) Install Docker"
echo "  4) Install Portainer"
echo "  5) Exit"
read -p "Option: " input
until [[ "$input" =~ ^[1-5]$ ]]; do
	echo "$input: invalid selection."
	read -p "Option: " input
done
case "$input" in
    1)
        read -p "Are you sure to update ubuntu? [y/n]: " input
        until [[ "$input" =~ ^[yYnN]*$ ]]; do
            echo "$input: invalid selection."
            read -p "Are you sure to update ubuntu? [y/n]: " input
        done
        if [[ "$input" =~ ^[yY]$ ]]; then
            update
            echo
            echo "Ubuntu has been updated"
        else
            echo
            echo "Update aborted!"
        fi
        # BACK TO MENU
        echo
        read -p "Are you want back to menu? [y/n]: " input
        until [[ "$input" =~ ^[yYnN]*$ ]]; do
            echo "$input: invalid selection."
            read -p "Are you want back to menu? [y/n]: " input
        done
        if [[ "$input" =~ ^[yY]$ ]]; then
            menu
        else
            exit
        fi
    ;;
    2)
        read -p "Are you sure to upgrade ubuntu? [y/n]: " input
        until [[ "$input" =~ ^[yYnN]*$ ]]; do
            echo "$input: invalid selection."
            read -p "Are you sure to upgrade ubuntu? [y/n]: " input
        done
        if [[ "$input" =~ ^[yY]$ ]]; then
            upgrade
            echo
            echo "Ubuntu has been upgraded"
        else
            echo
            echo "Upgrade aborted!"
        fi
        # BACK TO MENU
        echo
        read -p "Are you want back to menu? [y/n]: " input
        until [[ "$input" =~ ^[yYnN]*$ ]]; do
            echo "$input: invalid selection."
            read -p "Are you want back to menu? [y/n]: " input
        done
        if [[ "$input" =~ ^[yY]$ ]]; then
            menu
        else
            exit
        fi
    ;;
    3)
        read -p "Are you sure to Install Docker? [y/n]: " input
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
            else
                docker
                echo
                echo "Docker has been installed"
            fi
            menu
        else
            echo
            echo "Install Docker aborted!"
        fi
        # BACK TO MENU
        echo
        read -p "Are you want back to menu? [y/n]: " input
        until [[ "$input" =~ ^[yYnN]*$ ]]; do
            echo "$input: invalid selection."
            read -p "Are you want back to menu? [y/n]: " input
        done
        if [[ "$input" =~ ^[yY]$ ]]; then
            menu
        else
            exit
        fi
    ;;
    4)
        read -p "Are you sure to install portainer? [y/n]: " input
        until [[ "$input" =~ ^[yYnN]*$ ]]; do
            echo "$input: invalid selection."
            read -p "Are you sure to install portainer? [y/n]: " input
        done
        if [[ "$input" =~ ^[yY]$ ]]; then
            input
            echo
            echo "Portainer has been installed"
        else
            echo
            echo "Install Portainer aborted!"
        fi
        # BACK TO MENU
        echo
        read -p "Are you want back to menu? [y/n]: " input
        until [[ "$input" =~ ^[yYnN]*$ ]]; do
            echo "$input: invalid selection."
            read -p "Are you want back to menu? [y/n]: " input
        done
        if [[ "$input" =~ ^[yY]$ ]]; then
            menu
        else
            exit
        fi
    ;;
    5)
        exit
    ;;
	esac
}
menu
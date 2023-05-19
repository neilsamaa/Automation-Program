#!/bin/bash
sudo apt update -y;
sudo apt upgrade -y;
sudo apt install postgresql -y;
sudo su - postgres -c "createuser -s odoo";
wget -O - https://nightly.odoo.com/odoo.key | sudo gpg --dearmor -o /usr/share/keyrings/odoo-archive-keyring.gpg;
echo 'deb [signed-by=/usr/share/keyrings/odoo-archive-keyring.gpg] https://nightly.odoo.com/14.0/nightly/deb/ ./' | sudo tee /etc/apt/sources.list.d/odoo.list;
sudo apt-get update && sudo apt-get install odoo;
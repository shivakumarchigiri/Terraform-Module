#!/bin/bash
sudo yum install httpd -y
sudo service httpd start
sudo systemctl enable httpd
echo "Creating the Infrastructure from Terraform Modules" > /var/www/html/index.html
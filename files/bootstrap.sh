#!/bin/bash
apt-get update && apt-get install apache2 -y
apt-get remove nginx -y
echo "<h1>Deployed by Terraform </h1>" > /var/www/html/index.html
service apache2 start

#!/bin/bash
apt-get update && apt-get install nginx -y
echo "<h1>Deployed by Terraform </h1>" > /usr/share/nginx/index.html
service nginx start

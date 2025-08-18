#!/bin/bash
# Install nginx
sudo yum update -y
sudo yum install -y nginx

# Enable and start nginx
sudo systemctl enable nginx
sudo systemctl start nginx



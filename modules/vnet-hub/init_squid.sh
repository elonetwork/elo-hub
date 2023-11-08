#!/bin/bash

# Update package 
sudo apt update

# Install Squid
sudo apt install -y squid

# Start & enable Squid 
sudo systemctl start squid
sudo systemctl enable squid

# proxy settings
http_proxy="http://localhost:3128"
https_proxy="http://localhost:3128"

# Check if the /etc/environment file exists, and if it does, append the proxy settings
if [ -f /etc/environment ]; then
  echo "http_proxy=\"$http_proxy\"" | sudo tee -a /etc/environment > /dev/null
  echo "https_proxy=\"$https_proxy\"" | sudo tee -a /etc/environment > /dev/null
  echo "Proxy settings added to /etc/environment"
else
  echo "Error: /etc/environment file not found"
  exit 1
fi

# path to the Squid configuration file
squid_conf="/etc/squid/squid.conf"

# Define the configuration lines to be added
config_lines="# deny all request\nhttp_access deny all\n# Disable cache\ncache deny all"

# Check if the Squid configuration file exists
if [ -f "$squid_conf" ]; then
    # Append the configuration lines to the file
    echo -e "$config_lines" | sudo tee -a "$squid_conf" > /dev/null
    echo "Configuration lines added to $squid_conf"
else
    echo "Squid configuration file not found at $squid_conf. Please make sure Squid is installed and the configuration file path is correct."
fi

# Restart Squid service
sudo systemctl restart squid
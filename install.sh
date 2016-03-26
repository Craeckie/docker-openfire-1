#!/bin/bash

# Install openfire
filename="openfire_4.0.2_all.deb"
wget -O "$filename" http://www.igniterealtime.org/downloadServlet?filename=openfire/openfire_4.0.2_all.deb
dpkg -i "$filename"
rm "$filename"

# Install sparkweb
filename="sparkweb_0_9_0.tar.gz"
wget -O "$filename" http://www.igniterealtime.org/downloadServlet?filename=sparkweb/sparkweb_0_9_0.tar.gz
tar -xvf "$filename"
rm "$filename"
base_path="/var/lib/openfire/plugins/admin/webapp/"
mv sparkweb "$base_path"
mv "$base_path/sparkweb/SparkWeb.html"  "$base_path/sparkweb/index.html"

# Save configuration files for volume
mkdir -p "$CONFIG_BU"
cp -r /etc/openfire/* "$CONFIG_BU"

# Clear some data before saving this layer
rm -rf /tmp/* /var/tmp/*

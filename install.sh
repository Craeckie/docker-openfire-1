#!/bin/bash

# Install openfire
wget http://www.igniterealtime.org/downloadServlet?filename=openfire/openfire_3.10.2_all.deb
mv downloadServlet?filename=openfire%2Fopenfire_3.10.2_all.deb openfire_3.10.2_all.deb
dpkg -i openfire_3.10.2_all.deb
rm openfire_3.10.2_all.deb

# Install sparkweb
wget http://www.igniterealtime.org/downloadServlet?filename=sparkweb/sparkweb_0_9_0.tar.gz
mv downloadServlet?filename=sparkweb%2Fsparkweb_0_9_0.tar.gz sparkweb_0_9_0.tar.gz
tar -xvf sparkweb_0_9_0.tar.gz
rm sparkweb_0_9_0.tar.gz
mv sparkweb /usr/share/openfire/plugins/admin/webapp/
mv /usr/share/openfire/plugins/admin/webapp/sparkweb/SparkWeb.html  /usr/share/openfire/plugins/admin/webapp/sparkweb/index.html

# Save configuration files for volume
mkdir -p "$CONFIG_BU"
cp -r /etc/openfire/* "$CONFIG_BU"

# Clear some data before saving this layer
rm -rf /tmp/* /var/tmp/*

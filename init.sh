#!/bin/bash


set -e

if [ -f /etc/configured ]; then
        echo 'already configured'
else
       
        #needed to fix problem with ubuntu ... and cron 
        update-locale
        date > /etc/configured
fi

if [ -f /etc/openfire/openfire.xml ]; then
  echo 'Configuration files in place!'
else
  echo "Copying standard config files to original place"
  cp -r "$CONFIG_BU/*" "/etc/openfire"
fi

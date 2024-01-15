#!/bin/bash

# define the location of your nginx configuration file
nginx_conf="/etc/nginx/conf.d/default.conf"

# add the 'proxy_protocol' to the listen directives
cp $nginx_conf temp.txt
sed -i 's/listen 443 ssl;/listen 443 ssl proxy_protocol;/g' temp.txt
sed -i 's/listen \[::\]:443 ssl;/listen \[::\]:443 ssl proxy_protocol;/g' temp.txt
cat temp.txt > $nginx_conf
rm temp.txt

#!/bin/bash

apt-get update
apt-get install -y nginx

cat <<EOF > /etc/nginx/sites-available/proxy.conf
server {
    listen 80;
    server_name proxy;

    location / {
        proxy_pass http://192.168.33.100;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOF

rm /etc/nginx/sites-enabled/*
ln -s /etc/nginx/sites-available/proxy.conf /etc/nginx/sites-enabled/
service nginx restart

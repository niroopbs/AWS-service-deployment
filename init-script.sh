#!/bin/bash

set -e

sudo -s

echo "${file_content}!" > /var/www/html/index.nginx-debian.html

systemctl restart nginx

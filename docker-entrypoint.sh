#!/bin/bash
set -e



# Set rights of postfix spool folder
chown -R postfix /var/spool/postfix 
chmod -R 755 /var/spool/postfix
chmod 700 /var/spool/postfix/defer
chown -R root /var/spool/postfix/etc
chown -R root /var/spool/postfix/lib
chown -R root /var/spool/postfix/usr

# Copy necessary files for chroot environment
cp /etc/resolv.conf /var/spool/postfix/etc/
cp /etc/services /var/spool/postfix/etc/


exec "$@"


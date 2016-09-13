# Uninstall Odoo
##fixed parameters

OE_USER="odoo"
OE_HOME="/opt/$OE_USER"
OE_HOME_EXT="/opt/$OE_USER/$OE_USER-server"

#Enter version for checkout "9.0" for version 9.0,"8.0" for version 8.0, "7.0 (version 7), "master" for trunk
OE_VERSION="9.0"

# Superadmin password
OE_SUPERADMIN="superadminpassword"
OE_CONFIG="$OE_USER-server"
INIT_FILE=/lib/systemd/system/$OE_CONFIG.service


## Remove dirs

### Main dir
cd $OE_HOME_EXT/
sudo rm start.sh

### Daemon dir (init file)
cd /lib/systemd/system/
sudo rm -R $OE_CONFIG.service

### Log file dir
cd /var/log/
sudo rm -f -R $OE_CONFIG.conf/

### Server config dir
cd /etc/
sudo rm -f $OE_CONFIG.conf

# ### Startup flie 
# cd /opt
# sudo rm -R 

## Delete postgres database
### delete odoo database
sudo su - postgres -c "dropdb odoo"
### delete odoo user
sudo su - postgres -c "dropuser odoo"
### Restart postgres 
sudo systemctl restart postgresql.service

## Delete odoo system user
### Check that this is the correct command
sudo deluser odoo --remove-all-files






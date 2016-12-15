#================================
# Configure Linux Server Guest
#================================

# TODO: figure out how to deal with interactive elements during install when running a script like this

NEW_USER='zwilson'

# Create non-root user
adduser $NEW_USER --disabled-password
# add new user to the sudo group
usermod -aG sudo $NEW_USER

sudo apt-get -y update && sudo apt-get -y upgrade && sudo apt-get -y dist-upgrade
sudo apt-get update -y && sudo apt-get upgrade -y && sudo apt-get dist-upgrade

# definitely not installed by default
sudo apt-get install -y ssh
sudo apt-get install -y git
sudo apt-get install -y html2text
sudo apt-get install -y lynx
sudo apt-get install -y pandoc
sudo apt-get install -y bash-completion

# requires reboot
sudo apt-get install -y virtualbox-guest-dkms

# Note for scripting: The following have interactive elements during install
#sudo apt-get install -y lamp-server^
#sudo do-release-upgrade -y
#sudo apt-get install -y phpmyadmin

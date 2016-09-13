#!/bin/bash

# Initial Server Setup for Ubuntu 16.04 on VirtualBox 5.1.2

#==========
# VARIABLES
#==========
#! Set before running the script

# VM Creation Variables
#----------------------
# e.g. "server1"
$VMNAME="server2"
# e.g. Linux_64
$OSTYPE="Linux_64"
# 1026MB is default
$MEMORY="1026"
# no spaces in name, extension should be .vdi or other supported by vbox
$DISK_NAME="$VMNAME.vdi"
# 8GB is about right
$DISK_SIZE="8000"
# probably default to `~/Downloads/*.iso`
$GUEST_OS_ISO_PATH="/full/path/to/os.iso"

# SSH Variables
#--------------
$PUBLIC_IP=
$VM_HOSTNAME="$PUBLIC_IP"
$VM_USERNAME="root"
$SSH_TARGET="$VM_USERNAME@$VM_HOSTNAME"
$SSH_PORT=22
# TODO: Figure out how to get the IP address automatically
# Almost works:
# VBoxManage guestproperty get $VMNAME "/VirtualBox/GuestInfo/Net/0/V4/IP"
# 'ubuntu' is the default hostname 

#===========================
# Create the Virtual Machine
# @link:http://www.virtualbox.org/manual/ch07.html#idm3193
#===========================
echo -e "\n---- Creating the Virtual Machine $VMNAME----"
# Create a new virtual machine
VBoxManage createvm --name $VMNAME --ostype $OSTYPE --register
echo -e "\n---- Configuring the Virtual Machine $VMNAME for Boot ----"
# Configure VM settings for the guest OS 
VBoxManage modifyvm $VMNAME --memory $MEMORY --acpi on --boot1 dvd --nic1 bridged --bridgeadapter1 eth0
# Create a virtual disk for the VM
VboxManage createmedium disk --filename $DISK_NAME --size $DISK_SIZE
# Add an IDE Controll to the VM
VboxManage storagectl $VMNAME --name "IDE Controller" --add ide --controller PIIX4
# Set the VDI file created above as the first virtual hard disk of the VM
VBoxManage storageattach $VMNAME --storagectl "IDE Controller" --port 0 --device 0 --type hdd --medium $DISK_NAME
#Attach the ISO file that contains the operating system installation that you want to install
VBoxManage storageattach $VMNAME --storagectl "IDE Controller" --port 0 --device 1 --type dvddrive --medium $GUEST_OS_ISO_PATH
echo -e "\n---- Starting the Virtual Machine $VMNAME ----"
# Start the VM
VBoxManage startvm $VMNAME --type headless

#================================
# Connect to Linux Server Guest
#================================
echo -e "\n---- Connecting to $SSH_TARGET ----"
ssh $SSH_TARGET --port $SSH_PORT

#================================
# Configure Linux Server Guest
#================================

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
# TODO: figure out how to deal with interactive elements during install when running a script like this

#===========
# References
#===========

# Creating a VM 
#---------------
# @link:http://www.virtualbox.org/manual/ch07.html#idm3193

# Cloning a VM
#---------------
# @link:

# VM Config
#---------------
# @link:https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu-14-04
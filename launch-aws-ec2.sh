#!/bin/bash
# launches an aws EC2 instance of Ubuntu Server 14.04 LTS on the EZ VPC in the 
# "EZ VPC WebServerSG" Security Group

# Modify commenting for different options

#--- See available options for --image-id ---#
#aws ec2 describe-images --owner amazon --output json
#aws ec2 describe-images --owner self --output json

#--- See available options for --security-group-ids ---#
#aws ec2 describe-security-groups

#--- See available options for subnet-id ---#
#aws ec2 describe-subnets --output json

aws \
ec2 \
run-instances \
--image-id ami-2d39803a `# Ubuntu Server 14.04 LTS (HVM)` \
--count 1 \
--instance-type t2.micro \
--key-name admin-key-pair-useast1 \
--security-group-ids sg-0d0aef77 `# EZ VPC WebServerSG` \
--subnet-id subnet-96d63fdf `# ez Public Subnet 1` \
--output json

#--- ssh-ing into your new instance ---#
# After you run the above command, aws will return a json formatted description
# of your new instance to standard out. Note the "InstanceId:" value. Wait a few
# minutes for your instance to boot then do:
#aws ec2 describe-instances --instance-ids <instance-id> --output json | grep PublicDns

# If you didn't cp your image-id when the instance was created do
#aws ec2 describe-instances --output json
# then look for the "LaunchTime:" key in the output to figure out which 
# instance it was. Then note the "InstanceId:" value 

#!/usr/bin/env sh

################################################################################
# Description	: Deploy our docker server on your own. It is meant to be a
#		  testing deployment. Assuming you're on Ubuntu server 18.04 LTS
################################################################################

error() { printf "%s\\n" "$1" 1>&2; exit 1; }

# Testing the environment
command -v docker > /dev/null || error "You need Docker to preceed."
[ ! -d "./database" ] && error "The file should be in the repo root folder."
[ $( whoami ) != "root" ] && error "You have to be root to run this."
cd "database" || error "Something went wrong... Do you have access permission?"

# Building Docker images
sudo docker build 							\
	-t casalinovalerio/reverseproxy 				\
	./reverseproxy							\
|| error "Error building reverseproxy image"

sudo docker build 							\
	-t casalinovalerio/mybigchaindb 				\
	./mybigchaindb							\
|| error "Error building mybigchaindb image"

# Deploy and return back to original folder
sudo docker-compose up -d || error "Error with docker-compose"
cd ..

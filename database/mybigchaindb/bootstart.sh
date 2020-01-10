#!/bin/bash

NODE="noden"

# Update the system
apt-get -y update &&\
	apt-get -y full-upgrade &&\
        apt-get -y install ufw nginx certbot python3-pip libssl-dev mongodb unzip monit &&\
        apt-get -y autoremove &&\
        apt-get -y autoclean

# Allow traffic from a lot of ports
ufw allow proto tcp \
	from any \
	to any port 22,80,443,26656,26657,9984,9985,2812,27017 &&\
       	ufw enable

# Obtain SSL
echo "2\\ncasalinovalerio.cv@gmail.com\\nA\\nN\\n$NODE.casalinovalerio.com" |\
	certbot certonly

# Configure and reload nginx
cp "/etc/letsencrypt/live/$NODE.casalinovalerio.com/fullchain.pem" \
	"/etc/nginx/ssl/cert.pem"
cp "/etc/letsencrypt/live/$NODE.casalinovalerio.com/privkey.pem" \
	"/etc/nginx/ssl/cert.key"

rm "/etc/nginx/nginx.conf"
wget "https://raw.githubusercontent.com/bigchaindb/bigchaindb/master/nginx/nginx.conf" \
	-O "/etc/nginx/nginx.conf"
sed -i "s/example.testnet2.com/$NODE.casalinovalerio.com/g" "/etc/nginx/nginx.conf"

service nginx reload

# Set up Bigchaindb, Mongodb and Tendermint
# BCDB
pip3 install bigchaindb==2.0.0
pip3 install -U pip
pip3 install bigchaindb==2.0.0

yes "" | bigchaindb configure
sed -i "s/bnode.example.com/$NODE.casalinovalerio.com/g" "$HOME/.bigchaindb"

# Tendermint
wget https://github.com/tendermint/tendermint/releases/download/v0.31.5/tendermint_v0.31.5_linux_amd64.zip
unzip tendermint_v0.31.5_linux_amd64.zip
rm tendermint_v0.31.5_linux_amd64.zip
mv tendermint /usr/local/bin

tendermint init
bigchaindb-monit-config

echo <<EOF
Now connect all of your nodes:
http://docs.bigchaindb.com/projects/server/en/latest/simple-deployment-template/network-setup.html

Good luck to myself!

PS: remember to start bigchaindb and monit!
$ bigchaindb && monit -d 1
EOF

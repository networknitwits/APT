#!/bin/bash

echo -e "\n Starting checks for dependencies now... \n"

# Begin checks for executable paths, if path does not exist then install program
if [ -x /usr/bin/nmap ]; then
	echo -e "\n NMAP already installed"
else
	echo -e "\n Installing NMAP now..."
	sudo apt-get install nmap
	echo -e "\n NMAP has been installed"
fi

if [ -x /usr/bin/ndiff ]; then
	echo -e "\n NDIFF already installed"
else
	echo -e "\n Installing NDIFF now..."
	sudo apt-get install ndiff
	echo -e "\n NDIFF has been installed"
fi

if [ -x /usr/local/bin/seashells ]; then
	echo -e "\n Seashells already installed"
else
	echo -e "\n Installing Seashells IO now..."
	sudo pip install seashells
	echo -e "\n Seashells IO has been installed"
fi

if [ -x /usr/bin/msmtp ]; then
	echo -e "\n MSMTP already installed"
else
	echo -e "\n Installing MSMTP now..."
	sudo apt-get install msmtp ca-certificates
	echo -e "\n MSMTP has been installed"

	# Check for file path, if path does not exist then create it
	if [ ! -f /etc/msmtprc ]; then
		echo -e "File does not exist"
		echo -e "Creating file /etc/msmtprc now \n"
		sudo touch /etc/msmtprc
		sudo chmod +x /etc/msmtprc
		echo -e "\n The file /etc/msmtprc has been created"
		echo -e "\n Please use the following link to assist with setting up the /etc/msmtprc file"
		echo -e "\n https://jacmoe.dk/blog/2013/january/how-to-send-emails-with-msmtp-on-windows-or-linux-or-mac-os-x"
	else
		echo -e "File already exists"
	fi
fi

if [ -x /usr/bin/yad ]; then
	echo -e "\n YAD already installed \n"
else 
	echo -e "\n Installing YAD now..."
	sudo add-apt-repository ppa:webupd8team/y-ppa-manager
	sudo apt-get update
	sudo apt-get install yad
	echo -e "\n YAD has been installed"
fi

echo -e "\n Dependency checks have been completed, all required programs should be installed \n"
echo -e " Have a great day! \n"

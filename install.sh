#!/usr/bin/bash
declare -a DEPENDANCIES=("ln cm");
declare -a OPTIONS=("Download-Install Install-Downlaoded exit");
URI="https://r2---sn-n545gpjvh-hc5e.gvt1.com/edgedl/android/studio/ide-zips/4.1.0.19/android-studio-ide-201.6858069-linux.tar.gz?cms_redirect=yes&mh=gy&mip=196.97.7.223&mm=28&mn=sn-n545gpjvh-hc5e&ms=nvh&mt=1604213352&mv=m&mvi=2&pl=13&shardbypass=yes"
PCODE=""
if [[ $UID -eq 0 ]]; then
	INSTALL_DIR="/root/INSTALL_DIR"
else
	echo -en "\E[1;31m Enter sudo password: \E[m";
	read PCODE
	INSTALL_DIR="/home/$USER/INSTALL_DIR/"
fi
set -o errexit
net_notif=""
function net_manager() {
	ping google.com c -3;
	if [[ $? -ne 0 ]]; then
		echo -e $net_notif
		net_manager
	fi
}
function webInstall() {
	if [ $(which wget) ];then
		echo -e "\E[1;34m Downloading .... Get a cup of coffee and wait for the download to finish ... 🤓🤓\E[m"
			sudo wget $URI<<EOF
			$PCODE
EOF
		local_install
		else
			sudo apt install wget<<EOF
			$PCODE
EOF
webInstall
	fi
	return 0
}
function local_install(){
	echo -e "\E[1;35m Extracting files. Hangon ... 🤗🤗🤗 \E[m"
	tar -xvf ./*.gz

	if [[  $(which ln) ]]; then
		echo "Setting up the studio .... "
		echo $(ls $(ln -sf $(pwd)/android-studio/bin/studio.sh))
		ln -s $(pwd)/android-studio/bin/studio.sh /usr/local/bin/studio && rm -rf $INSTALL_DIR
		stats_code=$?
		if [ $? -eq 0 ];then
			 echo -e "\033[1;34m All done, whenever you want to start android just type the name studio on your terminal.Good byes.\E[m"
		 else
			 echo -e "\E[1;31m An error occured ... Exiting with status code $stats_code"
	fi
	exit $stats_code
	fi
}
function base(){
	cd "$INSTALL_DIR"
	echo $(pwd)
	select opt in $OPTIONS;do
		case $opt in
			"Download-Install")
				webInstall
				;;
		"Install-Downlaoded")
			local_install
			;;
		"exit")
		echo -e "\033[1;34m Sad to see you leave but good bye $USER 😰\E[5;31m 😥 \E[m\033[m"
		exit
	esac
	done
}

mkdir -p $INSTALL_DIR && base

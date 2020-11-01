#!/usr/bin/bash
declare -a DEPENDANCIES=("ln cm");
declare -a OPTIONS=("Download-Install Install-Downloaded exit");
PS3="$USER's Option> "
export PS3
URI="https://r2---sn-n545gpjvh-hc5e.gvt1.com/edgedl/android/studio/ide-zips/4.1.0.19/android-studio-ide-201.6858069-linux.tar.gz?cms_redirect=yes&mh=gy&mip=196.97.7.223&mm=28&mn=sn-n545gpjvh-hc5e&ms=nvh&mt=1604213352&mv=m&mvi=2&pl=13&shardbypass=yes"
PCODE=""
if [[ $UID -eq 0 ]]; then
	INSTALL_DIR="/root/.INSTALL_DIR"
else
	echo -en "\E[1;31m Enter sudo password: \E[m";
	read PCODE
	INSTALL_DIR="/home/$USER/.INSTALL_DIR/"
fi
set -o errexit
g_info="$USER"
net_notif=""
Banner="\E[1;34m
        8***        8        *     *   Author - Codem
        8   *     8___8      *  *  *
        8__ *     8   8      *     *

\E[m"

printf "$Banner"
echo -e "\E[1;34m Hello $g_info, am gonna take you through the installation of the android studio sdk.\E[m"
function net_manager() {
  local NET_MON
  echo -e "\033[1;33m Checking internet connection ...  👀 \033[m"
  ping google.com -c 3 > /dev/null 2>&1
  if [ $? -ne 0 ]; then
    NET_MON=1
    sleep 2;
    echo -en "\E[1;31m You are offline 😖 PS:(\E[m\n \E[1;33m Waiting for internet connection to come back ... 🤢🤢 \E[m";
  fi
  ping google.com -c 1 > /dev/null 2>&1
  while [[ $? -ne 0 ]]; do
    NET_MON=1
    ping google.com -c 1 > /dev/null 2>&1 ;
  done
  if [[ $? -eq 0 ]]; then
      NET_MON=0
  fi
  if [ $NET_MON -eq 0 ] ; then
    echo -e "\E[5;35m \E[1m you are Online PS 👍 :)\E[m \E[m";
  fi
}

function webInstall() {
	net_manager
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
	if [[ $(echo $(ls)|wc -l ) -ne 0 ]]; then
		echo -e "\E[1;35m Extracting files. Hangon ... 🤗🤗🤗 \E[m"
		tar -xvf ./*tar.gz
		if [[  $(which ln) ]]; then
			echo -e "\E[1;31m Setting up android studio .... \E[m"
			ln -s $(pwd)/android-studio/bin/studio.sh /usr/local/bin/android
			stats_code=$?
			if [ $? -eq 0 ];then
				 echo -e "\033[1;34m All done, whenever you want to start android just type android on your terminal.Good byes.\E[m"
			 else
				 echo -e "\E[1;31m An error occured ... Exiting with status code $stats_code"
		fi
		exit $stats_code
		fi
	else
		echo -e "\E[1;31m No tar file inside $INSTALL_DIR . Exiting ... \E[m"
		exit $?
	fi
}
function base(){
	cd "$INSTALL_DIR"
	select opt in $OPTIONS;do
		case $opt in
			"Download-Install")
				webInstall
				;;
		"Install-Downloaded")
			local_install
			;;
		"exit")
		echo -e "\033[1;34m Sad to see you leave but good bye $USER 😰\E[5;31m 😥 \E[m\033[m"
		exit
	esac
	done
}

mkdir -p $INSTALL_DIR && base

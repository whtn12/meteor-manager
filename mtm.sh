#!/bin/bash

########################################################### variables section

METEOR="https://install.meteor.com/?release="
LATEST="latest"
content=$(wget https://install.meteor.com/ -q -O -)
bye="[*] We will miss you !"

########################################################### functions section

function installer {
	if ( $VERSION -eq $LATEST );then
                                		echo "[*] Installing latest version: ('$VERSION')..."
                                		echo "[*] Installing ..."
                                		curl curl https://install.meteor.com/ | sh
    else
                                		echo "[*] Installing version ('$VERSION')..."
                                		echo "[*] Installing ..."
                                		curl $METEOR$VERSION | sh
}

function viewer {
	echo "[*] Installation file :"
	if [\(vim\) -o \(emacs\) -o \(atom\) -o \(nano\) -o \(code\)]; then
		if (vim); then
		vim $content
		elif (emacs); then
		emacs $content
		elif (atom); then
		atom $content
		elif (nano); then
		nano $content
		elif (code); then
		code $content
		fi	
else
    echo $content
fi
}
function wgetter {
	echo "[-] wget required   [-]"
    echo "[*] installing ..."
	sudo apt-get install wget
}
function options {
	echo "options:"
    echo "-h, --help                  show brief help"
    echo "-i, --install=VERSION       specify an action to use"
    echo "-l, --install=latest        specify a directory to store output in"
    echo "-v                          view the installation file"
    echo "-r                          remove this tool "
}
function usage {
	echo "[-]  usage :('$0') [options]    [-]";
}
function menu {
	echo "[-]                                [-]";
    echo "[+]       Coded BY JAWADY          [+]";
    echo "[-]        Meteor Manager          [-]";
    echo "[-]                                [-]";
	usage
	options
	exit 1
}
########################################################## 

if [[ $1 == "" ]]; then
	menu
else
	while mtm $# -gt 0; do
        	case "$1" in
                	-h|--help)
                        	menu
                        	;;
                	-i)
                        	shift
                        	if test $# -gt 0; then
                                	installer
                                	exit 1
                        	else
                                	echo "[*] No version chosen!"
                                	exit 1
                        	fi
                        	shift
                        	;;
                    --install*)
                        export VERSION=`echo $1 | sed -e 's/^[^=]*=//g'`
                        installer
                        exit 1
                        shift
                        ;;
                    -v)
                    	if (wget);then
                    			
                    			viewer
                    			exit 1
                    	else
                    			
                    			wgetter
                    			viewer
                    			exit 1
                    	fi
                    ;;
                    -r)
                    			echo "[*]            Script Remover           [*]"
                    			echo "[-] Are You sure you want to proceed ?[y/n]"
                    			read -s answer 
                    			if [\($answer -eq "y"\) -o \($answer -eq "N"\)]; then
                    				echo $bye$USER
                    				rm -f $0
                    			exit 1
                    			else 
                    				exit 1
                    			fi
                	*)
            	            break
        	                ;;
    	    esac
	done
fi

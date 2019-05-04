#!/bin/bash

#The purpose of the bash script is to analyse, monitor and recover various sorts of data from the web.
#The Script shall use N-Map for network analysis and provide customized results the scope of which is yet to be determined
#The Script shall also function on other networking tools such as IPtables and firewalls in order to determine the state of the network. 
#It shall relay information to the user about the forensics and info about various happenings such as your ip etc.

#Four modules are present currently. The IP module and the Reconnaissance module, The Encryptor © and Vulnerous web ©.

#The Encryptor © by Ankush Sharma makes official debut in version 1.2 #######################
#To learn more about the encryptor visit https://github.com/ScorchingShade/Encryptor ######## 

#Vulnerous-web © by Ankush Sharma makes official debut in version 2.5 #######################
#To learn more about the encryptor visit https://github.com/ScorchingShade/Vulnerous-web ######## 


VERSION="2.5"
#### Declare global vars ##########
CURRENT_DIR=`pwd`
###Fetch IP public and private#####
PRIV_IP_ADDR=`hostname -I | awk '{print $1}'`
PUB_IP_ADDR=`wget -qO- https://ipecho.net/plain ; echo`

###COLORS##########################
RED='\033[0;31m'
NC='\033[0m'

################################progress bar###############################################################
progress_bar()
{
  local DURATION=$1
  local INT=0.25      # refresh interval

  local TIME=0
  local CURLEN=0
  local SECS=0
  local FRACTION=0

  local FB=2588       # full block

  trap "echo -e $(tput cnorm); trap - SIGINT; return" SIGINT

  echo -ne "$(tput civis)\r$(tput el)│"                # clean line

  local START=$( date +%s%N )

  while [ $SECS -lt $DURATION ]; do
    local COLS=$( tput cols )

    # main bar
    local L=$( bc -l <<< "( ( $COLS - 5 ) * $TIME  ) / ($DURATION-$INT)" | awk '{ printf "%f", $0 }' )
    local N=$( bc -l <<< $L                                              | awk '{ printf "%d", $0 }' )

    [ $FRACTION -ne 0 ] && echo -ne "$( tput cub 1 )"  # erase partial block

    if [ $N -gt $CURLEN ]; then
      for i in $( seq 1 $(( N - CURLEN )) ); do
        echo -ne \\u$FB
      done
      CURLEN=$N
    fi

    # partial block adjustment
    FRACTION=$( bc -l <<< "( $L - $N ) * 8" | awk '{ printf "%.0f", $0 }' )

    if [ $FRACTION -ne 0 ]; then 
      local PB=$( printf %x $(( 0x258F - FRACTION + 1 )) )
      echo -ne \\u$PB
    fi

    # percentage progress
    local PROGRESS=$( bc -l <<< "( 100 * $TIME ) / ($DURATION-$INT)" | awk '{ printf "%.0f", $0 }' )
    echo -ne "$( tput sc )"                            # save pos
    echo -ne "\r$( tput cuf $(( COLS - 6 )) )"         # move cur
    echo -ne "│ $PROGRESS%"
    echo -ne "$( tput rc )"                            # restore pos

    TIME=$( bc -l <<< "$TIME + $INT" | awk '{ printf "%f", $0 }' )
    SECS=$( bc -l <<<  $TIME         | awk '{ printf "%d", $0 }' )

    # take into account loop execution time
    local END=$( date +%s%N )
    local DELTA=$( bc -l <<< "$INT - ( $END - $START )/1000000000" \
                   | awk '{ if ( $0 > 0 ) printf "%f", $0; else print "0" }' )
    sleep $DELTA
    START=$( date +%s%N )
  done

  echo $(tput cnorm)
  trap - SIGINT
}
###############################################################################################################################
logo(){
	echo "$(tput setaf 1)                                                  
              (                                   
 (   (    (   )\          (   (           (       
 )\  )\  ))\ ((_) (      ))\  )(    (    ))\  (   
((_)((_)/((_) _   )\ )  /((_)(()\   )\  /((_) )\  
\ \ / /(_))( | | _(_/( (_))   ((_) ((_)(_))( ((_) 
 \ V / | || || || ' \))/ -_) | '_|/ _ \| || |(_-< 
  \_/   \_,_||_||_||_| \___| |_|  \___/ \_,_|/__/
  
  $(tput sgr0)"
}

function __init__(){
	echo "$(tput setab 6)Initialising programme$(tput sgr0)"
	progress_bar 2
	echo "$(tput sgr 6)Finished Initialisation$(tput sgr0)"
	#statements
	#printf "\n# # # # # # # # # # # # # # Welcome to the Vulnerous # # # # # # # # # # # # # #\n"
	logo
	printf "\nWith Vulnerous you can perform easy analysis of network, calculate network details and statistics and create detailed reports.\nThe tool helps beginners to create modular VA reports and use several toolkits in an ethical hacker's arsenal.\n"


}

####Ip info######
function find_ip(){

	echo "$(tput setab 4)Your Private IP is: $PRIV_IP_ADDR$(tput sgr0)"
	echo "$(tput setab 5)Your Public IP is: $PUB_IP_ADDR$(tput sgr0)"
	echo "$(tput setab 1)Exiting IP Suite...$(tput sgr0)"
}

### Adding the Encryptor Module support #####
### The Encryptor ©  is a software by Ankush Sharma ##
### Please read the license before its usage #######
function Encryptor(){
	`gnome-terminal -e "python3 $CURRENT_DIR/Source.py"`

}

### Adding Vulnerous-web Module support #####
### Vulnerous-web © is a software by Ankush Sharma ##
### Please read the license before its usage #######
function Vulnerous-web(){
	printf "$(tput setab 3)\nINFO--- by default, your localhost will be analysed at 127.0.0.1\n $(tput sgr0)"
	printf "\n$(tput setab 2)Enter the website you want to analyse by Vulnerous-web© (avoid writing htts:// or www etc):$(tput sgr0)\n"
	read URL
	if [[ -z "$URL"  ]]; then
				#statements
				echo "$(tput setab 1)Empty URL, analysing localhost now...$(tput sgr0)"
				`gnome-terminal -e "python3 $CURRENT_DIR/Vulweb.py 127.0.0.1"`			
			else
				echo "$(tput setab 2)Analysing $URL now .....$(tput sgr0)"
				`gnome-terminal -e "python3 $CURRENT_DIR/Vulweb.py $URL"`			
			fi
	

}


function nmap(){

	echo "$(tput setaf 6)                                                                                                                            
 _ _ _     _                      _          _____                         _                            _____     _ _       
| | | |___| |___ ___ _____ ___   | |_ ___   | __  |___ ___ ___ ___ ___ ___|_|___ ___ ___ ___ ___ ___   |   __|_ _|_| |_ ___ 
| | | | -_| |  _| . |     | -_|  |  _| . |  |    -| -_|  _| . |   |   | .'| |_ -|_ -| .'|   |  _| -_|  |__   | | | |  _| -_|
|_____|___|_|___|___|_|_|_|___|  |_| |___|  |__|__|___|___|___|_|_|_|_|__,|_|___|___|__,|_|_|___|___|  |_____|___|_|_| |___|
                                                                                                                             $(tput sgr0)"


	###Target analysis##
	re='[0-9./]'
	TARGET='127.0.0.1'
	truth_Check=1

	while [[ truth_Check ]]; do
	
		#statements
			echo "$(tput setab 6)Enter the target IP address: (e.g 192.168.1.1)$(tput sgr0) "
			read TARGET
			if [[ "$TARGET" =~ $re  ]]; then
				#statements
				echo "$(tput setab 2)Target accepted.$(tput sgr0)"
				break
			else
				echo "$(tput setab 1)Wrong Target info! $(tput sgr0)"			
			fi

	done

while [[ 1 ]]; do
		#statements
	

	printf "$(tput setab 4)What do you want to know? Chose the option below:\n1) Discover hosts connected.\n2) Discover MAC address, scripts etc.\n3) Calculate the ip subnets and other info.\n4) Find/guess target OS.\n5) Exit reconnaissance suite!\n$(tput sgr0)"
	read option

	case $option in
		1 ) echo "$(tput setab 3)Please wait while the report is generated...$(tput sgr0)"
			`sudo nmap -F $TARGET >> Discovery_report.txt`
			echo "$(tput setab 2)The report has been generated in `pwd`/Discovery_report.txt$(tput sgr0)"
			;;		
		
		2 ) echo "$(tput setab 3)Please wait while the report is generated...$(tput sgr0)"
			`sudo nmap -sC $TARGET >> Script_report.txt`
			echo "$(tput setab 2)The report has been generated in `pwd`/Script_report.txt $(tput sgr0)"
			;;

		3 ) echo "$(tput setab 3)Please wait while the report is generated...$(tput sgr0)"
			Calculation= `sudo ipcalc $TARGET >> Calculation_report.txt`
			echo "$(tput setab 2)The report has been generated in `pwd`/Calculation_report.txt$(tput sgr0)"
			
			;;

		4 ) echo "$(tput setab 3)Performing a stealth OS scan,the packets won't be detected, please wait while the report is generated...$(tput sgr0)"
			`sudo nmap -v -Pn -O $TARGET >> OS_report.txt`
			echo "$(tput setab 2)The report has been generated in `pwd`/OS_report.txt$(tput sgr0)"
			echo "$(tput setab 6)The os is guessed at the parameter OS details$(tput sgr0)"
			;;

		5 ) echo "Exiting reconnaissance suite...."
			break
			;;		

	esac
	done

	echo "Placeholder"
	
}

__init__

while [[ 1 ]]; do
	
	printf "\nPlease chose your suite below:\n1) IP Finder suite\n2) Reconnaissance Suite.\n3) Encryptor ©  by Ankush\n4) Vulnerous-web ©  by Ankush\n5) Exit Vulnerous.\n"
	read option

	case $option in
		1 ) echo "$(tput setab 2)Loading IP finder.$(tput sgr0)"
			progress_bar 1
			find_ip
			;;
		2 ) echo "$(tput setab 2)Loading Reconnaissance Suite.$(tput sgr0)"
			progress_bar 2
			nmap
			;;

		3 ) echo "$(tput setab 2)Loading Encryptor ©  by Ankush$(tput sgr0)"
			Encryptor
			;;
		4 ) echo "$(tput setab 2)Loading Vulnerous-web© by Ankush$(tput sgr0)"
			Vulnerous-web
			printf "\n$(tput setab 1)Your vulnerability reports will be generated and saved in your current directory! Please refer to Vulnerous-Vulnerability-Report to check for all the vulnerabilities found on the given url.$(tput sgr0)\n\n"
			;;	
		5 ) echo "$(tput setab 1)Are you sure you want to exit Vulnerous? (y/n)$(tput sgr0)"
			read choice

			if [ "$choice" = "y" ] || [ "$choice" = "Y" ] || [ "$choice" = "yes" ] || [ "$choice" = "YES" ] || [ "$choice" = "Yes" ];then
				printf "\nThank you for using Vulnerous, authored by Ankush Sharma. A product of AINC, Creating Code"
				exit -1
			else
				continue	
			fi	
			;;	

		esac



	done





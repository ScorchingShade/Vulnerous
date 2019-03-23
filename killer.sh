#!/bin/bash

#The purpose of the bash script is to analyse, monitor and recover various sorts of data from the web.
#The Script shall use N-Map for network analysis and provide customized results the scope of which is yet to be determined
#The Script shall also function on other networking tools such as IPtables and firewalls in order to determine the state of the network. 
#It shall relay information to the user about the forensics and info about various happenings such as your ip etc.

#Two modules are present currently. The IP module and the Reconnaissance module.

#The Encryptor © by Ankush Sharma makes official debut in version 1.2 #######################
#To learn more about the encryptor visit https://github.com/ScorchingShade/Encryptor ######## 

VERSION="1.2"
#### Declare global vars #########
CURRENT_DIR=`pwd`
###Fetch IP public and private#####
PRIV_IP_ADDR=`hostname -I | awk '{print $1}'`
PUB_IP_ADDR=`wget -qO- https://ipecho.net/plain ; echo`

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


function __init__(){
	echo "Initialising programme"
	progress_bar 2
	echo "Finished Initialisation"
	#statements
	printf "\n# # # # # # # # # # # # # # Welcome to the Vulnerous # # # # # # # # # # # # # #\n"
	printf "\nWith Vulnerous you can perform easy analysis of network, calculate network details and statistics and create detailed reports.\nThe tool helps beginners to create modular VA reports and use several toolkits in an ethical hacker's arsenal.\n"


}

####Ip info######
function find_ip(){

	echo "Your Private IP is: $PRIV_IP_ADDR"
	echo "Your Public IP is: $PUB_IP_ADDR"
	echo "Exiting IP Suite..."
}

### Adding the Encryptor Module support #####
### The Encryptor ©  is a software by Ankush Sharma ##
### Please read the license before its usage #######
function Encryptor(){
	`gnome-terminal -e "python3 $CURRENT_DIR/Source.py"`

}


function nmap(){

	###Target analysis##
	re='[0-9./]'
	TARGET='127.0.0.1'
	truth_Check=1

	echo "Welcome to the Reconnaissance suite!"

	while [[ truth_Check ]]; do
	
		#statements
			echo "Enter the target IP address: (e.g 192.168.1.1) "
			read TARGET
			if [[ "$TARGET" =~ $re  ]]; then
				#statements
				echo "Target accepted."
				break
			else
				echo "Wrong Target info!"			
			fi

	done

while [[ 1 ]]; do
		#statements
	

	printf "What do you want to know? Chose the option below:\n1) Discover hosts connected.\n2) Discover MAC address, scripts etc.\n3) Calculate the ip subnets and other info.\n4) Find/guess target OS.\n5) Exit reconnaissance suite!\n"
	read option

	case $option in
		1 ) echo "Please wait while the report is generated..."
			`sudo nmap -F $TARGET >> Discovery_report.txt`
			echo "The report has been generated in `pwd`/Discovery_report.txt"
			;;		
		
		2 ) echo "Please wait while the report is generated..."
			`sudo nmap -sC $TARGET >> Script_report.txt`
			echo "The report has been generated in `pwd`/Script_report.txt"
			;;

		3 ) echo "Please wait while the report is generated..."
			Calculation= `sudo ipcalc $TARGET >> Calculation_report.txt`
			echo "The report has been generated in `pwd`/Calculation_report.txt"
			
			;;

		4 ) echo "Performing a stealth OS scan,the packets won't be detected, please wait while the report is generated..."
			`sudo nmap -v -Pn -O $TARGET >> OS_report.txt`
			echo "The report has been generated in `pwd`/OS_report.txt"
			echo "The os is guessed at the parameter OS details"
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
	
	printf "\nPlease chose your suite below:\n1) IP Finder suite\n2) Reconnaissance Suite.\n3) Encryptor ©  by Ankush\n4) Exit Vulnerous.\n"
	read option

	case $option in
		1 ) echo "Loading IP finder."
			progress_bar 1
			find_ip
			;;
		2 ) echo "Loading Reconnaissance Suite."
			progress_bar 2
			nmap
			;;

		3 ) echo "Loading Encryptor ©  by Ankush"
			Encryptor
			;;
		4 ) echo "Are you sure you want to exit Vulnerous? (y/n)"
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





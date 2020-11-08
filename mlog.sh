#! /bin/sh
# Author: Zuhayer Alam
# This script runs and infinite loop to monitor
# which users on a denial list have logged into the UNIX system
# more than once.

#if the denial list does not exit then the script will exit
if [ ! -f user.deny ] ; then
	echo "file listing the usernames (named user.deny), does not exist" ; exit
fi

while true; do
	while read username; do
		#Trying to find if the username exists more than once in the logged in users
		times_logged_in=`users|grep -o "$username"|wc -l`
		if [ $times_logged_in -gt 1 ] ; then
		#Then find the user's full name from finger and echo it in the screen
			echo "The user `finger -s "$username" |grep "$username" | head -1 |  awk '{print $2,$3}'` (on the denial list) has logged in more than once!"
		fi
	done <user.deny #inner loop uses user.deny file to read the usernames
	sleep 3
done

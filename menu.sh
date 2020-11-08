#! /bin/sh
# Author: Zuhayer Alam
# This script lets users add, delete, search for,
# and display specific information from the file named "records".

#function to add information to the records file.
add()
{
while echo -e "Add new employee record"
do
	while	echo -e "Phone Number(xxxxxxxx): \c"
	do
		read phonenum
		case "$phonenum" in
		[1-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9])	if grep "$phonenum" records >/dev/null 
		then echo "Phone number exists"; continue 
		fi ;;
		"") echo "Phone number not entered" ; continue ;;	
		*) echo "Invalid Phone number" ; continue ;;		
		esac

		while	echo -e "\nFamily Name: \c"
		do
			read famname
			case "$famname" in
			*[!\ a-zA-Z]*) echo "Family name can contain only alphabetic characters and spaces"; continue ;;
			"") echo "Family name not entered." ; continue ;;
			esac

			while	echo -e "\nGiven Name: \c"
			do
				read givename
				case "$givename" in
				*[!\ a-zA-Z]*) echo "Given name can contain only alphabetic characters and spaces"; continue ;;
				"") echo "Given name not entered." ; continue ;;
				esac

				while	echo -e "\nDepartment Number: \c"
				do
					read depnum
					case "$depnum" in
						[0-9][0-9]);;
						*) echo "A valid department number contains 2 digits" ; continue ;;
					esac

					while	echo -e "\nJob Title: \c"
					do
						read jobtitle
						case "$jobtitle" in
						*[!\ a-zA-Z]*) echo "Job title can contain only alphabetic characters and spaces"; continue ;;
						"") echo "Job title not entered" ; continue ;;
						*) echo "Adding new employee record to the records file ..." 
							echo "$phonenum:$famname:$givename:$depnum:$jobtitle" >> records;
							COMMAND_SUCCESS="$?"
							if [ "$COMMAND_SUCCESS" -eq 0 ]; then
								echo "New Record Saved"
							else
								echo "Record saving failed"
							fi
						break;;
						esac
					done
					break
				done
				break
			done
			break
		done
		break
	done
	echo -e "\nAdd another? (y)es or (n)o: \c"
	read answerforadd
	case "$answerforadd" in
	[yY]*) continue ;;
	*) break ;;
	esac
done
}

#function to delete entry from records file
delete()
{
while echo -e "Delete employee record"
do
	while	echo -e "Phone Number(xxxxxxxx): \c"
	do
		read phonenumfordel
		case "$phonenumfordel" in
		[1-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9])	if grep "$phonenumfordel" records >/dev/null 
		then grep -i "$phonenumfordel" ./records; break 
		else
			echo "Phone number is not found"
		fi ;;		
		"") echo "Phone number not entered" ; continue ;;	
		*) echo "Invalid Phone number" ; continue ;;		
		esac
	done
	echo -e "\nConfirm Deletion? (y)es or (n)o: \c"
	read answerfordel
	case "$answerfordel" in
	[yY]*) grep -F -v "$phonenumfordel" records > records.txt && mv records.txt records
		DEL_COMMAND_SUCCESS="$?"
		if [ "$DEL_COMMAND_SUCCESS" -eq 0 ]; then
			echo "Record Deleted"
		else
			echo "Record was not deleted!"
		fi 
		break;;
	*) break ;;
	esac
done
}
#Does not let the user continue if they don't press enter key
pause()
{
while true
do
	echo -e "Press Enter to Continue..."
	read userenter
	case "$userenter" in
	"") break ;;
	*) continue ;;
	esac
done
}
# if the records file does not exist, program should exit
if [ ! -f records ] ; then
	echo "file containing records does not exist." ; exit
fi

MENU_HEADER="Dominion Consulting Employees Info Main Menu"
HEADER_LEN=`echo -n $MENU_HEADER | wc -m`

#Starting loop of the program to show the user the menu
while echo "$MENU_HEADER"
do
	i=1
	#loop for drawing the "=" lines under the header
	while [ $i -le $HEADER_LEN ]
	do
		echo -n "="
		(( i++ ))
	done
	echo -e "\n1 - Print All Current Records"
	echo -e "2 - Search for Specific Record(s)"
	echo -e "3 - Add New Records"
	echo -e "4 - Delete Records"
	echo -e "Q - Quit\n"
	echo -e "Your Selection: \c"

	read choice
	case $choice in
		1) cat records
			echo -e "\n" ;;
		2) echo -e "Enter keyword: \c"
			read keyword
			case "$keyword" in
			"") echo -e "Keyword not Entered\n" ;
				 pause
				 continue ;;
			*) if grep -i "$keyword" ./records >/dev/null
				then  echo "`grep -i "$keyword" ./records`"
				else
				echo -e ""$keyword" not found\n"
				fi
			esac
			pause;;
		3)add;;
		4)delete;;
		Q)exit;;
		*) echo -e "Invalid selection\n"
			pause ;;
	esac
done
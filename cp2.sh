#! /bin/sh
# Author: Zuhayer Alam
# This script copies all the files
# from the directories named dir1 and dir2
# into a new directory named dir3 (timestamps are preserved).
if [ ! -d $1 -a ! -d $2 ] ; then
	echo "Directory where the file is being copied from, does not exist" ; exit
fi
if [ -d $3 ] ; then
	echo "Directory where the file is being copied to, already exists" ; exit
fi
mkdir $3

# creating two temporary directories for
# displaying information to users.
# these directories must be removed at the end of the program.
mkdir temp1dir
mkdir temp2dir

cp -a $1/. $3
echo -e "These new files from dir1 copied into dir3: \n`ls $1`"
for file in `ls $2`
do
	if [ ! -f $3/$file ] ; then
		cp -a ./$2/$file $3
		cp -a ./$2/$file temp1dir
	elif [ -f $3/$file -a $3/$file -ot $2/$file ] ; then
		cp -a ./$2/$file $3
		cp -a ./$2/$file temp2dir
	fi
done
echo -e "These new file(s) from dir2 copied into dir3: \n`ls temp1dir`"
echo -e "These new file(s) from dir2 copied into dir3 and overwrite(s) their namesakes in dir3: \n`ls temp2dir`"
rm -r temp1dir
rm -r temp2dir
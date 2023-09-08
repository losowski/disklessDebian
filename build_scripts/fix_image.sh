#!/bin/bash
# Script to correct the symbolic links for using this image over NFS

# Import shell
source exports.sh

# Fix the symbolic links on a particular file
# 1 - File to process
fixSingleFileSymbolicLinks () {
	echo "Fixing: "$1
	ls -l $1 | grep "\->\ \/"
	$(ls -l $1 | grep "\->\ \/" | sed 's/\/bin/..\/..\/bin/g' | sed 's/\/lib/..\/..\/lib/g' | sed 's/\/etc/..\/..\/etc/g' | tr -s ' ' | awk '{print "ln -sf "$11" "$9}')
}

# Copy the dependency into the image
# 1 - File to process
copyFileFromLinks () {
	echo "Copying linked: "$1
	ls -l $1 | grep "\->\ \/"
	#$(ls -l $1 | grep "\->\ \/" | tr -s ' ' | awk '{print "cp --remove-destination "$11" "$9}')
	#BINPATH=$(ls -l $1 | grep "\->\ \/" | tr -s ' ' | cut -d ' ' -f 11)
	BINPATH=$(echo $1)
	NEWPATH=$(echo $BUILDROOTIMAGE$BINPATH)
	echo "FIX is to copy from $BINPATH to $NEWPATH"
	sudo cp -v $BINPATH $NEWPATH
}



# UnFix the symbolic links on a particular file
# 1 - File to process
unFixSingleFileSymbolicLinks () {
	echo "unFixing: "$1
	ls -l $1 | grep "\->\ \.\.\/\.\.\/"
	$(ls -l $1 | grep "\->\ \.\.\/" | sed 's/..\/..\/bin/\/bin/g' | sed 's/..\/..\/lib/\/lib/g' | sed 's/..\/..\/etc/\/etc/g' | tr -s ' ' | awk '{print "ln -sf "$11" "$9}')
}

# Attempt to convert the symbolic link into a hardlink
# 1 - File to process
fixSingleFileLinks () {
	echo "Hard linking: "$1
	ls -l $1 | grep "\->\ \/"
	$(ls -l $1 | grep "\->\ \/" | tr -s ' ' | awk '{print "ln -f "$11" "$9}')
}


# Main function to process the arguments
# Args
if [ $# -eq 1 ]; then
	if [ $1 = "-h" ]; then
		echo "help"
	else
		fixSingleFileSymbolicLinks $1
	fi

elif [ $# -eq 2 ]; then
	if [ $1 = "-r" ]; then
		echo "recursive is Dangerous"
		for file in $(find $2 -type l);
			# Check if the file is symbolic - and only process those
			do if [ -L $file ]; then
				echo $file" is Symbolic";
				#fixSingleFileSymbolicLinks $file
			fi
		done
	elif [ $1 = "-d" ]; then
		echo "directory"
		for file in $(ls -1 $2);
			# Check if the file is symbolic - and only process those
			do if [ -L $2/$file ]; then
				#echo $2/$file" is Symbolic";
				fixSingleFileSymbolicLinks $2/$file
			fi
		done
	elif [ $1 = "-c" ]; then
		echo "directory"
		for file in $(ls -l $2/* | grep "\->\ \/" | tr -s ' ' | cut -d ' ' -f 11 | sort | uniq );
			# Check if the file is symbolic - and only process those
			do copyFileFromLinks $file
		done
	elif [ $1 = "-u" ]; then
		echo "directory"
		for file in $(ls -1 $2);
			# Check if the file is symbolic - and only process those
			do if [ -L $2/$file ]; then
				#echo $2/$file" is Symbolic";
				unFixSingleFileSymbolicLinks $2/$file
			fi
		done
	fi
else
	echo "Set the path"
fi 
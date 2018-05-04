#!/usr/bin/bash -i


# Author pacmanator
# Email mrpacmanator at gmail dot com


##### Clear the shell history, cache memory, buffer and swap memory. #####

function clear_shell_history
{	
	SHRED=$(which shred)
	if [ $? -eq 1 ]; then
		echo "[!] Hmmmmmm, Looks like shred is not installed. Weird sh|7."
		echo "[!] Using /dev/urandom."
		clear_shell_history_urandom;
	else
		echo "[*] Shredding $HISTFILE."
		$SHRED -n 10 -z "$HISTFILE"
		sleep 1
		echo "[*] Nulling $HISTFILE"
		cat /dev/null > "$HISTFILE"
		sync;
	fi
}


function clear_shell_history_urandom
{
	echo "[*] Overwritting $HISTFILE 10 times with /dev/urandom."
	for (( i = 0; i < 10; i++ )); do
		cat /dev/urandom > "$HISTFILE"
	done
	
	echo "[*] Nulling $HISTFILE."
	cat /dev/null > "$HISTFILE"
	
	if [ $(echo $0)=="bash" ]; then
		clear_bash_history
		rm "$HISTFILE";
	fi
	
	sync
}

function clear_bash_history
{
	history -c && history -w
}

function cleaner
{
	clear_shell_history
	
	echo "[*] Dropping pagecache, dentries and inode data."
	# Clear pagecache, dentries and inode data.
	echo '3' > /proc/sys/vm/drop_caches
	
	echo "[*] Flushing swap files."
	# Clear swap memory.
	swapon -a
	sleep 2
	swapoff -a
	sync
}

#Check if user is root
if [ $(id -u ) -ne 0 ]; then
	echo "[!] You aren't root. Clearing shell history."
	clear_shell_history;
else
	echo "[:D] Good job!! You are root!"
	echo "[!] Clearing shell history and emptying memory cache, buffer and swap file."
	cleaner;
fi

echo "Done! Have a nice day! :D"

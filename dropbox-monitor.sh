#!/bin/bash
while true; do
	D=`date` 
	S=`/dropbox.py status`
	echo "$D => $S"
	sleep 3
done


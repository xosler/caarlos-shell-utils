#!/bin/bash
		
fuser $1/tcp > pid.txt
echo "Matando processo " `cat pid.txt`
kill -9 `cat pid.txt`
rm -rf pid.txt


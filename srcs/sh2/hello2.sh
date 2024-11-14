#!/bin/sh
echo "Hello, I am an sh script running in a Docker container!"

#I want a loop that print Hi every 1 second
while true; do
	echo "HEYY"
	sleep 1
done
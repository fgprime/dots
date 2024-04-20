#!/bin/sh
while killall "Skype for Business"; do 
    sleep 1
done
open -a "Skype for Business"

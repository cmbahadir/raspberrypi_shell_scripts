#!/bin/bash
#Author: Cihan Mete BAHADIR
#Date: 06.05.2016
#License: Free of anything.

upd=$(ps -ef | grep "update" | wc -l)
upg=$(ps -ef | grep "upgrade" | wc -l)
ins=$(ps -ef | grep "upgrade" | wc -l)
sizeofdisk=$(df -h | grep mmcblk0p1 | awk '{print $5}' | cut -d'%' -f1)

function memo
{
if [ $sizeofdisk -gt 95 ]; then 
                echo  "Its almost full:" 
                echo  "$sizeofdisk"
                process_id=$(ps -fu $USER| grep "apt-get" | grep -v "grep" | awk '{print $2}')
                kill -9 $process_id
                exit 0
else
                echo  "OK"
                echo  "$sizeofdisk"
                exit 1
fi
}

if [[ ("$upd" > 1) || ("$upg" > 1) || ("$ins" > 1) ]]; then 
        memo
        echo "Process killed."
else 
        echo "There is no apt-get process running."
        exit 0
fi

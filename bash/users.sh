#!/bin/bash

echo ""
echo "=== SYSTEM USERS ==="
echo ""

awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | while read user
do
    lastlogin=$(last -1 $user | head -1 | awk '{if (NF > 3) print $4, $5, $6, $7; else print "Never"}')

    if [ -z "$lastlogin" ] || [ "$lastlogin" = "wtmp" ]; then
        lastlogin="Never"
    fi
    
    printf "%-20s %s\n" "$user" "$lastlogin"
done

echo ""

#!/bin/bash

clear
echo "=== DATA CENTER ADMINISTRATION TOOL ==="
echo "1. System users and last login"
echo "2. Disks and filesystems"
echo "3. Top 10 largest files"
echo "4. RAM and Swap memory"
echo "5. Backup to USB"
echo "6. Exit"
echo ""

read -p "Select an option: " option

case $option in
    "1") bash users.sh ;;
    "2") bash disks.sh ;;
    "3") bash files.sh ;;
    "4") bash memory.sh ;;
    "5") bash backup.sh ;;
    "6") echo "Exiting..." ;;
    *) echo "Invalid option" ;;
esc

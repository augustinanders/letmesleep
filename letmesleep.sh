#!/bin/bash

echo "Select a sleep time:"
echo "1. 5:00"
echo "2. 10:00"
echo "3. 15:00"
echo "4. 20:00"
echo "5. 25:00"
echo "6. 30:00"
echo "7. Custom Time"

read -p "Enter the number of your choice: " choice

case $choice in
    1) sleeptime="5:00";;
    2) sleeptime="10:00";;
    3) sleeptime="15:00";;
    4) sleeptime="20:00";;
    5) sleeptime="25:00";;
    6) sleeptime="30:00";;
    7)
        while true; do
            read -p "Enter the sleep time in the format M:S (e.g., 2:20 for 2 minutes and 20 seconds): " custom_time
            if [[ $custom_time =~ ^[0-9]+:[0-9]+$ ]]; then
                sleeptime=$custom_time
                break
            else
                echo "Invalid input. Please enter a valid time in the format M:S."
            fi
        done
        ;;
    *) echo "Invalid choice. Please select a valid option."; exit 1;;
esac

IFS=':' read -r -a timeparts <<< "$sleeptime"
minutes="${timeparts[0]}"
seconds="${timeparts[1]}"

total_seconds=$((minutes * 60 + seconds))

if [[ $total_seconds -le 0 ]]; then
    echo "Invalid input. Please enter a valid time (e.g., 2:20 for 2 minutes and 20 seconds)."
    exit 1
fi

echo "Sleeping for $sleeptime..."
for ((s=total_seconds; s>0; s--)); do
    printf "\rSleeping in %02d:%02d... " $((s / 60)) $((s % 60))
    sleep 1
done

echo -e "\nSleeping for 00:00..."
pmset sleepnow

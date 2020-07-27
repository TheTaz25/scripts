#!/bin/sh

# Time of last login
login=$(last -n1 --time-format iso | head -n1 | tr -s ' ' | cut -d ' ' -f 4)
# Seconds since login
loginsec=$(date -d "$login" +%s)
# Current timestamp
now=$(date +%s)
# Flag for when to add 45 Minutes pause instead of 30 minutes
morepause=540
# get current working time and decide on the pausetime
let "diff = (($now - $loginsec) / 60)" 
pausetime=30
if [ ${diff} -ge ${morepause} ]
then
  pausetime=45
fi

# Recalc the time-difference and get hours and minutes
let "diff = $diff - $pausetime"
let "hours = $diff / 60"
let "minutes = $diff % 60"

# Set the pause label
indicator="(00:$pausetime pause)"

# Print time with leading zeros
if [ ${#minutes} -eq 1 ]
then
  echo "$hours":0"$minutes $indicator"
else 
  echo "$hours":"$minutes $indicator"
fi
echo $diff

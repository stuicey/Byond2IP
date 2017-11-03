#!/bin/bash
## Script to get the most recent tcp opened connection and record its IP into ./data/ips.log

# Change active directory to data/
cd data

# Query netstat and grep for non SSH,DNS or byond ports (20002,6001)
netstat -nt | grep -P ':(?!22)\d+\s+(([\d|\.])+\:(?!(20002|6001|53))\d+)' | awk '{print $5}' > .netstat.log

# Get the different IP address from the netstat logs
IP=$(diff .netstat.log .netstat.log.bak | grep "<" | cut -d" " -f 2)

# Copy the netstat log into a backup so we can check the next itteration
cp .netstat.log .netstat.log.bak

# Finaly save the recorded IP alongwith its name from code.dm 
echo $@#$IP >> ips.log

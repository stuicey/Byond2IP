#!/bin/bash

URL="http://www.byond.com/games/Exadv1/SpaceStation13"

# Download the server listing page 
wget $URL -O /tmp/ss13

# Remove HTML tags
#sed -i.bak 's/<[^>]*>/\n/g' /tmp/ss13

# Get the world addresses
grep -oP 'byond:\/\/BYOND.world.(\d+)' /tmp/ss13 | cut -d"." -f 3 > /tmp/Bwa

# Get the world names
grep -oP '\[(?:\<[a|c].+)?\<b\>(?:(\<a.+\-))?([\w|\s|\.|\[|\|\]]+)' /tmp/ss13 | awk -F'>' '{print $NF}' > /tmp/Bwn

# Merge the two files together
paste -d":" /tmp/Bwn /tmp/Bwa > ../config/worlds.txt

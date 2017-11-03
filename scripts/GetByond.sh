#!/bin/bash
## Script to generate a list of [Server Name]:[World Address] in ./config/worlds.txt from the given Byond Hub $URL

URL="http://www.byond.com/games/Exadv1/SpaceStation13"

# Make sure script is executed in ./scripts
cd "$(dirname "$0")"

# Download the server listing page 
wget $URL -O /tmp/ss13

# Get the world addresses
grep -oP 'byond:\/\/BYOND.world.(\d+)' /tmp/ss13 | cut -d"." -f 3 > /tmp/Bwa

# Get the world names
grep -oP '\[(?:\<[a|c].+)?\<b\>(?:(\<a.+\-))?([\w|\s|\.|\[|\|\]]+)' /tmp/ss13 | awk -F'>' '{print $NF}' > /tmp/Bwn

# Merge the two files together
paste -d":" /tmp/Bwn /tmp/Bwa > ../config/worlds.txt

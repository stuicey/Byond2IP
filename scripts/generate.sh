#!/bin/bash
## A simple wrapper that generates a list of IPs from the byond Hub given in ./scripts/GetByond.sh

# Make sure script is executed in ./scripts
cd "$(dirname "$0")"

# Check the byond hub for new servers
sh GetByond.py

# ./config/worlds.txt should be generated now so lets convert to IP
# Recompile Byond2IP.dm incase of modification
DreamMaker ../Byond2IP.dm
# Run DreamDaemon
DreamDaemon ../Byond2IP.dmb -trusted

#!/bin/bash

# Check the byond hub for new servers
sh GetByond.sh

# ./config/worlds.txt should be generated now so lets convert to IP
# Recompile Byond2IP.dm incase of modification
DreamMaker ../Byond2IP.dm
# Run DreamDaemon
DreamDaemon ../Byond2IP.dmb -trusted

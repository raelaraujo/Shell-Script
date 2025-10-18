#!/bin/bash

set -euo pipefail

# --------------------------------
#               Nmap 
# This shell aims to automate 
#       some scans process
# --------------------------------

USAGE="Usage: ./nmap.sh <target/example>
Example: ./nmap.sh example
Note: run chmod +x nmap.sh before exec
"

# verify args
if [ $# -ne 1 ]; 
then
  echo "$USAGE"
  exit 1
fi
TARGET="$1"

# verify if exists
NMAP=/usr/bin/nmap

if [ -x "$NMAP" ];
then
    echo "$NMAP exists"
else
    echo "Nmap NOT found in /usr/bin/nmap. Installing"
    sudo apt update && sudo apt install -y nmap

    #verify again
    if [ -x "$NMAP" ];
    then 
        echo "$NMAP available"
    else
        echo "Error: nmap isnt available yet"
        exit 1
    fi
fi

#!/bin/bash

set -euo pipefail

# --------------------------------
#               Nmap 
# This shell aims to automate 
#       some scans process
# --------------------------------

USAGE="Usage: ./nmap.sh <target> <Scan Mode>

A: Agressive Scan
S: Stealth scan

Example: ./nmap.sh example.com A

Note: run chmod +x nmap.sh before exec
"

# verify args
if [ $# -ne 2 ]; 
then
  echo "$USAGE"
  exit 1
fi

TARGET="$1"
OUTDIR="nmap_output_$TARGET"
mkdir -p "$OUTDIR"

# verify if exists
NMAP=/usr/bin/nmap

if [ -x "$NMAP" ];
then
    echo "Nmap exists at $NMAP"

else
    echo "Nmap NOT found in /usr/bin/nmap. Installing"
    sudo apt update && sudo apt install -y nmap

    #verify again
    if [ -x "$NMAP" ];
    then 
        echo "Nmap available $NMAP"
    else
        echo "Error: nmap still isnt available"
        exit 1
    fi
fi

if [ "$2" == "A" ];
then
    echo "Startin Agressive scan on $TARGET"
    nmap -sV -sC -T4 $TARGET > $OUTDIR/nmap_agressive_$TARGET.txt
else 
    echo "Startin Stealth scan on $TARGET"
    nmap -sS -sV -T1 --scan-delay 250ms $TARGET > $OUTDIR/nmap_stealth_$TARGET.txt
fi
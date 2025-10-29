#!/bin/bash

set -euo pipefail

# --------------------------------
#             Subd Enum 
# This shell aims to automate 
#       some scans process
# --------------------------------

USAGE="Usage: ./enums.sh <target/example>
Example: ./enums.sh example.com

Note: nice to have some tools:
      - amass
      - subfinder
"

# verify args
if [ $# -ne 1 ];
then
    echo "$USAGE"
    exit 1
fi

DOMAIN="$1"
OUTDIR="enum_output_$DOMAIN"
mkdir -p "$OUTDIR" #-p parents

# verify if exists
AMASS=/snap/bin/amass
SUBFINDER=/usr/local/bin/subfinder

# verify AMASS ENUM
if [ -x "$AMASS" ]; 
then
    echo "Amass found at $AMASS"
else
    echo "Amass not found in /usr/bin/amass. Installing"
    # some distros doesnt uses snap
    echo "= = INSTALLING THROUGHT SNAP= ="
    sudo apt update && sudo snap install amass enum -y
fi

# verify SUBFINDER
if [ -x "$SUBFINDER" ]; then
    echo "Subfinder exists at $SUBFINDER"

    subfinder -d $DOMAIN > "$OUTDIR/subfinder_$DOMAIN.txt"

else
    echo "Subfinder not found in /usr/local/bin/subfinder"
    sudo apt update && sudo apt install subfinder

    # verify again
    if [ -x  "$SUBFINDER"];
    then
        echo "Subfinder avilable $SUBFINDER"
    else
        echo "Error: Subfinder still isnt available"
    fi
fi
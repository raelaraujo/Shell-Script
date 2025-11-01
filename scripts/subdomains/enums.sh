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

enums_scan() {
    subfinder -d $DOMAIN -silent > $OUTDIR/subfinder_$DOMAIN.txt
    amass enum --passive -d $DOMAIN > $OUTDIR/amass_$DOMAIN.txt

    echo "Subdomain enum has been saved in:"
    echo "$OUTDIR/subfinder_$DOMAIN.txt"
    echo "$OUTDIR/amass_$DOMAIN.txt"
}

# verify AMASS ENUM
if [ -x "$AMASS" ]; 
then
    echo "Amass found at $AMASS"
else
    echo "Amass not found in /usr/bin/amass. Installing"
    # some distros doesnt uses snap
    echo "= = INSTALLING THROUGHT SNAP= ="
    sudo apt update && sudo snap install amass -y

    # verify again
    if [ -x $AMASS ];
    then
        echo "Amass available $AMASS"
    else
        echo "Error: Amass still isnt available"
    fi
fi

# verify SUBFINDER
if [ -x "$SUBFINDER" ];
then
    echo "Subfinder exists at $SUBFINDER"

else
    echo "Subfinder not found in /usr/local/bin/subfinder"
    sudo apt update && sudo apt install subfinder

    # verify agai
    if [ -x  "$SUBFINDER"];
    then
        echo "Subfinder avilable $SUBFINDER"
    else
        echo "Error: Subfinder still isnt available"
    fi
fi

enums_scan "$DOMAIN"

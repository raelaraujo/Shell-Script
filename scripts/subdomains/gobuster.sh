#!/bin/bash

set -euo pipefail

# --------------------------------
#               Subd Enum 
# This shell aims to automate 
#       some scans process
# --------------------------------

USAGE="Usage: ./gobuster.sh <target/example>
Example: ./gobuster.sh example.com

Note: nice to have some tools:
      - gobuster
      - SecList

If u doesnt have SecList and wanna install (needs git), type:
./gobuster.sh ISL

"

# verify args
if [ $# -ne 1 ];
then
    echo "$USAGE"
    exit 1
fi

DOMAIN="$1"
OUTDIR="enum_output_$DOMAIN"

if [[ "$1" == "ISL" ]];
then
    if ! command -v git &> /dev/null;
    then        
        echo "Git not found. Installing Git:"
        apt update -y && apt install git -y
    fi
    
    echo "Cloning SecLists:"
    git clone https://github.com/danielmiessler/SecLists.git

    echo "SecLists has been cloned successfully"
    echo "Run again, this time, with domain"

    exit 0
fi

if ! command -v gobuster &> /dev/null;
then
    echo "Error: Gobuster not found. You can install it runnin './gobuster.sh ISL'"
    echo "$USAGE"
    exit 1
fi

gobuster_scan() {
    gobuster dir -u https://"$DOMAIN" -w SecLists/Discovery/subdomains-top1million-20000.txt > "$OUTDIR/gobuster_$DOMAIN.txt"

    echo "Subdomain gobuster has been saved in:"
    echo "$OUTDIR/gobuster_$DOMAIN.txt"
}

gobuster_scan "$DOMAIN"

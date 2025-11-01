#!/bin/bash

set -euo pipefail

# --------------------------------
#               Nmap 
# This shell aims to automate 
#       some scans process
# --------------------------------

USAGE="Usage: ./nmap.sh <target> <Scan Mode>

A: Agressive Scan
D: Default scan
S: Stealth scan
V: vulnerability scan

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

# functions
agressive_scan() {
    echo "Startin Agressive scan on $TARGET"
    # sV - scan version
    # sC - default scripts
    # T4 - faster
    nmap -sV -sC -T4 $TARGET > $OUTDIR/nmap_agressive_$TARGET.txt

    echo "The scan has been saved in $OUTDIR/nmap_agressive_$TARGET.txt"
}

default_scan() {
    echo "Startin Discovery scan on $TARGET"

    nmap $TARGET > $OUTDIR/nmap_discovery_$TARGET.txt

    echo "The scan has been saved in $OUTDIR/nmap_discovery_$TARGET.txt"
}

stealth_scan() {
    echo "Startin Stealth scan on $TARGET"
    # sS - stealth scan
    # sV - scan version
    # T1 - slower
    # scan-delay XXXms - delay between probes
    nmap -sS -sV -T1 --scan-delay 250ms $TARGET > $OUTDIR/nmap_stealth_$TARGET.txt

    echo "The scan has been saved in $OUTDIR/nmap_stealth_$TARGET.txt"
}

vulnerability_scan() {
    echo "Startin Vulnerability scan on $TARGET"
    # script vuln - vulnerability scripts
    nmap --script vuln $TARGET > $OUTDIR/nmap_vuln_$TARGET.txt

    echo "The scan has been saved in $OUTDIR/nmap_vuln_$TARGET.txt"
}

case "$2" in
    "A"|"a")
    agressive_scan "$TARGET"
    ;;
    "S"|"s")
    stealth_scan "$TARGET"
    ;;
    "D"|"d")
    default_scan "$TARGET"
    ;;
    "V"|"v")
    vulnerability_scan "$TARGET"
    ;;
    *)
    echo "Error, scan mode not recognize"
    echo "$CHO"
    exit 1
esac

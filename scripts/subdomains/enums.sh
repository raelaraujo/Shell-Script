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
OUTDIR="enum_output_$(DOMAIN)"
mkdir -p "$OUTDIR"

# verify if exists
AMASS=/snap/bin/amass
SUBFINDER=/usr/local/bin/subfinder

if [ -x ]
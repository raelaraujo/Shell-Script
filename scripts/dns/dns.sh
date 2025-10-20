#!/bin/bash

set -euo pipefail

# --------------------------------
#              DNS 
# This shell aims to automate 
#       some scans process
# --------------------------------

USAGE="Usage: ./dns.sh <target/example>
Example: ./dns.sh example.com
Note: run chmod +x dns.sh before exec
"

# verify args
if [ $# -ne 1 ]; 
then
    echo "$USAGE"
    exit 1
fi

# verify if exists
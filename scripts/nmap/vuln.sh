#!/bin/bash

set -euo pipefail

# --------------------------------
#         Vulnerabilitys 
# This shell aims to automate 
#       some scans process
# --------------------------------

USAGE="Usage: ./vuln.sh <target/example>
Example: ./vuln.sh example.com
"

if [ $# -ne 1 ];
then
    echo "$USAGE"
    exit 1
fi
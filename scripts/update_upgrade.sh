#!/bin/bash

update_upgrade() {
    echo "- - - UPDATE - - -"
    echo ""
    sudo apt update -y
    echo ""

    echo "- - - UPGRADE - - -"
    echo ""
    sudo apt upgrade -y
    echo ""

    echo "- - - AUTOREMOVE && AUTORCLEAN - - -"
    echo ""
    sudo apt autoremove && sudo apt autoclean
    echo ""
}

update_upgrade

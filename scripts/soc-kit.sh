#!/bin/bash

USAGE="Usage: ./soc-kit.sh e/d"

if [ $# -ne 1 ];
then
    echo "$USAGE"
    exit 1
fi

enable_kit()
{
    echo "Enable kit"
    sudo systemctl start suricata \
                         wazuh-indexer \
                         wazuh-manager \
                         wazuh-dashboard

    sudo /opt/splunk/bin/splunk start --run-as-root
    sudo /opt/splunkforwarder/bin/splunk start

    sudo systemctl status suricata \
                          splunk \
                          splunkforwarder \
                          wazuh-indexer \
                          wazuh-manager \
                          wazuh-dashboard
}

disable_kit()
{
    echo "Disable kit"
    sudo systemctl stop suricata \
                        wazuh-indexer \
                        wazuh-manager \
                        wazuh-dashboard

    sudo /opt/splunk/bin/splunk stop --run-as-root
    sudo /opt/splunkforwarder/bin/splunk stop

    sudo systemctl status suricata \
                          splunk \
                          splunkforwarder \
                          wazuh-indexer \
                          wazuh-manager \
                          wazuh-dashboard
}

case "$1" in
    "E"|"e")
        enable_kit
        ;;
    "D"|"d")
        disable_kit
        ;;
    *)
        echo "$USAGE"
        exit 1
        ;;
esac

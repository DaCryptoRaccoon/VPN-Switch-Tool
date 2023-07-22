#!/bin/bash

# Check if the script was invoked with an argument (either "udp", "tcp", or "random") to set the mode
if [ "$1" == "udp" ]; then
    MODE="udp"
elif [ "$1" == "tcp" ]; then
    MODE="tcp"
elif [ "$1" == "random" ]; then
    MODE="random"
else
    echo "Usage: $0 [udp|tcp|random]"
    exit 1
fi

while true; do

    # Get the list of VPN connections based on the selected mode
    if [ "$MODE" == "udp" ]; then
        vpn_connections=$(nmcli --mode tabular --fields name,type,timestamp con | grep -E "\s+vpn\s+" | grep -i "udp" | sort -k3)
    elif [ "$MODE" == "tcp" ]; then
        vpn_connections=$(nmcli --mode tabular --fields name,type,timestamp con | grep -E "\s+vpn\s+" | grep -i "tcp" | sort -k3)
    elif [ "$MODE" == "random" ]; then
        vpn_connections=$(nmcli --mode tabular --fields name,type,timestamp con | grep -E "\s+vpn\s+" | sort -k3)
    fi

    test=$(nmcli con show --active | grep -c vpn)

    # Possible results:
    # 0 - No VPN connected. Start one
    # 1 - VPN connected. Disable the running connection and start a new one, beginning with the earliest used

    case $test in

        "0")
            # If there are no VPNs connected, start the earliest VPN in the list for the selected mode
            first_vpn=$(echo "$vpn_connections" | head -n1 | awk '{print $1}')
            nmcli con up "$first_vpn"
            echo "Connecting to VPN: $first_vpn."
            ;;

        "1")
            # If there is a VPN connected, switch to the next VPN in the list for the selected mode
            current_vpn=$(nmcli con show --active | grep vpn | awk '{print $1}')
            nmcli con down id "$current_vpn"

            # Find the next VPN in the list
            if [ "$MODE" == "random" ]; then
                next_vpn=$(echo "$vpn_connections" | shuf -n1 | awk '{print $1}')
            else
                next_vpn=$(echo "$vpn_connections" | awk -v current="$current_vpn" 'BEGIN { found=0 } { if (found==1) {print $1; exit} } $1==current {found=1}' )
                if [ -z "$next_vpn" ]; then
                    # If there is no next VPN in the list, start the earliest one
                    next_vpn=$(echo "$vpn_connections" | head -n1 | awk '{print $1}')
                fi
            fi

            nmcli con up "$next_vpn"
            echo "Switched VPN. Connecting to VPN: $next_vpn."
            ;;

    esac

    # Get the connection speed and proxy information
    connection_info=$(nmcli con show "$next_vpn")
    connection_speed=$(nmcli connection show "$next_vpn" | grep "GENERAL.DEVICES" | awk '{print $2}')
    proxy_info=$(nmcli connection show "$next_vpn" | grep "proxy.method:" | awk '{print $2}')

    echo "Proxy Info: $proxy_info"

    sleep 120 # Wait for 2 minutes before running the script again

done


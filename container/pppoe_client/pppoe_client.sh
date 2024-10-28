#!/bin/bash

# Define the filename and path
FILE_PATH="/etc/ppp/peers/dsl_vgu"
PAP_PATH="/etc/ppp/pap-secrets"

# Check if the script is being run with root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root."
  exit 1
fi

# Determine the current machine name
MACHINE_NAME=$(hostname)

# Extract the number from the machine name (gtw[x])
if [[ "$MACHINE_NAME" =~ gtw([0-9]+) ]]; then
    NUMBER="${BASH_REMATCH[1]}"
    USER_NAME="user$NUMBER"
    PASS="pass$NUMBER"
else
    echo "Machine name does not match expected format: gtw[x]"
    exit 1
fi

# Check for the existence of the network interfaces
E1_INTERFACE="e1-1"
ETH_INTERFACE="eth1"

if ifconfig | grep -q "$E1_INTERFACE"; then
    NIC="nic-$E1_INTERFACE"
elif ifconfig | grep -q "$ETH_INTERFACE"; then
    NIC="nic-$ETH_INTERFACE"
else
    echo "No suitable network interface found: $E1_INTERFACE or $ETH_INTERFACE."
    exit 1
fi

# Create or overwrite the file with the desired configuration
cat <<EOL > "$FILE_PATH"
noipdefault
defaultroute
replacedefaultroute
hide-password
#lcp-echo-interval 30
#lcp-echo-failure 4
noauth
persist
#mtu 1492
#persist
#maxfail 0
#holdoff 20
plugin rp-pppoe.so
$NIC
user "$USER_NAME"
usepeerdns
EOL

cat <<EOL > "$PAP_PATH"
"$USER_NAME" * "$PASS" *
EOL

# Inform the user that the file has been created
echo "Configuration file created at $FILE_PATH with user: $USER_NAME and NIC: $NIC"

# DNS server
cat <<EOL > /etc/resolve.conf
nameserver 20.20.20.100
EOL
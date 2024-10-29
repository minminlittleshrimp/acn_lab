#!/bin/bash

# Function to format and display the content of the file with borders
format_output() {
    echo -e " _______________________________ "
    echo -e "|      PPPoE Server Options     |"
    echo -e "|-------------------------------|"

    while IFS= read -r line; do
        printf "| %-29s |\n" "$line"
        sleep 0.5
    done < /etc/ppp/pppoe-server-options

    echo -e "+-------------------------------+"
}

{
    format_output
} &

pid=$!
wait $pid
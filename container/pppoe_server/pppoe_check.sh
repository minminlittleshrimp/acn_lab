#!/bin/bash

# Function to format and display the content of the file with borders
format_output() {
    echo -e "+-------------------------------+"
    echo -e "|      PPPoE Server Options     |"
    echo -e "|-------------------------------|"

    while IFS= read -r line; do
        printf "| %-29s |\n" "$line"
        sleep 0.5
    done < /etc/ppp/pppoe-server-options
    echo -e "+-------------------------------|"
    echo -e "|PO/Architect: Minh, Luu Quang  |"
    echo -e "|Dev: Nam, Truong Hoang         |"
    echo -e "|Scrum: Thu, Mai Thi Hang       |"
    echo -e "|Test: Hao, Ho Vinh             |"
    echo -e "+-------------------------------+"
}

{
    format_output
} &

pid=$!
wait $pid

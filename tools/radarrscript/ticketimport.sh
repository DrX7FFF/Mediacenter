#!/bin/bash
set -u
ticketpath="/data/Servarr/Tickets"

if [ -z "$1" ]; then
    echo "Usage: $0 <ticket_file_name>"
    exit 1
fi

ticketfile="$ticketpath/$1"
if [ ! -f "$ticketfile" ]; then
    echo "Ticket file not found: $ticketfile"
    exit 1
fi

source "$ticketfile"
source "onimport.sh"

#!/bin/bash

# https://wiki.servarr.com/radarr/custom-scripts

logfile="/data/Servarr/radarr_event.log"
ticketpath="/data/Servarr/Tickets"
destinationpath="/data/Films"

echo "$(date) : ${radarr_eventtype}" >> "$logfile"

mkdir -p $ticketpath

if [[ "${radarr_eventtype}" == "Test" ]]; then
    ticketname="Fake Movie ($(date))"
else
    ticketname="${radarr_movie_title} (${radarr_movie_year}).mkv"
fi

ticketfile="$ticketpath/$ticketname.txt"

echo "ticketname=\"$ticketname\"" > "$ticketfile"
echo "title=\"${radarr_movie_title}\"" >> "$ticketfile"
echo "year=\"${radarr_movie_year}\"" >> "$ticketfile"
echo "sourcepath=\"${radarr_moviefile_sourcepath}\"" >> "$ticketfile"
echo "sourcefolder=\"${radarr_moviefile_sourcefolder}\"" >> "$ticketfile"
echo "isupgrage=\"${radarr_isupgrade}\"" >> "$ticketfile"
echo "quality=\"${radarr_moviefile_quality}\"" >> "$ticketfile"
echo "deletedpaths=\"${radarr_deletedpaths}\"" >> "$ticketfile"
echo "destinationpath=\"$destinationpath\"" >> "$ticketfile"

echo "$(date) : Created '$ticketfile'" >> "$logfile"

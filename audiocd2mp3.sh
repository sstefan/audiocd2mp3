#!/bin/bash
CDDEV=/dev/scd0
TRACKS=`cdda-player -l $CDDEV |grep seconds`
cdda-player -s $CDDEV
IFS="
"
for line in $TRACKS; do
 sleep 5
 echo "READING: $line."
 B={${line%% seconds*};
 seconds=${B##*[}
 track=${line%%:*}
 track=${track## }
 echo "Track $track, $seconds seconds."
 cdda-player -t $track-$track $CDDEV
 arecord -f cd -d $seconds - | \
 lame -b 128 - $track.mp3
done

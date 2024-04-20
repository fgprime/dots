#!/bin/bash
LOGFILE=~/.pomodoro.log
SCRIPTDIR=`dirname $0`

echo -e ";" >> $LOGFILE
printf '%s,' "$(date +'%Y-%m-%d,%H:%M')" >> $LOGFILE

timer.sh 25*60

printf '%s' "$(date +'%H:%M')" >> $LOGFILE

afplay "$SCRIPTDIR/done.mp3"  -v 0.9

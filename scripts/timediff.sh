#!/bin/bash
set -euo pipefail

line=$(</dev/stdin)

if [ -n "$line" ]; then
	# Data was piped to this script.
	start="$(echo "$line" | cut -d' ' -f1)"
	end="$(echo "$line" | cut -d' ' -f3)"
else
	# Data was given as parameter
	if [[ -n "$1" ]] && [[ -n "$2" ]]; then
		start=$1
		end=$3
	else
		echo "No input given!"
	fi
fi

StartDate=$(gdate -u -d "$start" +"%s")
FinalDate=$(gdate -u -d "$end" +"%s")
diff=$(gdate -u -d "0 $FinalDate sec - $StartDate sec" +"%H:%M")
echo "$line $diff"

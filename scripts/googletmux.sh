#!/bin/bash
echo "Google"
read input
encoded=$(printf %s "$input" | jq -sRr @uri)
open "https://google.de/search?q=$encoded"

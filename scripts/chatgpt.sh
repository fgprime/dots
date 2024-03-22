#!/bin/bash
echo "ChatGPT"
read input
encoded=$(printf %s "$input" | jq -sRr @uri)
open "https://chat.openai.com/chat?q=$encoded"

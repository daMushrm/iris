#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo "${YELLOW}Do you want to auto start remind on startup? [y/N]:${NC}"
read choice

if [ "$choice" = "y" ] || [ "$choice" = "Y" ]; then
  while true; do
    echo "${BLUE}Enter the reminder interval in minutes (between 5 and 120):${NC}"
    read interval
    if [ "$interval" -ge 5 ] && [ "$interval" -le 120 ]; then
      break
    else
      echo "${RED}[!] Invalid interval. Please enter a value between 5 and 120.${NC}"
      echo "${YELLOW}[!] Press Ctrl+C to cancel.${NC}"
    fi
  done

  sed -i '/iris/d' ~/.profile
  echo "iris -r $interval" >> ~/.profile
  
  echo "${GREEN}[!] Iris is enabled to run at startup, beginning from next login.${NC}"
else
  echo "${YELLOW}[!] Skipping startup configuration.${NC}"
fi

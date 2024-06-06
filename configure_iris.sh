#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo "${YELLOW}Do you want to auto start remind on startup? [y/n]:${NC}"
read choice

if [ "$choice" = "y" ]; then
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

  echo "${BLUE}Creating iris.desktop file...${NC}"
  SERVICE_FILE="$HOME/.config/autostart/iris.desktop"
  
  touch $SERVICE_FILE
  echo "[Desktop Entry]" | sudo tee $SERVICE_FILE
  echo "Version=1.0" | sudo tee -a $SERVICE_FILE
  echo "Comment=Run iris at startup" | sudo tee -a $SERVICE_FILE
  echo "Exec=/usr/bin/iris -r $interval" | sudo tee -a $SERVICE_FILE
  echo "Terminal=false" | sudo tee -a $SERVICE_FILE
  echo "Type=Application" | sudo tee -a $SERVICE_FILE
  echo "Categories=Utility;" | sudo tee -a $SERVICE_FILE

  echo "${GREEN}[!] Iris is enabled to run at startup, beginning from next login.${NC}"
else
  echo "${YELLOW}[!] Skipping startup configuration.${NC}"
fi

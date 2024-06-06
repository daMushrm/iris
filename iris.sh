#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# logic for each flag
help() {
    echo -e "${BLUE}Usage: $(basename "$0") [OPTIONS] [ARGUMENTS]${NC}"
    echo ""
    echo "Options:"
    echo -e "  ${YELLOW}-h, --help${NC}             Display this help message"
    echo -e "  ${YELLOW}-w, --warm    [VALUE]${NC}  Adjust the color temperature (range: 1-10)"
    echo -e "  ${YELLOW}-d, --dim     [VALUE]${NC}  Adjust the brightness level (range: 1-10)"
    echo -e "  ${YELLOW}-r, --remind  [VALUE]${NC}  Set a reminder interval in minutes (range: 5-120)"
    echo -e "                         Run 'iris -r stop' to stop the reminder"
    echo -e "  ${YELLOW}-i, --inverse${NC}          Enable inverted colors"
    echo -e "  ${YELLOW}-n, --normal${NC}           Restore default color settings"
    echo ""
    echo "Examples:"
    echo -e "  ${YELLOW}$(basename "$0") -w 5 -d 3 -i -r 15${NC}"
    echo -e "  ${YELLOW}$(basename "$0") --warm 5 --dim 3 --inverse --remind 15${NC}"
    exit 0
}

warm() {
    if [[ ! $1 =~ ^[1-9]$|^10$ ]]; then
        echo -e "${RED}[x] Error: Warm value must be between 1 and 10${NC}"
        exit 1
    fi

    xcalib -clear
    xcalib -blue 1.8 0 $1 -alter
}

dim() {
    if [[ ! $1 =~ ^[0-9]$ ]]; then
        echo -e "${RED}[x] Error: Dim value must be between 1 and 10${NC}"
        exit 1
    fi

    xcalib -clear
    xcalib -co $(( (10 - ($1 - 1)) * 10 )) -alter
}

inverse() {
    xcalib -i -a
}

normal() {
    xcalib -clear
    exit
}

remind() {
    habits=(
        "Take a break and rest your eyes."
        "Get up and stretch for a minute."
        "Drink some water to stay hydrated."
        "Adjust your sitting posture."
        "Look away from the screen for a moment."
        "Take a deep breath and relax."
        "Close your eyes and relax for a moment."
        "Relax your shoulders and release tension."
    )

    while true; do
        # Randomly select a habit from the list
        reminder=${habits[$RANDOM % ${#habits[@]}]}
        sleep $1
        notify-send -t 5000 "Iris" "$reminder"
    done
} 

remind_option=0
remind_value_in_sec=0
remind_value_in_min=0

# Check if no arguments or flags are provided
if [[ $# -eq 0 ]]; then
    help
fi

# Parse command-line options
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -h|--help)
            help
            ;;
        -w|--warm)
            warm $2
            shift 2
            ;;
        -d|--dim)
            dim $2
            shift 2
            ;;
        -i|--inverse)
            if [[ $2 && $2 != -* ]]; then
                echo -e "${RED}[x] Error: The '-i' or '--inverse' flag does not take any arguments${NC}"
                echo -e "${YELLOW}[!] Run -h or --help for more information${NC}"
                exit 1
            fi
            inverse
            shift 1
            ;;
        -n|--normal)
            if [[ $2 && $2 != -* ]]; then
                echo -e "${RED}[x] Error: The '-n' or '--normal' flag does not take any arguments${NC}"
                echo -e "${YELLOW}[!] Run -h or --help for more information${NC}"
                exit 1
            fi
            normal
            shift 1
            ;;
        -r|--remind)
            remind_option=1
            remind_value_in_min=$2
            remind_value_in_sec=$(( $2 * 60 ))
            shift 2
            ;;
        -*)
            echo -e "${RED}[x] Unknown option: $1${NC}"
            help
            ;;
        *)
            echo -e "${RED}[x] Unknown parameter: $1${NC}"
            help
            ;;
    esac
done

# Run remind if remind option is enabled
if [[ $remind_option -eq 1 ]]; then
    if [[ $remind_value_in_min == "stop" ]]; then
        echo -e "${YELLOW}[!] Iris is no longer reminding you${NC}"
        pkill iris
        exit 0
    elif [[ ! $remind_value_in_min =~ ^[5-9]$|^1[0-9]$|^120$ ]]; then
        echo -e "${RED}[x] Error: Remind value must be between 5 and 120 minutes${NC}"
        exit 1
    fi
    echo -e "${GREEN}[!] Iris is now reminding you every $remind_value_in_min minutes${NC}"
    read -p "Do you want to automatically run this script on startup? (y/N): " auto_run
    if [[ $auto_run == "y" ]]; then
        # logic here
        echo -e "${GREEN}[!] Automatically running Iris on startup${NC}"
        # write a good explanation
        # check if the script is already in the startup folder
        cp "$(readlink -f "$0")" /etc/init.d/
        ln -s /etc/init.d/iris.sh /etc/rc.d/
        # You may need to adjust the paths and commands based on your system configuration
    fi
    fi
    echo -e "${YELLOW}[!] Run 'iris -r stop' to stop the reminder${NC}"
    remind $remind_value_in_sec &
fi

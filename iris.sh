#!/bin/bash

# logic for each flag
help() {
    echo "Usage: $0 [OPTIONS] [ARGUMENTS]"
    echo "Options:"
    echo "  -h, --help             Show help message"
    echo "  -w, --warm    [VALUE]  Set warm value (1~10)"
    echo "  -d, --dim     [VALUE]  Set dim value (1~10)"
    echo "  -r, --remind  [VALUE]  Set remind interval in minutes (5~120)"
    echo "  -i, --inverse          Activate inverted colors"
    echo "  -n, --normal           Restore normal colors"
    echo "Example:"
    echo "  $0 -w 5 -d 3 -i -r 15"
    echo "  $0 --warm 5 --dim 3 --inverse -remind 15"
    exit 0
}

warm() {
    if [[ ! $1 =~ ^[1-9]$|^10$ ]]; then
        echo "[x] Error: Warm value must be between 1 and 10"
        exit 1
    fi

    xcalib -clear
    xcalib -blue 1.8 0 $1 -alter
}

dim() {
    if [[ ! $1 =~ ^[0-9]$ ]]; then
        echo "[x] Error: Dim value must be between 1 and 10"
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
                echo "[x] Error: The '-i' or '--inverse' flag does not take any arguments"
                echo "[!] Run -h or --help for more information"
                exit 1
            fi
            inverse
            shift 1
            ;;
        -n|--normal)
            if [[ $2 && $2 != -* ]]; then
                echo "[x] Error: The '-n' or '--normal' flag does not take any arguments"
                echo "[!] Run -h or --help for more information"
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
            echo "[x] Unknown option: $1"
            help
            ;;
        *)
            echo "[x] Unknown parameter: $1"
            help
            ;;
    esac
done

if [[ $remind_option -eq 1 ]]; then
    if [[ $remind_value_in_min == "stop" ]]; then
        echo "[!] Iris is no longer reminding you"
        pkill iris
        exit 0
    elif [[ ! $remind_value_in_min =~ ^[5-9]$|^1[0-9]$|^120$ ]]; then
        echo "[x] Error: Remind value must be between 5 and 120 minutes"
        exit 1
    fi
    echo "[!] Iris is now reminding you every $remind_value_in_min minutes"
    remind $remind_value_in_sec &
fi
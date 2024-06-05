#!/bin/bash

# Display usage information
display_help() {
    echo "Usage: $0 [help | warm | dim | inv | off | remind]"
    echo
    echo "Options:"
    echo "  ❓    help   Show this help message and exit"
    echo "  🌞    warm   Apply a warm color temperature to the screen"
    echo "  🌑    dim    Make the screen darker"
    echo "  🌈    inv    Invert the screen colors"
    echo "  🔄    off    Return to normal screen settings"
    echo "  ⏰    remind Start a reminder every 15 minutes"
}

# Show help if -h or no argument is provided
if [ "$1" == "help" ] || [ -z "$1" ]; then
    display_help
    exit
fi

# Return to normal settings
if [ "$1" == "off" ]; then
    xcalib -clear
    exit
fi

# Invert screen colors
if [ "$1" == "inv" ]; then
    xcalib -i -a
    exit
fi

# Make the screen darker
if [ "$1" == "dim" ]; then
    xcalib -clear
    xcalib -co 30 -alter
    exit
fi

# Apply warm color temperature
if [ "$1" == "warm" ]; then
    xcalib -clear
    xcalib -co 90 -alter
    xcalib -blue 1.8 0 50 -alter
    exit
fi

# Start a reminder every 15 minutes
if [ "$1" == "remind" ]; then
    habits=(
        "Take some rest."
        "walk around for a minute."
        "Stretch for a bit."
        "Drink some water."
        "Adjust your posture."
        "Look away from the screen for a minute."
        "Take a deep breath."
        "Close your eyes for a moment."
        "Relax your shoulders."
    )

    while true; do
        # Randomly select a habit from the list
        reminder=${habits[$RANDOM % ${#habits[@]}]}
        sleep 5
        echo "[!] $reminder"
        notify-send -t 5000 "Iris" "$reminder"
    done
    exit
fi


# If an unknown option is provided, show help
display_help
exit 1

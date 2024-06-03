#!/bin/bash

# Display usage information
display_help() {
    echo "Usage: $0 [help | warm | dim | inv | off]"
    echo
    echo "Options:"
    echo "  ❓    help  Show this help message and exit"
    echo "  🌞    warm  Apply a warm color temperature to the screen"
    echo "  🌑    dim   Make the screen darker"
    echo "  🌈    inv   Invert the screen colors"
    echo "  🔄    off   Return to normal screen settings"
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

# If an unknown option is provided, show help
display_help
exit 1

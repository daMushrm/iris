![image](https://github.com/M1ghtyMushroom/iris/assets/149011900/dbe11902-c337-4309-99c0-ab945bc72d21)

Iris.sh is a bash script that provides a simple command-line interface for adjusting your screen's color temperature and brightness. It's perfect for those late-night coding sessions when you want to reduce eye strain.

# Usage
To use iris.sh, simply run the script with one of the following options:

```bash
./iris.sh [help | warm | dim | inv | off]
```
```bash
Options:
  ❓    help  Show this help message and exit
  🌞    warm  Apply a warm color temperature to the screen
  🌑    dim   Make the screen darker
  🌈    inv   Invert the screen colors
  🔄    off   Return to normal screen settings
```

# Dependencies
This script depends on `xcalib`, a tiny utility to modify monitor color profiles. You can install it using your package manager. For example, on Ubuntu:

```bash
sudo apt-get install xcalib
```

# Contributing
Contributions are welcome! Please feel free to submit a Pull Request.

## TODO
* intensity control
* periodic break reminder


# Iris 👀

Iris is a versatile shell script designed to enhance your screen experience by providing convenient color temperature adjustment, brightness control, color inversion, and periodic reminders for taking breaks. This user-friendly tool aims to reduce eye strain and promote healthy habits while working on your computer. 💻

## Features 🌟

- **Adjust Color Temperature**: Change the color temperature of your screen to reduce eye strain and create a more comfortable viewing environment. 🌇
- **Adjust Brightness**: Modify the brightness level of your screen for optimal visibility in different lighting conditions. 💡
- **Invert Colors**: Invert the colors of your display for improved readability or accessibility purposes. ⚫⚪
- **Reminders**: Set periodic reminders to take breaks, stretch, or engage in other healthy activities to prevent eye strain and promote overall well-being. 🕰️
- **Restore Default Settings**: Easily revert back to the default screen settings with a single command. ⚙️

## Installation 🚀

### Prerequisites

Ensure you have `xcalib`, `libnotify`, and `make` installed on your system. You can install them using the following command:

```bash
sudo apt-get install xcalib libnotify make
```

### Steps

1. Clone the repository:

   ```bash
   git clone https://github.com/M1ghtyMushroom/iris.git
   cd iris
   ```

2. Install the script:

   ```bash
   make install
   ```

   You will be prompted to run the reminder option on startup. Proceed with `y` and select your desired time interval to set it up.

## Usage 🎮

Run the `iris` command with the appropriate options:

```
Usage: iris [OPTIONS] [ARGUMENTS]
Options:
  -h, --help             Display this help message
  -w, --warm    [VALUE]  Adjust the color temperature (range: 1-10)
  -d, --dim     [VALUE]  Adjust the brightness level (range: 1-10)
  -r, --remind  [VALUE]  Set a reminder interval in minutes (range: 5-120)
                         Run 'iris -r stop' to stop the reminder
  -i, --inverse          Enable inverted colors
  -n, --normal           Restore default color settings
```

### Examples 💻

- Adjust the color temperature to 5, brightness to 3, enable inverted colors, and set a reminder every 15 minutes:

  ```bash
  iris -w 5 -d 3 -i -r 15
  ```

- Restore default screen settings:

  ```bash
  iris -n
  ```

- Stop the reminder:

  ```bash
  iris -r stop
  ```

## Uninstallation ⚠️

To uninstall Iris and remove its auto-start configuration, run:

```bash
make delete
```

## Contributing 🤝

Contributions are welcome! If you find a bug or have a feature request, please open an issue or submit a pull request.

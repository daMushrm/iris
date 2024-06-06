![image](https://github.com/M1ghtyMushroom/iris/assets/149011900/0ea262aa-b6fd-4b91-bbda-6cf768230bcb)

# Iris

This script allows you to adjust your screen settings and set reminders for healthy habits. You can change the screen's color temperature, invert colors or dim the screen. Additionally, you can set a reminder to receive health tips every 15 minutes.
It's perfect for those late-night coding sessions when you want to reduce eye strain.

## Installation

1. Clone the repo.
2. Run `make install`
3. You will be asked if you want to have iris remind work at startup, `y` for yes `n` for no 

## Usage

```bash
$ iris [help | warm | dim | inv | off | remind]
```

## Options

| Option    | Description                                                    |
| --------- | -------------------------------------------------------------- |
| ❓ help   | Show this help message and exit                                |
| 🌞 warm   | Apply a warm color temperature to the screen                   |
| 🌑 dim    | Make the screen darker                                         |
| 🌈 inv    | Invert the screen colors                                       |
| 🔄 off    | Return to normal screen settings                               |
| ⏰ remind | Start a reminder every 15 minutes with tips for healthy habits |

## Example

```bash
$ iris warm
```

This command will apply a warm color temperature to the screen.

```bash
$ iris remind
```

This command will start a reminder that notifies you every 15 minutes with a healthy habit tip.

## Dependencies

- `make` for installation/deletion script
- `xcalib` for adjusting screen settings
- `libnotify` for desktop notifications

Make sure you have these installed on your system.

## License

This script is released under the MIT License.

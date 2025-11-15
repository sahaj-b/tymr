# tymr
A stateful, general purpose timer/alarm CLI. It runs in the background, survives reboots, and understands human time.


## Features

- **Fire-and-forget:** Timers run in the background by default. No need to keep a terminal open.
- **Smart Time Parsing:** Understands `5m`, `2h30m`, `17:30`, `8:00pm`, `+2 days 14:00`, and more (anything `date` understands).
- **Stateful:** Timers/Alarms are tracked. `tymr` provides commands to list, cancel, or revive them (from a reboot).
- **Stopwatch Mode:** `tymr -s` counts up until you `Ctrl+C`.
- **Notifications:** Uses `notify-send` when a timer is up.
- **Sound Alarm:** Plays a looping sound until the notification is dismissed.
- **Configurable:** Set your own sound files, default volume, or even custom player commands in `~/.config/tymr/config`.

## Installation
This is a Bash script, so installation is simple:
```bash
git clone https://github.com/sahaj-b/tymr
cd tymr
sudo mv tymr /usr/local/bin/tymr
```

### Auto-Revive on Reboot (Systemd)
Timers survive reboots, but their processes are killed. Use `--revive` flag to:  
- Revive/Start the processes
- Notify for expired timers (when the system was off)

You can either autostart `tymr --revive` via your DE/WMs autostart settings, or use systemd service as shown below.
#### Setting up systemd service for auto-revive on startup
```bash
# Copy the systemd service file in this repo to user directory
mkdir -p ~/.config/systemd/user/
cp tymr-revive.service ~/.config/systemd/user/tymr-revive.service

# Enable & start the service
systemctl --user daemon-reload
systemctl --user enable --now tymr-revive
```

##  Dependencies
- `date` (GNU coreutils version, usually pre-installed on Linux)
- `notify-send` (from `libnotify` or similar)
- **For sound (optional):** `paplay`, `ffplay`, or `mpv`. `tymr` auto-detects them.

##  Usage

```
USAGE:
  timer [OPTIONS] TIME/DURATION [TIMER_NAME]

OPTIONS:
  -s, --stopwatch         Run as stopwatch (counts up)
  -f, --foreground        Run timer in foreground
  -n, --no-sound          Disable alarm sound
  -S, --sound-file PATH   Custom sound file to loop
  -v, --volume VOL        Set volume (1-100)
  -h, --help              Show this help message

TIMER MANAGEMENT:
  -l, --list                 List active timers
  -d, --delete PID_OR_NAME   Delete timer by PID or Timer Name
  -r, --revive               Revive killed timers' processes

TIME/DURATION FORMATS:
  Plain seconds:    300, 1500, etc.
  Duration format:  5m, 2h30m, 1d12h, etc.
  Date/time format: '10:30', '10:30am', 'next Friday 14:00', '+2 days 5:00pm', etc.
  See 'date --help' for more information on valid date/time formats.
```

### Stopwatch
```bash
tymr -s
```

### Starting Timers
```bash
# Start a 25-minute timer named "Pomodoro" (runs in background)
tymr 25m "Pomodoro"

# Start a timer for 2 hours, 6 minutes, and 9 seconds
tymr 2h6m9s

# Watch the timer in the foreground (useful for debugging)
tymr -f 5s "Foreground test"

# Pomodoro
while true; do
  tymr -f 25m "Break"
  tymr -f 5m "Work"
done
```

### Setting Alarms
```bash
# Set an alarm for 17:30 today
tymr 17:30 "Evening Alarm"

# Set an alarm for 8:00pm tomorrow
tymr 'Tomorrow 8:00pm' "Attend meeting"

# Use any time formats that `date` understands
# you can check by running `date -d 'your time string'`
tymr 'next Friday 14:00' "Friday standup"
tymr '+2 days 5:00pm' "Review deadline"
tymr 'December 25 00:00' "Christmas"

# Mix with custom options
tymr -v 75 18:30 "Volume 75%, alarm at 18:30"
tymr -n 25m "Silent focus mode"
tymr -S /path/to/myAlarm.wav 10m "Custom sound alarm"
```

### Managing Timers
```bash
# List all active timers with time remaining
tymr -l

# Delete a specific timer by name or PID
tymr -d "Pomodoro"
tymr -d 12345
```

### Configuration File
Create `~/.config/tymr/config` to set defaults.  
[default-config.sh](default-config.sh):
```bash
# Default configuration for tymr
FOREGROUND=false # Run timers in foreground by default
NO_SOUND=false   # Disable sound by default
SOUND_FILE=""    # Path to custom sound file, eg: "/path/to/sound.wav"
VOLUME=""        # Default volume

STATE_FILE="$HOME/.cache/tymr_state" # File to store timers' state
DELIMITER="|"                        # Delimiter for separating fields in the state file, must not be in timer names

# Sound player configuration. paplay, ffplay and mpv are already supported.
PLAYER_CMD=""           # Command to play sound
PLAYER_VOL_FLAG=""      # Volume flag for the player command (eg, "--volume ")
PLAYER_VOL_MULTIPLIER=1 # Multiplier for volume
```

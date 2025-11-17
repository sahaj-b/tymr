# Default configuration for tymr
FOREGROUND=false # Run timers in foreground by default
NO_SOUND=false   # Disable sound by default
SOUND_FILE=""    # Path to custom sound file, eg: "/path/to/sound.wav"
VOLUME=""        # Default volume
TIMEOUT=0        # Notification/sound timeout in seconds, 0 means no timeout

STATE_FILE="$HOME/.cache/tymr_state" # File to store timers' state
DELIMITER="|"                        # Delimiter for separating fields in the state file, must not be in timer names

# Sound player configuration. paplay, ffplay and mpv are already supported.
PLAYER_CMD=""           # Command to play sound
PLAYER_VOL_FLAG=""      # Volume flag for the player command (eg, "--volume ")
PLAYER_VOL_MULTIPLIER=1 # Multiplier for volume

NTFY_TOPIC="" # Default notification topic for ntfy.sh

# Default configuration for tymr

FOREGROUND=false
NO_SOUND=false
SOUND_FILE=""
VOLUME=""

STATE_FILE="$HOME/.cache/tymr_state" # File to store timers' state
DELIMITER="|"                        # Delimiter for separating fields in the state file, must not be in timer names

# Sound player configuration. paplay, ffplay and mpv are already supported.
PLAYER_CMD=""           # Command to play sound
PLAYER_VOL_FLAG=""      # Volume flag for the player command (eg, "--volume ")
PLAYER_VOL_MULTIPLIER=1 # Multiplier for volume

#!/bin/bash
# ~/.config/shell/host.sh - Host-specific settings

# ==============================================================================
# The hostname of the current machine is used to select the correct settings.
# This is sourced by other scripts to apply environment-specific configurations.
# ==============================================================================
hostname=$(hostname)

# Default settings
# This pattern is used by sanity-check to find the correct audio sink.
# It should be a regex substring of the sink's description from `pactl list sinks`.
HOST_AUDIO_SINK_PATTERN="Speaker"

case $hostname in
    "darkstar" | "darkstar25")
        # Dell Laptop settings
        HOST_AUDIO_SINK_PATTERN="Built-in Audio Analog Stereo"
        ;;

    "derkling5")
        # ThinkPad settings
        # No specific audio sink override needed, default is fine.
        ;;

    *)
        # Default case for unknown hosts can go here if needed
        ;;
esac

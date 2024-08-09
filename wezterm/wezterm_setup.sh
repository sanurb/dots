#!/usr/bin/env bash

set -euo pipefail

CONFIG_FILE=".wezterm.lua"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
SRC_FILE="$SCRIPT_DIR/$CONFIG_FILE"
DEST_FILE="${HOME}/${CONFIG_FILE}"

# Helper function to print status messages
print_status() {
    echo -e "\033[1;34m$1\033[0m"
}

copy_config_file() {
    if [[ ! -f "$SRC_FILE" ]]; then
        echo "Error: Source configuration file $SRC_FILE does not exist."
        exit 1
    fi

    if [[ -f "$DEST_FILE" ]]; then
        print_status "Updating existing Wezterm configuration at $DEST_FILE..."
    else
        print_status "Creating configuration directory at $CONFIG_DIR..."
        mkdir -p "$CONFIG_DIR"
    fi

    print_status "Copying $CONFIG_FILE to $DEST_FILE..."
    cp "$SRC_FILE" "$DEST_FILE"

    print_status "Wezterm configuration installed/updated successfully."
}

main() {
    copy_config_file
}

main
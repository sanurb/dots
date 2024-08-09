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

ensure_src_file_exists() {
    if [[ ! -f "$SRC_FILE" ]]; then
        print_status "Source configuration file $SRC_FILE does not exist."
        print_status "Creating a default source configuration file at $SRC_FILE..."
        touch "$SRC_FILE"
    fi
}

copy_config_file() {
    ensure_src_file_exists

    if [[ -f "$DEST_FILE" ]]; then
        print_status "Updating existing Wezterm configuration at $DEST_FILE..."
    fi

    print_status "Copying $CONFIG_FILE to $DEST_FILE..."
    cp "$SRC_FILE" "$DEST_FILE"

    print_status "Wezterm configuration installed/updated successfully."
}

main() {
    copy_config_file
}

main
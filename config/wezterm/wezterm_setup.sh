#!/usr/bin/env bash

set -euo pipefail

CONFIG_FILE=".wezterm.lua"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
SRC_FILE="$SCRIPT_DIR/$CONFIG_FILE"
DEST_FILE="${HOME}/${CONFIG_FILE}"

print_status() {
    echo -e "\033[1;34m$1\033[0m"
}

ensure_src_file_exists() {
    if [[ ! -f "$SRC_FILE" ]]; then
        print_status "Source configuration file $SRC_FILE does not exist. Creating a default configuration."
        echo "# Default Wezterm configuration" > "$SRC_FILE"
    fi
}

copy_config_file() {
    ensure_src_file_exists

    if [[ -f "$DEST_FILE" ]]; then
        if cmp -s "$SRC_FILE" "$DEST_FILE"; then
            print_status "The destination file $DEST_FILE is already up to date. No action needed."
        else
            print_status "Updating existing Wezterm configuration at $DEST_FILE..."
            cp "$SRC_FILE" "$DEST_FILE"
            print_status "Wezterm configuration updated successfully."
        fi
    else
        print_status "Copying $CONFIG_FILE to $DEST_FILE..."
        cp "$SRC_FILE" "$DEST_FILE"
        print_status "Wezterm configuration installed successfully."
    fi
}

main() {
    copy_config_file
}

main

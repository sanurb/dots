#!/usr/bin/env bash

set -euo pipefail

CONFIG_DIR="${HOME}/.config/wezterm"
CONFIG_FILE=".wezterm.lua"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
SRC_FILE="$SCRIPT_DIR/$CONFIG_FILE"
DEST_FILE="$CONFIG_DIR/$CONFIG_FILE"

# Helper function to print status messages
print_status() {
    echo -e "\033[1;34m$1\033[0m"
}

handle_existing_file() {
    local dest_file="$1"

    print_status "Wezterm configuration file already exists at $dest_file."
    echo "What would you like to do?"
    echo "  [1] Overwrite the existing file"
    echo "  [2] Create a backup of the existing file"
    echo "  [3] Keep the existing file and cancel installation"
    read -p "Enter your choice [1-3]: " choice

    case "$choice" in
        1)
            print_status "Overwriting the existing configuration..."
            ;;
        2)
            local backup_file="${dest_file}.bak_$(date +%Y%m%d%H%M%S)"
            print_status "Creating a backup at $backup_file..."
            mv "$dest_file" "$backup_file"
            ;;
        3)
            echo "Installation cancelled. Keeping the existing configuration."
            exit 0
            ;;
        *)
            echo "Invalid choice. Installation aborted."
            exit 1
            ;;
    esac
}

copy_config_file() {
    if [[ ! -f "$SRC_FILE" ]]; then
        echo "Error: Source configuration file $SRC_FILE does not exist."
        exit 1
    fi

    if [[ -f "$DEST_FILE" ]]; then
        handle_existing_file "$DEST_FILE"
    else
        print_status "Creating configuration directory at $CONFIG_DIR..."
        mkdir -p "$CONFIG_DIR"
    fi

    print_status "Copying $CONFIG_FILE to $DEST_FILE..."
    cp "$SRC_FILE" "$DEST_FILE"

    print_status "Wezterm configuration installed successfully."
}

main() {
    copy_config_file
}

main

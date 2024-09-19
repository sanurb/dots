#!/usr/bin/env bash

set -euo pipefail

CONFIG_DIR="$HOME/.config/git"
GIT_REPO_BASE_URL="https://raw.githubusercontent.com/sanurb/dots/main/config/git"

install_ignore_file() {
    mkdir -p "$CONFIG_DIR"
    local ignore_file_url="$GIT_REPO_BASE_URL/ignore"

    curl -fsSL "$ignore_file_url" -o "$CONFIG_DIR/ignore"
    if [[ -f "$CONFIG_DIR/ignore" ]]; then
        echo "Global gitignore file downloaded and installed in $CONFIG_DIR/ignore"
    else
        echo "Failed to download gitignore file." >&2
        exit 1
    fi
}

configure_git_globals() {
    git config --global user.name "David Urbano"
    git config --global color.ui true
    git config --global push.default simple
    git config --global pull.rebase true
    git config --global remote.origin.prune true
    git config --global commit.verbose true
    git config --global diff.algorithm patience
    git config --global diff.compactionHeuristic true

    echo "Git global configurations applied."
}

configure_git_aliases() {
    set +u
    declare -A aliases=(
        ["amend"]="commit --amend"
        ["ci"]="commit -v"
        ["co"]="checkout"
        ["cpick"]="cherry-pick"
        ["empty"]="commit --allow-empty -m 'Trigger notification'"
        ["flush"]="clean -fd"
        ["flush-all"]="clean -fdx"
        ["mail"]="config user.email"
        ["main"]="!git stash && git co main && git pull && git prune-local && git stash pop"
        ["sts"]="status -s"
        ["prune-local"]="!git branch -vv | awk '/: gone]/{print \$1}' | xargs git branch -d"
        ["uncommit"]="reset --soft HEAD^"
        ["wipe"]="!git add -A && git commit -qm 'WIPE SAVEPOINT' && git reset HEAD~1 --hard"
        ["prune-merged"]="!git branch --merged main | grep -v \"\* main\" | xargs -n 1 git branch -d"
        ["prev"]="checkout HEAD^1"
        ["next"]="!sh -c 'git log --reverse --pretty=%H | awk \"/$(git rev-parse HEAD)/{getline;print}\" | xargs git checkout'"
        ["authors"]="!git shortlog -sn --all --no-merges"
        ["count-lines"]="!sh -c 'git log --author=\"$1\" --pretty=tformat: --numstat | awk \"{ add += \$1; subs += \$2; loc += \$1 - \$2 } END { printf \\\"added lines: %s, removed lines: %s, total lines: %s\\\", add, subs, loc }\"'"
        ["latest-tag"]="describe --tags --abbrev=0"
    )
    set -u

    for alias in "${!aliases[@]}"; do
        git config --global alias.$alias "${aliases[$alias]}"
    done

    echo "Git aliases configured."
}

configure_git_tools() {
    git config --global merge.tool nano
    git config --global merge.conflictstyle diff3
    git config --global diff.tool nano
    git config --global difftool.prompt false
    git config --global alias.review "!f() { git difftool --tool=kdiff3 --dir-diff \$1..; }; f"

    if [[ $(uname -s) == MINGW* ]]; then
        git config --global core.autocrlf true
    else
        git config --global credential.helper osxkeychain
    fi

    echo "Git merge and diff tools configured."
}

install_ignore_file
configure_git_globals
configure_git_aliases
configure_git_tools

echo "Git setup completed successfully."

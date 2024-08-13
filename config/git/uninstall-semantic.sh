#!/usr/bin/env bash

set -euo pipefail

unregister_git_alias() {
    local alias_name=$1
    if git config --global --get-all alias."$alias_name" &>/dev/null; then
        git config --global --unset alias."$alias_name"
        echo "Alias $alias_name unregistered."
    else
        echo "Alias $alias_name not found. Skipping."
    fi
}

uninstall_semantic_commits() {
    local semantic_aliases=('chore' 'docs' 'feat' 'fix' 'localize' 'perf' 'refactor' 'style' 'test')

    for alias in "${semantic_aliases[@]}"; do
        unregister_git_alias "$alias"
    done

    local compatibility_aliases=('ch' 'rf' 'c' 'd' 'f' 'p' 'x' 'l' 'r' 's' 't')

    for alias in "${compatibility_aliases[@]}"; do
        unregister_git_alias "$alias"
    done
}

echo "Uninstalling semantic commits aliases..."
uninstall_semantic_commits
echo "Semantic commits aliases uninstallation completed."

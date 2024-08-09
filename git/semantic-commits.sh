#!/usr/bin/env bash

set -euo pipefail

register_git_alias() {
    local alias_name=$1
    local custom_command=${2:-}

    if ! git config --global --get-all alias."$alias_name" &>/dev/null; then
        if [[ -z $custom_command ]]; then
            git config --global alias."$alias_name" \
                '!f() { [[ -z "$GIT_PREFIX" ]] || cd "$GIT_PREFIX" && if [ "$#" == 0 ]; then git commit -m "'$alias_name': " --edit; elif [ "$#" == 2 ]; then git commit -m "'$alias_name'(${1}): ${@:2}"; else git commit -m "'$alias_name': ${@}"; fi }; f'
        else
            git config --global alias."$alias_name" "!git $custom_command"
        fi
        echo "Alias $alias_name registered."
    else
        echo "Alias $alias_name already exists. Skipping."
    fi
}

install_semantic_commits() {
    local semantic_aliases=('chore' 'docs' 'feat' 'fix' 'localize' 'perf' 'refactor' 'style' 'test')

    for alias in "${semantic_aliases[@]}"; do
        register_git_alias "$alias"
    done

    declare -A compatibility_aliases=(
        ["ch"]="chore"
        ["rf"]="refactor"
        ["c"]="chore"
        ["d"]="docs"
        ["f"]="feat"
        ["p"]="perf"
        ["x"]="fix"
        ["l"]="localize"
        ["r"]="refactor"
        ["s"]="style"
        ["t"]="test"
    )

    for alias in "${!compatibility_aliases[@]}"; do
        register_git_alias "$alias" "${compatibility_aliases[$alias]}"
    done
}

echo "Installing semantic commits aliases..."
install_semantic_commits
echo "Semantic commits setup completed. See https://github.com/fteem/git-semantic-commits for more details."

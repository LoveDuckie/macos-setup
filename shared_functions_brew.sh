#!/bin/bash
<<EOF

    LDK \ Shell Scripts \ Shared Functions (Brew)

    A collection of reusable scripts and functions.

EOF
[ -n "${SHARED_FUNCTIONS_BREW_EXT}" ] && return
SHARED_FUNCTIONS_BREW_EXT=0
CURRENT_SCRIPT_DIRECTORY_FUNCTIONS=$(dirname $(realpath ${BASH_SOURCE[0]:-${(%):-%x}}))
export SHARED_EXT_SCRIPTS_PATH=$(realpath ${SHARED_EXT_SCRIPTS_PATH:-$CURRENT_SCRIPT_DIRECTORY_FUNCTIONS})
export REPO_ROOT_PATH=${REPO_ROOT_PATH:-$(realpath $SHARED_EXT_SCRIPTS_PATH/../../)}
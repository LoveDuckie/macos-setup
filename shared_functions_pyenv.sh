#!/bin/bash
<<EOF

    LDK \ Shell Scripts \ Shared Functions PyEnv

    A collection of reusable scripts and functions.

EOF
[ -n "${SHARED_FUNCTIONS_PYENV}" ] && return
SHARED_FUNCTIONS_PYENV=0
CURRENT_SCRIPT_DIRECTORY_FUNCTIONS=$(dirname $(realpath ${BASH_SOURCE[0]:-${(%):-%x}}))
export SHARED_EXT_SCRIPTS_PATH=$(realpath ${SHARED_EXT_SCRIPTS_PATH:-$CURRENT_SCRIPT_DIRECTORY_FUNCTIONS})
. $CURRENT_SCRIPT_DIRECTORY_FUNCTIONS/shared_functions.sh

is_pyenv_installed() {
    if [[ "$(type -t pyenv)" != "" ]] && [[ "$(command -v pyenv)" != "" ]]; then
        ldk_write_info "shared-functions-pyenv" "pyenv is installed on this machine"
        return 0
    fi
    return 1
}

is_pyenv_python_version_installed() {
    if [ -z "$1" ]; then
        ldk_write_error "shared-functions" "python version number was not defined."
        return 1
    fi

    if ! is_command_available "pyenv"; then
        ldk_write_error "shared-functions" "failed to find pyenv"
        return 2
    fi

    if ! pyenv prefix $1 >/dev/null 2>&1; then
        return 3
    fi
    return 0
}
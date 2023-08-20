#!/bin/bash
<<EOF

    LDK \ Shell Scripts \ Shared Functions Keychain

    A collection of reusable scripts and functions.

EOF
[ -n "${SHARED_FUNCTIONS_KEYCHAIN}" ] && return
SHARED_FUNCTIONS_KEYCHAIN=0
CURRENT_SCRIPT_DIRECTORY_FUNCTIONS=$(dirname $(realpath ${BASH_SOURCE[0]:-${(%):-%x}}))
export SHARED_EXT_SCRIPTS_PATH=$(realpath ${SHARED_EXT_SCRIPTS_PATH:-$CURRENT_SCRIPT_DIRECTORY_FUNCTIONS})
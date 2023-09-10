#!/bin/bash
<<EOF

   LDK \ Shell Scripts \ macOS \ Setup Poetry

   A script for installing Poetry (for Python) on the macOS system.

EOF
CURRENT_SCRIPT_DIRECTORY=${CURRENT_SCRIPT_DIRECTORY:-$(dirname $(realpath ${BASH_SOURCE[0]:-${(%):-%x}}))}
export SHARED_EXT_SCRIPTS_PATH=${SHARED_EXT_SCRIPTS_PATH:-$(realpath $CURRENT_SCRIPT_DIRECTORY/)}
export CURRENT_SCRIPT_FILENAME=${CURRENT_SCRIPT_FILENAME:-$(basename $0)}
export CURRENT_SCRIPT_FILENAME_BASE=${CURRENT_SCRIPT_FILENAME%.*}
. "$SHARED_EXT_SCRIPTS_PATH/shared_functions.sh"
write_header

if ! is_command_available python; then
    write_error "setup_poetry" "Python is not installed on this system. Unable to continue."
    exit 1
fi

if is_command_available poetry; then
    write_error "setup_poetry" "Poetry appears to already be installed on this system."
    exit 2
fi

write_info "setup_poetry" "Installing: Poetry"
curl -sSL https://install.python-poetry.org | python -

. ~/.profile

if ! is_command_available poetry; then
    write_error "setup_poetry" "Failed: Unable to install Poetry"
    exit 3
fi

write_success "setup_poetry" "done"
exit 0

#!/bin/bash
<<EOF

   LDK \ Shell Scripts \ macOS \ Setup Poetry

   A script for installing Poetry (for Python) on the macOS system.

EOF
CURRENT_SCRIPT_DIRECTORY=${CURRENT_SCRIPT_DIRECTORY:-$(dirname $(realpath $0))}
export SHARED_EXT_SCRIPTS_PATH=${SHARED_EXT_SCRIPTS_PATH:-$(realpath $CURRENT_SCRIPT_DIRECTORY/)}
export CURRENT_SCRIPT_FILENAME=${CURRENT_SCRIPT_FILENAME:-$(basename $0)}
export CURRENT_SCRIPT_FILENAME_BASE=${CURRENT_SCRIPT_FILENAME%.*}
. "$SHARED_EXT_SCRIPTS_PATH/shared_functions.sh"
write_header

if is_command_available poetry; then
    write_error "setup_poetry" "Poetry appears to already be installed on this system."
    return 1
fi

write_success "setup_poetry" "done"
return 0
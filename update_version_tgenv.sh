#!/bin/bash
<<EOF

   LDK \ Shell Scripts \ Setup \ Update Version tgenv

   

EOF
CURRENT_SCRIPT_DIRECTORY=${CURRENT_SCRIPT_DIRECTORY:-$(dirname $(realpath ${BASH_SOURCE[0]:-${(%):-%x}}))}
export SHARED_EXT_SCRIPTS_PATH=${SHARED_EXT_SCRIPTS_PATH:-$(realpath $CURRENT_SCRIPT_DIRECTORY/)}
export CURRENT_SCRIPT_FILENAME=${CURRENT_SCRIPT_FILENAME:-$(basename $0)}
export CURRENT_SCRIPT_FILENAME_BASE=${CURRENT_SCRIPT_FILENAME%.*}
. "$SHARED_EXT_SCRIPTS_PATH/shared_functions.sh"
write_header

TGENV_VERSION_FILE_PATH=$CURRENT_SCRIPT_DIRECTORY/config/tgenv/version

INSTALLED_VERSION=$(tgenv list | sed -nE 's/\* ([0-9]+\.[0.9]+\.[0-9]+) .*/\1/p')

if [[ "$INSTALLED_VERSION" != "" ]]; then
    write_info "update_version_tgenv" "Updating: \"$TGENV_VERSION_FILE_PATH\""
fi

write_success "update_version_tgenv" "Done"
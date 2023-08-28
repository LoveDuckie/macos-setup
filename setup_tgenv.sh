#!/bin/bash
<<EOF

   LDK \ Shell Scripts \ Setup \ tgenv

   

EOF
CURRENT_SCRIPT_DIRECTORY=${CURRENT_SCRIPT_DIRECTORY:-$(dirname $(realpath ${BASH_SOURCE[0]:-${(%):-%x}}))}
export SHARED_EXT_SCRIPTS_PATH=${SHARED_EXT_SCRIPTS_PATH:-$(realpath $CURRENT_SCRIPT_DIRECTORY/)}
export CURRENT_SCRIPT_FILENAME=${CURRENT_SCRIPT_FILENAME:-$(basename $0)}
export CURRENT_SCRIPT_FILENAME_BASE=${CURRENT_SCRIPT_FILENAME%.*}
. "$SHARED_EXT_SCRIPTS_PATH/shared_functions.sh"
write_header

write_info "setup_tgenv" "Installing: Terragrunt with \"tgenv\""

write_info "setup_tgenv" "Retrieving latest version of Terragrunt..."
LATEST_VERSION=$(tgenv list-remote | head -n 1)

write_info "setup_tgenv" "Installing: \"$LATEST_VERSION\""
tgenv install $LATEST_VERSION
write_info "setup_tgenv" "Using: \"$LATEST_VERSION\""
tgenv use $LATEST_VERSION

write_success "setup_tgenv" "Done"
exit 0
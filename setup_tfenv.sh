#!/bin/bash
<<EOF

   LDK \ Shell Scripts \ Setup \ tfenv

   Install and configure "tfenv" on this system.

EOF
CURRENT_SCRIPT_DIRECTORY=${CURRENT_SCRIPT_DIRECTORY:-$(dirname $(realpath ${BASH_SOURCE[0]:-${(%):-%x}}))}
export SHARED_EXT_SCRIPTS_PATH=${SHARED_EXT_SCRIPTS_PATH:-$(realpath $CURRENT_SCRIPT_DIRECTORY/)}
export CURRENT_SCRIPT_FILENAME=${CURRENT_SCRIPT_FILENAME:-$(basename $0)}
export CURRENT_SCRIPT_FILENAME_BASE=${CURRENT_SCRIPT_FILENAME%.*}
. "$SHARED_EXT_SCRIPTS_PATH/shared_functions.sh"
write_header

write_info "setup_tfenv" "Installing: Terraform with \"tfenv\""

write_info "setup_tfenv" "Retrieving latest version of Terraform..."
LATEST_VERSION=$(tfenv list-remote | head -n 1)

write_info "setup_tfenv" "Installing: $LATEST_VERSION"
tfenv install $LATEST_VERSION
tfenv use $LATEST_VERSION

write_success "setup_tfenv" "Done"
exit 0
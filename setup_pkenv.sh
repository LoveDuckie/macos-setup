#!/bin/bash
<<EOF

   LDK \ Shell Scripts \ Setup \ pkenv

   

EOF
CURRENT_SCRIPT_DIRECTORY=${CURRENT_SCRIPT_DIRECTORY:-$(dirname $(realpath ${BASH_SOURCE[0]:-${(%):-%x}}))}
export SHARED_EXT_SCRIPTS_PATH=${SHARED_EXT_SCRIPTS_PATH:-$(realpath $CURRENT_SCRIPT_DIRECTORY/)}
export CURRENT_SCRIPT_FILENAME=${CURRENT_SCRIPT_FILENAME:-$(basename $0)}
export CURRENT_SCRIPT_FILENAME_BASE=${CURRENT_SCRIPT_FILENAME%.*}
. "$SHARED_EXT_SCRIPTS_PATH/shared_functions.sh"
write_header

write_info "setup_pkenv" "Installing: Packer with \"pkenv\""

LATEST_VERSION=$(pkenv list-remote | head -n 1)


pkenv install $LATEST_VERSION
pkenv use $LATEST_VERSION

write_success "setup_pkenv" "Done"
exit 0
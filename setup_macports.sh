#!/bin/bash
<<EOF

   LDK \ Shell Scripts \ macOS \ Setup MacPorts

   A script for configuring and installing Mac ports.

EOF
CURRENT_SCRIPT_DIRECTORY=${CURRENT_SCRIPT_DIRECTORY:-$(dirname $(realpath $0))}
export SHARED_EXT_SCRIPTS_PATH=${SHARED_EXT_SCRIPTS_PATH:-$(realpath $CURRENT_SCRIPT_DIRECTORY/)}
export CURRENT_SCRIPT_FILENAME=${CURRENT_SCRIPT_FILENAME:-$(basename $0)}
export CURRENT_SCRIPT_FILENAME_BASE=${CURRENT_SCRIPT_FILENAME%.*}
. "$SHARED_EXT_SCRIPTS_PATH/shared_functions.sh"
write_header

MACPORTS_PKG_INSTALLER_PATH=https://github.com/macports/macports-base/releases/download/v2.8.1/MacPorts-2.8.1-13-Ventura.pkg
write_info "setup_macports" "Installing MacPorts"
curl -L -f "https://github.com/macports/macports-base/releases/download/v2.8.1/MacPorts-2.8.1-13-Ventura.pkg" --silent --output ~/Downloads/macports.pkg
if ! write_response "setup_macports" "Download MacPorts: PKG"; then
    write_error "setup_macports" "Failed: unable to download the MacPorts installer package."
fi

write_info "setup_macports" "Installing: MacPorts"
installer -pkg ~/Downloads/macports.pkg -target /

write_success "setup_macports" "Done"
exit 0
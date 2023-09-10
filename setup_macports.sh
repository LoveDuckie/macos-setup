#!/bin/bash
<<EOF

   LDK \ Shell Scripts \ macOS \ Setup MacPorts

   A script for configuring and installing Mac ports.

EOF
CURRENT_SCRIPT_DIRECTORY=${CURRENT_SCRIPT_DIRECTORY:-$(dirname $(realpath ${BASH_SOURCE[0]:-${(%):-%x}}))}
export SHARED_EXT_SCRIPTS_PATH=${SHARED_EXT_SCRIPTS_PATH:-$(realpath $CURRENT_SCRIPT_DIRECTORY/)}
export CURRENT_SCRIPT_FILENAME=${CURRENT_SCRIPT_FILENAME:-$(basename $0)}
export CURRENT_SCRIPT_FILENAME_BASE=${CURRENT_SCRIPT_FILENAME%.*}
. "$SHARED_EXT_SCRIPTS_PATH/shared_functions.sh"
write_header

MACPORTS_PKG_INSTALLER_URL=https://github.com/macports/macports-base/releases/download/v2.8.1/MacPorts-2.8.1-13-Ventura.pkg
MACPORTS_PKG_DOWNLOAD_PATH=$(realpath ~/Downloads/macports.pkg)
write_info "setup_macports" "Installing MacPorts"
curl -L -f "$MACPORTS_PKG_INSTALLER_URL" --silent --output $MACPORTS_PKG_DOWNLOAD_PATH
if ! write_response "setup_macports" "Download MacPorts: PKG"; then
    write_error "setup_macports" "Failed: unable to download the MacPorts installer package."
fi

write_info "setup_macports" "Installing: MacPorts"
installer -pkg $MACPORTS_PKG_DOWNLOAD_PATH -target /
if ! write_response "setup_macports" "Install: MacPorts"; then
    write_error "setup_macports" "Failed: Unable to install the MacPorts package on this system."
    write_error "setup_macports" "Package: \"$MACPORTS_PKG_DOWNLOAD_PATH\""
fi

if ! is_command_available port; then
    write_error "setup_macports" "Failed: Unable to install MacPorts"
    exit 1
fi


write_success "setup_macports" "Done"
exit 0
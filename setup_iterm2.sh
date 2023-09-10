#!/bin/bash
<<EOF

   LDK \ Shell Scripts \ macOS \ Setup iTerm2

   Restore the configuration for iTerm2

EOF
CURRENT_SCRIPT_DIRECTORY=${CURRENT_SCRIPT_DIRECTORY:-$(dirname $(realpath ${BASH_SOURCE[0]:-${(%):-%x}}))}
export SHARED_EXT_SCRIPTS_PATH=${SHARED_EXT_SCRIPTS_PATH:-$(realpath $CURRENT_SCRIPT_DIRECTORY/)}
export CURRENT_SCRIPT_FILENAME=${CURRENT_SCRIPT_FILENAME:-$(basename $0)}
export CURRENT_SCRIPT_FILENAME_BASE=${CURRENT_SCRIPT_FILENAME%.*}
. "$SHARED_EXT_SCRIPTS_PATH/shared_functions.sh"
write_header

ITERM2_CONFIG_FILE_PATH=$CURRENT_SCRIPT_DIRECTORY/config/iterm2/com.googlecode.iterm2.plist

if [ ! -e $ITERM2_CONFIG_FILE_PATH ]; then
   write_error "setup_iterm2" "Failed: Unable to find the preference file for iTerm2."
   exit 1
fi

write_info "setup_iterm2" "Restoring: Configuration for iTerm2"
mv "$ITERM2_CONFIG_FILE_PATH" ~/Library/Preferences/com.googlecode.iterm2.plist

write_success "setup_iterm2" "Done"
exit 0
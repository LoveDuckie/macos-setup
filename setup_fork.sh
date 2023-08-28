#!/bin/bash
<<EOF

   LDK \ Shell Scripts \ macOS \ Setup Fork

   A script for configuring Fork with custom commands

EOF
CURRENT_SCRIPT_DIRECTORY=${CURRENT_SCRIPT_DIRECTORY:-$(dirname $(realpath ${BASH_SOURCE[0]:-${(%):-%x}}))}
export SHARED_EXT_SCRIPTS_PATH=${SHARED_EXT_SCRIPTS_PATH:-$(realpath $CURRENT_SCRIPT_DIRECTORY/)}
export CURRENT_SCRIPT_FILENAME=${CURRENT_SCRIPT_FILENAME:-$(basename $0)}
export CURRENT_SCRIPT_FILENAME_BASE=${CURRENT_SCRIPT_FILENAME%.*}
. "$SHARED_EXT_SCRIPTS_PATH/shared_functions.sh"
write_header

FORK_CONFIG_PATH="$HOME/Library/Application Support/com.DanPristupov.Fork"

write_info "setup_fork" "Fork Configuration Path: \"$FORK_CONFIG_PATH\""

CUSTOM_COMMANDS_CONFIG_FILE_PATH=$CURRENT_SCRIPT_DIRECTORY/config/fork/custom-commands.json

write_warning "setup_fork" "Creating Fork Configuration: $FORK_CONFIG_PATH"
mkdir -p $FORK_CONFIG_PATH
write_info "setup_fork" "Copying Custom Commands Configuration: $CUSTOM_COMMANDS_CONFIG_FILE_PATH"
cp -f "$CUSTOM_COMMANDS_CONFIG_FILE_PATH" "$FORK_CONFIG_PATH/$(basename $CUSTOM_COMMANDS_CONFIG_FILE_PATH)"


write_success "setup_fork" "Done"

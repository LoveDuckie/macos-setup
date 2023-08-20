#!/bin/bash
<<EOF

   LDK \ Shell Scripts \ macOS \ Setup Homebrew

   A script for installing Homebrew on this system.

EOF
CURRENT_SCRIPT_DIRECTORY=${CURRENT_SCRIPT_DIRECTORY:-$(dirname $(realpath $0))}
export SHARED_EXT_SCRIPTS_PATH=${SHARED_EXT_SCRIPTS_PATH:-$(realpath $CURRENT_SCRIPT_DIRECTORY/)}
export CURRENT_SCRIPT_FILENAME=${CURRENT_SCRIPT_FILENAME:-$(basename $0)}
export CURRENT_SCRIPT_FILENAME_BASE=${CURRENT_SCRIPT_FILENAME%.*}
. "$SHARED_EXT_SCRIPTS_PATH/shared_functions.sh"
write_header

if is_command_available brew; then
   write_warning "setup_homebrew" "Homebrew is already configured and ready to use."
   return 1
fi

write_info "setup_homebrew" "Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

write_info "setup_homebrew" "Loading: Brew"
eval "$(/opt/homebrew/bin/brew shellenv)"

if ! is_command_available brew; then
   write_error "setup_homebrew" "Failed: Unable to install Homebrew Package Manager on the system."
   exit 1
fi

write_success "setup_homebrew" "Done"
exit 0
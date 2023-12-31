#!/bin/bash
<<EOF

   LDK \ Shell Scripts \ macOS \ Setup

   Setup macOS from nothing.

EOF
CURRENT_SCRIPT_DIRECTORY=${CURRENT_SCRIPT_DIRECTORY:-$(dirname $(realpath ${BASH_SOURCE[0]:-${(%):-%x}}))}
export SHARED_EXT_SCRIPTS_PATH=${SHARED_EXT_SCRIPTS_PATH:-$(realpath $CURRENT_SCRIPT_DIRECTORY/)}
export CURRENT_SCRIPT_FILENAME=${CURRENT_SCRIPT_FILENAME:-$(basename $0)}
export CURRENT_SCRIPT_FILENAME_BASE=${CURRENT_SCRIPT_FILENAME%.*}
. "$SHARED_EXT_SCRIPTS_PATH/shared_functions.sh"
write_header

SETUP_SCRIPTS=(setup_homebrew.sh setup_fonts.sh setup_ssh.sh setup_sudoers.sh
    setup_pyenv.sh setup_poetry.sh setup_nvm.sh setup_macports.sh setup_macports_php.sh
setup_zsh.sh setup_iterm2.sh setup_goenv.sh)

for script in setup*.sh; do
    write_info "setup" "Running \"$script\""
    . $CURRENT_SCRIPT_DIRECTORY/$script
done

write_success "setup" "Done"

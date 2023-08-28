#!/bin/bash
<<EOF

   LDK \ Shell Scripts \ macOS \ Setup Sudoers

   A script for updating sudoers on the system.

EOF
CURRENT_SCRIPT_DIRECTORY=${CURRENT_SCRIPT_DIRECTORY:-$(dirname $(realpath ${BASH_SOURCE[0]:-${(%):-%x}}))}
export SHARED_EXT_SCRIPTS_PATH=${SHARED_EXT_SCRIPTS_PATH:-$(realpath $CURRENT_SCRIPT_DIRECTORY/)}
export CURRENT_SCRIPT_FILENAME=${CURRENT_SCRIPT_FILENAME:-$(basename $0)}
export CURRENT_SCRIPT_FILENAME_BASE=${CURRENT_SCRIPT_FILENAME%.*}
. "$SHARED_EXT_SCRIPTS_PATH/shared_functions.sh"
write_header

is_sudoers_configured() {
    if [ -e /etc/sudoers.d/$(whoami) ] && [[ "$(cat /etc/sudoers.d/$(whoami))" == *"$(whoami)"* ]]; then
        return 0
    fi
    return 1
}

configure_sudoers() {
    if is_sudoers_configured; then
        write_warning "setup_sudoers" "sudoers already configured (\"/etc/sudoers.d/$(whoami)\")"
        exit 1
    fi
    echo "$(whoami) ALL=(ALL:ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers.d/$(whoami) >/dev/null 2>&1
    return 0
}

write_info "setup_sudoers" "checking sudoers configuration..."
if is_sudoers_configured; then
    write_warning "setup_sudoers" "sudoers already configured!"
    exit 0
fi

if ! configure_sudoers; then
    write_error "setup_sudoers" "failed to configure sudoers"
    exit 1
fi

write_success "setup_sudoers" "done"
return 0
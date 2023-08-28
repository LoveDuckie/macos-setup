#!/bin/bash
<<EOF

    LDK \ Shell Scripts \ Shared Functions

    A collection of reusable scripts and functions.

EOF
[ -n "${SHARED_FUNCTIONS_EXT}" ] && return
SHARED_FUNCTIONS_EXT=0
CURRENT_SCRIPT_DIRECTORY_FUNCTIONS=$(dirname $(realpath ${BASH_SOURCE[0]:-${(%):-%x}}))
export SHARED_EXT_SCRIPTS_PATH=$(realpath ${SHARED_EXT_SCRIPTS_PATH:-$CURRENT_SCRIPT_DIRECTORY_FUNCTIONS})
export REPO_ROOT_PATH=${REPO_ROOT_PATH:-$(realpath $SHARED_EXT_SCRIPTS_PATH/../../)}

type -f write_info >/dev/null 2>&1 && unset -f write_info
type -f write_error >/dev/null 2>&1 && unset -f write_error
type -f write_success >/dev/null 2>&1 && unset -f write_success
type -f write_critical >/dev/null 2>&1 && unset -f write_critical
type -f write_response >/dev/null 2>&1 && unset -f write_response
type -f write_warning >/dev/null 2>&1 && unset -f write_warning
type -f write_header >/dev/null 2>&1 && unset -f write_header
type -f write_header_sub >/dev/null 2>&1 && unset -f write_header_sub
type -f is_command_available >/dev/null 2>&1 && unset -f is_command_available

export OPTIONS_LOG_SHOW_HEADER=1

reload_profile() {
    if [[ $SHELL == *"zsh"* ]]; then
        return 1
    elif [[ $SHELL == *"bash"* ]]; then
        return 1
    fi
    
    return 0
}

is_mac() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        return 0
    fi
    return 1
}

is_mac_arm() {
    if [[ `uname -m` == 'arm64' ]] && is_mac; then
        return 0
    fi

    return 1
}

is_mac_x86() {
    if [[ `uname -m` == 'x86_64' ]] && is_mac; then
        return 0
    fi

    return 1
}


is_ubuntu() {
    if is_command_available "lsb_release" && [[ "$(lsb_release --description -s)" == *"Ubuntu"* ]]; then
        return 0
    fi
    return 1
}

is_wsl() {
    if [[ "$(uname -r)" == *"WSL"* ]]; then
        return 0
    fi

    return 1
}

write_header_sub() {
    if [ ! -z "$CURRENT_SCRIPT_FILENAME" ]; then
        echo ""
        write_info "*** SCRIPT: $(echo \"${CURRENT_SCRIPT_FILENAME%.*}\" | awk '{print toupper($0)}')"
        echo ""
    fi

    return 0
}

write_header() {
    if [[ "$OPTIONS_LOG_SHOW_HEADER" == "1" ]] && [ -z "$HEADER_OUTPUT" ] && [ -e "$SHARED_EXT_SCRIPTS_PATH/script-header" ]; then
        if [ ! -z "$HEADER_OUTPUT_LOLCAT" ]; then
            cat $SHARED_EXT_SCRIPTS_PATH/script-header | lolcat
        else
            echo -e "\033[1;37m$(cat $SHARED_EXT_SCRIPTS_PATH/script-header)\033[0m"
        fi
    fi

    export HEADER_OUTPUT=1

    write_header_sub

    return 0
}

write_info() {
    MSG=$2
    echo -e "\033[1;36m$1\033[0m \033[0;37m${MSG}\033[0m" 1>&2
    return 0
}

write_success() {
    MSG=$2
    echo -e "\033[1;32m$1\033[0m \033[0;37m${MSG}\033[0m" 1>&2
    return 0
}

write_error() {
    MSG=$2
    echo -e "\033[1;31m$1\033[0m \033[0;37m${MSG}\033[0m" 1>&2
    return 0
}

write_critical() {
    MSG=$2
    echo -e "\033[1;31;5m$1\033[0m \033[0;37m${MSG}\033[0m" 1>&2
    return 0
}

write_warning() {
    MSG=$2
    echo -e "\033[1;33m$1\033[0m \033[0;37m${MSG}\033[0m" 1>&2
    return 0
}

write_response() {
    if [ $? -ne 0 ]; then
        write_error "error" "$2"
        return 1
    fi
    
    write_success "success" "$2"
    return 0
}

is_command_available() {
    if [ -z "$(command -v $1)" ]; then
        return 1
    fi
    
    if [ -z "$(type -t $1)" ]; then
        return 2
    fi
    
    return 0
}

export -f write_info
export -f write_error
export -f write_success
export -f write_response
export -f write_critical
export -f write_warning
export -f write_header
export -f write_header_sub
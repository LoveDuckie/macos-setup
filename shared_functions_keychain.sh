#!/bin/bash
<<EOF

    LDK \ Shell Scripts \ Shared Functions (Keychain)

    A collection of reusable scripts and functions.

EOF
[ -n "${SHARED_FUNCTIONS_KEYCHAIN_EXT}" ] && return
SHARED_FUNCTIONS_KEYCHAIN_EXT=0
CURRENT_SCRIPT_DIRECTORY_FUNCTIONS=$(dirname $(realpath ${BASH_SOURCE[0]:-${(%):-%x}}))
export SHARED_EXT_SCRIPTS_PATH=$(realpath ${SHARED_EXT_SCRIPTS_PATH:-$CURRENT_SCRIPT_DIRECTORY_FUNCTIONS})
export REPO_ROOT_PATH=${REPO_ROOT_PATH:-$(realpath $SHARED_EXT_SCRIPTS_PATH/../../)}

type -f get_login_keychain >/dev/null 2>&1 && unset -f get_login_keychain 
type -f is_login_keychain >/dev/null 2>&1 && unset -f is_login_keychain 
type -f login_keychain_exists >/dev/null 2>&1 && unset -f login_keychain_exists 
type -f keychain_exists >/dev/null 2>&1 && unset -f keychain_exists 
type -f list_user_keychains >/dev/null 2>&1 && unset -f list_user_keychains 
type -f get_default_user_keychain >/dev/null 2>&1 && unset -f get_default_user_keychain 
type -f update_user_keychains >/dev/null 2>&1 && unset -f update_user_keychains 
type -f is_process_running >/dev/null 2>&1 && unset -f is_process_running 
type -f is_ssh_agent_running >/dev/null 2>&1 && unset -f is_ssh_agent_running 
type -f get_certificate_pem >/dev/null 2>&1 && unset -f get_certificate_pem 
type -f get_certificate_common_name >/dev/null 2>&1 && unset -f get_certificate_common_name 
type -f find_certificate_in_keychain >/dev/null 2>&1 && unset -f find_certificate_in_keychain 
type -f get_certificate_hashes_in_keychain >/dev/null 2>&1 && unset -f get_certificate_hashes_in_keychain 
type -f is_certificate_hash_in_keychain >/dev/null 2>&1 && unset -f is_certificate_hash_in_keychain 
type -f get_certificate_hash >/dev/null 2>&1 && unset -f get_certificate_hash 
type -f is_certificate_in_keychain >/dev/null 2>&1 && unset -f is_certificate_in_keychain 

# Retrieve the filepath to the keychain that is being used for login
get_login_keychain() {
    echo $(security login-keychain | xargs | tr -d '"')
    return 0
}

is_login_keychain() {
    if [ -z "$1" ]; then
        write_error "shared_functions" "The keychain name was not defined"
        return 1
    fi
    if [[ "$(get_login_keychain)" == *"$1"* ]]; then
        return 0
    fi

    return 1
}

login_keychain_exists() {
    local DEFAULT_LOGIN_KEYCHAIN_PATH="$HOME/Library/Keychains/login.keychain-db"
    # local DEFAULT_LOGIN_KEYCHAIN_PATH="$(get_login_keychain)"
    if [[ $(security list-keychains -d user | tr -d ' ' | sed -e s/\"//g) == *"$DEFAULT_LOGIN_KEYCHAIN_PATH"* ]]; then
        return 0
    fi
    return 1
}

keychain_exists() {
    if [ -z "$1" ]; then
        write_error "shared_functions" "The name of the keychain was not defined."
        return 1
    fi
    # local DEFAULT_LOGIN_KEYCHAIN_PATH="$(get_login_keychain)"
    if [[ $(security list-keychains -d user | tr -d ' ' | sed -e s/\"//g) == *"$1"* ]]; then
        return 0
    fi
    return 1
}

list_user_keychains() {
    echo $(security list-keychains -d user | tr -d ' ' | sed -e s/\"//g)
    if [ $? -eq 0 ]; then
        return 0
    fi

    return 1
}

get_default_user_keychain() {
    security default-keychain -d user | sed -e s/\"//g | xargs
    return 0
}

update_user_keychains() {
    if [ -z "$1" ]; then
        write_error "shared_functions" "The keychain name was not defind."
        return 1
    fi
    USER_KEYCHAINS=$(list_user_keychains | xargs)
    write_info "shared_functions" "Updating: User Keychains"
    security list-keychains -d user -s "$1" ${USER_KEYCHAINS[@]}
    if [ $? -eq 0 ]; then
        return 0
    fi
    return 1
}

is_process_running() {
    if [ -z "$1" ]; then
        write_error "shared_functions" "The process ID was not defined as the first parameter."
    fi
    if ps -p $1 >/dev/null; then
        return 0
    fi

    return 1
}

is_ssh_agent_running() {
    if [ ! -z $SSH_AGENT_PID ]; then
        if ! is_process_running $SSH_AGENT_PID; then
            return 1
        fi

        return 0
    fi

    return 1
}

get_certificate_pem() {
    if [ -z "$1" ]; then
        write_error "shared_functions" "The certificate file name is invalid or null"
        return 1
    fi
    if [ ! -e $1 ]; then
        write_error "shared_functions" "Failed: Unable to find the certificate file (\"$1\")"
        return 2
    fi
    OUTPUT=$(openssl x509 -inform der -in "$1" -outform pem)
    if [ -z "$OUTPUT" ]; then
        write_error "shared_functions" "The certificate PEM is invalid or null"
        return 3
    fi
    echo $OUTPUT
    return 0
}

get_certificate_common_name() {
    if [ -z "$1" ]; then
        write_error "shared_functions" "The file path to the certificate was not defined"
        return 1
    fi
    openssl x509 -inform der -in $1 -subject -nameopt sep_multiline -nameopt sname -noout |
        grep -E 'CN=(.*)$' --colour=never |
        xargs |
        sed -e "s/^CN=//"

    return 0
}

find_certificate_in_keychain() {
    if [ -z "$1" ]; then
        write_error "shared_functions" "The name of the certificate was not defined."
        return 1
    fi
    if [ -z "$2" ]; then
        write_error "shared_functions" "The name of the keychain was not defined."
        return 2
    fi

    if ! keychain_exists $2; then
        write_error "shared_functions" "The keychain specified does not exist. (\"$2\")"
        return 3
    fi
    echo $(security find-certificate -a -c "$1" $2)
    return 0
}

get_certificate_hashes_in_keychain() {
    if [ -z "$1" ]; then
        write_error "shared_functions" "The name of the keychain was not defined."
        return 1
    fi
    echo $(security find-certificate -Z -a $1 | grep -E 'SHA-256 hash:' | sed -e 's/^SHA-256 hash\://')
    if [ $? -ne 0 ]; then
        return 2
    fi
    return 0
}

is_certificate_hash_in_keychain() {
    if [ -z "$1" ]; then
        write_error "shared_functions" "The hash is invalid or null."
        return 1
    fi
    if [ -z "$2" ]; then
        write_error "shared_functions" "The keychain name is invalid or null."
        return 2
    fi

    if ! keychain_exists $2; then
        write_error "shared_functions" "The keychain does not exist (\"$2\")"
        return 3
    fi

    CERTIFICATE_HASH=$(get_certificate_hash)
    if [ -z "$CERTIFICATE_HASH" ]; then
        write_error "shared_functions" "The certificate hash is invalid or null"
        return 1
    fi
}

get_certificate_hash() {
    if [ -z "$1" ]; then
        write_error "shared_functions" "The certificate file path was not defined."
        return 1
    fi
    if [ ! -e "$1" ]; then
        write_error "shared_functions" "The certificate could not be found or does not exist. (\"$1\")"
        return 2
    fi
    # echo $(openssl x509 -inform der -in $1 | openssl dgst -sha256 | awk '{print toupper($0)}')
    echo $(openssl x509 -inform der -in $1 -sha256 -fingerprint -noout | sed -e 's/SHA256 Fingerprint=//' | tr -d ':' | xargs)
    return 0
}

is_certificate_in_keychain() {
    if [ -z "$1" ]; then
        write_error "shared_functions" "The name of the keychain was not defined."
        return 1
    fi
    if [ -z "$2" ]; then
        write_error "shared_functions" "The certificate file path was not defined."
        return 2
    fi
    if [ ! -e "$2" ]; then
        write_error "shared_functions" "Failed: Unable to find the certificate file \"$2\"."
        return 3
    fi
    CERTIFICATE_HASH=$(get_certificate_hash $2)
    if [ -z "$CERTIFICATE_HASH" ]; then
        write_error "shared_functions" "The certificate hash specified is invalid or null"
        return 4
    fi
    KEYCHAIN_HASHES=$(get_certificate_hashes_in_keychain $1)
    if [[ "$KEYCHAIN_HASHES" == *"$CERTIFICATE_HASH"* ]]; then
        return 0
    fi
    return 1
}

export -f get_login_keychain
export -f is_login_keychain
export -f login_keychain_exists
export -f keychain_exists
export -f list_user_keychains
export -f get_default_user_keychain
export -f update_user_keychains
export -f is_process_running
export -f is_ssh_agent_running
export -f get_certificate_pem
export -f get_certificate_common_name
export -f find_certificate_in_keychain
export -f get_certificate_hashes_in_keychain
export -f is_certificate_hash_in_keychain
export -f get_certificate_hash
export -f is_certificate_in_keychain

declare -F
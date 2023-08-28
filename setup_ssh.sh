#!/bin/bash
<<EOF

   LDK \ Shell Scripts \ macOS \ Setup SSH

   A setup script for configuring SSH on the host system.

EOF
CURRENT_SCRIPT_DIRECTORY=${CURRENT_SCRIPT_DIRECTORY:-$(dirname $(realpath ${BASH_SOURCE[0]:-${(%):-%x}}))}
export SHARED_EXT_SCRIPTS_PATH=${SHARED_EXT_SCRIPTS_PATH:-$(realpath $CURRENT_SCRIPT_DIRECTORY)}
export CURRENT_SCRIPT_FILENAME=${CURRENT_SCRIPT_FILENAME:-$(basename $0)}
export CURRENT_SCRIPT_FILENAME_BASE=${CURRENT_SCRIPT_FILENAME%.*}
. "$SHARED_EXT_SCRIPTS_PATH/shared_functions.sh"
write_header

SSH_CONFIG=$(
   cat <<'EOF'
is_process_running() {
    if [ -z "$1" ]; then
        echo "The process ID was not defined as the first parameter."
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

start_ssh_agent() {
   if is_ssh_agent_running; then
      echo "Killing existing SSH agent (PID $SSH_AGENT_PID)"
      ssh-agent -k
   fi

   (
      umask 066
      ssh-agent -s >~/.ssh-agent
   )
   sudo chown $(whoami) ~/.ssh-agent
   eval "$(<~/.ssh-agent)"

   return 0
}

[ -e ~/.ssh-agent ] && eval $(<~/.ssh-agent)
if [ ! -z "$SSH_AGENT_PID" ]; then
   if ! ps -p $SSH_AGENT_PID >/dev/null; then
      echo "Unable to find SSH agent."
      unset SSH_AGENT_PID
      unset SSH_AUTH_SOCK
      rm -rf ~/.ssh-agent
      start_ssh_agent
   fi
fi

ssh-add
EOF
)

write_info "setup_ssh" "Configuring SSH"

CONFIG_FILES=(~/.profile ~/.zprofile .profile)

for config_file in ${CONFIG_FILES[@]}; do
   if [ -z "$config_file" ]; then
      write_error "setup_ssh" "The configuration file specified is invalid or null"
      return
   fi
done

write_success "setup_ssh" "Done"

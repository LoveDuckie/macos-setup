#!/bin/bash
<<EOF

   LDK \ Shell Scripts \ macOS \ Setup PYENV

   Setup PYENV terminal

EOF
CURRENT_SCRIPT_DIRECTORY=${CURRENT_SCRIPT_DIRECTORY:-$(dirname $(realpath $0))}
export SHARED_EXT_SCRIPTS_PATH=${SHARED_EXT_SCRIPTS_PATH:-$(realpath $CURRENT_SCRIPT_DIRECTORY/)}
export CURRENT_SCRIPT_FILENAME=${CURRENT_SCRIPT_FILENAME:-$(basename $0)}
export CURRENT_SCRIPT_FILENAME_BASE=${CURRENT_SCRIPT_FILENAME%.*}
. "$SHARED_EXT_SCRIPTS_PATH/shared_functions.sh"
write_header

PYENV_CONFIG=$(
   cat <<'EOF'
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export PATH="/Users/lucshelton/.local/bin:$PATH"
EOF
)

CONFIG_FILES=(~/.zprofile ~/.zshrc ~/.profile)

for config_file in ${CONFIG_FILES[@]}; do
    write_info "setup_pyenv" "Updating: \"$config_file\""
    if [[ $(cat $config_file) == *"$PYENV_CONFIG"* ]]; then
        write_warning "setup_pyenv" "Shell profile already configured. (\"$config_file\")"
        continue
    fi
done

write_success "setup_pyenv" "done"
return 0
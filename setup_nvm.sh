#!/bin/bash
<<EOF

   LDK \ Shell Scripts \ macOS \ Setup NVM

   Setup NVM terminal

EOF
CURRENT_SCRIPT_DIRECTORY=${CURRENT_SCRIPT_DIRECTORY:-$(dirname $(realpath ${BASH_SOURCE[0]:-${(%):-%x}}))}
export SHARED_EXT_SCRIPTS_PATH=${SHARED_EXT_SCRIPTS_PATH:-$(realpath $CURRENT_SCRIPT_DIRECTORY/)}
export CURRENT_SCRIPT_FILENAME=${CURRENT_SCRIPT_FILENAME:-$(basename $0)}
export CURRENT_SCRIPT_FILENAME_BASE=${CURRENT_SCRIPT_FILENAME%.*}
. "$SHARED_EXT_SCRIPTS_PATH/shared_functions.sh"
write_header

NVM_CONFIG=$(
    cat <<'EOF'
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
EOF
)

CONFIG_FILES=(~/.zprofile ~/.zshrc ~/.profile)

for config_file in ${CONFIG_FILES[@]}; do
    write_info "setup_nvm" "Updating: \"$config_file\""
    if [[ $(cat $config_file) == *"$NVM_CONFIG"* ]]; then
        write_warning "setup_nvm" "Shell profile already configured. (\"$config_file\")"
        continue
    fi
done

write_info "setup_nvm" "Installing: NodeJS Stable Latest"
nvm install --lts
write_info "setup_nvm" "Installing: Angular CLI"
npm install -g @angular/cli

write_success "setup_nvm" "done"

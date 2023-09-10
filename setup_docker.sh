#!/bin/bash
<<EOF

   LDK \ Shell Scripts \ Setup \ Docker

   Setup Docker configuration on host system

EOF
CURRENT_SCRIPT_DIRECTORY=${CURRENT_SCRIPT_DIRECTORY:-$(dirname $(realpath $0))}
export SHARED_EXT_SCRIPTS_PATH=${SHARED_EXT_SCRIPTS_PATH:-$(realpath $CURRENT_SCRIPT_DIRECTORY/)}
export CURRENT_SCRIPT_FILENAME=${CURRENT_SCRIPT_FILENAME:-$(basename $0)}
export CURRENT_SCRIPT_FILENAME_BASE=${CURRENT_SCRIPT_FILENAME%.*}
. "$SHARED_EXT_SCRIPTS_PATH/shared_functions.sh"
write_header

CONFIG_FILES=()

for config in ${CONFIG_FILES[@]}; do
    if [[ "$(cat ~/$config)" == *"$varname"* ]]; then
        write_warning "setup_docker" "variable \"$varname\" is already inserted into ~/.bashrc. nothing to add."
        continue
    fi
    
    write_info "setup_docker" "Adding configuration $config"
    cat >> ~/$config <<EOL
export $varname=1
EOL
    
done

write_success "setup_docker" "Done"
exit 0
#!/bin/bash
<<EOF

   LDK \ Shell Scripts \ Setup \ AWS

   A script for configuring AWS

EOF
CURRENT_SCRIPT_DIRECTORY=${CURRENT_SCRIPT_DIRECTORY:-$(dirname $(realpath $0))}
export SHARED_EXT_SCRIPTS_PATH=${SHARED_EXT_SCRIPTS_PATH:-$(realpath $CURRENT_SCRIPT_DIRECTORY/)}
export CURRENT_SCRIPT_FILENAME=${CURRENT_SCRIPT_FILENAME:-$(basename $0)}
export CURRENT_SCRIPT_FILENAME_BASE=${CURRENT_SCRIPT_FILENAME%.*}
. "$SHARED_EXT_SCRIPTS_PATH/shared_functions.sh"
write_header

CONFIG_FILES=(.zshenv .zshrc .zprofile .profile)

if [ ! -d ~/.aws ]; then
    write_warning "setup_aws" "Creating: \"~/.aws\""
    mkdir -p ~/.aws
fi

DEFAULT_CONFIG=$(cat <<'EOF'
[default]
region = eu-west-2
EOF
)

DEFAULT_ENV=$(cat <<'EOF'
export AWS_DEFAULT_REGION=eu-west-2
export AWS_VAULT=lucshelton
EOF
)

touch ~/.aws/config

write_success "setup_aws" "Done"

write_info "setup_aws" "Updating: Shell Environments"

for config in ${CONFIG_FILES[@]}; do
    if [[ "$(cat $config)" == *""* ]]; then
        write_warning "setup_aws" "\"$config\" is already configured."
        continue
    fi
    write_warning "setup_aws" "Configuring: \"$config\""
    
done

write_success "setup_aws" "Done"

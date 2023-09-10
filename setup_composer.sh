#!/bin/bash
<<EOF

   LDK \ Shell Scripts \ Setup \ Composer

   Install Composer from source

EOF
CURRENT_SCRIPT_DIRECTORY=${CURRENT_SCRIPT_DIRECTORY:-$(dirname $(realpath $0))}
export SHARED_EXT_SCRIPTS_PATH=${SHARED_EXT_SCRIPTS_PATH:-$(realpath $CURRENT_SCRIPT_DIRECTORY/)}
export CURRENT_SCRIPT_FILENAME=${CURRENT_SCRIPT_FILENAME:-$(basename $0)}
export CURRENT_SCRIPT_FILENAME_BASE=${CURRENT_SCRIPT_FILENAME%.*}
. "$SHARED_EXT_SCRIPTS_PATH/shared_functions.sh"
write_header

write_info "setup_composer" "Downloading: Composer"
EXPECTED_CHECKSUM="$(php -r 'copy("https://composer.github.io/installer.sig", "php://stdout");')"
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
ACTUAL_CHECKSUM="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"

write_info "setup_composer" "Validating: Composer Installer Checksum"
if [ "$EXPECTED_CHECKSUM" != "$ACTUAL_CHECKSUM" ]
then
    >&2 echo 'ERROR: Invalid installer checksum'
    rm composer-setup.php
    exit 1
fi

write_info "setup_composer" "Installing: Composer"
php composer-setup.php --quiet
RESULT=$?

COMPOSER_INSTALL_PATH=/usr/local/bin/composer
write_warning "setup_composer" "Moving: \"composer.phar\" -> \"$COMPOSER_INSTALL_PATH\""
sudo mv composer.phar $COMPOSER_INSTALL_PATH
write_warning "setup_composer" "Deleting: \"composer-setup.php\""
rm composer-setup.php

write_success "setup_composer" "Done"
exit $RESULT
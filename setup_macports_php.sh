#!/bin/bash
<<EOF

   LDK \ Shell Scripts \ Setup \ MacPorts PHP

   Setup PHP with MacPorts

EOF
CURRENT_SCRIPT_DIRECTORY=${CURRENT_SCRIPT_DIRECTORY:-$(dirname $(realpath $0))}
export SHARED_EXT_SCRIPTS_PATH=${SHARED_EXT_SCRIPTS_PATH:-$(realpath $CURRENT_SCRIPT_DIRECTORY/)}
export CURRENT_SCRIPT_FILENAME=${CURRENT_SCRIPT_FILENAME:-$(basename $0)}
export CURRENT_SCRIPT_FILENAME_BASE=${CURRENT_SCRIPT_FILENAME%.*}
. "$SHARED_EXT_SCRIPTS_PATH/shared_functions.sh"
write_header

MACPORTS_PKGS=(php80 php81 php82)
MACPORTS_PHP_PKGS=(openssl soap gd zip xsl exif 
                    gmp opcache intl tidy ldap bcmatch pdo pdo_mysql mysqli solr curl mbstring)
for pkg in ${MACPORTS_PKGS[@]}; do
    write_info "setup_macports_php" "Installing PHP: \"$pkg\""
    sudo port install -N $pkg 
    for phppkg in ${MACPORTS_PHP_PKGS[@]}; do
        write_info "setup_macports_php" "Installing PHP Package: \"$phppkg\""
        sudo port install -N $pkg-$phppkg
    done
done

write_success "setup_macports_php" "Done"
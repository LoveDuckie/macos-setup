#!/bin/bash
<<EOF

   LDK \ Shell Scripts \ Setup \ PHPBrew

   A script for installing PHPBrew

EOF
CURRENT_SCRIPT_DIRECTORY=${CURRENT_SCRIPT_DIRECTORY:-$(dirname $(realpath $0))}
export SHARED_EXT_SCRIPTS_PATH=${SHARED_EXT_SCRIPTS_PATH:-$(realpath $CURRENT_SCRIPT_DIRECTORY/)}
export CURRENT_SCRIPT_FILENAME=${CURRENT_SCRIPT_FILENAME:-$(basename $0)}
export CURRENT_SCRIPT_FILENAME_BASE=${CURRENT_SCRIPT_FILENAME%.*}
. "$SHARED_EXT_SCRIPTS_PATH/shared_functions.sh"
write_header

write_info "setup_phpbrew" "Downloading: PHPBrew exectuable"
curl -L -O https://github.com/phpbrew/phpbrew/releases/latest/download/phpbrew.phar
chmod +x phpbrew.phar

# Move phpbrew.phar to somewhere can be found by your $PATH
sudo mv phpbrew.phar /usr/local/bin/phpbrew
phpbrew init

# I assume you're using bash
echo "[[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc" >> ~/.bashrc

# For the first-time installation, you don't have phpbrew shell function yet.
source ~/.phpbrew/bashrc

# Fetch the release list from official php site...
phpbrew update

# List available releases
phpbrew known

# List available variants
phpbrew variants

# Let's brew something out.
phpbrew --debug install --stdout 7.0 as 7.0-dev +default +intl -- # put your extra configure options here, e.g. --with-readline=...
# --debug and --stdout are useful for debugging if the configure script encountered some problems
# the first "7.0" will be expanded to 7.0.7 (the latest release) and 7.0-dev will be the build name that you use to switch versions.
# extra configure option is optional.

# Set 7.0-dev as default php and switch to it.
phpbrew switch 7.0-dev

# Install some extensions for php7, please note the command below are for php7
phpbrew --debug ext install xdebug 2.4.0
phpbrew --debug ext install github:krakjoe/apcu
phpbrew --debug ext install github:php-memcached-dev/php-memcached php7 -- --disable-memcached-sasl
phpbrew --debug ext install github:phpredis/phpredis php7

# Install php 5.6 with the same variant options like 7.0
phpbrew install 5.6 as 5.6-dev like 7.0-dev
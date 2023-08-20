#!/bin/bash
<<EOF

   LDK \ Shell Scripts \ macOS \ Setup Git

   A script for configuring Git.

EOF
CURRENT_SCRIPT_DIRECTORY=${CURRENT_SCRIPT_DIRECTORY:-$(dirname $(realpath $0))}
export SHARED_EXT_SCRIPTS_PATH=${SHARED_EXT_SCRIPTS_PATH:-$(realpath $CURRENT_SCRIPT_DIRECTORY/)}
export CURRENT_SCRIPT_FILENAME=${CURRENT_SCRIPT_FILENAME:-$(basename $0)}
export CURRENT_SCRIPT_FILENAME_BASE=${CURRENT_SCRIPT_FILENAME%.*}
. "$SHARED_EXT_SCRIPTS_PATH/shared_functions.sh"
write_header

GIT_COMMIT_MESSAGE_FILE_PATH=$CURRENT_SCRIPT_DIRECTORY/config/git/gitmesssage.txt
write_info "setup_git" "Copying: \"$GIT_COMMIT_MESSAGE_FILE_PATH\""
cp -f "$GIT_COMMIT_MESSAGE_FILE_PATH" "$HOME/.gitmessage.txt"

if [ ! -e $HOME/.gitmessage.txt ]; then
   write_error "setup_git" "Failed: Unable to copy the git commit message template \"$GIT_COMMIT_MESSAGE_FILE_PATH\""
   exit
fi
write_success "setup_git" "Copied: \"$HOME/.gitmessage.txt\""

write_info "setup_git" "Configuring: Git"
git config --global init.defaultBranch main
git config --global user.name "Luc Shelton"
git config --global user.email "lucshelton@gmail.com"
git config --global commit.template ~/.gitmessage.txt

write_info "setup_git" "Displaying global configuration options"
git config --global --list

write_success "setup_git" "Done"
exit 0
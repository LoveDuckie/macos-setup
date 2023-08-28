#!/bin/bash
<<EOF

   LDK \ Shell Scripts \ macOS \ Setup Fonts

   Setup the custom fonts

EOF
CURRENT_SCRIPT_DIRECTORY=${CURRENT_SCRIPT_DIRECTORY:-$(dirname $(realpath ${BASH_SOURCE[0]:-${(%):-%x}}))}
export SHARED_EXT_SCRIPTS_PATH=${SHARED_EXT_SCRIPTS_PATH:-$(realpath $CURRENT_SCRIPT_DIRECTORY/)}
export CURRENT_SCRIPT_FILENAME=${CURRENT_SCRIPT_FILENAME:-$(basename $0)}
export CURRENT_SCRIPT_FILENAME_BASE=${CURRENT_SCRIPT_FILENAME%.*}
. "$SHARED_EXT_SCRIPTS_PATH/shared_functions.sh"
write_header

FONTS_PATH=$CURRENT_SCRIPT_DIRECTORY/fonts

rm -rf $FONTS_PATH/extracted

write_info "setup_fonts" "Installing Fonts: $FONTS_PATH"

for fontarchive in $(find $FONTS_PATH -type f -iname '*.zip'); do
   if [ -z "$fontarchive" ]; then
      write_error "setup_fonts" "The font archive specified is invalid or null"
      exit 1
   fi
   mkdir -p $FONTS_PATH/extracted
   write_info "setup_fonts" "Extracting: \"$fontarchive\""
   ARCHIVE_NAME=$(basename $fontarchive)
   ARCHIVE_NAME=${ARCHIVE_NAME%.*}
   unzip $fontarchive -d $FONTS_PATH/extracted/$ARCHIVE_NAME
done

write_info "setup_fonts" "Copying Fonts: \"$FONTS_PATH\""
write_info "setup_fonts" "Destination: $(realpath ~/Library/Fonts)"

for fontfile in $(find $FONTS_PATH/extracted -type f -iname '*.ttf'); do
   write_info "setup_fonts" "Copying Font: $(basename $fontfile)"
   cp -f $fontfile ~/Library/Fonts
   write_success "setup_fonts" "Copied: $(basename $fontfile)"
done

write_success "setup_fonts" "Done"
exit 0

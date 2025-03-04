#!/bin/sh
# script for finding a safespot. 
# It processes only 100 images at a time to reduce RAM usage.
# first argument folder with frames, second argument filename for a result.
# original method for finding a safespot was created by toimine.

# TODO: Check for permissions.
# TODO: Check for free space on disk.

# set -xe

FRAME_DIR="$1"  # input directory
OUTPUT_NAME="$2" # output

# check if arguments are empty
if [ -z "$FRAME_DIR" ]; then
   echo "[ERROR] no directory with frames provided"
   exit 1
fi
if [ -z "$OUTPUT_NAME" ]; then
   echo "[ERROR] no output file name provided"
   exit 1
fi

SEQNUM=0
FILELIST="$(find "$FRAME_DIR" -maxdepth 1 -type f | sort -n)"
_spf() {
   if [ -n "$FILELIST" ]; then
      CURRENT_FILELIST=$(echo "$FILELIST" | head -100)
      FILELIST=$(echo "$FILELIST" | tail -n +101)
      SEQNUM=$(echo "$SEQNUM+1" | bc)

      echo "[INFO] Combining 100 files from sequence #$SEQNUM to /tmp/${SEQNUM}_${OUTPUT_NAME}"
      magick $CURRENT_FILELIST -evaluate-sequence Max /tmp/"$SEQNUM"_"$OUTPUT_NAME"

      _spf "$FOLDER"
   fi
}

_spf "$FRAME_DIR"
unset FOLDER FILELIST SEQNUM

echo "[INFO] Combining rendered images into $OUTPUT_NAME"
magick /tmp/*_$OUTPUT_NAME -evaluate-sequence Max "$OUTPUT_NAME"

echo "[INFO] Removing /tmp/*_$OUTPUT_NAME"
rm /tmp/*_$OUTPUT_NAME

unset FRAME_DIR OUTPUT_NAME

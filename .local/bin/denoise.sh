#!/bin/bash

FILENAME=$(ls -l *.jpg  | head -n1 | awk '{print $NF}')
FILENAME=${FILENAME/.jpg/_denoised.jpg}


hugin-tools:

echo
echo "Aligning images..."
ls -la *.jpg
time OMP_NUM_THREADS=4 align_image_stack -a aligned_ -C *.jpg

echo
echo "Median stacking $FILENAME..."
time convert aligned_*.tif -evaluate-sequence median $FILENAME
rm -f *.tif

echo
echo "DONE!!!"

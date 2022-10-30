#!/bin/bash

mkdir unsplash
#for q in {1..25}; do wget "https://source.unsplash.com/random/?Nature" -O unsplash/test$q.jpg;done

rm -rv cropped
mkdir cropped
for q in {1..25}; do
echo "...Cropping photo $q"
convert unsplash/test$q.jpg -gravity center -auto-level -sharpen +2x3 -resize 256x256^ -crop 256x256+0+0 -auto-level -sharpen 1x0 cropped/test-256-$q.png;done

montage -geometry 256x256+0+0 -tile 5x cropped/test-256-{1..25}.png photos.png


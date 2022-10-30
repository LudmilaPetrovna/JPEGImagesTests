#!/bin/bash

find -iname "*.png" -o -iname "*.jpg" | xargs -n1 rm -v
bash generate_test.sh
bash png-source.sh
bash gradients.sh
bash im_patterns.sh

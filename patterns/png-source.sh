gcc -Wall hdr-xor.c -lm && ./a.out 512 16 | ffmpeg -s 512x512 -pix_fmt gray16 -f rawvideo -i - -y hdr-xor16.png
gcc -Wall hdr-xor.c -lm && ./a.out 512 12 | ffmpeg -s 512x512 -pix_fmt gray16 -f rawvideo -i - -y hdr-xor12.png
convert -size 120x120 pattern:checkerboard -resize 64x64 -auto-level -colors 3 -auto-level checkerboard.png
convert -background none -fill red -pointsize 100 label:R -trim -resize 8x8\! label_R.png
convert -background none -fill green -pointsize 100 label:G -trim -resize 8x8\! label_G.png
convert -background none -fill blue -pointsize 100 label:B -trim -resize 8x8\! label_B.png
convert -background none -fill white -pointsize 100 label:W -trim -resize 8x8\! label_W.png
convert -background none -fill cyan -pointsize 100 label:C -trim -resize 8x8\! label_C.png
convert -background none -fill magenta -pointsize 100 label:M -trim -resize 8x8\! label_M.png
convert -background none -fill yellow -pointsize 100 label:Y -trim -resize 8x8\! label_Y.png
convert -background none -fill black -pointsize 100 label:K -trim -resize 8x8\! label_K.png
convert -background none -size 16x16 xc: label_R.png -geometry +0+0 -composite label_G.png -geometry +8+0 -composite label_B.png -geometry +0+8 -composite label_W.png -geometry +8+8 -composite label_RGBW.png
convert -background none -size 16x16 xc: label_C.png -geometry +0+0 -composite label_M.png -geometry +8+0 -composite label_Y.png -geometry +0+8 -composite label_K.png -geometry +8+8 -composite label_CMYK.png

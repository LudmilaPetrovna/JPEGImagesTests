
OUTDIR="out"
#wget https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/imagetestsuite/imagetestsuite-jpg-1.00.tar.gz
#tar xvf imagetestsuite-jpg-1.00.tar.gz


function produce_files(){
SAMPLE="$1"
DATASET="$2";
echo "Converting \"$SAMPLE\" to \"$DATASET\" dataset";

for dp in {8..8}; do for cs in `convert -list colorspace`; do
OUT="im_${DATASET}_${cs}_${dp}.jpg"
echo "...$OUT";
convert $SAMPLE -depth $dp -colorspace $cs -gravity center -auto-level -sharpen +2x3 -resize 256x256^ -crop 256x256+0+0 -auto-level -sharpen 1x0 "$OUTDIR/$OUT"
done;done
#for cc in `ffmpeg -pix_fmts 2>&1 | grep -E "^\S\S\S\S\S\s\S+\s+[0-9]+\s+[0-9]+" | cut -d" " -f2`; do ffmpeg -i test2.jpg -pix_fmt "$cc" -s 32x32 -y "ffmpeg-$cc.jpg";done

for cc in {yuvj444p,yuvj422p,yuvj420p}; do
OUT="ffmpeg_${DATASET}_${cc}.jpg"
echo "...$OUT";
ffmpeg -hide_banner -i $SAMPLE -pix_fmt "$cc" -y "$OUTDIR/$OUT"
done

convert "$SAMPLE" tmp.tga
cjpeg -rgb tmp.tga > "$OUTDIR/cjpeg_${DATASET}_rgb.jpg"
cjpeg -grayscale tmp.tga > "$OUTDIR/cjpeg_${DATASET}_grayscale.jpg"
cjpeg -optimize -dct float tmp.tga > "$OUTDIR/cjpeg_${DATASET}_optimize_float.jpg"
cjpeg -optimize -dct float -arithmetic tmp.tga > "$OUTDIR/cjpeg_${DATASET}_optimize_float_arithmetic.jpg"
cjpeg -progressive tmp.tga > "$OUTDIR/cjpeg_${DATASET}_progressive.jpg"
rm tmp.tga
}

cd patterns
bash build.sh
cd ..

cd photos
bash build.sh
cd ..


produce_files photos/photos.png photo
produce_files photos/cropped/test-256-2.png grass
produce_files patterns/checkerboard.png checker
produce_files patterns/im_patterns.png patterns_bw
produce_files patterns/im_color_patterns.png patterns_color
produce_files patterns/gradients.png gradients
produce_files patterns/label_CMYK.png cmyk
produce_files patterns/label_RGBW.png rgb
produce_files patterns/gradient_simple.png gradient

mkdir tiny
find photos/ patterns/ -iname "*.png" | sort -u | sort -R | while read ff; do OO=tiny/`sed -r "s,.+/,,g;s,\.png$,.jpg,g" <<< "$ff"`; echo "$ff -> $OO";convert "$ff" "$OO";done

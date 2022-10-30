SIZE="32x32"
EXT=png

echo "Creating gradients and plasma $SIZE, type $EXT"

convert -size "$SIZE" gradient:              gradient_simple.$EXT
convert -size "$SIZE" gradient:blue              gradient_linear_range1.$EXT
convert -size "$SIZE" gradient:yellow            gradient_linear_range2.$EXT
convert -size "$SIZE" gradient:green-yellow      gradient_linear_range3.$EXT
convert -size "$SIZE" gradient:red-blue          gradient_linear_range4.$EXT
convert -size "$SIZE" gradient:tomato-steelblue  gradient_linear_range5.$EXT
convert -size "$SIZE" plasma:blue              plasma_linear_range1.$EXT
convert -size "$SIZE" plasma:yellow            plasma_linear_range2.$EXT
convert -size "$SIZE" plasma:green-yellow      plasma_linear_range3.$EXT
convert -size "$SIZE" plasma:red-blue          plasma_linear_range4.$EXT
convert -size "$SIZE" plasma:tomato-steelblue  plasma_linear_range5.$EXT
convert -size "$SIZE" plasma:black-black -blur 0x2 -colorspace Gray plasma_grey0.$EXT
convert -size "$SIZE" plasma:grey25-grey25 -blur 0x2 -colorspace Gray plasma_grey1.$EXT
convert -size "$SIZE" plasma:grey50-grey50 -blur 0x2 -colorspace Gray plasma_grey2.$EXT
convert -size "$SIZE" plasma:grey75-grey75 -blur 0x2 -colorspace Gray plasma_grey3.$EXT
convert -size "$SIZE" plasma:white-white -blur 0x2 -colorspace Gray plasma_grey4.$EXT


convert -size "$SIZE" radial-gradient:  gradient_radial.$EXT
convert -size "$SIZE" gradient: -function Polynomial -4,4,0 gradient_peak.$EXT
convert -size "$SIZE" radial-gradient: -function Polynomial -4,4,0 gradient_radial_donut.$EXT
convert -size "$SIZE" gradient: -function sinusoid 4,-90 gradient_bands.$EXT
convert -size 142x142 gradient: -rotate -45 -gravity center -crop "$SIZE"+0+0 +repage gradient_diagonal.$EXT
convert -size "$SIZE" gradient: -swirl 180 gradient_swirl.$EXT
convert -size 1x1000 gradient: -rotate 90 -distort Arc '360 -90 50 0' +repage -gravity center -crop "$SIZE"+0+0 +repage  gradient_angle_even.$EXT

convert -size "$SIZE" gradient: \( +clone +clone \) -background gray50 -compose ModulusAdd -flatten gradient_venetian.$EXT
convert -size "$SIZE" gradient: \( gradient: -rotate -90 \) \( -clone 0--1 -clone 0--1 \) -background gray50 -compose ModulusAdd -flatten  gradient_vent_diag.$EXT
convert -size "$SIZE" gradient:yellow-blue \( gradient:black-lime -rotate -90 \)  -compose CopyGreen -composite  gradient_colormap.$EXT
convert -size "$SIZE" xc: -channel G  -fx '(1-(2*i/w-1)^4)*(1-(2*j/h-1)^4)' -separate  gradient_fx_quad2.$EXT
convert -size 150x150 xc: -channel G  -fx '(1-(2*i/w-1)^4)*(1-(2*j/h-1)^4)' -separate +repage -gravity center -background black -rotate 45 -resize "$SIZE" gradient_diamond.$EXT


  convert -size "$SIZE" xc: +size xc:red xc:blue xc:lime -colorspace HSB \
          -fx 'ar=1/max(1,  (i-50)*(i-50)+(j-10)*(j-10)  );
               br=1/max(1,  (i-10)*(i-10)+(j-70)*(j-70)  );
               cr=1/max(1,  (i-90)*(i-90)+(j-90)*(j-90)  );
               ( u[1]*ar + u[2]*br + u[3]*cr )/( ar+br+cr )' \
          -colorspace sRGB   gradient_shepards_HSB.$EXT

montage -geometry $SIZE+0+0 -tile 5x plasma_* gradient_* gradients.$EXT

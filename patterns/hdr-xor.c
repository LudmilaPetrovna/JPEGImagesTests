#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <math.h>

int main(int argc, char **argv){

if(argc!=3){
printf("Usage: %s [side] [bit_depth]\n",argv[0]);
exit(0);
}
int side=atoi(argv[1]);
int depth=atoi(argv[2]);

int q,w;
uint32_t sample;
int shift=log2(side)-8;
int shift2=depth-shift*2-1;
int bytes=(depth+7)/8;
fprintf(stderr,"Output %d bit depth, active bits: %d (%d shift), %d bytes per sample\n",depth,shift,shift2,bytes);
for(w=0;w<side;w++){
for(q=0;q<side;q++){
sample=q^w;
if(shift){
sample=(((((w>>8)<<shift)|(q>>8))<<shift)<<shift2)|(sample&0xFF);
}
fwrite(&sample,1,bytes,stdout);
}
}

return 0;
}

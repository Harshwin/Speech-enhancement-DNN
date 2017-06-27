
LF0WIN=win/lf0.win

NLF0WIN=3
NMGCWIN=3
MGCDIM=35 #`expr 34 + 1`; \
LF0DIM=1; \
MGCWINDIM=105 #`expr $(NMGCWIN) \* $${MGCDIM}`; \
LF0WINDIM=3 #`expr $(NLF0WIN) \* $${LF0DIM}`; \
BYTEPERFRAME=`expr 4 \* \( ${MGCWINDIM} + ${LF0WINDIM} \)`; \



LF0WINS=""; \
i=1; \
while [ ${i} -le 3 ]; do \
	eval LF0WINS=\"${LF0WINS} win/lf0.win${i}\"; \
	i=`expr ${i} + 1`; \
done; \

#/usr/local/bin/x2x +af file.sp | \
#/usr/local/bin/mcep -a 0.55 -m 34 -l 2048 -e 1.0E-08 -j 0 -f 0.0 -q 3 > file.mgc; \
#$T= wc -c file.f0

#T=get_file_size("file.f0")/4;
/usr/bin/perl  /home/computing4/iisc_kannada_hts/STRAIGHT/data/scripts/window.pl ${MGCDIM} file.mgc ${MGCWINS} > tmp.mgc;
/usr/bin/perl /home/computing4/iisc_kannada_hts/STRAIGHT/data/scripts/window.pl 1 file.f0 ${LF0WINS} > tmp.lf0; \
/usr/local/bin/merge +f -s 0 -l ${LF0WINDIM} -L ${MGCWINDIM} tmp.mgc < tmp.lf0                 > tmp.cmp; \
/usr/bin/perl /home/computing4/iisc_kannada_hts/STRAIGHT/data/scripts/addhtkheader.pl 48000 240 ${BYTEPERFRAME} 9 tmp.cmp > file1.cmp; \
rm -f tmp.mgc tmp.lf0 tmp.cmp; \

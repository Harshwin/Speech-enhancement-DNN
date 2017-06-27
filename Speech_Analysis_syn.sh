# awk and perl
AWK=mawk
PERL=/usr/bin/perl

# SPTK commands
X2X=/usr/local/bin/x2x
MGCEP=/usr/local/bin/mcep
MGC2SP=/usr/local/bin/mgc2sp
LPC2LSP=/usr/local/bin/lpc2lsp
MERGE=/usr/local/bin/merge
VSTAT=/usr/local/bin/vstat
SOPR=/usr/local/bin/sopr
NAN=/usr/local/bin/nan
MINMAX=/usr/local/bin/minmax
PITCH=/usr/local/bin/pitch
FRAME=/usr/local/bin/frame
WINDOW=/usr/local/bin/window
RAW2WAV=/usr/local/bin/raw2wav

# speech analysis conditions
SAMPFREQ=48000   # Sampling frequency (16kHz)
FRAMELEN=800   # Frame length in point (400 = 16000 * 0.025)
FRAMESHIFT=80 # Frame shift in point (80 = 16000 * 0.005)
WINDOWTYPE=1 # Window type -> 0: Blackman 1: Hamming 2: Hanning
NORMALIZE=1  # Normalization -> 0: none  1: by power  2: by magnitude
FFTLEN=1024     # FFT length in point
FREQWARP=0.34   # frequency warping factor
GAMMA=0      # pole/zero weight for mel-generalized cepstral (MGC) analysis
MGCORDER=13   # order of MGC analysis
BAPORDER=24   # order of BAP analysis
LNGAIN=1     # use logarithmic gain rather than linear gain
LOWERF0=80    # lower limit for f0 extraction (Hz)
UPPERF0=400    # upper limit for f0 extraction (Hz)

# windows for calculating delta features
MGCWIN=win/mgc.win
LF0WIN=win/lf0.win
BAPWIN=win/bap.win
NMGCWIN=3
NLF0WIN=3
NBAPWIN=3
fw=0.41;
gm=0;
# input sp processing
#sp = sp*32768.0;
#save '$${base}.sp' sp -ascii;
base='text_1.mat'
base_op='text900_op' 
ordr_mgc=13
#if [ -s ${base}.sp ]; then \
#	if [ ${GAMMA} -eq 0 ]; then \
#		$X2X +af ${base}.sp | \
#		$MGCEP -a ${FREQWARP} -m ${MGCORDER} -l 2048 -e 1.0E-08 -j 0 -f 0.0 -q 3 > ${base}.mgc; \
#	else \
#		if [ ${LNGAIN} -eq 1 ]; then \
#			GAINOPT="-L"; \
#		fi; \
#		$X2X +af ${base}.sp | \
#		$MGCEP -a ${FREQWARP} -c ${GAMMA} -m ${MGCORDER} -l 2048 -e 1.0E-08 -j 0 -f 0.0 -q 3 -o 4 | \
#		$LPC2LSP -m ${MGCORDER} -s ${SAMPKHZ} ${GAINOPT} -n 2048 -p 8 -d 1.0E-08 > ${base}.mgc; \
#	fi; \
#	if [ -n "`$NAN ${base}.mgc`" ]; then \
#		echo " Failed to extract features from ${raw}"; \
#		rm -f ${base}.mgc; \
#	fi; \
#fi; \

# convert Mel-cepstral coefficients to spectrum
mgc='text900_mfc.mgc'
ordr_mgcp=13
#	if [ ${gm} == 0 ]; then \
		$MGC2SP -a ${fw} -g ${gm} -m ${ordr_mgcp} -l 1024 -o 2 $mgc > $base_op.sp;\
#	else \
#		$MGC2SP -a ${fw} -g ${gm} -c ${ordr_mgcp} -l 2048 -o 2 $mgc > $base_op.sp;\
#	fi; \


# how to open and retrieve sp in MATLAB for STRAIGHT synthesis
#fid1 = fopen('%s','r','%s');\n",        "$gendir/$base.sp", "ieee-le";
#sp = fread(fid1,[%d, %d],'float');\n",  1025, $T;
#sp = sp/32768.0;

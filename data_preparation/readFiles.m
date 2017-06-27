clear ;close all;
addpath('/home/spectrumlab/Downloads/wav');
filednn = 'cmu_us_arctic_slt_text_1';
filehts = 'TTS_Synthesized';
file = 'text_1';

[dnn,fs1]=audioread([filednn,'.wav']);
[hts,fs2]=audioread([filehts,'.wav']);
[wav,fs3]=audioread([file,'.wav']);
display(['dnn:', ' ' num2str(fs1),' ','hts:',' ', num2str(fs2),' ', 'Originnal:',' ', num2str(fs3)])
[length(dnn) length(hts) length(wav)]
fs = fs1;
winD = 20E-3;
shiftD = 10E-3;
winL = floor(fs*winD);
shiftL = floor(fs*shiftD);
L = length(wav);
dnn = dnn(1:L);
hts = hts(1:L);
nFr = floor((L-winL)/shiftL)+1
%plfor i=1:nFr

% clc;
% clear all;
%warning off all
[x,fs]=audioread('/home/spectrumlab/Downloads/10001.wav');

%prm.F0frameUpdateInterval=5; % 240/4800*1000
%prm.levelNormalizationIndicator = 0;
% prm.F0searchUpperBound=400    ;
% prm.F0searchLowerBound=150    ;
% prm.spectralUpdateInterval=5;
[f0,ap,analysisParams]=exstraightsource(x,fs); % F0 and aperiodicity extraction
% 
% [sp,prmP]=exstraightspec(x,f0,fs); % Smoothed spectral envelope extraction
% 
% save 'file.f0' f0 -ascii;
% save 'file.ap' ap -ascii;
% save 'file.sp' sp -ascii;
% 
% % fid1 = fopen('/home/computing4/iisc_kannada_hts/M_STRAIGHT/gen/qst001/ver1/stc/0/Gen01.sp','r','ieee-le');       
% % fid2 = fopen('/home/computing4/iisc_kannada_hts/M_STRAIGHT/gen/qst001/ver1/stc/0/Gen01.ap','r','ieee-le'); 
% % fid3 = fopen('/home/computing4/iisc_kannada_hts/M_STRAIGHT/gen/qst001/ver1/stc/0/Gen01.f0','r','ieee-le'); 
% % f=dir('/home/computing4/iisc_kannada_hts/M_STRAIGHT/gen/qst001/ver1/stc/0/Gen01.f0');
fs = 48000;
fid1 = fopen('cmu_us_arctic_slt_text_1.sp','r','ieee-le');       
fid2 = fopen('cmu_us_arctic_slt_text_1.ap','r','ieee-le'); 
fid3 = fopen('cmu_us_arctic_slt_text_1.f0','r','ieee-le'); 
f=dir('cmu_us_arctic_slt_text_1.f0');
T=f.bytes;
T=T/4;
sp = fread(fid1,[1025, T],'float');   %217969 is the file size of file.f0 = $T
ap = fread(fid2,[1025, T],'float');
f0 = fread(fid3,[1, T],'float');
fclose(fid1);
fclose(fid2);
fclose(fid3);
%sp = sp/32768.0;
[sy] = exstraightsynth(f0,sp,ap,fs,prm);

sy1 =sy./(1.01*max(abs(sy)));
audiowrite('Straight_synthesized.wav', sy1, fs);


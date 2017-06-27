% converting .mgc files to .mat files

close all
clear all
clc

 path_txt_Omgc = '/home/spectrumlab/Documents/Harshwin/Using_mgc/english/orig_mgc/';
 path_txt_Smgc = '/home/spectrumlab/Documents/Harshwin/Using_mgc/english/synth_mgc/';



 wpath_txt_Omgc = '/home/spectrumlab/Documents/Harshwin/Using_mgc/english/Orig_mgc_matt/';
 wpath_txt_Smgc = '/home/spectrumlab/Documents/Harshwin/Using_mgc/english/synth_mgc_matt/';


 
mgc_files_O = dir([path_txt_Omgc '*.mgc']);
mgc_files_S = dir([path_txt_Smgc '*.mgc']);

%[wav_files fs] = wavread([path_txt '*.wav']);
num_files = length(mgc_files_O);

for i=1:num_files
    i
    
    fname_O = mgc_files_O(i).name;
    fname_S = mgc_files_S(i).name;
    
  

    filepath_O = [path_txt_Omgc fname_O];
    filepath_S = [path_txt_Smgc fname_S];
    
    
   
   
    fid2 = fopen(filepath_O,'r','ieee-le'); 
    fid3 = fopen(filepath_S,'r','ieee-le'); 
   
    mgc_O1 = fread(fid2,'float');  
    mgc_S1 = fread(fid3,'float');
    mgc_O = reshape(mgc_O1,35,[]);
    mgc_S = reshape(mgc_S1,35,[]);
    
    
    filename_O = regexprep(fname_O,'.mgc','.mat');
    filename_S = regexprep(fname_S,'.mgc','.mat');
    
    
    fclose(fid2);
    fclose(fid3);
 
    
    filepath_O=[wpath_txt_Omgc filename_O];
    filepath_S=[wpath_txt_Smgc filename_S];   

    save(filepath_O,'mgc_O');
    save(filepath_S,'mgc_S');

end
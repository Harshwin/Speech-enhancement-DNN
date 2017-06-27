close all
clear all
clc

 path_txt_Omfcc = '/home/spectrumlab/Documents/Harshwin/orig_mfc_dtw/';


 wpath_txt_Omfcc = '/home/spectrumlab/Documents/Harshwin/n_orig_mfc_dtw/';



 
mfc_files_O = dir([path_txt_Omfcc '*.mat']);

%[wav_files fs] = wavread([path_txt '*.wav']);
num_files = length(mfc_files_O);

for i=1:num_files
    i
    
    fname_O = mfc_files_O(i).name;
 
    filepath_O = [path_txt_Omfcc fname_O];
 
    mfc_Ostruct = load(filepath_O);
    
    mfc_O = mfc_Ostruct.nmfc_O;
    
    nmfc_O=zeros(size(mfc_O,1),size(mfc_O,2));

        for j=1:size(mfc_O,1);
            sd=sqrt(var(mfc_O(j,:)));
            m = mean(mfc_O(j,:));
            if sd == 0
                nmfc_O(j,:)= mfc_O(j,:);
            else
                nmfc_O(j,:)= (mfc_O(j,:) - m )./sd;
            end
            
         end
   % nmfc_S = nmfc_S';
      
    filepath_O=[wpath_txt_Omfcc fname_O];

    save(filepath_O,'nmfc_O');
 

end

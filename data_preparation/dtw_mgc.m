% applying dtw to mgc

close all
clear all
clc

 path_txt_Omgc = '/home/spectrumlab/Documents/Harshwin/Using_mgc/english/Orig_mgc_matt/';
 path_txt_Smgc = '/home/spectrumlab/Documents/Harshwin/Using_mgc/english/Synth_mgc_matt/';

 wpath_txt_Omgc = '/home/spectrumlab/Documents/Harshwin/Using_mgc/english/Orig_mgc_dtw/';
 wpath_txt_Smgc = '/home/spectrumlab/Documents/Harshwin/Using_mgc/english/Synth_mgc_dtw/';


 
mgc_files_O = dir([path_txt_Omgc '*.mat']);
mgc_files_S = dir([path_txt_Smgc '*.mat']);
%[wav_files fs] = wavread([path_txt '*.wav']);
num_files = length(mgc_files_O);

for i=1:num_files
    i
    
    fname_O = mgc_files_O(i).name;
    fname_S = mgc_files_S(i).name;

    filepath_O = [path_txt_Omgc fname_O];
    filepath_S = [path_txt_Smgc fname_S];
    mgc_Ostruct = load(filepath_O);
    mgc_Sstruct = load(filepath_S);
    
    mgc_O = mgc_Ostruct.mgc_O;
    mgc_S = mgc_Sstruct.mgc_S;
    

    
    [dist,ix,iy] = dtw(mgc_O,mgc_S);
   % [dist,~,~,~,nmgc_O,nmgc_S] = dtwmine(mgc_O',mgc_S',0,1);
    
%     nmgc_O=zeros(size(ix,1),size(mgc_O,2));
%     nmgc_S=zeros(size(iy,1),size(mgc_S,2));

%         for i=1:size(ix,1);
%             nmgc_O(i,:)=mgc_O(ix(i),:);
%         end
%     
%         for j=1:size(iy,1);
%             nmgc_S(j,:)=mgc_S(iy(j),:);
%         end

    nmgc_O=zeros(size(mgc_O,1),size(ix,1));
    nmgc_S=zeros(size(mgc_S,1),size(iy,1));

        for i=1:size(ix,1);
            nmgc_O(:,i)=mgc_O(:,ix(i));
        end
    
        for j=1:size(iy,1);
            nmgc_S(:,j)=mgc_S(:,iy(j));
        end
    filepath_O=[wpath_txt_Omgc fname_O];
    filepath_S=[wpath_txt_Smgc fname_S];   
    nmgc_O = nmgc_O';
    nmgc_S = nmgc_S';
    
    save(filepath_O,'nmgc_O');
    save(filepath_S,'nmgc_S');

end
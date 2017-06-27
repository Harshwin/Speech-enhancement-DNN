clear all
PathName ='/home/spectrumlab/Documents/Harshwin/matt_w_synth/';
file_all = dir(fullfile(PathName,'*.mat'));
matfile        = file_all([file_all.isdir] == 0); 

%d=dir('*.mat');  % get the list of files
x=[];            % start w/ an empty array
for i=1:length(matfile)
x=[x; load(matfile(i).name)];   % read/concatenate into x
end
b=[];
for j=1:length(x)
    b=[b; x(j, 1).variable1];
end
FileName = [matfile(i,1).name(1:end-9),'.mat'];
save(FileName,'matfile','x','b');
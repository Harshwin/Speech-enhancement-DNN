
m = load('/home/spectrumlab/Documents/Harshwin/a0001.mat');
mgc = double(m.pred);
file = m.file;
file = [file '.mgc'];
save(file,'mgc','-ascii');





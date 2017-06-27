# -*- coding: utf-8 -*-
"""
Created on Tue Feb  7 19:11:12 2017

@author: spectrumlab
"""

# -*- coding: utf-8 -*-
"""
Created on Thu Feb  2 16:26:31 2017

@author: spectrumlab
"""

# 3. Import libraries and modules

import numpy as np
import os.path
import os
import scipy
import scipy.io as sio

path = '/home/spectrumlab/Documents/Harshwin/Using_mgc/english/Orig_mgc_dtw/'
num_files = sum(os.path.isfile(os.path.join(path, f)) for f in os.listdir(path))
mats = []
for file in os.listdir( path ) :
    mats.append( scipy.io.loadmat( path+file ) )
    
x3 = np.concatenate([mats[0]['nmgc_O'],mats[1]['nmgc_O']])     
for i in range(2,num_files):
    print i
    x3 = np.concatenate([x3,mats[i]['nmgc_O']])

sio.savemat('English_concat_orig_mgc.mat',{'O_mgc':x3})    


path = '/home/spectrumlab/Documents/Harshwin/Using_mgc/english/Synth_mgc_dtw/'
num_files = sum(os.path.isfile(os.path.join(path, f)) for f in os.listdir(path))
mats_synth = []
for file in os.listdir( path ) :
    mats_synth.append( scipy.io.loadmat( path+file ) )
    
x4 = np.concatenate([mats_synth[0]['nmgc_S'],mats_synth[1]['nmgc_S']])     
for j in range(2,num_files):
    print j
    x4 = np.concatenate([x4,mats_synth[j]['nmgc_S']])

sio.savemat('English_concat_synth_mgc.mat',{'S_mgc':x4})    
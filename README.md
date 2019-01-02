# Speech-enhancement-DNN

This repository does not contain the complete set of codes and data required.

It is not a complete end to end framework. Each step has to be performed manually.
This is a small experiment to enhance speech quality of the synthesized audio files using feed forward neural network.
Synthesize_audio_using_straight.m --> this will synthesis audio files using straight(a speech synthesis and analysis system).
st_feats.sh --> this will generate features called as MFCC from the audio files.
Speech_Analysis_syn.sh --> This code will convert MFCC to mgc.
nn_mfc.py --> Is the python neural network code, which uses original audio files as labels and synthesized files as input to the model.

# Speech-enhancement-DNN

This repository does not contain the complete set of codes and data required.

It is not a complete end to end framework. Each step has to be performed manually.
This is a small experiment to enhance speech quality of the synthesized audio files using feed forward neural network.

Synthesize_audio_using_straight.m --> this will synthesis audio files using straight(a speech synthesis and analysis system).

st_feats.sh --> this will generate features called as MFCC from the audio files.

Speech_Analysis_syn.sh --> This code will convert MFCC to mgc.

nn_mfc.py --> Is the python neural network code, which uses original audio files as labels and synthesized files as input to the model.

Speech-enhancement-DNN/data_preparation/ contains miscellaneous codes to assist in data preparation.
######  dtw is the discrete time warping code, which is used to match the lengths of input and output features of the neural network

Abstract:

We consider the problem of text-to-speech (TTS) synthesis using the
statistical parametric speech synthesis (SPSS) framework using hidden
Markov models. Typically, a statistical model based synthesis engine
smooths out the parameter trajectories and causes buzziness in the
synthesized speech. Consequently, the synthesized speech does not sound
natural. In order to address this issue, we formulate the problem of
parameter restoration as one of regression, which we solve using a
feedforward deep neural network. We consider both mel-frequency cepstral
coefficients (MFCCs) and mel-generalized cepstral coefficients (MGCs) as
parameter representations for the regression problem. The network is
trained to accept the parameter vectors emanating from synthesized speech
as the input and those of the natural speech as output. Experiments show
that MGCs are a better feature representation for the regression problem.
Unlike most standard postfiltering techniques, a feedforward deep neural
network allows for nonlinear smoothing and preserves the sharpness of
formant peaks. Validations using a HMM-based TTS system for English and
Kannada show an improvement in the PESQ scores.


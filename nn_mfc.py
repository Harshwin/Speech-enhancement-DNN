# -*- coding: utf-8 -*-
"""
Created on Thu Feb  9 16:40:00 2017

@author: spectrumlab
"""


# 3. Import libraries and modules
import numpy as np
np.random.seed(123)  # for reproducibility
 
from keras.models import Sequential
from keras.layers import Dense, Dropout, Activation, Flatten
from keras.layers import Convolution2D, MaxPooling2D
from keras.utils import np_utils
from keras.datasets import mnist
from keras.optimizers import Adam
import scipy.io as sio 
from keras.models import model_from_json
import matplotlib.pyplot as plt
import keras


class LossHistory(keras.callbacks.Callback):
    def on_train_begin(self, logs={}):
        self.losses = []

    def on_batch_end(self, batch, logs={}):
        self.losses.append(logs.get('loss'))








# 4. Load pre-shuffled MNIST data into train and test sets

 
# 5. Preprocess input data
X_train = sio.loadmat('/home/spectrumlab/Documents/Harshwin/Using_mgc/english/English_concat_orig_mgc_500.mat')['O_mgc']

 
# 6. Preprocess class labels
Y_train =  sio.loadmat('/home/spectrumlab/Documents/Harshwin/Using_mgc/english/English_concat_synth_mgc_500.mat')['S_mgc']


#keras.layers.advanced_activations.LeakyReLU(alpha=0.3)
# 7. Define model architecture
model = Sequential()
model.add(Dense(35, input_dim=35, init='uniform', activation='relu'))
model.add(Dense(1024, init='uniform', activation='relu'))
model.add(Dropout(0.2))
model.add(Dense(1024, init='uniform', activation='relu'))
model.add(Dropout(0.2))
#model.add(Dense(512, init='uniform', activation='LeakyReLU'))
#model.add(Dense(512, init='uniform', activation='LeakyReLU'))
model.add(Dense(35, activation='linear'))

# 8. Compile model
#adam = Adam(lr=0.001, beta_1=0.9, beta_2=0.999, epsilon=1e-08, decay=0.0)
#model.compile(loss='mse', optimizer='adam', metrics=['accuracy'])
model.compile(loss='mse', optimizer='rmsprop', metrics=['accuracy'])
history = LossHistory()
 
# 9. Fit model on training data
model.fit(Y_train, X_train, 
          batch_size=100, nb_epoch=50, verbose=0, callbacks=[history])



# 10. Evaluate model on test data
score = model.evaluate(X_train, Y_train, verbose=0)
print "%s: %.2f%%" % (model.metrics_names[1], score[1]*100)
 # serialize model to JSON
model_json = model.to_json()
with open("model_mgc_dropout.json", "w") as json_file:
    json_file.write(model_json)
# serialize weights to HDF5
model.save_weights("model_mgc_dropout.h5")
print("Saved model to disk")


# load json and create model
json_file = open('/home/spectrumlab/Documents/Harshwin/Using_mgc/kannada/model_mgc_500_n100l2.json', 'r')
loaded_model_json = json_file.read()
json_file.close()
loaded_model = model_from_json(loaded_model_json)
# load weights into new model
loaded_model.load_weights("/home/spectrumlab/Documents/Harshwin/Using_mgc/kannada/model_mgc_500_n100l2.h5")
print("Loaded model from disk")

test_orig=sio.loadmat('/home/spectrumlab/Documents/Harshwin/Using_mgc/Orig_mgc_matt/cmu_us_arctic_slt_text_512.mat')['mgc_O']
test_orig=np.matrix.transpose(test_orig)
test = sio.loadmat('/home/spectrumlab/Documents/Harshwin/Using_mgc/Synth_mgc_matt/cmu_us_arctic_slt_text_512.mat')['mgc_S']
test = np.matrix.transpose(test)
pred = loaded_model.predict(test)



test2 = sio.loadmat('/home/spectrumlab/Documents/Harshwin/Using_mgc/english/Synth_mgc_matt/cmu_us_arctic_slt_a0593.mat')['mgc_S']
test2 = np.matrix.transpose(test2)
pred2 = loaded_model.predict(test2)

plt.figure(3)
plt.plot(test.flatten(),color='blue')
plt.plot(pred.flatten(),color='black')
plt.plot(test_orig.flatten(),color='red')

plt.figure()
plt.plot(test2[1,:])
plt.plot(pred2[1,:],color='red')



fig=plt.figure()
fig.suptitle('1st mgc vector')
plt.plot(test[1,:],color='blue',label='mgc_TTS')
plt.plot(pred[1,:],color='black',label='mgc_predicted_NN')
plt.plot(test_orig[1,:],color='red',label='mgc_original_Wave')
plt.legend(loc='bottom right')
plt.xlabel('mgc vector indices')
plt.ylabel('value')
#fig.savefig('test.jpg')


fig=plt.figure()
fig.suptitle('1st mgc vector')
plt.plot(test[:,1],color='blue',label='mgc_TTS')
plt.plot(pred[:,1],color='black',label='mgc_predicted_NN')
plt.plot(test_orig[:,1],color='red',label='mgc_original_Wave')
plt.legend(loc='lower right')
plt.xlabel('frame index')
plt.ylabel('1st mgc coefficient')
fig.savefig('test1.jpg')


plt.figure(figsize=(6, 3))
plt.plot(history.losses)
plt.ylabel('error')
plt.xlabel('iteration')
plt.title('training error')
plt.show()

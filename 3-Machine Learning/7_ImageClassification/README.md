# Assignment 7 - Image Classification

This project aims to build an image classifier that is capable of properly identifying four different categories of image. 

The data consists of various train and test samples across the four categories of image. The data for a specific category is a singular image that has been flipped, rotated, or slightly altered in some way. 

1. Data Processing
  a) Use the "ImageDataGenerator()" class from keras.processing.image to build out an instance called "train_datagen" with the following parameters
  b) Then build your training set by using the method ".flow_from_directory()"
  
2. Initial Classifier Build: 
  a) Create an instance of Sequential called "classifier"
  b) Add a Conv2D layer with the following parameters
  c) Add a MaxPooling2D layer where pool_size = (2,2)
  d) Add another Conv2D layer
  e) Add a MaxPooling2D layer where pool_size = (2,2)
  f) Add a Flatten layer
  g) Add a Dense layer
  h) Add a final Dense layer (this will output our probabilities)
  i) Compile
  
3. Model Runs
  a) Use .fit() with the training set
  b) save model to a file
  c) Predict using the model built in step 2
  d) Determine accuracy
  e) Run this process for some combinations


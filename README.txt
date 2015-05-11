Speech Emotion Classification - SYDE 522 Group 7
Devs: Nick Mostowich, Imaad Umar, Ruchir Doshi, Shouvik D'Costa

******************************************************************************************** 

This program will classify emotional state based on the speech sample provided. 
The emotions are classified into one of the six emotions: Anger, Disgust, Fear, Happiness, Sadness, Surprise

********************************************************************************************
REQUIRED LIBs:


It requires Voicebox toolbox as wellas RASTAMat to run. The files are included in the zip. Ensure that 
the folders for the two toolboxes are added to the path in Matlab, along with the folders containing the audio files.

********************************************************************************************
TO RUN

NOTE: Most of the data extraction takes hours to run and therefore we have provided pre extracted
files as "training_data_allmel.dat" and "training_data_allmell_fuzzy.dat". If you choose
to still run the scripts please see the optional instructions below.

1. (Optional) Extract feature vector for all audio samples
	a. Change the directory path of extract_script.m to the appropriate location contianing the .wav files
	b. Change the output directory at the bottom of the file
	c. Run Extract_Script.m

2. (Optional) Fuzzification of the extracted feature vector
	a. Change the directory path in the fuzzify.m to the location of the training data obtained in step 1C.
	b. Change the indices in the file as instructed by the comments.
	c. Change the output name at the bottom of the file to the desired name.
	d. Run fuzzify.m

3. Run the getTarget.m script to get the target matrix that maps the audio sample to an emotion

4. Run neuralnetSetup.m (crispy data)

5. Run neuralnetSetupwFuzzy.m (Fuzzified data)

6. View the results in the following format [{perceptron sizes}, confusion value, performance]
	a. Crispy value results are stored in 'results' folder
	b. Fuzzified value results are stored in 'fuzz' folder
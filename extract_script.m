clear all
clc

% Specify the directory where the sample size is stored
% Replace '\' with '/' for MAC OSX or Linux Machines
files = dir('ConvertedAudio\*.wav');
fv_train = [;];
i = 1;

% Label - 1 = anger, 2 = disgust, 3 = fear, 4 = happiness, 5 = sadness,
% 6 = surprise

% Iterates through all the files in the specified directory
for file = files'
    [data, fs] = audioread(file.name);
    fv_norm = ExtractFeatures(data, fs);
    fv_mel = ExtractFeaturesMel(data,fs);
    label = 0;
    % Assignes label to the feature vector for class identification
    % purposes
    if ~isempty(strfind(file.name,'_an_'))
        label = 1;
    elseif ~isempty(strfind(file.name,'_di_'))
        label = 2;
    elseif ~isempty(strfind(file.name,'_fe_'))
        label = 3;
    elseif ~isempty(strfind(file.name,'_ha_'))
        label = 4;
    elseif ~isempty(strfind(file.name,'_sa_'))
        label = 5;
    elseif ~isempty(strfind(file.name,'_su_'))
        label = 6;
    end
    fv_train(i,:) = [fv_norm, fv_mel', label];
    i = i+1;
end

% Saving the data to a file so the extraction process does not have to be
% run every single time
dlmwrite('training_data_all_mel.dat',fv_train,'delimiter', ',', 'precision', 20);
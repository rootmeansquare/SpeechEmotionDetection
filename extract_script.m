clear all
clc

files = dir('ConvertedAudio/*.wav');
fv_train = [;];
i = 1;

% Label >>>> 1 = anger, 2 = disgust, 3 = fear, 4 = happiness, 5 = sadness,
% 6 = surprise

for file = files'
    mel_filename = ['MelAudio/',file.name,'_m.wav'];
    [data, fs] = audioread(file.name);
    [mel_data, mel_fs] = audioread(mel_filename);
    fv_norm = ExtractFeatures(data, fs);
    fv_mel = ExtractFeatures(mel_data,mel_fs);
    label = 0;
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
    fv_train(i,:) = [fv_norm, fv_mel, label];
    i = i+1;
end
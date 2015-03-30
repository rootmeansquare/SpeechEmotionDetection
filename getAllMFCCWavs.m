clear all
clc

files = dir('ConvertedAudio/*.wav');

for file = files'
    mfcc2wav(file.name);   
end
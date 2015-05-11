% Specify the directory where the sample size is stored
% Replace '\' with '/' for MAC OSX or Linux Machines

files = dir('ConvertedAudio/*.wav');

for file = files'
    % Extracts MFCCs and converts them back into a .wav file
    mfcc2wav(file.name);   
end
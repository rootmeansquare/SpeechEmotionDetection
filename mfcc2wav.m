function mfcc2wav( inputfile )
%mffc2wav [filename]: Conversion of the raw audio signal into mfcc scaled
%audio.
% Reads the wav file, outputs a frequency vector and sampling rate. Uses
% ratamat toolbox amd melfcc module to calculate PLP and MFCC. Then the
% invmelfcc module converts the cepstral coefficients into spectograms and
% noise excited waveforms. The options for invmelfcc should be exactly the
% same as mefcc in order to reverse the process.


[d,sr] = audioread(inputfile);

% Check if the audio signal has two channels. If it does, then the signal
% is converted into mono by taking the mean of the two channels.
[m, n] = size(data);
if n == 2
    data = mean(data, 2);
end

% Convert to MFCCs very close to those genrated by feacalc -sr 22050 -nyq 8000 -dith -hpf -opf htk -delta 0 -plp no -dom cep -com yes -frq mel -filt tri -win 32 -step 16 -cep 20
[mm,aspc] = melfcc(d*3.3752, sr, 'maxfreq', 8000, 'numcep', 20, 'nbands', 22, 'fbtype', 'fcmel', 'dcttype', 1, 'usecmp', 1, 'wintime', 0.032, 'hoptime', 0.016, 'preemph', 0, 'dither', 1);

% .. then convert the cepstra back to audio (same options)
[im,ispc] = invmelfcc(mm, sr, 'maxfreq', 8000, 'numcep', 20, 'nbands', 22, 'fbtype', 'fcmel', 'dcttype', 1, 'usecmp', 1, 'wintime', 0.032, 'hoptime', 0.016, 'preemph', 0, 'dither', 1); 

audiowrite(['MelAudio/',inputfile,'_m.wav'],im/4,sr);

end


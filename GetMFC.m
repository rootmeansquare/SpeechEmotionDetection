function [ MFCC ] = GetMFC( x, fs )
%Developed by Nick Mostowich for SYDE 312 and 552
%   The Mel Frequency Cepstrum is a power spectrum representation of an
%   audio signal based on the transformation to a non linear scale that 
%   approximates how a human ear hears pitches.
%   There are 5 main steps:
%       1) take the Fourier transform of the signal
%       2) map that transform to the mel scale
%       (http://en.wikipedia.org/wiki/Mel_scale)
%       3) take the logs of those powers at each mel frequency
%       4) take the discrete cosine transform as if it were a normal audio
%       signal transforming BACK into the time domain
%       5) the coefficients of 4) are the feature weightings of our signal

x_freq = fft(x); %x_freq is now expressed in standard coordinates



MFCC = [];
end


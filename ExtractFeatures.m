function [ feature_vec ] = ExtractFeatures( data, freq )
%EXTRACTFEATURES extracts 8 features from an audio sample:
%   feature_vec is 11 elements long:
    % 1: mean pitch, 2: min pitch, 3: max pitch, 4: pitch variance,
    % 5: median pitch, 6: mean pitch deriv, 7: min pitch deriv,
    % 8: max pitch deriv, 9: pitch deriv variance, 10: median pitch deriv
    % 11: average speech spurt length
[pitch, frames] = fxrapt(mean(data,2), freq);
meanpitch = nanmean(pitch);
minpitch = min(pitch);
maxpitch = max(pitch);
varpitch = nanvar(pitch);
medianpitch = nanmedian(pitch);

pitchderiv = diff(pitch); %439 samples per frame
meanpitchderiv = nanmean(pitchderiv);
minpitchderiv = min(pitchderiv);
maxpitchderiv = max(pitchderiv);
varpitchderiv = nanvar(pitchderiv);
medianpitchderiv = nanmedian(pitchderiv);

talkspurtlengths = [];
curlen = 1;
for i=1:length(frames) %ugly for loop that changes i
    if (isnan(pitch(i))) %no speech in this sample
        continue
    end
    if(frames(i,3) == 1) %indicates the start of a talk spurt
        i = i + 1;
        while (i <= length(frames) && frames(i,3) == 0)
            curlen = curlen + 1;
            i = i + 1;
        end
        talkspurtlengths = [talkspurtlengths, curlen]; %inefficient for preallocation, efficient overall size
        curlen = 1;
    end
end
meanspurtlength = mean(talkspurtlengths);

feature_vec = [ meanpitch, minpitch, maxpitch, varpitch, medianpitch,...
    meanpitchderiv, minpitchderiv, maxpitchderiv, varpitchderiv,...
    medianpitchderiv, meanspurtlength ];

end


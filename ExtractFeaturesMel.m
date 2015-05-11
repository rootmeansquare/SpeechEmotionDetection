function [ fv ] = ExtractFeaturesMel( d, fs )
%EXTRACT 13 Mel Coefs and then the 5 feature sets (NaN not counted) for
%each Mel Coef
[m, n] = size(d);
if n == 2
    d = mean(d, 2);
end
n_cep = 13;
%get mel
mm = melfcc(d*3.3752, fs, 'maxfreq', 8000, 'numcep', n_cep, 'nbands', 22, 'fbtype', 'fcmel', 'dcttype', 1, 'usecmp', 1, 'wintime', 0.032, 'hoptime', 0.016, 'preemph', 0, 'dither', 1);
%get time derivative of mel
mmderiv = diff(mm,1,2);
fv = zeros(130,1);

%get 5 features of mel (not couting NaN)
for i=0:12
    j = 10*i;
    fv(j+1) = nanmean(mm(i+1,:));
    fv(j+2) = min(mm(i+1,:));
    fv(j+3) = max(mm(i+1,:));
    fv(j+4) = nanvar(mm(i+1,:));
    fv(j+5) = nanmedian(mm(i+1,:));
    fv(j+6) = nanmean(mmderiv(i+1,:));
    fv(j+7) = min(mmderiv(i+1,:));
    fv(j+8) = max(mmderiv(i+1,:));
    fv(j+9) = nanvar(mmderiv(i+1,:));
    fv(j+10) = nanmedian(mmderiv(i+1,:));
end
end


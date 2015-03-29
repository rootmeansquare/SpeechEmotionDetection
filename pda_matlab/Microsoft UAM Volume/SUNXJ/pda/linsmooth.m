function [y]=linsmooth(x,n,wintype)
% linsmooth(x,wintype,n) : linear smoothing
% x: input
% n: length of window
% wintype: window type, default: 'hann'

if nargin<3
   wintype='hann';
end

if nargin<2
   n=3;
end
[r,c]=size(x);
if min(r,c)~=1
   error('sorry, no matrix here!:(')
end

if r==1 % row vector
   %x=x.';
   len=c;
else
   len=r;
   x=x.';
end
y=zeros(len,1);
% pad ends to compensate for filter length
if mod(n,2)==0
   l=n/2;
   x = [ones(1,l)*x(1) x ones(1,l)*x(len)]';
else
   l=(n-1)/2;
   x = [ones(1,l)*x(1) x ones(1,l+1)*x(len)]';
end
win=window(n,wintype);
win=win/sum(win); % normalization
for k=1:len
	y(k) = win*x(k:k+n-1);
end
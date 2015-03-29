function y = medsmooth(x,L)
%y = medsmooth(x,L) Median smoothing filter.
% the order of the filter has very different effects on the output. even order tends to have
% interpolation effect, which is similar to smoothing. i guess i should use even order more often for pitch contours.
% for image processing, i guess using odd order is better cause it can preserve the sharpness
if nargin ~= 2,
    error('usage: y=medsmooth(x,L)');
end;
[r,c]=size(x);
if min(r,c)~=1
   error('sorry, no matrix here!:(')
end
if r==1 % row vector
   len=c;
else
   x=x.';
   len=r;
end

y = zeros(len,1);
% pad ends to compensate for filter length
if mod(L,2)==0
   l=L/2;
   % x = [zeros(1,l) x zeros(1,l)]';
   x1 = [ones(1,l-1)*x(1) x ones(1,l+1)*x(len)]';
   x2 = [ones(1,l)*x(1) x ones(1,l)*x(len)]';
else
   l=(L-1)/2;
   % x = [zeros(1,l) x zeros(1,l+1)]';
   x1 = [ones(1,l)*x(1) x ones(1,l+1)*x(len)]';
end

% median filter
for k=1:len
	y(k,1) = median(x1(k:k+L-1));
end
if mod(L,2)==0
	% using even length, we have bias, so we run it again but shift the window one point right
	y1=zeros(len,1);
	for k=1:len
		y1(k,1) = median(x2(k:k+L-1));
	end
	y=(y+y1)/2;
end
	

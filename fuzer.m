function [normed] =  fuzer(trainingFull)
% Call the fuzzification script
 [normed, sortedData] = statss(trainingFull);

end



function [fuzzPlace,sortedData] =  statss(training)
% Creating zero arrays
[len, wid] = size(training(:,1));
splSize = floor(len/5);

%sorts data
sortedData = sort(training);
statsData = zeros(5,2);
fuzzTemp = zeros(len,5);
fuzzPlace = zeros(len,1);

norms = zeros(len);

%NOTE: the indicies are hardcoded to split the data into 5 even sections
%assuming a vector length of 1263, please change as necessary

% Gets mean per 5 sections of data
statsData(1,1) = mean(sortedData(1:252,1));
statsData(2,1) = mean(sortedData(253:505,1));
statsData(3,1) = mean(sortedData(506:758,1));
statsData(4,1) = mean(sortedData(759:1011,1));
statsData(5,1) = mean(sortedData(1012:1263,1));

% Gets variance per 5 sections of data
statsData(1,2) = std(sortedData(1:252,1));
statsData(2,2) = std(sortedData(253:505,1));
statsData(3,2) = std(sortedData(506:758,1));
statsData(4,2) = std(sortedData(759:1011,1));
statsData(5,2) = std(sortedData(1012:1263,1));

% Creates norm probaility distribution function per 5 sections of data
norms(1:252,1) = normpdf(sortedData(1:252,1),statsData(1,1),statsData(1,2));
norms(253:505,1) = normpdf(sortedData(253:505,1),statsData(2,1),statsData(2,2));
norms(506:758,1) = normpdf(sortedData(506:758,1),statsData(3,1),statsData(3,2));
norms(759:1011,1) = normpdf(sortedData(759:1011,1),statsData(4,1),statsData(4,2));
norms(1012:1263,1) = normpdf(sortedData(1012:1263,1),statsData(5,1),statsData(5,2));

% Gets proabilty for each 5 sections ("membership")
fuzzTemp(:,1) = normpdf(training,statsData(1,1),statsData(1,2));
fuzzTemp(:,2) = normpdf(training,statsData(2,1),statsData(2,2));
fuzzTemp(:,3) = normpdf(training,statsData(3,1),statsData(3,2));
fuzzTemp(:,4) = normpdf(training,statsData(4,1),statsData(4,2));
fuzzTemp(:,5) = normpdf(training,statsData(5,1),statsData(5,2));


%Finds highest probabilty (membership) and replaces original value with
%bucket label
for i = 1:len
    bestIndex = find(fuzzTemp(i,:) == max(fuzzTemp(i,:)));
    fuzzPlace(i,:) = bestIndex;
    
end 


end 
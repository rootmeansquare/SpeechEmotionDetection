%Calls the fuzzification script "fuzer" to fuzzify each column of the
%training data

toFuzz = load('training_data_allmel.dat');
[r,c] = size(toFuzz);
fuzzed = zeros(r,c);

for i=1:141
    fuzzed(:,i) = fuzer(toFuzz(:,i));
end

fuzzed(:,142) = toFuzz(:,142);

dlmwrite('training_data_allmell_fuzzy.dat',fuzzed);
range = length(fv_train);
for i = 1:range
    if mod(i,5) == 0
        dlmwrite('testData.dat', fv_train(i,:), '-append', 'delimiter', ',', 'precision', 20);
    else
        dlmwrite('trainingData.dat', fv_train(i,:), '-append', 'delimiter', ',', 'precision', 20);
    end
end
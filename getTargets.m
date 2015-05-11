filename = 'training_data_allmel.dat';
data = csvread(filename);

% Generates a target matrix to classify an audio sample in to one of the
% six emotions

[rows, ools] = size(data);
for i = 1:rows
    if data(i,142) == 1
        target =[1,0,0,0,0,0];
    elseif data(i,142) == 2
        target =[0,1,0,0,0,0];
    elseif data(i,142) == 3
        target =[0,0,1,0,0,0];
    elseif data(i,142) == 4
        target =[0,0,0,1,0,0];
    elseif data(i,142) == 5
        target =[0,0,0,0,1,0];
    elseif data(i,142) == 6
        target =[0,0,0,0,0,1];
    end
    
    dlmwrite('target.dat',target, '-append', 'delimiter', ',');
end
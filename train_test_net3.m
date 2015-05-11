function [ confusion_value, performance ] = train_test_net3( input, target, i, j, k)
% Solve a Pattern Recognition Problem with a Neural Network
% This script assumes these variables are defined:
%
%   input - input data.
%   target - target data.

x = input';
t = target';

% Create a Pattern Recognition Network
hiddenLayer1Size = i*50;
hiddenLayer2Size = j*50;
hiddenLayer3Size = k*50;
net = patternnet([hiddenLayer1Size,hiddenLayer2Size,hiddenLayer3Size]);


% Setup Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;


% Train the Network
%[net,tr] = train(net,x,t,'useParallel','yes','useGPU','only');
[net,tr] = train(net,x,t);


% Test the Network
y = net(x);
e = gsubtract(t,y);
tind = vec2ind(t);
yind = vec2ind(y);
percentErrors = sum(tind ~= yind)/numel(tind);
performance = perform(net,t,y);
confusion_value = confusion(t,y);

% View the Network
%view(net)

% Plots
% Uncomment these lines to enable various plots.
%figure, plotperform(tr);
%saveas(gcf,['images\triplelayer\perform\',num2str(i*10),'x',num2str(j*10),'x',num2str(k*10),'_perform.png']);
%figure, plottrainstate(tr)
%figure, plotconfusion(t,y);
%saveas(gcf,['images\triplelayer\conf_mat\',num2str(i*10),'x',num2str(j*10),'x',num2str(k*10),'_conf_mat.png']);
%figure, plotroc(t,y)
%figure, ploterrhist(e)
end


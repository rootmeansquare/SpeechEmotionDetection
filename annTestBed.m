fakeData = rand(40,22);
fakeData(1:10,23) = 1;
fakeData(11:20,23) = 2;
fakeData(21:30,23) = 3;
fakeData(31:40,23) = 4;
outputTrain = fakeData(:,end);

net1 = feedforwardnet([10]); %more columns = more hidden layers
net1 = train(net1,fakeData(:,1:22)',outputTrain(:,1)');
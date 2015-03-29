function networkSetup(trainData,trainOutput)
    net1 = feedforwardnet([10]); %more columns, = more hidden layers
    net1 = train(net1,trainData',trainOutput');
    
end 
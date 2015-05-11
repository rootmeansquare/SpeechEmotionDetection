filename = 'training_data_allmell_fuzzy.dat';
data = csvread(filename);
input = data(:,1:141);

targetname = 'target.dat';
target = csvread(targetname);

for i = 5:25
    [c_v1, p_v1] = train_test_net(input,target,i);
    N = [i*10, c_v1, p_v1];
    dlmwrite('fuzz\results_single.dat',N,'-append','delimiter',',');
end

for a = 5:25
    for b = 5:25
        [c_v2, p_v2] = train_test_net2(input,target,a,b);
        M = [a*10, b*10, c_v2, p_v2];
        dlmwrite('fuzz\results_double.dat',M,'-append','delimiter',',');
    end
end

for x = 1:5
    for y = 1:5
        for z = 1:5
            [c_v3, p_v3] = train_test_net3(input,target,x,y,z);
            L = [x*50, y*50, z*50, c_v3, p_v3];
            dlmwrite('fuzz\results_triple.dat',L,'-append','delimiter',',');
        end
    end
end
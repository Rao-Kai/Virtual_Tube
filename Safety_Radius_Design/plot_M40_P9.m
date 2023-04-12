function out = plot_M40_P9
global rs ra
load('M41.mat')
rm = 10;
l  = 5;
vmax = 15;
ro = 0;
rs=15;
ra=1.5*rs;
rd=ra+rs+2*vmax;
M = 41;


    figure(1);
    for i=1:9
    subplot(3,3,i);
    if i ==1
        j=1;
    else if i==2
            j=200;
        else
j=1+3300*(i-2);
        end
    end

%     figure(1);
hold off

    for k = 1: M
    o1 = [data{1}{1}.Values.Data(j,2*k-1) data{1}{1}.Values.Data(j,2*k)]';
    o2 = [data{1}{1}.Values.Data(j,2*k-1)+data{1}{1}.Values.Data(j,82+2*k-1)/l data{1}{1}.Values.Data(j,2*k)+data{1}{1}.Values.Data(j,82+2*k)/l]';
    mydrawcolorball(o1,o2,k);  

    end

    axis([-450 450 -450 450]) 
grid on

    pause(0.1);

end


out = 0;
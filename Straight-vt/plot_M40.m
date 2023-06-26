function out = plot_M40
global rm rs ra rd
hold off
load('M40_NEW.mat')
rm = 9;
l  = 5;
vmax = 15;
ro = 0;
rs=20;
ra=1.5*rs;
rd=ra+rs+2*vmax;
M = 40;
% 2D map
% for k = 1: M
%     for i = 1:UavTeam.Uav(k).AllTaskNum
%     plot(UavTeam.Uav(k).Waypoint(1,i), UavTeam.Uav(k).Waypoint(2,i),'rp')
%     hold on
%     end
% end
% end

% Highway plot
% line11 = [0,500];
% line12 = [150,150];
% plot(line11,line12);
% hold on
%
% line21 = [0,500]';
% line22 = [-150,-150]';
% plot(line21,line22);
% hold on

figure(1);
a=23900;
for j=1:1:a
    % subplot(3,2,(j-1)/4600+1)
    figure(1);
    hold off
    line11 = [0,500];
    line12 = [150,150];
    
    hold on
    
    line21 = [0,700]';
    line22 = [-150,-150]';
    
    hold on
    for k = 1: M
        o1 = [data{1}{1}.Values.Data(j,2*k-1) data{1}{1}.Values.Data(j,2*k)]';
        o2 = [data{1}{1}.Values.Data(j,2*k-1)+1/l*data{1}{1}.Values.Data(j,80+2*k-1) data{1}{1}.Values.Data(j,2*k)+1/l*data{1}{1}.Values.Data(j,80+2*k)]';
        mycircle_y(o1,rd)
        hold on
    end
    for k = 1: M
        o1 = [data{1}{1}.Values.Data(j,2*k-1) data{1}{1}.Values.Data(j,2*k)]';
        o2 = [data{1}{1}.Values.Data(j,2*k-1)+1/l*data{1}{1}.Values.Data(j,80+2*k-1) data{1}{1}.Values.Data(j,2*k)+1/l*data{1}{1}.Values.Data(j,80+2*k)]';
        mycircle_g(o2,ra)
        hold on
    end
    for k = 1: M
        o1 = [data{1}{1}.Values.Data(j,2*k-1) data{1}{1}.Values.Data(j,2*k)]';
        o2 = [data{1}{1}.Values.Data(j,2*k-1)+1/l*data{1}{1}.Values.Data(j,80+2*k-1) data{1}{1}.Values.Data(j,2*k)+1/l*data{1}{1}.Values.Data(j,80+2*k)]';
        mycircle_b(o2,rs)
        hold on
    end
    for k = 1: M
        o1 = [data{1}{1}.Values.Data(j,2*k-1) data{1}{1}.Values.Data(j,2*k)]';
        o2 = [data{1}{1}.Values.Data(j,2*k-1)+1/l*data{1}{1}.Values.Data(j,80+2*k-1) data{1}{1}.Values.Data(j,2*k)+1/l*data{1}{1}.Values.Data(j,80+2*k)]';

        plot(o1(1),o1(2),'k-o','MarkerFaceColor','k','MarkerSize',4)
        hold on
    end
    plot(line11,line12,'r');
    plot(line21,line22,'r');
    hold on
    axis([-600 1000 -600 600])
    grid on
    xlabel('x')
    ylabel('y')
    pause(0.1);
    
end
figure(2)
plot(data{1}{1}.Values.Time,data{1}{1}.Values.Data(:,99));
out = 0;
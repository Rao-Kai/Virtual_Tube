function out = plot_M20
global rm rs ra rd
load('New_Export.mat')
rm = 7;
l  = 5;
vmax = 10;
ro = 0;
rs=20;
ra=1.5*rs;
rd=ra+rs+2*vmax;
M = 20;
% 2D map
% for k = 1: M
%     for i = 1:UavTeam.Uav(k).AllTaskNum  
%     plot(UavTeam.Uav(k).Waypoint(1,i), UavTeam.Uav(k).Waypoint(2,i),'rp')
%     hold on
%     end
% end
% end

% Highway plot
line11 = [0,500];
line12 = [50,50];
plot(line11,line12);
hold on

line21 = [0,500]';
line22 = [-50,-50]';
plot(line21,line22);
hold on


for j=1:50:16001
    figure(1);
hold off
line11 = [0,700];
line12 = [50,50];
plot(line11,line12);
hold on

line21 = [0,700]';
line22 = [-50,-50]';
plot(line21,line22);
hold on
    for k = 1: M
    o1 = [data{1}{1}.Values.Data(j,2*k-1) data{1}{1}.Values.Data(j,2*k)]';
    o2 = [data{1}{1}.Values.Data(j,2*k-1)+1/5*data{1}{1}.Values.Data(j,40+2*k-1) data{1}{1}.Values.Data(j,2*k)+1/5*data{1}{1}.Values.Data(j,40+2*k)]';
    mydrawcolorball(o1,o2,k);  

    end
    axis([-600 1500 -550 550]) 
grid on
xlabel('x')
ylabel('y')
    pause(0.05);

end
axis([-600 1500 -550 550]) 
grid on
xlabel('x')
ylabel('y')

out = 0;
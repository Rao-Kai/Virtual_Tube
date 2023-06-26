function out = MyMap(UavTeam,Obstacle,Highway)

M = UavTeam.AvailableNumMax;
% 2D map
% for k = 1: M
%     for i = 1:UavTeam.Uav(k).AllTaskNum  
%     plot(UavTeam.Uav(k).Waypoint(1,i), UavTeam.Uav(k).Waypoint(2,i),'rp')
%     hold on
%     end
% end
% end

% Highway plot
line11 = [Highway(1).ph1(1),Highway(1).ph2(1)-4500];
line12 = [Highway(1).ph1(2)+Highway(1).rh,Highway(1).ph2(2)+Highway(1).rh];
plot(line11,line12);
hold on
line21 = [Highway(1).ph1(1)  Highway(1).ph2(1)-4500]';
line22 = [Highway(1).ph1(2)-Highway(1).rh  Highway(1).ph2(2)-Highway(1).rh]';
plot(line21,line22);
hold on

for k = 1: M
    o1 = [UavTeam.Uav(k).CurrentPos(1) UavTeam.Uav(k).CurrentPos(2)]';
    o2 = [UavTeam.Uav(k).CurrentPos(1)+1/UavTeam.gain*UavTeam.Uav(k).Velocity(1) UavTeam.Uav(k).CurrentPos(2)+1/UavTeam.gain*UavTeam.Uav(k).Velocity(2)]';
    mydrawcolorball(o1,o2,k);  
end
axis([-600 600 -600 600]) 
grid on
xlabel('x')
ylabel('y')

out = 0;
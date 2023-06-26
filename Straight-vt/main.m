clc;
clear all;
global Highway Obstacle
global UavTeam
global gcount gfigure
global rm rs ra rd rv InitialPosition

gcount = 0;
gfigure = 1;
time_end = 50;
rm = 9;
l  = 5;
vmax = 15;
ro = 0;
rs=20;
ra=1.5*rs;
rd=ra+rs+2*vmax;
% Initialize Highway
Highway(1).ph1  = [0  0]'; 
Highway(1).ph2  = [5000  0]';
Highway(1).rh   =  150;
Highway(1).rb   =  50;

% Initialize UavTeam
M = 40; 
UavTeam = UAVInitialization(M,rm,l,vmax);
A=[zeros(2*M,2*M) eye(2*M);zeros(2*M,2*M) l*eye(2*M)];
B=[zeros(2*M,2*M);-l*eye(2*M)];
C=eye(4*M);
D=zeros(4*M,2*M);
Initialcondition=[InitialPosition;zeros(2*M,1)];
for k=1:M
UavTeam.Uav(k).rs = rs;
UavTeam.Uav(k).ra = ra;
end
% One multicopter is close to the edge of the tunnel
UavTeam.Uav(1).Waypoint = [0;149.9];
UavTeam.Uav(1).HomePos = UavTeam.Uav(1).Waypoint;
UavTeam.Uav(1).CurrentPos= UavTeam.Uav(1).Waypoint;
% UavTeam.Uav(1).vmax = 20;
% % 
% % % % Two multicopters are close to each other
% UavTeam.Uav(2).Waypoint = [-500;0.1];
% UavTeam.Uav(2).HomePos = UavTeam.Uav(2).Waypoint;
% UavTeam.Uav(2).CurrentPos= UavTeam.Uav(2).Waypoint;
% % UavTeam.Uav(k).vmax = 50;
% 
% UavTeam.Uav(3).Waypoint = [-500;-0.1];
% UavTeam.Uav(3).HomePos = UavTeam.Uav(3).Waypoint;
% UavTeam.Uav(3).CurrentPos= UavTeam.Uav(3).Waypoint;


% Draw 2D map
figure(1);
% subplot(3,2,1)
MyMap_init(UavTeam,Obstacle,Highway);
 
%  for k = 1: M
%     o = [UavTeam.Uav(k).CurrentPos(1) UavTeam.Uav(k).CurrentPos(2)]';
%     mydrawcolorball(o(1),o(2),k);   
% end
 tic
'start'
sim('platform.slx')
'over'
toc
figure(2)
subplot(2,1,2)
plot(mindis(1:end-2000,1),mindis(1:end-2000,3),'-','LineWidth',2); hold on;
ksm = find(mindis(:,3)==min(mindis(:,3)));
text(mindis(ksm(1),1),mindis(ksm(1),3),['\leftarrow' num2str(mindis(ksm(1),3))],'HorizontalAlignment','left')
plot(mindis(1:end-2000,1),rs*ones(size(mindis(1:end-2000,1))),'r-.','LineWidth',1);
legend('Between two multicopters')
axis([0 230 0 60])
xlabel('t(sec)')
ylabel('Between multicopter and tunnel edge(m)')

subplot(2,1,1)
plot(mindis(1:end-2000,1),mindis(1:end-2000,4),'-','LineWidth',2); hold on;
ksh = find(mindis(:,4)==min(mindis(:,4)));
text(mindis(ksh(1),1),mindis(ksh(1),4),['\leftarrow' num2str(mindis(ksh(1),4))],'HorizontalAlignment','left')
plot(mindis(1:end-2000,1),2*rs*ones(size(mindis(1:end-2000,1))),'r-.','LineWidth',1);
xlabel('t(sec)')
ylabel('minimum distance(m)')
axis([0 230 0 60])
legend('Minimum distance(m)')

hold off
    
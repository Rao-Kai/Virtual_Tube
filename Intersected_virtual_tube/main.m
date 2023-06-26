clc;
clear all;
dbstop if error;
global UavTeam Ts
global rs ra rv rd width length Gainfactor_rs Gainfactor_ra control_mode
global inflow_settings time_end M bp bv
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% initial settings
width = 250; %width(m)
length = 250; %length(m)
Ts=0.1; %step time(s)
rs=10; %safety radius(m)
ra=2*rs;%avoidance radius(m)
bp=0;
bv=0;
switchtime = [0;1;2;3;4;5;6];%(min)
switchvalue = [1;1;2;2;1;0];%(veh/s)
glowthrate = [0;1;0;-1;0;0]; %INFLOW SETTINGS
Gainfactor_rs = 1;
Gainfactor_ra = 1; % do not change these 2 parameters if not necessary
control_mode = 2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% do not modify the
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% following codes
inflow_settings = inflowInitialization(switchtime,switchvalue,glowthrate);
M = inflow_settings.totalnum(end);
% Initialize UavTeam
time_end=inflow_settings.time(end)*60;
UavTeam = UAVInitialization(M);
L=UavTeam.gain;
rd=ra+rs+2*rv;
for k=1:M
    UavTeam.Uav(k).rs = rs;
    UavTeam.Uav(k).ra = ra;
end
'start'
sim('platform_B1.slx')
'over'
save('UAVstate1.mat','UAVstates')
save('UAVstate_e1.mat','UAVstates_e')
cal_distance
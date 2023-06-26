function UavTeam = UAVInitialization(M)
% Initialize UAV

global Obstacle
global rv vm Ts bp bv
% The number of UAVs
UavTeam.AvailableNumMax  = M;
UavTeam.Ts               = Ts;
UavTeam.gain             = 5;
L=UavTeam.gain;
UavTeam.Noise.bp=bp;
UavTeam.Noise.bv=bv;
% UavTeam.Noise.bl=bl;
% UavTeam.PacketLossRate=theta;

adjust_parameter = 1.1;% huanchongqu
vm = 0;
rv = 0;
r_distribute = 400;

L=UavTeam.gain;
% Distances between among waypoints and obstacles have to be greater than a
% value. So SavedWPOB is defined to save current waypoints and obstacles for distance check.
sz   =  size(Obstacle);

% Write down the waypoint
for k = 1: UavTeam.AvailableNumMax
    UavTeam.Uav(k)=createUAV(k,L);
    if UavTeam.Uav(k).rv>rv
        rv=UavTeam.Uav(k).rv;
    end
    if UavTeam.Uav(k).vmax>vm
        vm=UavTeam.Uav(k).vmax;
    end   
end
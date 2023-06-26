function [sys,x0,str,ts] = AttitudeDynamics(t,x,u,flag)
global UavTeam width length
M = UavTeam.AvailableNumMax;
L = UavTeam.gain;

switch flag,
    case 0,
        [sys,x0,str,ts]=mdlInitializeSizes;
%     case 1,
%         sys=mdlDerivatives(t,x,u);
    case 2,
        sys=mdlUpdate(t,x,u);
    case 3,
        sys=mdlOutputs(t,x,u);
    case {1,4,9}
        sys=[];
    otherwise
        error(['Unhandled flag = ',num2str(flag)]);
end
function [sys,x0,str,ts]=mdlInitializeSizes
global UavTeam Ts
% Initialize multicopter positions
Pint = [];
for  k = 1: UavTeam.AvailableNumMax
    Pint = [Pint; UavTeam.Uav(k).HomePos];
end
for  k = 1: UavTeam.AvailableNumMax
    Pint = [Pint; UavTeam.Uav(k).Velocity];
end

sizes = simsizes;
sizes.NumContStates  = 0;
sizes.NumDiscStates  = 4*UavTeam.AvailableNumMax;
% sizes.NumContStates  = 4*UavTeam.AvailableNumMax;
% sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 7*UavTeam.AvailableNumMax;
sizes.NumInputs      = 2*UavTeam.AvailableNumMax;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0  = Pint;
str = [];
ts  = [-1 0];

% function sys = mdlDerivatives(t,x,u)
% global UavTeam
% M = UavTeam.AvailableNumMax;
% L = UavTeam.gain;
% sys(1:2*M) = x(2*M+1:4*M);
% sys(2*M+1:4*M) = -UavTeam.gain*(x(2*M+1:4*M)-u);

function sys = mdlUpdate(t,x,u)
global UavTeam Ts
M = UavTeam.AvailableNumMax;
L = UavTeam.gain;

for k =1:M
    switch UavTeam.Uav(k).state
        case 0
            sys(2*k-1:2*k)=x(2*k-1:2*k);
            sys(2*M+2*k-1:2*M+2*k)=x(2*M+2*k-1:2*M+2*k);
        case 1
            sys(2*k-1:2*k) = x(2*k-1:2*k)+Ts*x(2*M+2*k-1:2*M+2*k);
%             sys(2*M+2*k-1:2*M+2*k) = (1-UavTeam.gain*Ts)*x(2*M+2*k-1:2*M+2*k)+UavTeam.gain*Ts*u(2*k-1:2*k);
            sys(2*M+2*k-1:2*M+2*k) = u(2*k-1:2*k);
            
        case 2
            sys(2*k-1:2*k) = x(2*k-1:2*k);
            sys(2*M+2*k-1:2*M+2*k) = zeros(2,1);
            % sys(2*k-1:2*k) = x(2*M+2*k-1:2*M+2*k);
            % sys(2*M+2*k-1:2*M+2*k) = (-UavTeam.gain)*(x(2*M+2*k-1:2*M+2*k)-u(2*k-1:2*k));
            
    end
end

function sys=mdlOutputs(t,x,u)
global UavTeam
M = UavTeam.AvailableNumMax;
L = UavTeam.gain;

% for k=1:M
%     if norm(UavTeam.Uav(k).CurrentPos-UavTeam.Uav(k).Waypoint(:,2))<1
%
%         UavTeam.Uav(k)=createUAV(k,L);
%         x(2*k-1:2*k)=UavTeam.Uav(k).CurrentPos;
%         x(2*M+2*k-1:2*M+2*k)=UavTeam.Uav(k).Velocity;
%     end
%
% end
sys(1:4*M)=x(1:4*M);
for k =1:M
    sys(4*M+k)=UavTeam.Uav(k).startline;
    sys(5*M+k)=UavTeam.Uav(k).finishline;
    sys(6*M+k)=UavTeam.Uav(k).state;
end

function u = mycontrol(i,matrix)
global Obstacle
global UavTeam E bp bv length width control_mode

L=UavTeam.gain;
gamma =  1;
Pcur  =  UavTeam.Uav(i).Pes;
Vcur  =  UavTeam.Uav(i).Ves;
Pdes  =  UavTeam.Uav(i).Waypoint(:,UavTeam.Uav(i).CurrentTaskNum);
%    rs = UavTeam.Uav(i).rs*2.5;
%    ra = UavTeam.Uav(i).ra*2;
vm = UavTeam.Uav(i).vmax;
% Velocity to waypoint
k1 = 50;
switch UavTeam.Uav(i).finishline
    case 1
        p2 = [-length/2 width/2]';
        p3 = [length/2 width/2]';
    case 2
        p2 = [length/2 -width/2]';
        p3 = [length/2 width/2]';
    case 3
        p2 = [-length/2 -width/2]';
        p3 = [length/2 -width/2]';
    case 4
        p2 = [-length/2 -width/2]';
        p3 = [-length/2 width/2]';
end
switch control_mode
    case 1
At23 = eye(2) - (p2-p3)*(p2-p3)'/(norm(p2-p3)*norm(p2-p3)); 
    case 2
At23= eye(2);
end
ksi_w  = Pcur + 1/UavTeam.gain*Vcur - Pdes;
Vw = - mysat(k1*At23*ksi_w,vm);

%     if norm(Vw)<vm
%         UavTeam.Uav(i).state=2;
%     end

% %   % Velocity away other multicopters
Vmx=sum(matrix(2*i-1,:));
Vmy=sum(matrix(2*i,:));
Vm=[Vmx;Vmy];
% Sum of all velocities
u = mysat(Vw+Vm,vm);
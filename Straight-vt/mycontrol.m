function u = mycontrol(i)
global Highway
global UavTeam

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Pcur  =  UavTeam.Uav(i).CurrentPos;
Vcur  =  UavTeam.Uav(i).Velocity;
Pdes  =  UavTeam.Uav(i).Waypoint(:,UavTeam.Uav(i).CurrentTaskNum);
   rm = UavTeam.Uav(i).r;
   ra = UavTeam.Uav(i).ra;     
 vmax = UavTeam.Uav(i).vmax;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % Area Definition
pt1  = Highway(1).ph1; 
pt2  = Highway(1).ph2;
 rt = Highway(1).rh;
pt3 = Highway(1).ph2 + [0 rt]';
 ksi  = Pcur + 1/UavTeam.gain*Vcur;
 rb = 0;
 rsr= 10000;
 rrt= 10000;
 
 if UavTeam.Uav(i).State == 1  % Left Standby Area
    psr1 = [pt2(1) rt+rsr]';
    psr2 = [-rsr rt+rsr]';
    psr3 = [-rsr rt]';
       u = mytunnel(i,psr1,psr2,psr3,rsr);
    
 elseif  UavTeam.Uav(i).State == 2 % Right Standby Area
   psr1p = [pt2(1) -rt-rsr]';
   psr2p = [-rsr -rt-rsr]';
   psr3p = [-rsr -rt]';
       u = mytunnel(i,psr1p,psr2p,psr3p,rsr); 
       
 elseif  UavTeam.Uav(i).State == 3 % Left Ready Area
   prt1 = [-rrt rt+rrt]';
   prt2 = [-rrt 0]';
   prt3 = [-2*rrt    0]';
       u = mytunnel(i,prt1,prt2,prt3,rrt); 
       
 elseif  UavTeam.Uav(i).State == 4 % Right Ready Area 
   prt1p = [-rrt -rt-rrt]';
   prt2p = [-rrt 0]';
   prt3p = [0    0]';
       u = mytunnel(i,prt1p,prt2p,prt3p,rrt); 
       
 else% Tunnel and Tunnel Extension
       u = mytunnel(i,pt1,pt2,pt3,rt); 
 end
    
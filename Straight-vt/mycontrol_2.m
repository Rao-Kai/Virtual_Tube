function u = mycontrol_2(i)
global Highway
global UavTeam

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Pcur  =  UavTeam.Uav(i).CurrentPos;
Vcur  =  UavTeam.Uav(i).Velocity;
Pdes  =  UavTeam.Uav(i).Waypoint(:,UavTeam.Uav(i).CurrentTaskNum);
   rs = UavTeam.Uav(i).rs;
   ra = UavTeam.Uav(i).ra;     
 vmax = UavTeam.Uav(i).vmax;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % Area Definition
pt1  = Highway(2).ph1; 
pt2  = Highway(2).ph2;
 rt = Highway(2).rh;
pt3 = Highway(2).ph2 + [0 rt]';
 ksi  = Pcur + 1/UavTeam.gain*Vcur;
 rb = ra;
 rsr= 10000;
 rrt= 10000;
 
 if ksi(1)>0 & ksi(2)>rt  % Left Standby Area
    psr1 = [pt2(1) rt+rsr]';
    psr2 = [-rb rt+rsr]';
    psr3 = [-rb rt]';
       u = mytunnel(i,psr1,psr2,psr3,rsr);
    
 elseif  ksi(1)>0 & ksi(2)<-rt % Right Standby Area
   psr1p = [pt2(1) -rt-rsr]';
   psr2p = [-rb -rt-rsr]';
   psr3p = [-rb -rt]';
       u = mytunnel(i,psr1p,psr2p,psr3p,rsr); 
       
 elseif  ksi(1)<=0 & ksi(2)>=rt % Left Ready Area
   prt1 = [-rrt rt+rrt]';
   prt2 = [-rrt rt-rb]';
   prt3 = [0    rt-rb]';
       u = mytunnel(i,prt1,prt2,prt3,rrt); 
       
 elseif  ksi(1)<=0 & ksi(2)<=-rt % Left Ready Area %% wrong
   prt1p = [-rrt rt+rrt]';
   prt2p = [-rrt rt-rb]';
   prt3p = [0    rt-rb]';
       u = mytunnel(i,prt1p,prt2p,prt3p,rrt); 
       
 else% Tunnel and Tunnel Extension
       u = mytunnel(i,pt1,pt2,pt3,rt); 
 end
    
function u = collisioncon(in)
global Highway Obstacle
global UavTeam
global gcount gfigure


gcount = gcount + 1;

M = UavTeam.AvailableNumMax;
V = [];
rh = Highway(1).rh ;
rb=Highway(1).rb;
for k = 1:M
    UavTeam.Uav(k).CurrentPos =  in(2*(k-1)+1:2*k);
    UavTeam.Uav(k).Velocity   =  in(2*M+2*(k-1)+1: 2*M+2*k);
end

for k = 1:M
    % Velocity control command

      Pcur                      =  UavTeam.Uav(k).CurrentPos;
      Pdes                      =  UavTeam.Uav(k).Waypoint(:,UavTeam.Uav(k).CurrentTaskNum);
      Vcur                      =  UavTeam.Uav(k).Velocity;
      ksicur= Pcur+1/UavTeam.gain*Vcur;
      
      if norm(ksicur)~=0
      if ksicur(1)<-rb && UavTeam.Uav(k).State == 1 
          UavTeam.Uav(k).State = 3;
      end
          if ksicur(1)<-rb && UavTeam.Uav(k).State == 2 
          UavTeam.Uav(k).State = 4;
      end
       if ksicur(2)<rh-rb && UavTeam.Uav(k).State == 3
              UavTeam.Uav(k).State =5;
      end
              if  ksicur(2)>-rh+rb && UavTeam.Uav(k).State == 4
                                UavTeam.Uav(k).State =5;
              end
   UavTeam.Uav(k).VelocityCom   =  mycontrol(k);
    % Collect all the control
     V  = [V;UavTeam.Uav(k).VelocityCom];
      else
          V  = [V; 0;0];
      end

% plot online
  if gcount>=2500
     figure(1);
     gfigure=gfigure+1;
%      subplot(3,2,gfigure)
     MyMap(UavTeam,Obstacle,Highway);
     for k = 1:M
        o = [UavTeam.Uav(k).CurrentPos(1) UavTeam.Uav(k).CurrentPos(2)]';
        mydrawcolorball(o,k); 
     end
     gcount = 0;
     in(end)
  end
     if gcount>=1000
        figure(1);
    
         hold off
         MyMap(UavTeam,Obstacle,Highway);

     end
end

if gcount>=1000
gcount = 0;
gfigure = gfigure+1;
t = in(end)
end

u = V;

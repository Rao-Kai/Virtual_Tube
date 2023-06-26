function u = mytunnel(i,p1,p2,p3,rh)
global UavTeam

Pcur  =  UavTeam.Uav(i).CurrentPos;
Vcur  =  UavTeam.Uav(i).Velocity;
Pdes  =  UavTeam.Uav(i).Waypoint(:,UavTeam.Uav(i).CurrentTaskNum);
   rs = UavTeam.Uav(i).rs;
   ra = UavTeam.Uav(i).ra;     
 vmax = UavTeam.Uav(i).vmax;

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 At12 = eye(2) - (p1-p2)*(p1-p2)'/(norm(p1-p2)*norm(p1-p2));
 At23 = eye(2) - (p2-p3)*(p2-p3)'/(norm(p2-p3)*norm(p2-p3)); 
 
% Velocity to line
    k1 = 1;
    el = Pcur + 1/UavTeam.gain*Vcur - p2;
    Vl = -mysat(k1*At23*el,vmax);
 
% Velocity away other multicoptee
    Vm = [0;0];
    for l = 1:UavTeam.AvailableNumMax
        if i~=l && norm(Pcur)~=0
     k2 = 1; e = 0.000001; 
 ksimil = (Pcur - UavTeam.Uav(l).CurrentPos) + 1/UavTeam.gain*(Vcur - UavTeam.Uav(l).Velocity);
   temp = (1+e)*norm(ksimil) - (2*rs)*mys(norm(ksimil)/(2*rs),e);
    bil = k2*dmysigma(norm(ksimil),2*rs,rs+ra)/temp ...
        - k2*mysigma(norm(ksimil),2*rs,rs+ra)*((1+e)-dmys(norm(ksimil)/(2*rs),e))/(temp^2);
     Vm = Vm - bil*(ksimil/norm(ksimil));
        end
    end
 
 % Velocity within the tunnel
    Vt = [0;0];
      k3 = 1; e = 0.001;
   ksihi = At12*((Pcur-p2) + 1/UavTeam.gain*Vcur);
  temp1  = (rh-rs)/(norm(ksihi)+e);
  temp2  = (rh-rs) - norm(ksihi)*mys(temp1,e);
  %% wrong ¸ººÅ
     ci = -k3*dmysigma(rh-norm(ksihi),rs,rs+ra)/temp2 ...
        - k3*mysigma(rh-norm(ksihi),rs,rs+ra)*(-mys(temp1,e)+norm(ksihi)*dmys(temp1,e)*(rh-rs)/(norm(ksihi)+e)/(norm(ksihi)+e))/(temp2^2);
     Vt = Vt - ci*(ksihi/norm(ksihi));
     
   % Sum of all velocities
    u = mysat(Vl+Vm+Vt,vmax);
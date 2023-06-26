function u = collisioncon(in)
global UavTeam L inflow_settings
global length width Gainfactor_rs Gainfactor_ra inflow_settings control_mode
M = UavTeam.AvailableNumMax;
V = [];
L=UavTeam.gain;
num = floor(in(end)*2)/2;
time = in(end)
for j =1:size(inflow_settings.inflow,1)
    if time <60*(j) && time>=60*(j-1)
        temp = inflow_settings.num(j)/60*(time-60*(j-1));
        temp_next =inflow_settings.num(j)/60*(time+0.5-60*(j-1));
        if j ==1
            totalnum = 0;
        else
            totalnum = inflow_settings.totalnum(j-1);
        end
        for k = totalnum+ceil(temp):1:totalnum+floor(temp_next)
            if k ~=0
                UavTeam.Uav(k).state = 1;
            end
        end
    end
end
for k=1:M
    %     UavTeam.Uav(k).CurrentPos=in(2*k-1:2*k);
    %     UavTeam.Uav(k).Velocity=in(2*M+2*k-1:2*M+2*k);
    UavTeam.Uav(k).Pes=in(2*k-1:2*k);
    UavTeam.Uav(k).Ves=in(2*M+2*k-1:2*M+2*k);
    if UavTeam.Uav(k).state ==1
        switch control_mode
            case 1
                if  (UavTeam.Uav(k).finishline == 1 && width/2-UavTeam.Uav(k).CurrentPos(2)<0)...
                        ||(UavTeam.Uav(k).finishline == 3 && width/2+UavTeam.Uav(k).CurrentPos(2)<0)...
                        ||(UavTeam.Uav(k).finishline == 2 && length/2-UavTeam.Uav(k).CurrentPos(1)<0)...
                        ||(UavTeam.Uav(k).finishline == 4 && length/2+UavTeam.Uav(k).CurrentPos(1)<0)
                    UavTeam.Uav(k).state=2;
                end
            case 2
                if  norm(UavTeam.Uav(k).Waypoint(:,2)-UavTeam.Uav(k).CurrentPos)<4   
                    UavTeam.Uav(k).state=2;
                end
        end
    end
end
vm_matrix=zeros(2*M,M);
for i=1:M
    if UavTeam.Uav(i).state == 1
        for j = 1:M
            if i~=j && UavTeam.Uav(j).state == 1
                ksimil = (UavTeam.Uav(i).Pes - UavTeam.Uav(j).Pes) +...
                    1/UavTeam.gain * (UavTeam.Uav(i).Ves - UavTeam.Uav(j).Ves);
                rs = UavTeam.Uav(i).rs*Gainfactor_rs;
                ra = UavTeam.Uav(i).ra*Gainfactor_ra;
                if norm(ksimil)<(ra+rs)
                    gamma =1;
                    k3 = 1; e = 0.000001;
                    temp = (1+e)*norm(ksimil) - ((gamma+1)*rs)*mys(norm(ksimil)/((gamma+1)*rs),e);
                    bil = k3*dmysigma(norm(ksimil),(gamma+1)*rs,ra+rs)/temp ...
                        - k3*mysigma(norm(ksimil),(gamma+1)*rs,ra+rs)*((1+e)-dmys(norm(ksimil)/((gamma+1)*rs),e))/(temp^2);
                    vm_matrix(2*i-1:2*i,j)= - bil*(ksimil/norm(ksimil));
                end
            end
        end
    end
end

for k = 1:M
    %     hold off
    if UavTeam.Uav(k).state == 1
        % Velocity control command
        UavTeam.Uav(k).VelocityCom   =  mycontrol(k,vm_matrix);
    else
        UavTeam.Uav(k).VelocityCom   =  zeros(2,1);
    end
    % Collect all the control
    V  = [V;UavTeam.Uav(k).VelocityCom];
%         if rem(time,2)==1
%         MyMap(UavTeam);
%         end
%         N=0;
%         for k=1:M
%                 if UavTeam.Uav(k).state ==1
%                     N=N+1;
%                 end
%         end
    %     N

end


u =V;

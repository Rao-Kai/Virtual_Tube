function UavTeam = UAVInitialization(M,rm,l,vmax)
% Initialize UAV

global Highway Obstacle InitialPosition

% The number of UAVs
UavTeam.AvailableNumMax  = M;
UavTeam.gain             = 1;
rh = Highway(1).rh ;
rb = Highway(1).rb ;
InitialPosition=[];
% Distances between among waypoints and obstacles have to be greater than a
% value. So SavedWPOB is defined to save current waypoints and obstacles for distance check.
sz   =  size(Obstacle);
SavedWPOB = [];

for k = 1:sz(2)
  SavedWPOB = [SavedWPOB  Obstacle(k).Center];
end

% Write down the waypoint
for k = 1: UavTeam.AvailableNumMax
    
    UavTeam.Uav(k).Waypoint = [];
           UavTeam.Uav(k).r = rm;
           UavTeam.Uav(k).vmax = 5+k/4;
           UavTeam.Uav(k).ra = 2*(rm + (UavTeam.Uav(k).vmax/UavTeam.gain) + 1);
    % Home waypoint
    % The output temp satisfies mydistance(temp,SavedWPOB)>=2*rm+ro 
        temp = [(rand-0.5)*1000; (rand-0.5)*1000];

           UavTeam.Uav(k).HomePos = temp;
                   if UavTeam.Uav(k).HomePos(1)>-rb && UavTeam.Uav(k).HomePos(2)>rh
            UavTeam.Uav(k).State = 1;
        else if UavTeam.Uav(k).HomePos(1)>-rb && UavTeam.Uav(k).HomePos(2)<-rh
                UavTeam.Uav(k).State = 2;
        else if UavTeam.Uav(k).HomePos(1)<0 &&  UavTeam.Uav(k).HomePos(2)>rh-rb
                UavTeam.Uav(k).State = 3;

            else if UavTeam.Uav(k).HomePos(1)<0 &&  UavTeam.Uav(k).HomePos(2)<-rh+rb
                    UavTeam.Uav(k).State = 4;
                else
                    UavTeam.Uav(k).State = 5;
                end
            end
            end
        end
          UavTeam.Uav(k).Waypoint = [UavTeam.Uav(k).Waypoint UavTeam.Uav(k).HomePos];
        UavTeam.Uav(k).CurrentPos =  UavTeam.Uav(k).HomePos;
        
        
          % Velocity
          UavTeam.Uav(k).Velocity = zeros(2,1);
          % Current task number
          UavTeam.Uav(k).CurrentTaskNum =1;
          % All task number 
          UavTeam.Uav(k).AllTaskNum = 1;
          % Updata SavedWPOB   
          SavedWPOB = [SavedWPOB UavTeam.Uav(k).Waypoint];    
          InitialPosition=[InitialPosition;UavTeam.Uav(k).CurrentPos];
end

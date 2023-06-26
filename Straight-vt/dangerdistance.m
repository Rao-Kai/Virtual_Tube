function u = dangerdistance(in)

global Highway Obstacle
global UavTeam

M     =  UavTeam.AvailableNumMax;
Pcur  = in(1:2*M);
Vcur  = in(2*M+1:4*M);
% Vcur  = zeros(size(Vcur));
% Minimum distance among UAVs 
mindism = 100000;
% for i = 1 : M 
%     for j = i+1 : M
%         dm = norm((Pcur(2*i-1:2*i)+1/UavTeam.gain*Vcur(2*i-1:2*i)-(Pcur(2*j-1:2*j)+1/UavTeam.gain*Vcur(2*j-1:2*j))));
%         if dm < mindism
%             mindism = dm;
%         end
%     end
% end

% Minimum distance between UAVs and Obstacles
mindiso = 100000;
  sz   =  size(Obstacle);
% for i = 1 : M 
%     for j = 1 : sz(2)
%         do = norm(Pcur(2*i-1:2*i)+1/UavTeam.gain*Vcur(2*i-1:2*i) - Obstacle(j).Center);
%         if do< mindiso
%             mindiso = do;
%         end
%     end
% end

% Distance between UAVs and highway centerline
 rh = Highway(1).rh;
mindish = rh;
% for i = 1 : M 
%       ph1 = Highway(1).ph1;
%       ph2 = Highway(1).ph2;
%        rh = Highway(1).rh;
%       Ah1 = eye(2)-(ph1-ph2)*(ph1-ph2)'/((ph1-ph2)'*(ph1-ph2));
%        dh = rh-norm(Ah1*(Pcur(2*i-1:2*i)-ph1));
%          if dh< mindish
%             if Pcur(2*i-1)>=0 && abs(Pcur(2*i))<=rh
%               mindish = dh;
%             end
%          end
% end

u = [mindiso;mindish;mindism];


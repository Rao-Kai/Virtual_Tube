function UAVstate = createUAV(i,L)
global width length rm rs ra
UAVstate.state = 0;
temp = randperm(4,2);
UAVstate.startline  = temp(1);
% UAVstate.finishline = temp(2);
switch UAVstate.startline
    case 1
        UAVstate.finishline = 3;
    case 2
        UAVstate.finishline = 4;
    case 3
        UAVstate.finishline = 1;
    case 4
        UAVstate.finishline = 2;
end
UAVstate.Waypoint = [];
UAVstate.r = rm;
UAVstate.vmax = 20;

UAVstate.rv = UAVstate.vmax/L;
UAVstate.rs = rs;
UAVstate.ra = ra;

switch UAVstate.startline
    case 1
        UAVstate.HomePos = [2*(rand-0.5)*length/2 width/2]';
    case 2
        UAVstate.HomePos = [length/2 2*(rand-0.5)*width/2]';
    case 3
        UAVstate.HomePos = [2*(rand-0.5)*length/2 -width/2]';
    case 4
        UAVstate.HomePos = [-length/2 2*(rand-0.5)*width/2]';
end
dis=0;
switch UAVstate.finishline
    case 1
        temp = [2*(rand-0.5)*length/2 width/2+dis]';
    case 2
        temp = [length/2+dis 2*(rand-0.5)*width/2]';
    case 3
        temp = [2*(rand-0.5)*length/2 -width/2-dis]';
    case 4
        temp = [-length/2-dis 2*(rand-0.5)*width/2]';
end
UAVstate.CurrentPos = UAVstate.HomePos;
UAVstate.Waypoint = [UAVstate.Waypoint UAVstate.HomePos];
UAVstate.Waypoint = [UAVstate.Waypoint temp];
UAVstate.CurrentTaskNum = 2;
UAVstate.AllTaskNum     = 2;
UAVstate.Velocity = zeros(2,1);
UAVstate.VelocityCom = zeros(2,1);
end
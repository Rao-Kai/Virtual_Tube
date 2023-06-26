function out=mydrawcolorball(o1,o2,k1,k2)
global rs ra Gainfactor_rs Gainfactor_ra
para=5;
alpha = 0:pi/20:2*pi;
x = o1(1) +  rs*cos(alpha);
y = o1(2) +  rs*sin(alpha);
x1 = o2(1) +  rs*Gainfactor_rs*cos(alpha);
y1 = o2(2) +  rs*Gainfactor_rs*sin(alpha);
hold on
switch k2
    case 1
        string1='r-';
        string2='r--';
    case 2
        string1='b-';
        string2='b--';
    case 3
        string1='y-';
        string2='y--';
    case 4
        string1='g-';
        string2='g--';
end
        h=fill(x,y,string1);
%         plot(x1,y1,string2);
%  switch k1
%     case 1
%   h=fill(x1,y1,'r-');hold on
%   case 2
%   h=fill(x1,y1,'b-');hold on
%   case 3
%   h=fill(x1,y1,'y-');hold on
%   case 4
%   h=fill(x1,y1,'g-');hold on
% end
set(h,'edgealpha',1,'facealpha',1)
hold on

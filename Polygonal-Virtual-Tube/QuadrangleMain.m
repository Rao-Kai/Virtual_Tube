clear;clc;
global  N UAV_Initial
N=20;
ts=0.001;

UAV_PInit=zeros(N,2);
UAV_PInit(1,:)=[0;0];UAV_PInit(2,:)=[0;1];UAV_PInit(3,:)=[0;2];UAV_PInit(4,:)=[0;3];UAV_PInit(5,:)=[0;4];
UAV_PInit(6,:)=[1;0];UAV_PInit(7,:)=[1;1];UAV_PInit(8,:)=[1;2];UAV_PInit(9,:)=[1;3];UAV_PInit(10,:)=[1;4];
UAV_PInit(11,:)=[2;0];UAV_PInit(12,:)=[2;1];UAV_PInit(13,:)=[2;2];UAV_PInit(14,:)=[2;3];UAV_PInit(15,:)=[2;4];
UAV_PInit(16,:)=[3;0];UAV_PInit(17,:)=[3;1];UAV_PInit(18,:)=[3;2];UAV_PInit(19,:)=[3;3];UAV_PInit(20,:)=[3;4];

UAV_Initial=[UAV_PInit(:,1);UAV_PInit(:,2)];

vmax=3;
rs=0.5;
ra=0.8;

p_leader(1,:)=[-5,2,0];
p_leader(2,:)=[5,2,0];
p_leader(3,:)=[15,-3,-pi/18];
p_leader(4,:)=[25,4,pi/18];
p_leader(5,:)=[35,2,0];
dis=[3 4 3 5 3];
  
p_left=[];
p_right=[];
for i=1:length(p_leader(:,1))
    p_left(i,:)=(p_leader(i,1:2))+dis(i)*[cos(p_leader(i,3)+pi/2),sin(p_leader(i,3)+pi/2)];%p_left是该点前进方向垂直正90度的点，距离有最大限制
    p_right(i,:)=(p_leader(i,1:2))+dis(i)*[cos(p_leader(i,3)-pi/2),sin(p_leader(i,3)-pi/2)];%p_right是该点前进方向垂直正90度的点，距离有最大限制
end

sim("QuadrangleSimulation")

DrawFinal(Pcur,p_left,p_right,N,rs,ra);






clear;
clc;
global N v_max v_max1 rs ra UAV_Initial
N=4;
v_max=2;
v_max1=20;
rs=0.4;
ra=0.6;
ts=0.001;

UAV_PInit=zeros(N,2);
UAV_PInit(1,:)=[0,0];UAV_PInit(2,:)=[3,0];UAV_PInit(3,:)=[6,0]; UAV_PInit(4,:)=[9,0];
UAV_VInit=zeros(N,2);
UAV_Initial=[UAV_PInit(:,1);UAV_PInit(:,2);UAV_VInit(:,1);UAV_VInit(:,2)];

p_target=[9,10;3,10;6,10;0,10];
p_obstacle=[2,3;3,7;7.5,5.5];
ro=[1.3;1.4;1.8];

sim('OVF2D');
DrawFinalObstacle(Pcur,N,rs,ra,p_obstacle,ro)



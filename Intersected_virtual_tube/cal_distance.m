% function out = cal_distance
global rs ra M length width time_end Ts
load('UAVstate.mat')
load('UAVstate_e.mat')
l=5;
UAVstates=UAVstates(:,2:end);
if exist('mindis') && exist('dis2line')
load('dis2line.mat');
load('mindis.mat');
else
mindis = 100000*ones(time_end/Ts,M);
dis2line = 100000*ones(time_end/Ts,M);
for j=1:time_end/Ts
    for kk=1:M
        o2 = [UAVstates(j,2*kk-1)+UAVstates(j,2*M+2*kk-1)/l UAVstates(j,2*kk)+UAVstates(j,2*M+2*kk)/l]';
        switch UAVstates(j,M*5+kk)
            case 1
                dis2line(j,kk)=width/2-o2(2);
            case 2
                dis2line(j,kk)=length/2-o2(1);
            case 3
                dis2line(j,kk)=o2(2)+width/2;
            case 4
                dis2line(j,kk)=o2(1)+length/2;
        end
        for ii=1:M
            if (UAVstates(j,M*6+kk) == 1 )&&(UAVstates(j,M*6+ii) == 1) && ii~=kk
                o2 = [UAVstates(j,2*kk-1)+UAVstates(j,2*M+2*kk-1)/l UAVstates(j,2*kk)+UAVstates(j,2*M+2*kk)/l]';
                o2_ii = [UAVstates(j,2*ii-1)+UAVstates(j,2*M+2*ii-1)/l UAVstates(j,2*ii)+UAVstates(j,2*M+2*ii)/l]';
                temp= norm(o2-o2_ii);
                if mindis(j,kk)>temp
                    mindis(j,kk)=temp;
                end
                
            end
        end
        j
    end
end
for a=1:size(mindis,1)
    for b=1:size(mindis,2)
        if mindis(a,b)==100000
            mindis(a,b)=20;
        end
    end
end

for a=1:M
    dis2line(:,a)=(dis2line(:,a)-250)*250/(250-dis2line(end,a))+250;
end
hold off
end
figure('color',[1 1 1]);
figure(1)
for aa=1:40
    plot(Ts:Ts:time_end,mindis(:,aa));
%     
    hold on
    axis([0 55 0 150])
end
plot(Ts:Ts:time_end,10*ones(size(mindis(:,aa),1)),'r-.','LineWidth',1);
hold off
figure(2)
for aa=1:40
    
    plot(Ts:Ts:time_end,dis2line(:,aa));
    hold on
    axis([0 55 0 260])
end
save('dis2line.mat','dis2line')
save('mindis.mat','mindis')
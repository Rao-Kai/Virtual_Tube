function out = plot_M5400
global rs ra M length width time_end Ts
load('UAVstate1.mat')
load('UAVstate_e1.mat')

l=5;
UAVstates=UAVstates(:,2:end);
UAVstates_e=UAVstates_e(:,2:end);
figure('color',[1 1 1]);
figure(1);

width = 250; %width(m)
length = 250;
t=0;
for j=t/Ts+1:5:time_end/Ts
    hold off
    plot([-length length]/2,[width width]/2,'r','LineWidth',2);hold on
    plot([length length]/2,[-width width]/2,'b','LineWidth',2);hold on
    plot([-length length]/2,-[width width]/2,'y','LineWidth',2);hold on
    plot(-[length length]/2,[-width width]/2,'g','LineWidth',2);hold on
    plot([-400 -length]/2,[width width]/2,'r--','LineWidth',2);hold on
    plot([length 400]/2,[width width]/2,'r--','LineWidth',2);hold on
    plot([length length]/2,[-400 -length]/2,'b--','LineWidth',2);hold on
    plot([length length]/2,[length 400]/2,'b--','LineWidth',2);hold on
    plot([-400 -length]/2,-[width width]/2,'y--','LineWidth',2);hold on
    plot([length 400]/2,-[width width]/2,'y--','LineWidth',2);hold on
    plot(-[length length]/2,[-400 -length]/2,'g--','LineWidth',2);hold on
    plot(-[length length]/2,[length 400]/2,'g--','LineWidth',2);hold on
    for kk = 1:M
        if UAVstates(j,M*6+kk) == 1
            o1 = [UAVstates(j,2*kk-1)+UAVstates(j,2*M+2*kk-1)/l UAVstates(j,2*kk)+UAVstates(j,2*M+2*kk)/l]';
            o2 = [UAVstates_e(j,2*kk-1)+UAVstates_e(j,2*M+2*kk-1)/l UAVstates_e(j,2*kk)+UAVstates_e(j,2*M+2*kk)/l]';
            k1 = UAVstates(j,M*4+kk);
            k2 = UAVstates(j,M*5+kk);
            mydrawcolorball(o1,o2,k1,k2);
        end
    end
    axis([-length/2-75 length/2+75 -width/2-75 width/2+75])
    grid on
    string = ['t=', num2str((j-1)*Ts),'s'];
    xlabel(string);
    time_interval = 5;
%     for ti = 1:time_interval:j
%         for kk = 1:M
%             if UAVstates(j,M*6+kk) == 1 && ti>time_interval
%                 o2 = [UAVstates(ti,2*kk-1)+UAVstates(ti,2*M+2*kk-1)/l UAVstates(ti,2*kk)+UAVstates(ti,2*M+2*kk)/l]';
%                 o2_last = [UAVstates(ti-time_interval,2*kk-1)+UAVstates(ti-time_interval,2*M+2*kk-1)/l UAVstates(ti-time_interval,2*kk)+UAVstates(ti-time_interval,2*M+2*kk)/l]';
%                 switch UAVstates(ti,M*4+kk)
%                     case 1
%                         plot([o2_last(1) o2(1)] ,[o2_last(2) o2(2)],'k','LineWidth',1);hold on
%                     case 2
%                         plot([o2_last(1) o2(1)] ,[o2_last(2) o2(2)],'k','LineWidth',1);hold on
%                     case 3
%                         plot([o2_last(1) o2(1)] ,[o2_last(2) o2(2)],'k','LineWidth',1);hold on
%                     case 4
%                         plot([o2_last(1) o2(1)] ,[o2_last(2) o2(2)],'k','LineWidth',1);hold on
%                 end
%             end
%             %         plot(data{1}{1}.Values.Data(ti,3),data{1}{1}.Values.Data(ti,4),'b.','MarkerSize',10)
%             %         plot(data{1}{1}.Values.Data(ti,5),data{1}{1}.Values.Data(ti,6),'b.','MarkerSize',10)
%             %         plot(data{1}{1}.Values.Data(ti,7),data{1}{1}.Values.Data(ti,8),'b.','MarkerSize',10)
%             %         plot(data{1}{1}.Values.Data(ti,9),data{1}{1}.Values.Data(ti,10),'b.','MarkerSize',10)
%             %         plot(data{1}{1}.Values.Data(ti,11),data{1}{1}.Values.Data(ti,12),'b.','MarkerSize',10)
%         end
%         %         plot(Combined_P(1),Combined_P(2),'b.','MarkerSize',10)        
%     end
    pause(0.1);
    hold off
end


out = 0;
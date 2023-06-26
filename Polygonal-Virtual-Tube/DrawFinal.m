function DrawFinal(Pcur,p_left,p_right,N,rs,ra)
figure(1)
set(0,'defaultfigurecolor','w')

for i=1:200:length(Pcur.data(1,1,:))
    hold on;
    axis equal;
    for j=1:N
        for k=1:length(p_left(:,1))
            line([p_left(k,1),p_right(k,1)],[p_left(k,2),p_right(k,2)],'Color','blue','LineStyle','--','Linewidth',1);
        end
        plot(p_left(:,1),p_left(:,2),'k','Linewidth',1.5);
        plot(p_right(:,1),p_right(:,2),'k','Linewidth',1.5);
        if j>=1 && j<=5
            fill_r(Pcur.data(j,1:2,i),rs,'r',1);
        elseif j>=6 && j<=10
            fill_r(Pcur.data(j,1:2,i),rs,'g',1);
        elseif j>=11 && j<=15
            fill_r(Pcur.data(j,1:2,i),rs,'b',1);
        elseif j>=16 && j<=20
            fill_r(Pcur.data(j,1:2,i),rs,'y',1);
        end
        axis([-6,36,-7,10]);
    end
    xlabel('X/m');
    ylabel('Y/m');
    set(gca,'FontSize',20,'Fontname', 'Times New Roman');
    
    pause(0.005);
    hold off
    plot(0,0);
end
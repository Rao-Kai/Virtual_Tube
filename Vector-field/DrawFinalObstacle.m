function DrawFinalObstacle(Pcur,N,rs,ra,p_obstacle,ro)
figure(1)
set(gcf,'color','w')
for i=1:10:length(Pcur.data(1,1,:))
    hold on;
    axis equal    
    axis([-1 11 -1 11]);
    for j=1:N
        if j==1
            mycircle(Pcur.data(j,1:2,i),rs,'k');
        elseif j==2
            mycircle(Pcur.data(j,1:2,i),rs,'r');
        elseif j==3
            mycircle(Pcur.data(j,1:2,i),rs,'b');
        elseif j==4
            mycircle(Pcur.data(j,1:2,i),rs,'g');
        end
        APF_x=Pcur.data(j,1,2:i+1);
        APF_y=Pcur.data(j,2,2:i+1);
        APF_x=reshape(APF_x,i,1);
        APF_y=reshape(APF_y,i,1);

        if j==1
            plot(APF_x,APF_y,'k--');
        elseif j==2
            plot(APF_x,APF_y,'r--');
        elseif j==3
            plot(APF_x,APF_y,'b--');
        elseif j==4
            plot(APF_x,APF_y,'g--');
        end
    end
    for k=1:length(p_obstacle(:,1))
        fill_b(p_obstacle(k,1:2),ro(k));
    end
    
    text(8,3,['T=',num2str(Pcur.time(i),'%.2f'),'s'],'FontSize',22)
    pause(0.005);
    hold off
    plot(0,0);
end


function out = MyMap(UavTeam)
global length width
M = UavTeam.AvailableNumMax;
plot([-length length]/2,[width width]/2,'r','LineWidth',2);hold on
plot([length length]/2,[-width width]/2,'b','LineWidth',2);hold on
plot([-length length]/2,-[width width]/2,'y','LineWidth',2);hold on
plot(-[length length]/2,[-width width]/2,'g','LineWidth',2);hold on
grid on
for k = 1: M
    if UavTeam.Uav(k).state == 1
        o1 = UavTeam.Uav(k).CurrentPos;
        o2 = UavTeam.Uav(k).CurrentPos+1/UavTeam.gain*UavTeam.Uav(k).Velocity;
        k1=UavTeam.Uav(k).startline;
        k2=UavTeam.Uav(k).finishline;
        mydrawcolorball(o1,o2,k1,k2);
    end
end
axis([-length/2-200 length/2+200 -width/2-200 width/2+200])
out = 0;
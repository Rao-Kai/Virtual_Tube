clc
clear all;

rm = 9;
ra = 20
 k2 = 1; e = 0.000001; rs = e; %0.000001
 x  = 0:0.1:50;
 sz = size(x)
 for k=1:max(sz)
  Vm(k) = k2*mysigma(x(k),2*rm,ra)/((1+e)*x(k)-(2*rm)*mys(x(k)/(2*rm),rs));
 end

 rm = 9;
 ra = 20;
 rt = 50;
 k3 = 1; e = 0.000001; rs = e;
 y  = 0:0.1:50
 sz = size(y)
 for k=1:max(sz)
  Vt(k) = k3*mysigma(rt-y(k),rm,ra)/((rt-rm)-y(k)*mys((rt-rm)/(y(k)+e),rs));
 end

figure(1)
 subplot(1,2,1)
   plot(x,Vm) 
  axis([-1 50 -1 1000])  
 subplot(1,2,2) 
  plot(y,Vt) 
 axis([-1 51 -1 1000])
 
figure(2)
 subplot(1,2,1)
   plot(x,Vm) 
  axis([-1 50 -1 1])  
 subplot(1,2,2) 
  plot(y,Vt) 
 axis([-1 51 -1 1])
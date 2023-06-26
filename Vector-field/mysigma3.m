function u=mysigma3(x,d1,d2)
A =2/(d1 - d2)^3;
B =-(3*(d1 + d2))/(d1 - d2)^3;
C =(6*d1*d2)/(d1 - d2)^3;
D =(d1^2*(d1 - 3*d2))/((d1 - d2)*(d1^2 - 2*d1*d2 + d2^2));

if x<=d1
    u = 0;
elseif d1<=x  && x<=d2
    u = A*x^3 + B*x^2 + C*x + D ;
else
    u = 1;
end
function [yy1,y,v,a]=jiesuan(yy0,dt,windowSize,windowSize1)
yy1=movmean( yy0 ,windowSize )-mean(yy0);
%plot(d)
%yy1 = bandp(yy1,20,2200,5,3800,0.1,5,10e4);
%yy2=abs(hilbert(yy1));
%y2 = unwrap(2*atan(yy1./yy2))/pi*79.1/40;
yy3=imag(hilbert(yy1));
%yy4=abs(hilbert(yy3));
%y5 = unwrap(2*atan(yy3./yy4))/pi*79.1/40;
%y2 = unwrap(2*atan(yy1./yy2))/pi*79;

plot(yy1,yy3),hold on
%y6 = unwrap(2*atan(y2./y5))/pi*79.1/0.0954;
y6 = unwrap(2*atan(yy1./yy3))/pi*79.1/0.0954;
%plot(y6)
%plot(x,y2,'r',x,y5,'b',x,y6+3000000,'g')
y=movmean( y6 ,[windowSize1 ] )/1e9;
%k=y(0.5e6:1:3.3e6);
%k=y;
%x=1:1:(size(k)-1);
v=diff(y)/dt;
%windowSize = 200000;
a=movmean(diff(v) ,[windowSize1 ] )/dt;
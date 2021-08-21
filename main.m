clc; clear; close all;
load('sig.mat')
x=sig(1:200000);
fs = 1e7; % sampling frequency
N = 200000; % data amount
t = (1:N)/fs; % time vector
%x = (2+cos(2*pi*0.5*t)).*cos(2*pi*5*t+15*t.^2)+...
   %  cos(2*pi*2*t);
[imf,ort,fvs,iterNum] = emd_sssc(x,fs,'display',1);
figure(1)
%set(gcf,'position',[150 150 500 900])%后两个范围由分辨率限制
%set(gcf,'unit','normalized','position',[0.2,0.2,0.64,0.32]);
%h(1)=subplot(imfn+1,1,1);
%+imf(8,:)+imf(9,:)
plot(t*1000,x);
set(gca,'FontSize',12,'fontname','Times');
ylim([-1, 1]);
set(gcf,'unit','normalized','position', [0.2,0.2,0.64,0.28]);
%title('denoise Signal VS in');
xlabel('Time(ms)')

plot(t*1000,x);
hold on
denoise=imf(6,:)+imf(7,:)+imf(8,:);
plot(t*1000,denoise);
set(gca,'FontSize',12,'fontname','Times');
ylim([-1, 1]);
set(gcf,'unit','normalized','position', [0.2,0.2,0.64,0.28]);
%title('denoise Signal VS in');
xlabel('Time(ms)')

for imfi = 1:9
    %h(1+imfi)=subplot(imfn+1,1,imfi+1);
    %set(h(1+imfi), 'position', [0.2,0.2,0.64,0.32]);
   evaluate_denoising_metrics(x,imf( imfi,:))
   
    %figure(imfi)
    subplot(10,1,imfi),plot(t*1000,imf(imfi,:));
    set(gca,'FontSize',12,'fontname','Times');
    set(gcf,'unit','normalized','position', [0.2,0.2,0.64,0.1]);
    set(gca,'XTickLabel','')
    set(gca,'YLim',[-0.5 0.5]);%X轴的数据显示范围
    ylabel(['IMF',num2str(imfi)],'FontSize',12);
    %title('Residual');
      
end
    subplot(10,1,10),plot(t*1000,imf(10,:));
    set(gca,'FontSize',12,'fontname','Times');
    set(gcf,'unit','normalized','position', [0.2,0.2,0.64,0.1]);
    set(gca,'YLim',[-0.5 0.5]);%X轴的数据显示范围
    ylabel(['RES',num2str(imfi)],'FontSize',12);
    
    xlabel('Time(ms)','FontSize',12)
    

figure(15)
value = [0.106094, 0.194094, 0.241376,0.099108,0.065632,0.447989,0.716289,0.242887,0.114767 -0.004889];
name = {'IM1', 'IM2', 'IM3','IM4','IM5','IM6','IM7','IM8','IM9','Residual'};
bar(value);
set(gca, 'XTickLabel', name,'FontSize',12);
ylabel('Correlation Coefficent')
set(gcf,'unit','normalized','position', [0.2,0.2,0.64,0.3]);
xmin=0; xmax=11; ymin=-0.1; ymax=0.9;
axis([xmin xmax ymin ymax]);
figure(14)
cwt(x,fs)
%figure('position',[200,200,500,500]) <span style="float:none;background-color:transparent;color:rgb(79,79,79);font-family:'PingFang SC', 'Microsoft YaHei', SimHei, Arial, SimSun;font-size:16px;font-style:normal;font-variant:normal;font-weight:400;letter-spacing:normal;text-align:justify;text-decoration:none;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;">

figure('color','w')
[p,q] = ndgrid(t,1:size(imf',2));
plot3(p,q,imf')
grid on
set(gca,'FontSize',12,'fontname','Times');
xlabel('Time Values')
ylabel('Mode Number')
zlabel('Mode Amplitude')

[mra,~,wfb,info] = ewt(x);
fs*info.PeakFrequencies
fs*info.FilterBank.Passbands 
f = 0:fs/length(x):fs-1/length(x);
plot(f,wfb)
ylabel('Magnitude')
grid on
yyaxis right
plot(f,abs(fft(x)),'k--','linewidth',1.5)
ylabel('Magnitude')
xlabel('Hz')
figure(12)
hht(imf(7,:)',fs,'FrequencyLimits',[0,4000])

windowSize = 500;
windowSize1 = 2000;
dt=1e-7;
yy0=denoise;

[yy1,y,v,a]=jiesuan(yy0,dt,windowSize,windowSize1);

%calllib('dpljiesuan', 'jiesuan', yy0,dt,windowSize,windowSize1)

tt=1:1:size(yy0');
tt=tt'
figure(1)
%plot(1e6:2e6,yy2(1e6:2e6),'r',1e6:2e6,yy1(1e6:2e6),'b',1e6:2e6,y2(1e6:2e6),'g')
%plot(y2(1.7e6:1.8e6),y5(1.7e6:1.8e6))
%subplot(4,1,1),plot(tt,denoise,'b')
plot(tt,y'.*1e6)
set(gca,'FontSize',12,'fontname','Times');
%ylim([-1, 1]);
set(gcf,'unit','normalized','position', [0.2,0.2,0.64,0.22]);
%title('displacement Signal');
ylabel('um')
xlabel('Time(s)')
%figure(2)
subplot(4,1,1),plot(x,yy0,'r',x,yy1,'b')

plot(t,x);
hold on

plot(t,imf(7,:));
set(gca,'FontSize',16,'fontname','Times');
ylim([-1, 1]);
hight=0.28;
set(gcf,'unit','normalized','position', [0.2,0.2,0.64,hight]);
title('Camparision of LDI & IM7');
xlabel('Time(s)')
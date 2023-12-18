clear all
close all
clc

fs=10000; %% sampling frequency
f1=500;  %% first sinewave freq (in band)
f2=3500; %% second sinnewave freq (out band)

N=10; %% filter order
nb=8; %% number of bits

T=1/500; %% maximum period
tt=0:1/fs:10*T; %% time samples

x1=sin(2*pi*f1*tt); %% first sinewave
x2=sin(2*pi*f2*tt); %% second sinewave

x=(x1+x2)/2; %% input signal

[bi, bq]=myfir_design(N, nb); %% filter design

y=filter(bq, 1, x); %% apply filter

%% quantize input and output
xq=floor(x*2^(nb-1));
idx=find(xq==2^(nb-1));
xq(idx)=2^(nb-1)-1;

yq=floor(y*2^(nb-1));
idy=find(yq==2^(nb-1));
yq(idy)=2^(nb-1)-1;

%% plots
A=readmatrix('resultsc.txt');
figure
tiledlayout(2,1)
nexttile
plot(tt(1:120),x(1:120), 'g--+');
xlabel("t[s]")
ylabel("Amplitude")
hold on
plot(tt(1:120), y(1:120), 'c--o');
grid on
legend('x', 'y')
nexttile
plot(tt(1:120), xq(1:120));
hold on
plot(tt(1:120), yq(1:120));
hold on
plot(tt(1:120),A(1:120));
xlabel("t[s]")
ylabel("Amplitude")
grid on

%%
legend('X quantizied','Y quantizied','C results')
saveas(gcf, 'output_filter.png')
figure
plot(tt(1:100),x1(1:100), 'g--o')
hold on 
plot(tt(1:100), x2(1:100), 'b--+')
hold on 
plot(tt(1:100),x(1:100), 'r', LineWidth=1)
xlabel("t[s]")
ylabel("Amplitude")
legend('x1', 'x2', 'x')
title("Input signal")
saveas(gcf,"inputSignalFilter.png")
%% save input and output
fp=fopen('samples.txt','w');
fprintf(fp,'%d\n', xq);
fclose(fp);

fp=fopen('resultsm.txt', 'w');
fprintf(fp, '%d\n', yq);
fclose(fp);
%% test C THD
thd(A)
%%
figure
plot(tt(1:120), xq(1:120));
hold on
plot(tt(1:120), yq(1:120));
hold on
plot(tt(1:120),A(1:120));
xlabel("t[s]")
ylabel("Amplitude")
grid on
legend('X quantizied','Y quantizied','C results')
saveas(gcf, 'comparison.png')

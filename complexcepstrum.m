clear all;
clc;
close all;
% windowing the signal for 10ms
[y,Fs] = audioread('s5.wav');
u=y(1:1988*10*1000/Fs);
% complex cepstrum of windowed signal
[c,n] = cceps(u);
l=fftshift(c);
% separating anti-causal part
for i=1:length(u)
    if(i<=length(u)/2)
    anti(i)= l(i);
    else
        anti(i)=0;
    end
end
% separating causal part
for j=1 : length(u)
    if(j >= length(u)/2)
    caus(j)= l(j);
    else
        caus(j)=0;
    end
end
% inverse complex cepstrum of anti-causal part
A=icceps(anti,n);
% inverse complex cepstrum of causal part
C=icceps(caus,n);
% plots
subplot(3,2,1)
plot(u);
title('Voiced signal');
xlabel('Data Points');
ylabel('Amplitude');
subplot(3,2,2)
plot(l);
title('Voiced signal complex cepstrum');
xlabel('Data Points');
ylabel('Amplitude');
subplot(3,2,3)
plot(anti);
title('Anti causal complex cepstrum');
xlabel('Data Points');
ylabel('Amplitude');
subplot(3,2,4)
plot(A);
title('Anti causal signal');
xlabel('Data Points');
ylabel('Amplitude');
subplot(3,2,5)
plot(caus);
title('Causal complex cepstrum');
xlabel('Data Points');
ylabel('Amplitude');
subplot(3,2,6)
plot(C);
title('Causal signal');
xlabel('Data Points');
ylabel('Amplitude');



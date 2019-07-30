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

%checking anti-causal zeros
% z transform of anti-causal part
L=length(A);
X=0;
z=sym('z');
for i=0:L-1
    X=X + A(i+1)*z^(-i);
end
% finding zeros of z transform
Y = collect(X);
[num,den] = numden(Y);
a=roots(sym2poly(num));

%checking causal zeros
% z transform of causal part
Lc=length(C);
Xc=0;
Z=sym('Z');
for i=0:Lc-1
    Xc=Xc + C(i+1)*Z^(-i);
end
% finding zeros of z transform
Yc = collect(Xc);
[numc,denc] = numden(Yc);
ac=roots(sym2poly(numc));

%plot
subplot(1,2,1)
plot(poly(a));
title("Polynomial of Anti-Causal Zeros (CCEP)");
xlabel("Data Points");
ylabel("Polynomial coefficients");
subplot(1,2,2)
plot(poly(ac));
title("Polynomial of Causal Zeros (CCEP)");
xlabel("Data Points");
ylabel("Polynomial coefficients")

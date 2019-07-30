clear all;
clc;
close all;
% windowing the signal
[y,Fs] = audioread('s5.wav');
u=y(1:1988*10*1000/Fs);
% z transform calculation
l=length(u);
X=0;
z=sym('z');
for i=0:l-1
    X=X + u(i+1)*z^(-i);
end
% separating numerator to find zeros
Y = collect(X);
[num,den] = numden(Y);
a=roots(sym2poly(num));
% separating causal and anti-causal zeros
al=1;
cl=1;
for i=1:length(a)
    if(abs(a(i)) > 1)
        az(al)=a(i);
        al=al+1;
    else
        cz(cl)=a(i);
        cl=cl+1;
end
end
% polynomial of zeros of anti-causal signal
pa=poly(az);
% polynomial of zeros of causal signal
pc=poly(cz);
%plot
subplot(1,2,1)
plot(pa);
title("Polynomial of Anti-Causal Zeros");
xlabel("Data Points");
ylabel("Polynomial coefficients");
subplot(1,2,2)
plot(pc);
title("Polynomial of Causal Zeros");
xlabel("Data Points");
ylabel("Polynomial coefficients");


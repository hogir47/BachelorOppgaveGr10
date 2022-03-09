G =@(x) x/2 +4*sin(x-1);   %Newton metode
G1 = @(x) 1/2+4*cos(x-1);
x=1;
for n=1:5
    x=x-G(x)/G1(x);
    pause(2)
end
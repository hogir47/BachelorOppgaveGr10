G =@(x) x/2 +4*sin(x-1);   %Første deriver av f(x)
G1 = @(x) 1/2+4*cos(x-1);  %Andre deriver av f(x)
x=1;
for n=1:5                % For-løkke med 5 iterasjoner
    x=x-G(x)/G1(x);      %Newtons metode formelen
    pause(2)
end
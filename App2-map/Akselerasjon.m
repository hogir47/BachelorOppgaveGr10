function A = Akselerasjon(Vx,X,h,f,M,g)
% Euler's Metode
%Funksjon av akselerasjon inneholder variabler
% D er første dervet av landscap
D=(f(X+h)-f(X-h))/(2*h);
B =-atan(D);
F=(f(X+h)-2*f(X)+f(X-h))/(h^2);
CheckSign=sign(g+F*Vx^2);
A= ( sin(B)-CheckSign*sign(Vx)*M*cos(B))*(g+F*Vx^2)/...
  ((1 + sign(Vx)*M*D)*cos(B)+(sign(Vx)*M-D)*sin(B));
       
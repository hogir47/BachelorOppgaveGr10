function N = Normalkraft(Vx,X,h,f,M,g)
D=(f(X+h)-f(X-h))/(2*h);
B =-atan(D);
F=(f(X+h)-2*f(X)+f(X-h))/(h^2);
N=(g+F*Vx^2)/...
((1 + sign(Vx)*M*D)*cos(B)+(sign(Vx)*M-D)*sin(B));
function N = Normalkraft(h,f,X)
D=(f(X+h)-f(X-h))/(2*h);
B =-atan(D);
W =98.1;
N=W*cos(B);                 % Normalkraft
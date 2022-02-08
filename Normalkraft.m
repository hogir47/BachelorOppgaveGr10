function N = Normalkraft(m,g,h,f,X)
D=(f(X+h)-f(X-h))/(2*h);
B =-atan(D);
 W=m*g;                     % Tyngdekraft
N=W*cos(B);                 % Normalkraft
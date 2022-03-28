function XstoppNy=MainFunksjonIkkePlot(x0,Vx0,func)
% Skript som plotter banen til en tenkt partikkel
% Input:  
% x0 - Startposisjon
% dt - Oppdelinga i td (bestemmer farten som simuleringa vises med)
% tMax - Hvor lenge simuleringa skal vare
% Na - antall punkter i x - for plottinga
% Landskap
switch (func)
    case 1
        f =@(x) x.^2/4 - 4 * cos(x-1);
    case 2
        f =@(x) x.^2/10 - 6 * sin(x+5);
    case 3
        f =@(x)-cos(sqrt(x.^2+2*x+1))./sqrt(2*x.^2+x+1);
    case 4
        f =@(x) 6*sin(x)-x+12;
end% Oppløsninga i tid - steglengda - og varigheten av simuleringa
dt = 0.005;
%t=0;                                        % Start-tid
% mot venstre
X =x0;
h = 1;
g = 9.81; 
M =0.1;
presisjon = 1e-8;
Vx = Vx0;                                   %Steglengde (blir endra inne i løkka)
Vmin=1e-4;
Xstopp= 0;
D=0;
XstoppNy= 10*presisjon;
while abs(Xstopp-XstoppNy)>presisjon
       Xstopp=XstoppNy;
    while abs(Vx) > Vmin || D > M          % Looper over alle tidspunktene
          %N=Normalkraft(Vx,X,h,f,M,g);     %Normalkraft funksjon
          %R=M*N;                           % Friksjon=Friksjonskoeffisient*Normalkraft
          D=(f(X+h)-f(X-h))/(2*h); 
          ax=Akselerasjon(Vx,X,h,f,M,g);   %Akselerasjon
          VxHatt=Vx+ax*dt/2;
          XHatt=X+Vx*dt/2;
          ax=Akselerasjon(VxHatt,XHatt,h,f,M,g);
          Vx=Vx+ax*dt;
          X=X+Vx*dt;
          %Y=f(X);
     end
  XstoppNy=X;
  M=M/2;
end
disp(['x0: ',num2str(x0),'.'])
disp(['Vx0: ',num2str(Vx0),'.'])
disp(['Minimalpunkt: ',num2str(XstoppNy),'.'])
disp(['Minmialverdi: ',num2str(f(XstoppNy)),'.'])
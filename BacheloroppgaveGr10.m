% Skript som plotter banen til en tenkt partikkel
% Input: 
% x0 - Startposisjon
% dt - Oppdelinga i td (bestemmer farten som simuleringa vises med)
% tMax - Hvor lenge simuleringa skal vare
% Na - antall punkter i x - for plottinga
% Landskap
%f =@(x) x.^2;
f =@(x) x.^2/4 - 4 * cos(x-1);
fig = figure(1);
xlabel("X-axis",'fontsize',16,'color','b');
ylabel("Y-axis",'fontsize',16,'color','b');
title("Simulating of sliding",'fontsize',16,'color','r');

% X-posisjon som funksjon av tid
x0 = -10;                                 % Startposisjon
Vx0 =10;                                    %Start av farten
% Oppløsninga i tid - steglengda - og varigheten av simuleringa
dt = 0.005;
tMax=10;
t=0;                                        % Start-tid
% mot venstre
xMin=-10;
xMax=10;
X =x0;
h = 0.001;
g = 9.81; 
M =0.1;
presisjon = 1e-8;
Vx = 20;                                   %Steglengde (blir endra inne i løkka)
Vmin=1e-5;
% Vektor med x-verdier
Na=300;                                     % antall punkter
xVektor = linspace(xMin,xMax,Na);           % Vektor med x-verdier
% Lager plott
plot(xVektor,f(xVektor),'k-','linewidth',2) % Plotter landskap
hold on
xVerdi = x0;
yVerdi = f(xVerdi);
% Ploter posisjonen til objektet (rød stjerne)
pl = plot(xVerdi,yVerdi,'rx','linewidth',10);    
hold off
ii=1;
Xstopp= 0;
XstoppNy= 10*presisjon;
while abs(Xstopp-XstoppNy)>presisjon
       Xstopp=XstoppNy;
    while abs(Vx) > Vmin || D > M          % Looper over alle tidspunktene
          N=Normalkraft(Vx,X,h,f,M,g);     %Normalkraft funksjon
          R=M*N;                           % Friksjon=Friksjonskoeffisient*Normalkraft
          D=(f(X+h)-f(X-h))/(2*h); 
          ax=Akselerasjon(Vx,X,h,f,M,g);   %Akselerasjon
          VxHatt=Vx+ax*dt/2;
          XHatt=X+Vx*dt/2;
          ax=Akselerasjon(VxHatt,XHatt,h,f,M,g);
          Vx=Vx+ax*dt;
          X=X+Vx*dt;
          Y=f(X);
          % Oppdaterer data til plotting
          set(pl,'xdata',X);
          set(pl,'ydata',Y);
      drawnow                               % Oppdaterer selve plottet
     end
  XstoppNy=X;
  M=M/2;
  disp(['Minimalpunkt: ',num2str(XstoppNy),'.'])
end
disp(['Minmialverdi: ',num2str(f(XstoppNy)),'.'])
% Lukker video-fila
%close(v)
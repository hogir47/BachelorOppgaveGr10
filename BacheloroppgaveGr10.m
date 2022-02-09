% Skript som plotter banen til en tenkt partikkel
% Input: 
% x0 - Startposisjon
% dt - Oppdelinga i td (bestemmer farten som simuleringa vises med)
% tMax - Hvor lenge simuleringa skal vare
% N - antall punkter i x - for plottinga
% Landskap
f = @(x) x.^2;
fig = figure(1);
xlabel("X-axis",'fontsize',16,'color','b');
ylabel("Y-axis",'fontsize',16,'color','b');
title("Simulating of sliding",'fontsize',16,'color','r');

% X-posisjon som funksjon av tid
x0 = 5;             % Startposisjon
Vx0 =0;                %Start av farten
% Oppløsninga i tid - steglengda - og varigheten av simuleringa
dt = 0.0025;
tMax=20;
t=0;                % Start-tid
% mot venstre
W =98.1;
h = 0.01;
g = 9.81;
D=(f(X+h)-f(X-h))/(2*h);
B =-atan(D);
N=W*cos(B);                 % Normalkraft
S=M*N;
BV = true;
M =0.25;                   %Friksjonskoeffisienten (0-1)
% Vektor med x-verdier
Na=100;              % antall punkter
xVektor = linspace(-1.*x0,1.*x0,Na);   % Vektor med x-verdier

% Lager plott
plot(xVektor,f(xVektor),'k-','linewidth',2) % Plotter landskap
hold on
xVerdi = x0;
yVerdi = f(xVerdi);
% Ploter posisjonen til objektet (rød stjerne)
pl = plot(xVerdi,yVerdi,'rx','linewidth',10);    
hold off
 Vx = Vx0;
 X =x0;
 for t=0:dt:tMax
%while abs(Vx)>1e-6 || abs(S)<W*sin(B)    % Looper over alle tidspunktene
if BV
      %nx = Normalkraft(h,X,f); 
      ax=Akselerasjon(Vx,X,h,f,M,g);
      VxHatt=Vx+ax*dt/2;
      XHatt=X+Vx*dt/2;
      ax=Akselerasjon(VxHatt,XHatt,h,f,M,g);
      Vx=Vx+ax*dt;
      X=X+Vx*dt;
      Y=f(X);
      F=(f(X+h)-2*f(X)+f(X-h))/(h^2);
else
   %abs(Vx)<1e-6;
   %abs(S)>W*sin(B);
         %disp('Utanfor området.')      % Skriv til skjerm
          %hold off                      % Sluttar å "spare på" plott
      
end
   % Oppdaterer data til plotting
     set(pl,'xdata',X);
     set(pl,'ydata',Y);

  drawnow               % Oppdaterer selve plottet
end

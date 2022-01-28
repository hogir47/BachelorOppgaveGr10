% Skript som plotter banen til en tenkt partikkel
% Input:
% x0 - Startposisjon
% dt - Oppdelinga i td (bestemmer farten som simuleringa vises med)
% tMax - Hvor lenge simuleringa skal vare
% N - antall punkter i x - for plottinga
% Landskap
f = @(x) x.^2;              %Landskapet vi glir over
fig = figure(1);
xlabel("X-axis",'fontsize',16,'color','b');
ylabel("Y-axis",'fontsize',16,'color','b');
title("Simulating of sliding",'fontsize',16,'color','r');

% X-posisjon som funksjon av tid...
x0 = 5;                    % Startposisjon
Vx0 =0;                    % Start av farten
 X =x0;
% Oppløsninga i tid - steglengda - og varigheten av simuleringa
dt = 0.0025;
tMax=20;
t=0;                       % Start-tid
% mot venstre
m =10;                     % Massen
h = 0.01;                  % Der h er et lite tall
g = 9.81;                  % Tyngdeakselerasjonen, g= 9.8 
M =0.25;                   %Friksjonskoeffisienten (0-1)
D=(f(X+h)-f(X-h))/(2*h);   % Numerisk metode til å bestemme vikelen
B =-atan(D);               % Vinkel mellom tangent og horisont
W=m*g;                     % Tyngdekraft
N=W*cos(B);                % Normalkraft
S=M*N;                     % Friksjonskoeffisienten * Normalkraft
% Vektor med x-verdier
Na=100;                    % antall punkter
xVektor = linspace(-5,5,Na);   % Vektor med x-verdier

% Lager plott
plot(xVektor,f(xVektor),'k-','linewidth',2) % Plotter landskap
hold on
xVerdi = x0;
yVerdi = f(xVerdi);
% Ploter posisjonen til objektet (rød stjerne)
pl = plot(xVerdi,yVerdi,'rx','linewidth',10);    
hold off
% ikke ferdig...
while (S < W*sin(B))      % Looper over alle tidspunktene
    if S>W*sin(B)         % Friksjonskoeffisienten her er større
        break             % Stoppkriterium 
    else
       continue           % Fortsette å gli igjen
    end
   % Oppdaterer data til plotting
     set(pl,'xdata',X);
     set(pl,'ydata',Y);

  drawnow               % Oppdaterer selve plottet
end



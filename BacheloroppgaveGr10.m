% Skript som plotter banen til en tenkt partikkel
% Input: 
% x0 - Startposisjon
% dt - Oppdelinga i td (bestemmer farten som simuleringa vises med)
% tMax - Hvor lenge simuleringa skal vare
% N - antall punkter i x - for plottinga
% Landskap
f =@(x) x.^2;
fig = figure(1);
xlabel("X-axis",'fontsize',16,'color','b');
ylabel("Y-axis",'fontsize',16,'color','b');
title("Simulating of sliding",'fontsize',16,'color','r');

% X-posisjon som funksjon av tid
x0 = 4.8;             % Startposisjon
Vx0 =0;                %Start av farten
% Oppløsninga i tid - steglengda - og varigheten av simuleringa
dt = 0.01;
tMax=10;
t=0;                % Start-tid
% mot venstre
W =98.1;
h = 0.001;
g = 9.81; 
M =0.025;
D=(f(X+h)-f(X-h))/(2*h);
B =-atan(D);
N=W*cos(B);                 % Normalkraft
S=M*N;
presisjon = 1e-6;
Vx = 0.1;                  %Steglengde (blir endra inne i løkka)
% Vektor med x-verdier
Na=300;              % antall punkter
xVektor = linspace(-5,5,Na);   % Vektor med x-verdier
% Lager plott
plot(xVektor,f(xVektor),'k-','linewidth',2) % Plotter landskap
hold on
xVerdi = x0;
yVerdi = f(xVerdi);
% Ploter posisjonen til objektet (rød stjerne)
pl = plot(xVerdi,yVerdi,'rx','linewidth',10);    
hold off
 X =x0;
 % For video
v = VideoWriter ('test.avi');
open (v); 
% Løkke som går over tidspunktene
indeks=1;               % Innfører indeks som teller iterasjoner
 while abs(Vx)>presisjon || abs(S)<W*sin(B)   % Looper over alle tidspunktene

      ax=Akselerasjon(Vx,X,h,f,M,g);
      VxHatt=Vx+ax*dt/2;
      XHatt=X+Vx*dt/2;
      ax=Akselerasjon(VxHatt,XHatt,h,f,M,g);
      Vx=Vx+ax*dt;
      X=X+Vx*dt;
      Y=f(X);
      F=(f(X+h)-2*f(X)+f(X-h))/(h^2);

  if abs(Vx)<presisjon && abs(S)>W*sin(B)
    break
  end
   % Oppdaterer data til plotting
     set(pl,'xdata',X);
     set(pl,'ydata',Y);

  drawnow               % Oppdaterer selve plottet
    % Sparer på hver 5. frame til video
  if mod(indeks,5)==0 
    % Spare på "frame" til filmen
    frame=getframe(gcf);
    writeVideo(v, frame);
  end
  indeks=indeks+1;      % Oppdaterer indeks  
end
% Lukker video-fila
close(v)
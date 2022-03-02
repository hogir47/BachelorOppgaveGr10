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
x0 = -10;             % Startposisjon
Vx0 =0;                %Start av farten
% Oppløsninga i tid - steglengda - og varigheten av simuleringa
dt = 0.005;
tMax=10;
t=0;                % Start-tid
% mot venstre
xMin=-10;
xMax=10;
X =x0;
h = 0.001;
g = 9.81; 
M =0.1;
presisjon = 1e-8;
Vx = 0.1;                  %Steglengde (blir endra inne i løkka)
Vmin=1e-5;
% Vektor med x-verdier
Na=300;              % antall punkter
xVektor = linspace(xMin,xMax,Na);   % Vektor med x-verdier
%xVektor = linspace(-5,5,Na);   % Vektor med x-verdier
% Lager plott
plot(xVektor,f(xVektor),'k-','linewidth',2) % Plotter landskap
hold on
xVerdi = x0;
yVerdi = f(xVerdi);
% Ploter posisjonen til objektet (rød stjerne)
pl = plot(xVerdi,yVerdi,'rx','linewidth',10);    
hold off
Mverdi=f(x);
disp(['Minimalpunkt: ',num2str(x),'.'])
disp(['Minmialverdi: ',num2str(Mverdi),'.'])
 % For video
%v = VideoWriter ('test.avi');
%open (v); 
% Løkke som går over tidspunktene
%indeks=1;               % Innfører indeks som teller iterasjoner
%while abs(Vx) > Vmin || D > M
ii=1;
Xstopp= 0;
XstoppNy= 10*presisjon;
while abs(Xstopp-XstoppNy)>presisjon
    Xstopp=XstoppNy;
while abs(Vx) > Vmin || D > M   % Looper over alle tidspunktene

      N=Normalkraft(Vx,X,h,f,M,g);            %Normalkraft funksjon
      R=M*N;                           % Friksjon=Friksjonskoeffisient*Normalkraft
      D=(f(X+h)-f(X-h))/(2*h);
      B =-atan(D);
      G=g*sin(B);                      % Tyngdekraft
      ax=Akselerasjon(Vx,X,h,f,M,g);   %Akselerasjon
      VxHatt=Vx+ax*dt/2;
      XHatt=X+Vx*dt/2;
      ax=Akselerasjon(VxHatt,XHatt,h,f,M,g);
      Vx=Vx+ax*dt;
      X=X+Vx*dt;
      Y=f(X);
      F=(f(X+h)-2*f(X)+f(X-h))/(h^2);
   % Oppdaterer data til plotting
     ii=ii+1;
     set(pl,'xdata',X);
     set(pl,'ydata',Y);

  drawnow               % Oppdaterer selve plottet
    % Sparer på hver 5. frame til video
  %if mod(indeks,5)==0 
  if mod(ii,5)==0
    % Spare på "frame" til filmen
    %frame=getframe(gcf);
    %writeVideo(v, frame);
  %end
  %indeks=indeks+1;      % Oppdaterer indeks  
  end
 end
  XstoppNy=X;
  M=M/2;
end
% Lukker video-fila
%close(v)
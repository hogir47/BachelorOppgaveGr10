function  MainFunksjon(app,sw,func,sw2)
cla(app.UIAxes);            
app.Label.Text="simulating";

%pause(0.01);
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
        f =@(x) x.^2/10 - 6 * cos(x+5);
end
xlabel(app.UIAxes,"X-axis",'fontsize',16,'color','b');
ylabel(app.UIAxes,"Y-axis",'fontsize',16,'color','b');
title(app.UIAxes,"Simulating of sliding",'fontsize',16,'color','r');
 x0 = app.X0.Value;                                % Startposisjon
 Vx0 =app.Vx0.Value; 
%Start av farten
% Opplّsninga i tid - steglengda - og varigheten av simuleringa
dt = 0.005;
% mot venstre
xMin=-10;
xMax=10;
X =x0;
h = 0.001;
g = 9.81; 
M =0.1;
presisjon = 1e-8;
Vx = Vx0;                                   %Steglengde (blir endra inne i lّkka)
Vmin=1e-5;
% Vektor med x-verdier
Na=300;                                     % antall punkter
xVektor = linspace(xMin,xMax,Na);           % Vektor med x-verdier
% Lager plott
plot(app.UIAxes, xVektor,f(xVektor),'k-','linewidth',2); % Plotter landskap
hold(app.UIAxes,'on');
xVerdi = x0;
yVerdi = f(xVerdi);
% Ploter posisjonen til objektet (rّd stjerne)
pl = plot(app.UIAxes,xVerdi,yVerdi,'rx','linewidth',10); 
plot(app.UIAxes, xVerdi,yVerdi,'k-','linewidth',2);
Xstopp= 0;
XstoppNy= 10*presisjon;
D=0;
teller=0;
while abs(Xstopp-XstoppNy)>presisjon
       Xstopp=XstoppNy;
    while abs(Vx) > Vmin || D > M          % Looper over alle tidspunktene
          N=Normalkraft(Vx,X,h,f,M,g);     %Normalkraft funksjon
          if(sw2=="fast")
              rate=100;
          elseif sw2=="slow"
              rate=0.0001;
          end
          
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
          if (sw=="On" & mod(teller,rate)==0)
            set(pl,'xdata',X);
            set(pl,'ydata',Y);
            drawnow limitrate           % Oppdaterer selve plottet
          end
          teller=teller+1;
          if (X>xMax)
              xMax=X+5;
              xVektor = linspace(xMin,xMax,Na);           % Vektor med x-verdier

              plot(app.UIAxes, xVektor,f(xVektor),'k-','linewidth',2); % Plotter landskap
          elseif (X<xMin)
              xMin=X-5;
              xVektor = linspace(xMin,xMax,Na);           % Vektor med x-verdier
              plot(app.UIAxes, xVektor,f(xVektor),'k-','linewidth',2); % Plotter landskap
          end
          
          
     end
  XstoppNy=X;
  M=M/2;
end
         if(sw=="Off")
          set(pl,'xdata',X);
          set(pl,'ydata',f(X));
          drawnow  
          end
          
disp(['x0: ',num2str(x0),'.'])
disp(['Vx0: ',num2str(Vx0),'.'])
disp(['Minimalpunkt: ',num2str(XstoppNy),'.'])
disp(['Minmialverdi: ',num2str(f(XstoppNy)),'.'])
hold(app.UIAxes,'off');
 app.Label.Text="done";
   end
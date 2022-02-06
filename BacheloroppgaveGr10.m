% Dette skriptet implementerar "steepest decent"
% eller "gradient decent" for å finne eit 
% (lokalt) minmalpunkt for ein funksjon.
% Input er:
% funk - sjølve funksjonen vi skal minimerer
% Maksima- og minimalverdiane for x og y 
% (funksjonen er definert på eit rektangulært
% område).
% Vidare er startpunktet (x0, y0) input.
% I tillegg brukar implementeringa parametrane 
% Gamma, som skalerar kor langt vi skal gå i 
% gradient-retninga, og h, som blir brukt til 
% å estimere numeriske (partielle) dervierte.

% Funksjon
funk = @(x,y) -cos(sqrt(x.^2+2*y.^2+1))./sqrt(2*x.^2+y.^2+1);
% Grenser for x og y
xMin=-4;
xMax=4;
yMin=-4;
yMax=4;

% Startpunkt
x0=1;
y0=-1;

% Steglengder
Gamma=0.05;
h=.01;

% Lagar vektorar med x- og y-punkt
xVector=linspace(xMin,xMax,200);
yVector=linspace(yMin,yMax,200);
% Lagar matrise med funksjonsverdiar
[X, Y] = meshgrid(xVector,yVector);
% Matrise med funksjonsverdiar
Z=funk(X,Y);

% Plottar flata i rommet
figure(1)
surf(X,Y,Z)
shading interp
xlabel('x')         % Namn på aksane
ylabel('y') 
alpha(0.5)          % Gjer flata delvis gjennomsiktig
hold on             % Lar plottet bli verande når vi plottar fleire ting

% Initerar variable
x=x0;
y=y0;
FunkVal=funk(x,y);          % Funksonsverdien
FunkValOld=FunkVal+1;       % "Gamal" funksjonsverdi
plot3(x,y,funk(x,y),'ro')   % Plottar startpunkt

% Implementerar sjølve "gradient decent"-metoden
while FunkVal<FunkValOld    % Gjentar så lenge neste funksjonverdi er mindre
  % Oppdaterar kva som er gamalt
  OldX=x;                   
  OldY=y;
  FunkValOld=FunkVal;       
  % Reknar ut tilnærma partielle deriverte (gradienten)
  Xderiv=(funk(x+h,y)-funk(x-h,y))/(2*h);
  Yderiv=(funk(x,y+h)-funk(x,y-h))/(2*h);
  % Reknar ut nytt punkt
  x=x-Gamma*Xderiv;
  y=y-Gamma*Yderiv;
  % Kontrollerar at punktet ligg i definisjonsområdet
  if x<xMin | x>xMax | y<yMin | y>yMax
    disp('Utanfor området.')      % Skriv til skjerm
    hold off                      % Sluttar å "spare på" plott
    return                        % Sluttar å køyre skriptet
  end
  FunkVal=funk(x,y);
  plot3(x,y,FunkVal,'k.')   % Plottar neste punkt i iterasjonen
end

% Plottar minmalpunktet vi fann og skriv det til skjerm
plot3(x,y,FunkVal,'kx')
hold off              % Sluttar å halde fast på gamle plott
disp(['Minimalpunkt: (',num2str(x),',',num2str(y),').'])
disp(['Minmialverdi: ',num2str(FunkVal),'.'])
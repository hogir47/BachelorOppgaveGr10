function map(app,dx,dvx,xmax,vmax,f)
% map function for å finne lokal og global punktum.
% Input: 
% Dobbel for-løkke for x0 og Vx0.
% x0 - Startposisjon
% Vx0 - Start av farten
% Npts antall punkter i x,v - for plottinga
x0ind=0;   % startposisjon i indexen
for x0 =-xmax:dx:xmax
        x0ind=x0ind+1;    % teller
        tic
        Vx0ind=0;   % start av farten i indexen
        for Vx0 =-vmax:dvx:vmax
            Vx0ind=Vx0ind+1;  % teller
            Mat(x0ind,Vx0ind)=MainFunksjonIkkePlot(x0,Vx0,f);
            toc;
        end
end

%figure(f);
Npts_x=((2*xmax)/dx)+1;
Npts_v=((2*vmax)/dvx)+1;

Xvector =linspace(-xmax,xmax,Npts_x); % Vektor med x-verdier
Vvector =linspace(-vmax,vmax,Npts_v); % Vektor med v-verdier

pcolor(app.UIAxes2,Vvector,Xvector,Mat);
colormap(app.UIAxes2,jet);


end


   
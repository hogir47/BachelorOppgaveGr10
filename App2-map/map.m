function map(app,dx,dvx,xmax,vmax,f)
x0ind=0;
for x0 =-xmax:dx:xmax
        x0ind=x0ind+1;
        tic
        Vx0ind=0;
        for Vx0 =-vmax:dvx:vmax
            Vx0ind=Vx0ind+1;
            Mat(x0ind,Vx0ind)=MainFunksjonIkkePlot(x0,Vx0,f);
            toc;
        end
end

%figure(f);

Npts_x=((2*xmax)/dx)+1;
Npts_v=((2*vmax)/dvx)+1;

Xvector =linspace(-xmax,xmax,Npts_x);
Vvector =linspace(-vmax,vmax,Npts_v);

pcolor(app.UIAxes2,Vvector,Xvector,Mat);
colormap(app.UIAxes2,jet);


end
   
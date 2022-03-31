function map(dx,f)
x0ind=0;
for x0 =-10:dx:10
        x0ind=x0ind+1;
        tic
        Vx0ind=0;
        for Vx0 =-10:dx:10
            Vx0ind=Vx0ind+1;
            Mat(x0ind,Vx0ind)=MainFunksjonIkkePlot(x0,Vx0,f);
            toc;
        end
end
figure(f);
X =-10:dx:10;
V =-10:dx:10;
pcolor(X,V,Mat);
colormap(jet)
colorbar;
end
   
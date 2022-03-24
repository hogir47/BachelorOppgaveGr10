function map()
x0ind=0;
for x0 =-10:5:10
        x0ind=x0ind+1;
        tic
        Vx0ind=0;
        for Vx0 =-10:5:10
            Vx0ind=Vx0ind+1;
            Mat(x0ind,Vx0ind)=MainFunksjonIkkePlot(x0,Vx0);
            toc;
        end
end
X =x0;
    V =Vx0;
surf(X,V,Mat);
colormap(jet)
    colorbar;
end

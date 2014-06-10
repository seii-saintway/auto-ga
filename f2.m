function z = f2(x, y)
% f2 is an objective function, i.e. performance index.
z = 0.9*exp( -((x+5).^2+(y+5).^2) / 10 ) + 0.99996*exp( -((x-5).^2+(y-5).^2) / 20);
end

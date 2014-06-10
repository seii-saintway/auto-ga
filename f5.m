function z = f5(x1, x2)
% f5 is an objective function, i.e. performance index.
% It was first proposed by Rastrigin as a 2-dimensional function.
z = x1.*sin(10*pi*x1) + x2.*sin(10*pi*x2);
end

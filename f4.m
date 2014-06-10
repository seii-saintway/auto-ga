function z = f4(x1, x2)
% f4 is an objective function, i.e. performance index.
% It was first proposed by Rastrigin as a 2-dimensional function.
z = 20 + x1.^2 + x2.^2 - 10*( cos(2*pi*x1) + cos(2*pi*x2) );
end

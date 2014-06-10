function z = f1(x, y)
% f1 is an objective function, i.e. performance index.
x = x + 0.00005; y = y + 0.00005;
z = (sin(x).*sin(y)) ./ (x.*y);
end

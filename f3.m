function z = f3(x1, x2)
% f3 is an objective function, i.e. performance index.
% It is also known as Rosenbrock's valley or Rosenbrock's banana function.
z = 100*(x2-x1.^2).^2 + (1-x1).^2;
end

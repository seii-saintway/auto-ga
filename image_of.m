function image_of(f, a, b, n)
% Visualize the 2-dimensional function.
if nargin < 4; n = 6; end;

[x, y] = meshgrid(a:(b-a)/(n*10):b); z = f(x, y);
surf(x, y, z), xlabel('x'), ylabel('y'), zlabel('z');

I = 1; J = 1;
for i = 1:length(z)
    for j = 1:length(z)
        if z(i, j)>z(I, J); I = i; J = j; end
    end
end
fprintf('f(%f, %f) = %f\n', x(I, J), y(I, J), z(I, J));

end

function main

fclose(fopen('outs.txt', 'wt'));
out = fopen('results.txt', 'wt');

H = @GA_E;
stringsCrossed = [20 28 36 44];
stringsMutated = [1 5 15 20];
f = {@f1, @f2, @(x, y) -f3(x, y), @(x, y) -f4(x, y), @f5};
fname = {'f1', 'f2', '-f3', '-f4', 'f5'};

for k = 1: length(f)
    for i = stringsCrossed
        for j = stringsMutated
            fprintf('\n%s, %d, %d\n', fname{k}, i, j);
            fprintf(out, '\n%s, %d, %d\n', fname{k}, i, j);
            [p, g] = H(f{k}, -10, 10, 0.0001, 50, i, j, 36, 18, 4);
            outputTheBest(f{k}, fname{k}, p, g);
        end
    end
end

fclose(out);

    function outputTheBest(f, fname, p, g)
        x = 0.0001 * double(p);
        [z, n] = max(f(x(:, 1), x(:, 2)));
        fprintf('%s(%.4f, %.4f) = %.4f  g = %d\n', fname, x(n, 1), x(n, 2), z, g);
        fprintf(out, '%s(%.4f, %.4f) = %.4f  g = %d\n', fname, x(n, 1), x(n, 2), z, g);
    end

end

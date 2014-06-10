function [population, generation, legend, era] = GA(f, a, b, delta, stringsAll, stringsCrossed, stringsMutated, bitsAll, bitsCrossed, bitsMutated)

out = fopen('outs.txt', 'at');
fprintf('\n');
fprintf(out, '\n');

% Initializing the population
% Code the two variable x and y separately to strengthen the linkage of bits of each one
rng('shuffle');
population = randi([a, b]/delta, stringsAll, 2, 'int32');
generation = 0;

V = 16^2;

rng('shuffle'); Rp = rng;
rng('shuffle'); Rs = rng;
rng('shuffle'); RsC = rng;
rng('shuffle'); RsM = rng;
rng('shuffle'); RbC = rng;
rng('shuffle'); RbM = rng;

legend = population(1, :); era = 0;
while true
    Population = [legend; population];
    Samples = delta * double(Population);
    [~, t] = max(f(Samples(:, 1), Samples(:, 2)));
    if t > 1; legend = Population(t, :); era = generation; end
    
    % Selecting the strings
    % Decoding the strings
    samples = delta * double(population);
    % Evaluating the samples
    evaluations = f(samples(:, 1), samples(:, 2));
    % Scaling the evaluations
    evaluations = evaluations - min(evaluations);
    % Getting the fitnesses
    fitnesses = evaluations / mean(evaluations);
    % Sampling on the remainders stochastically
    remainders = fitnesses - floor(fitnesses);
    selections = int32(floor(fitnesses));
    % Spinning the roulette wheel
    rng(Rp); ptr = randi(intmax); Rp = rng;
    % Initializing the intermediate population
    intermediation = zeros(stringsAll, 2, 'int32');
    rear = int32(0);
    % Shuffling the population
    rng(Rs); I = randperm(stringsAll); Rs = rng;
    for i = I
        ptr = ptr - intmax * remainders(i);
        % Determining whether or not a copy of a string is awarded
        if ptr <= 0
            selections(i) =  selections(i) + 1;
            ptr = ptr + intmax;
        end
        % Generating the intermediate population
        for j = 1:selections(i)
            rear = rear + 1;
            intermediation(rear, :) = population(i, :);
        end
    end
    
    % Determining whether or not the GA is converged
    stringsMean = mean(intermediation);
    stringsVar = [0 0];
    for i = 1: stringsAll
        stringsVar = stringsVar + (double(intermediation(i, :)) - stringsMean).^2;
    end
    fprintf('G = %4d, V = (%15.0f, %15.0f)\n', generation, stringsVar(1), stringsVar(2));
    fprintf(out, 'G = %4d, V = (%15.0f, %15.0f)\n', generation, stringsVar(1), stringsVar(2));
    if all(stringsVar < V) || generation >= 1000
        population = intermediation;
        break
    end
    
    % Picking the pairs of strings to cross stochastically
    rng(RsC); I = randperm(stringsAll, stringsCrossed); RsC = rng;
    for i = 1: 2: stringsCrossed
        rng(RbC);
        for j = randperm(bitsAll, bitsCrossed)
            k = 1;
            J = j;
            if j > bitsAll/2
                k = 2;
                J = j - bitsAll/2;
            end
            intermediation(I([i i+1]), k) = bitset(intermediation(I([i i+1]), k), J, bitget(intermediation(I([i+1 i]), k), J));
        end
        RbC = rng;
    end
    
    % Picking the strings to mutate stochastically
    rng(RsM); I = randperm(stringsAll, stringsMutated); RsM = rng;
    for i = I
        rng(RbM);
        for j = randperm(bitsAll, bitsMutated)
            k = 1;
            J = j;
            if j > bitsAll/2
                k = 2;
                J = j - bitsAll/2;
            end
            intermediation(i, k) = bitset(intermediation(i, k), J, 1-bitget(intermediation(i, k), J));
        end
        RbM = rng;
    end
    
    % Generating the next population
    population = bitshift(bitshift(intermediation, 32-bitsAll/2), bitsAll/2-32);
    for i = 1: (stringsAll * 2)
        if population(i) < a/delta; population(i) = a/delta; end
        if population(i) > b/delta; population(i) = b/delta; end
    end
    generation = generation + 1;
end

fprintf('\n');
fclose(out);

end

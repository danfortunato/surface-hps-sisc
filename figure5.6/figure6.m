%% h-refinement
n = 20+1;
grids = [4 8; 8 16; 16 32; 32 64];
t_hconv = zeros(length(grids), 1);
nelem   = zeros(length(grids), 1);

fprintf('# p = %g\n', n-1);
for k = 1:length(grids)
    fprintf('  grid = %g x %g\n', grids(k,1), grids(k,2));

    % Manufactured solution
    [dom, sol, f] = manufactured_solution(n, grids(k,1), grids(k,2));
    nelem(k) = length(dom);
    pdo = []; pdo.lap = 1;

    % Warm up
    if ( k == 1 )
        L = surfaceop(dom, pdo, f);
        L.rankdef = true;
        L.build();
        u = L.solve();
    end

    t = tic;
    L = surfaceop(dom, pdo, f);
    L.rankdef = true;
    u = L.solve();
    t_hconv(k) = toc(t);
end

%% p-refinement
ns = [4 8 12 16 20]+1;
grid = [32 64];
t_pconv = zeros(length(ns), 1);

fprintf('# grid = %g x %g, p =', grid(1), grid(2));
for j = 1:length(ns)
    fprintf(' %g', ns(j)-1);

     % Manufactured solution
    [dom, sol, f] = manufactured_solution(ns(j), grid(1), grid(2));
    pdo = []; pdo.lap = 1;

    % Warm up
    if ( j == 1 )
        L = surfaceop(dom, pdo, f);
        L.rankdef = true;
        L.build();
        u = L.solve();
    end

    t = tic;
    L = surfaceop(dom, pdo, f);
    L.rankdef = true;
    u = L.solve();
    t_pconv(j) = toc(t);
end
fprintf('\n');

%% Write results
fid = fopen('figure6.txt', 'w');
fprintf(fid, '# h-refinement with p = 20\n');
for k = 1:length(t_hconv)
    fprintf(fid, '%4d %e\n', nelem(k), t_hconv(k));
end
fprintf(fid, '\n\n');
fprintf(fid, '# p-refinement with 32 x 64 elements\n');
for j = 1:length(t_pconv)
    fprintf(fid, '%2d %e\n', ns(j)-1, t_pconv(j));
end
fclose(fid);

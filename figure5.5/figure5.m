n = 20+1;
grids = [4 8; 8 16; 16 32; 32 64];
t   = zeros(length(grids), 1);
err = zeros(length(grids), 1);

fprintf('# n = %g\n', n);
for k = 1:length(grids)
    fprintf('  grid = %g x %g\n', grids(k,1), grids(k,2));

    % Manufactured solution
    [dom, sol, f] = manufactured_solution(n, grids(k,1), grids(k,2));
    pdo = []; pdo.lap = 1;

    % Warm up
    if ( k == 1 )
        L = surfaceop(dom, pdo, f);
        L.rankdef = true;
        L.build();
        u = L.solve();
    end

    h = tic;
    L = surfaceop(dom, pdo, f);
    L.rankdef = true;
    u = L.solve();
    t(k) = toc(h);

    u = u - mean2(u);
    err(k) = norm(u-sol, inf) / norm(sol, inf);

end

% Write results
fid = fopen('figure5.txt', 'w');
for k = 1:size(t,1)
    fprintf(fid, '%e %e\n', t(k), err(k));
end
fclose(fid);

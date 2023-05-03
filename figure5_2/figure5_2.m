%% Figure 5.2a

clf
dom = surfacemesh.cube(17, 2);
plot(dom, 'linewidth', 2)
view(-45, 35), camlight, axis off

%% Figure 5.2b

% Run convergence study
ns = [3 4 5 6]+1;
nrefs = [0 1 2 3 4 5 6];
u = cell(length(nrefs), length(ns));
rng(0)
ffun = randnfun3(2);

for j = 1:length(ns)
    fprintf('# p = %g, nref =', ns(j)-1);
    for k = 1:length(nrefs)
        fprintf(' %g', nrefs(k));
        dom = surfacemesh.cube(ns(j), nrefs(k));
        f = surfacefun(@(x,y,z) ffun(x,y,z), dom);
        f = f - mean2(f);
        pdo = []; pdo.lap = 1;
        L = surfaceop(dom, pdo, f);
        L.rankdef = true;
        u{k,j} = L.solve();
        u{k,j} = u{k,j} - mean2(u{k,j});
    end
    fprintf('\n');
end

% Calculate self-convergence error
err = zeros(length(nrefs)-1, length(ns));
for j = 1:length(ns)
    for k = 1:length(nrefs)-1
        err(k,j) = norm(refine(u{k,j}, nrefs(end)-nrefs(k)) - u{end,j}, inf) / norm(u{end,j}, inf);
    end
end

% Write results
fid = fopen('figure5_2.txt', 'w');
for j = 1:size(err,1)
    fprintf(fid, '%2d ', 2^nrefs(j));
    for k = 1:size(err,2)
        fprintf(fid, ' %e', err(j,k));
    end
    fprintf(fid, '\n');
end
fclose(fid);

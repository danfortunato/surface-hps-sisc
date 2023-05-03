%% Figure 5.3a

clf
dom = surfacemesh.twisted_torus(30, 2, 20);
plot(dom, 'linewidth', 1.5)
view(-15, 37), camlight, axis off

%% Figure 5.3b

% Run convergence study
ns = [4 8 12]+1;
nrefs = [0 1 2 3 4];
u = cell(length(nrefs), length(ns));
rng(0)
ffun = randnfun3(0.5);

for j = 1:length(ns)
    fprintf('# p = %g, nref =', ns(j)-1);
    dom_orig = surfacemesh.twisted_torus(ns(j), 1, 10);
    for k = 1:length(nrefs)
        fprintf(' %g', nrefs(k));
        dom = refine(dom_orig, nrefs(k));
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
fid = fopen('figure5_3.txt', 'w');
for j = 1:size(err,1)
    fprintf(fid, '%2d ', 2^(nrefs(j)+2));
    for k = 1:size(err,2)
        fprintf(fid, ' %e', err(j,k));
    end
    fprintf(fid, '\n');
end
fclose(fid);

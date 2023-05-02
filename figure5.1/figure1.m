%% Figure 1a

clf
l = 20; m = 10;
solf = spherefun.sphharm(l, m);
dom = surfacemesh.sphere(17, 2);
sol = surfacefun(@(x,y,z) solf(x,y,z), dom);
plot(sol), hold on, plot(dom)
colormap turbo, axis off

%% Figure 1b

% Run convergence study
ns = [4 8 12 16 20]+1;
nrefs = [0 1 2 3 4 5];
err = zeros(length(nrefs), length(ns));
l = 20; m = 10;
solf = spherefun.sphharm(l, m);
norm_sol = norm(solf, inf);

for j = 1:length(ns)
    fprintf('# p = %g, nref =', ns(j)-1);
    for k = 1:length(nrefs)
        fprintf(' %g', nrefs(k));
        dom = surfacemesh.sphere(ns(j), nrefs(k));
        sol = surfacefun(@(x,y,z) solf(x,y,z), dom);
        f = -l*(l+1)*sol;
        pdo = []; pdo.lap = 1;
        L = surfaceop(dom, pdo, f);
        L.rankdef = true;
        u = L.solve();
        u = u - mean2(u);
        err(k,j) = norm(u-sol, inf) / norm_sol;
    end
    fprintf('\n');
end

% Write results
fid = fopen('figure1.txt', 'w');
for j = 1:size(err,1)
    fprintf(fid, '%2d ', 2^(nrefs(j)+1));
    for k = 1:size(err,2)
        fprintf(fid, ' %e', err(j,k));
    end
    fprintf(fid, '\n');
end
fclose(fid);

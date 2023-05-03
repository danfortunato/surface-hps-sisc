n = 16+1;
nrefs = [0 1 2 3 4 5];
l = 20; m = 10;
solf = spherefun.sphharm(l, m);
nelem     = zeros(length(nrefs), 1);
t_local   = zeros(length(nrefs), 1);
t_build   = zeros(length(nrefs), 1);
t_solve   = zeros(length(nrefs), 1);
t_rhs     = zeros(length(nrefs), 1);
mem_total = zeros(length(nrefs), 1);

fprintf('# p = %g, nref =', n-1);
for k = 1:length(nrefs)
    fprintf(' %g', nrefs(k));
    dom = surfacemesh.sphere(n, nrefs(k));
    nelem(k) = length(dom);
    sol = surfacefun(@(x,y,z) solf(x,y,z), dom);
    f = -l*(l+1)*sol;
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
    t_local(k) = toc(t);

    t = tic;
    L.rankdef = true;
    L.build();
    t_build(k) = toc(t);

    t = tic;
    L.rhs = f;
    t_rhs(k) = toc(t);

    t = tic;
    u = L.solve();
    t_solve(k) = toc(t);

    % Convert memory to GB
    mem_total(k) = bytes(L) / 1.024e9;
end
fprintf('\n');

% Write results
fid = fopen('figure5_4.txt', 'w');
for k = 1:size(nelem, 1)
    fprintf(fid, '%4d %e %e %e %e %e\n', nelem(k), t_local(k), ...
        t_build(k), t_solve(k), t_rhs(k), mem_total(k));
end
fclose(fid);

%% Helper functions

function b = bytes(obj)
    if ( isobject(obj) )
        % Convert class to struct
        warnstate = warning('query', 'MATLAB:structOnObject');
        warning('off', 'MATLAB:structOnObject');
        obj = struct(obj);
        warning(warnstate);
    end
    b = whos('obj').bytes;
end

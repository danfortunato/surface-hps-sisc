%% Turing spots on the blob mesh

delta_v = 5e-3;
delta_u = 0.516*delta_v;
alpha = 0.899;
beta = -0.91;
gamma = -0.899;
tau1 = 0.02;
tau2 = 0.15;
dt = 0.1;
n = 16;

Nu = @(u,v) alpha*u.*(1-tau1*v.^2) + v.*(1-tau2*u);
Nv = @(u,v) beta*v.*(1+alpha/beta*tau1*u.*v) + u.*(gamma+tau2*v);

rng(0)
dom = surfacemesh.blob(n, 2);
pdo = struct('lap', -dt*delta_u, 'b', 1);
Lu = surfaceop(dom, pdo);
Lu.build();
pdo = struct('lap', -dt*delta_v, 'b', 1);
Lv = surfaceop(dom, pdo);
Lv.build();

bb = boundingbox(dom);
f = randnfun3(0.5, bb);
u = surfacefun(@(x,y,z) f(x,y,z), dom);
f = randnfun3(0.5, bb);
v = surfacefun(@(x,y,z) f(x,y,z), dom);

doplot = @(u) chain(...
    @() camzoom(0.8), ...
    @() plot(resample(u, 40)), ...
    @() axis('off'), ...
    @() material('dull'), ...
    @() lighting('gouraud'), ...
    @() colormap('turbo'), ...
    @() camlight('headlight'));

figure, doplot(u), hold on, plot(dom, 'linewidth', 1.5)

t = 0;
kend = 2000;
for k = 1:kend
    Lu.rhs = u + dt*Nu(u,v);
    Lv.rhs = v + dt*Nv(u,v);
    u = Lu.solve();
    v = Lv.solve();
    t = t + dt;
    if ( mod(k, 100) == 0 )
        fprintf('# k = %d\n', k);
    end
    if ( k == 200 || k == 2000 )
        figure, doplot(u), drawnow, shg
    end
end

%% Turing spots on the stellarator mesh

delta_v = 2e-2;
delta_u = 0.516*delta_v;
alpha = 0.899;
beta = -0.91;
gamma = -0.899;
tau1 = 0.02;
tau2 = 0.2;
dt = 0.1;
n = 16;

Nu = @(u,v) alpha*u.*(1-tau1*v.^2) + v.*(1-tau2*u);
Nv = @(u,v) beta*v.*(1+alpha/beta*tau1*u.*v) + u.*(gamma+tau2*v);

rng(0)
dom = surfacemesh.stellarator(n, 8, 24);
pdo = struct('lap', -dt*delta_u, 'b', 1);
Lu = surfaceop(dom, pdo);
Lu.build();
pdo = struct('lap', -dt*delta_v, 'b', 1);
Lv = surfaceop(dom, pdo);
Lv.build();

bb = boundingbox(dom);
f = randnfun3(1, bb);
u = surfacefun(@(x,y,z) f(x,y,z), dom);
f = randnfun3(1, bb);
v = surfacefun(@(x,y,z) f(x,y,z), dom);

doplot = @(u) chain(...
    @() camzoom(0.9), ...
    @() plot(resample(u, 40)), ...
    @() axis('off'), ...
    @() material('dull'), ...
    @() lighting('gouraud'), ...
    @() colormap('turbo'), ...
    @() camlight('headlight'));

figure, doplot(u), hold on, plot(dom, 'linewidth', 1.5), shg

t = 0;
kend = 2000;
for k = 1:kend
    Lu.rhs = u + dt*Nu(u,v);
    Lv.rhs = v + dt*Nv(u,v);
    u = Lu.solve();
    v = Lv.solve();
    t = t + dt;
    if ( mod(k, 100) == 0 )
        fprintf('# k = %d\n', k);
    end
    if ( k == 200 || k == 2000 )
        figure, doplot(u), drawnow, shg
    end
end

%% Turing spots on the cow mesh

delta_v = 1e-3;
delta_u = 0.516*delta_v;
alpha = 0.899;
beta = -0.91;
gamma = -0.899;
tau1 = 0.02;
tau2 = 0.2;
dt = 0.1;
n = 16;

Nu = @(u,v) alpha*u.*(1-tau1*v.^2) + v.*(1-tau2*u);
Nv = @(u,v) beta*v.*(1+alpha/beta*tau1*u.*v) + u.*(gamma+tau2*v);

rng(1)
dom = surfacemesh.fromRhino('../surface-hps/models/cow.csv', 8);
dom = resample(dom, n);
pdo = struct('lap', -dt*delta_u, 'b', 1);
Lu = surfaceop(dom, pdo);
Lu.build();
pdo = struct('lap', -dt*delta_v, 'b', 1);
Lv = surfaceop(dom, pdo);
Lv.build();

bb = boundingbox(dom);
f = randnfun3(0.2, bb);
u = surfacefun(@(x,y,z) f(x,y,z), dom);
f = randnfun3(0.2, bb);
v = surfacefun(@(x,y,z) f(x,y,z), dom);

kend = 2000;
step = 3*360/kend;
doplot = @(u) chain(...
    @() plot(resample(u, 32)), ...
    @() axis('off'), ...
    @() material('dull'), ...
    @() lighting('gouraud'), ...
    @() colormap('turbo'), ...
    @() view(180, -85), ...
    @() camorbit(20, 0, 'data', 'y'), ...
    @() camorbit(10, 0, 'data', 'x'), ...
    @() camorbit(-3, 0, 'data', [0 0 1]), ...
    @() set(gca, 'CameraViewAngleMode', 'Manual'), ...
    @() camorbit(30*step, 0, 'data', [0 1 0]), ...
    @() camzoom(1.1), ...
    @() camlight('headlight'));

figure, doplot(u), hold on, plot(dom, 'linewidth', 1.5), shg

t = 0;
kend = 2000;
for k = 1:kend
    Lu.rhs = u + dt*Nu(u,v);
    Lv.rhs = v + dt*Nv(u,v);
    u = Lu.solve();
    v = Lv.solve();
    t = t + dt;
    if ( mod(k, 10) == 0 )
        fprintf('# k = %d\n', k);
    end
    if ( k == 200 || k == 2000 )
        figure, doplot(u), drawnow, shg
    end
end

%% Helper functions

function chain(varargin)
    for k = 1:nargin
        varargin{k}();
    end
end

%% Ginzburg-Landau on the blob mesh

alpha = 0;
delta = 1e-3*(1+alpha*1i);
c = -1.5;
dt = 0.03;
n = 16;

N = @(u) u - (1+c*1i)*u.*(abs(u).^2);

rng(0)
dom = surfacemesh.blob(n, 2);
pdo = struct('lap', -dt*delta, 'b', 1);
L = surfaceop(dom, pdo);
L.build();

bb = boundingbox(dom);
f = randnfun3(0.5, bb);
u = surfacefun(@(x,y,z) f(x,y,z), dom);

doplot = @(u) chain(...
    @() camzoom(0.8), ...
    @() plot(real(resample(u, 40))), ...
    @() axis('off'), ...
    @() material('dull'), ...
    @() lighting('gouraud'), ...
    @() colormap('turbo'), ...
    @() camlight('headlight'));

figure, doplot(u), hold on, plot(dom, 'linewidth', 1.5)

t = 0;
kend = 2000;
for k = 1:kend
    L.rhs = u + dt*N(u);
    u = L.solve();
    t = t + dt;
    if ( mod(k, 100) == 0 )
        fprintf('# k = %d\n', k);
    end
    if ( k == 200 || k == 2000 )
        figure, doplot(u), drawnow, shg
    end
end

%% Ginzburg-Landau on the stellarator mesh

alpha = 0;
delta = 1e-2*(1+alpha*1i);
c = 1.5;
dt = 0.03;
n = 16;

N = @(u) u - (1+c*1i)*u.*(abs(u).^2);

rng(0)
dom = surfacemesh.stellarator(n, 8, 24);
pdo = struct('lap', -dt*delta, 'b', 1);
L = surfaceop(dom, pdo);
L.build();

bb = boundingbox(dom);
f = randnfun3(1, bb);
u = surfacefun(@(x,y,z) f(x,y,z), dom);

doplot = @(u) chain(...
    @() camzoom(0.9), ...
    @() plot(real(resample(u, 40))), ...
    @() axis('off'), ...
    @() material('dull'), ...
    @() lighting('gouraud'), ...
    @() colormap('turbo'), ...
    @() camlight('headlight'));

figure, doplot(u), hold on, plot(dom, 'linewidth', 1.5), shg

t = 0;
kend = 2000;
for k = 1:kend
    L.rhs = u + dt*N(u);
    u = L.solve();
    t = t + dt;
    if ( mod(k, 100) == 0 )
        fprintf('# k = %d\n', k);
    end
    if ( k == 200 || k == 2000 )
        figure, doplot(u), drawnow, shg
    end
end

%% Ginzburg-Landau on the cow mesh

alpha = 0;
delta = 5e-4*(1+alpha*1i);
c = 1.5;
dt = 0.03;
n = 16;

N = @(u) u - (1+c*1i)*u.*(abs(u).^2);

rng(1)
dom = surfacemesh.fromRhino('models/cow.csv', 8);
dom = resample(dom, n);
pdo = struct('lap', -dt*delta, 'b', 1);
L = surfaceop(dom, pdo);
L.build();

bb = boundingbox(dom);
f = randnfun3(0.2, bb);
u = surfacefun(@(x,y,z) f(x,y,z), dom);

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
    L.rhs = u + dt*N(u);
    u = L.solve();
    t = t + dt;
    if ( mod(k, 100) == 0 )
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

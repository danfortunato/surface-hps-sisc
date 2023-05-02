n = 16;
dom = surfacemesh.torus(n, 16, 48);

% Construct a random smooth tangential vector field
rng(0)
gx = randnfun3(10, boundingbox(dom));
gy = randnfun3(10, boundingbox(dom));
gz = randnfun3(10, boundingbox(dom));
V = cross([0 1 1], surfacefunv(@(x,y,z) gx(x,y,z), ...
                               @(x,y,z) gy(x,y,z), ...
                               @(x,y,z) gz(x,y,z), dom));
vn = normal(dom);
f = -cross(vn, vn, V);

% Compute the Hodge decomposition: f = grad(u) + n x grad(v) + w
tic
[u, v, w, curlfree, divfree] = hodge(f);
toc

close all

figure(1), plot(norm(f)), hold on, plot(dom)
quiver(normalize(f), 0.6, 3, 'Color', 'k')
colormap turbo, axis equal off

figure(2), plot(norm(curlfree)), hold on
quiver(normalize(curlfree), 0.6, 3, 'Color', 'k')
colormap turbo, axis equal off

figure(3), plot(norm(divfree)), hold on
quiver(normalize(divfree), 0.6, 3, 'Color', 'k')
colormap turbo, axis equal off

figure(4), plot(norm(w)), hold on
quiver(normalize(w), 0.6, 3, 'Color', 'k')
colormap turbo, axis equal off

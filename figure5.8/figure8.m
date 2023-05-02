delta = 1e-3;
c = -1.5;
N = @(u) u - (1+c*1i)*u.*(abs(u).^2);

n = 8;
dom = surfacemesh.fromRhino('models/cow.csv', 8);
dom = resample(dom, n);
bb = boundingbox(dom);
rng(1)
f = randnfun3(0.2, bb);
uinit = surfacefun(@(x,y,z) f(x,y,z), dom);
tend = 1;
dts = 1./[8 16 32 64 128 256 512 1024];

schemes = {'bdf1', 'bdf2', 'bdf3', 'bdf4'};
U = cell(length(dts), length(schemes));

for l = 1:length(schemes)
    scheme = schemes{l};
    fprintf('# scheme = %s, 1/dt =', scheme);
    for j = 1:length(dts)
        dt = dts(j);
        fprintf(' %d', 1/dt);
        switch ( lower(scheme) )
            case 'bdf1'
                lapscl = -dt*delta;
                step = @bdf1;
                multistep = 1;
            case 'bdf2'
                lapscl = -2/3*dt*delta;
                step = @bdf2;
                multistep = 2;
            case 'bdf3'
                lapscl = -6/11*dt*delta;
                step = @bdf3;
                multistep = 3;
            case 'bdf4'
                lapscl = -12/25*dt*delta;
                step = @bdf4;
                multistep = 4;
            otherwise
                error('Unknown time-stepping scheme.');
        end

        pdo = struct('lap', lapscl, 'b', 1);
        L = surfaceop(dom, pdo);
        L.build();

        % Make sure dt divides into tend nicely
        nsteps = ceil(tend/dt);
        dt = tend/nsteps;
        dts(j) = dt;

        % Simulation
        t = 0;
        u = uinit;
        uold = cell(multistep-1, 1);

        if ( multistep > 1 )
            % Do a few steps of LIRK4 to start the multistep method
            pdo = struct('lap', -1/4*dt*delta, 'b', 1);
            L1 = surfaceop(dom, pdo);
            L1.build();
            for k = 1:multistep-1
                uold{multistep-k} = u;
                L1.rhs = u + dt*1/4*N(u);
                a = L1.solve();
                L1.rhs = u + dt*(delta*lap(1/2*a) - 1/4*N(u) + N(a));
                b = L1.solve();
                L1.rhs = u + dt*(delta*lap(17/50*a - 1/25*b) - 13/100*N(u) ...
                    + 43/75*N(a) + 8/75*N(b));
                c = L1.solve();
                L1.rhs = u + dt*(delta*lap(371/1360*a - 137/2720*b + 15/544*c) ...
                    - 6/85*N(u) + 42/85*N(a) + 179/1360*N(b) - 15/272*N(c));
                d = L1.solve();
                L1.rhs = u + dt*(delta*lap(25/24*a - 49/48*b + 125/16*c - 85/12*d) ...
                    + 79/24*N(a) - 5/8*N(b) + 25/2*N(c) - 85/6*N(d));
                e = L1.solve();
                u = u + dt*(delta*lap(25/24*a - 49/48*b + 125/16*c - 85/12*d + 1/4*e) ...
                    + 25/24*N(a) - 49/48*N(b) + 125/16*N(c) - 85/12*N(d) + 1/4*N(e));
                t = t + dt;
            end
        end

        for k = multistep:nsteps
            [L.rhs, uold] = step(N, dt, u, uold);
            u = L.solve();
            t = t + dt;
        end

        U{j,l} = u;

    end
    fprintf('\n');
end

% Compute error
err = zeros(length(dts)-1, length(schemes));
for l = 1:length(schemes)
    uref = U{end,l};
    for j = 1:length(dts)-1
        err(j,l) = norm(U{j,l} - uref, inf) / norm(uref, inf);
    end
end

% Write results
fid = fopen('figure8.txt', 'w');
for j = 1:length(dts)-1
    fprintf(fid, '%4d', 1/dts(j));
    for l = 1:length(schemes)
        fprintf(fid, ' %e', err(j,l));
    end
    fprintf(fid, '\n');
end
fclose(fid);

%% Helper functions

function [rhs, Uold] = bdf1(N, dt, U, Uold)
    rhs = U + dt*N(U);
end

function [rhs, Uold] = bdf2(N, dt, U, Uold)
    rhs = 4/3*U - 1/3*Uold{1} + dt*(4/3*N(U) - 2/3*N(Uold{1}));
    Uold{1} = U;
end

function [rhs, Uold] = bdf3(N, dt, U, Uold)
    rhs = 18/11*U - 9/11*Uold{1} + 2/11*Uold{2} + ...
        dt*(18/11*N(U) - 18/11*N(Uold{1}) + 6/11*N(Uold{2}));
    Uold(2) = Uold(1);
    Uold{1} = U;
end

function [rhs, Uold] = bdf4(N, dt, U, Uold)
    rhs = 48/25*U - 36/25*Uold{1} + 16/25*Uold{2} - 3/25*Uold{3} + ...
          dt*(48/25*N(U) - 72/25*N(Uold{1}) + 48/25*N(Uold{2}) - 12/25*N(Uold{3}));
    Uold(2:3) = Uold(1:2);
    Uold{1} = U;
end

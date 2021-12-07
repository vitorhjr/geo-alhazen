addpath(genpath(pwd))
clearvars

%% Input values
Has = [10 50 100 200 300 500 1000];
ehors = get_horizon_elevation_angle (Has); % Minimum elevation angle
algs = {'fujimura','martinneira','helm','millerandvegh','fermat'};
Rs = get_earth_radius ();

%% Pre-allocate data
n = numel(Has);
m = numel(algs);
tmp = NaN(n,m);
Di = tmp;
g = tmp;
arclen = tmp;
sldist = tmp;
xspec = tmp;
yspec = tmp;

%% Computation of parameters for each algorithm

for i=1:m
    
    algorithm = algs{i};
    [Di(:,i), g(:,i), arclen(:,i), sldist(:,i), xspec(:,i), yspec(:,i)]...
            = get_reflection_spherical (ehors(:), Has(:), [], [], algorithm);
        
end

%% Expected values on spherical horizon
[Diref, gref, arclenref, sldistref, xspecref, yspecref] ... 
                   = get_spherical_horizon_params (Has(:), []);
               
%% Reflection points from local frame to quasigeocentric frame
[Xspec, Yspec] = get_quasigeo_coord (xspec,yspec,[]);
[Xspecref, Yspecref] = get_quasigeo_coord (xspecref,yspecref,[]);

%% Differences from expectation
dif_Di = Di - Diref;
dif_g = g - gref;
dif_X = Xspec - Xspecref;
dif_Y = Yspec - Yspecref;
dif_sd = sldist - sldistref;
dif_al = arclen - arclenref;

%% RMSE
rmse (1,:) = sqrt (sum(dif_g,1).^2 /numel(Has));
rmse (2,:) = sqrt (sum(dif_Di,1).^2/numel(Has));
rmse (3,:) = sqrt (sum(dif_X,1).^2./numel(Has));
rmse (4,:) = sqrt (sum(dif_Y,1).^2 /numel(Has));
rmse (5,:) = sqrt (sum(dif_sd,1).^2/numel(Has));
rmse (6,:) = sqrt (sum(dif_al,1).^2/numel(Has));

%% Tables

% Parameters
tbl_Di = array2table (Di, 'VariableNames',algs);
tbl_g = array2table (g, 'VariableNames',algs);
tbl_X = array2table (Xspec, 'VariableNames',algs);
tbl_Y = array2table (Yspec, 'VariableNames',algs);
tbl_sd = array2table (sldist, 'VariableNames',algs);
tbl_al = array2table (arclen, 'VariableNames',algs);

% Differences from expectation
tbl_dDi = array2table (dif_Di, 'VariableNames',algs);
tbl_dg = array2table (dif_g, 'VariableNames',algs);
tbl_dx = array2table (dif_X, 'VariableNames',algs);
tbl_dy = array2table (dif_Y, 'VariableNames',algs);
tbl_dsd = array2table (dif_sd, 'VariableNames',algs);
tbl_dal = array2table (dif_al, 'VariableNames',algs);

% RMSE
tbl_rmse = array2table (rmse, 'VariableNames',algs, ...
                        'RowNames',{'Graz. angle','Delay','X coord.','Y coord.','Slant dist.','Arc Len.'});

%% Figure minimum elevation angle
x = 0:1:max(Has);
y = get_horizon_elevation_angle([0:1:max(Has)],[]);

figure
plot (x,y,'--r','LineWidth',3)
ylim([min(ehors) 0])
ylabel ('Minimum elevation angle (degrees)')
xlabel ('Antenna height (m)')
grid on
set(gca,'FontSize',18)

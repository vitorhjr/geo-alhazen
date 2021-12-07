function [X, Y] = get_quasigeo_coord (x,y,Rs)

% Return quasigeocentric cartesian coordinates (X,Y) w.r.t. the center of
% osculating sphere
%
% Input:
% x,y: pair of coordinates in a local frame
% Rs: surface radius to the center of osculating sphere

if isempty(Rs),  Rs = get_earth_radius();  end

Y = y + Rs;
X = x;

end
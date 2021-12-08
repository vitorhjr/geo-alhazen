function [delay, graz_ang, arc_len, slant_dist, X_spec, Y_spec, X_trans, Y_trans, elev_spec] = get_reflection_spherical_quasigeo (varargin)
% GET_REFLECTION_SPHERICAL_QUASIGEO  Calculates reflection on spherical surface, with output coordinates in quasi-geocentric frame.
%
% INPUT: same as get_reflection_spherical
% 
% OUTPUT: same as get_reflection_spherical, except:
% - X_spec, Y_spec: reflection point coordinates in quasi-geocentric frame (matrices, in meters)
% - X_trans, Y_trans: transmitter point coordinates in quasi-geocentric frame (matrices, in meters)

    [delay, graz_ang, arc_len, slant_dist, X_spec, Y_spec, X_trans, Y_trans, elev_spec] = get_reflection_spherical (varargin{:});
    [X_spec, Y_spec] = get_quasigeo_coord (x_spec, y_spec);
    [X_trans, Y_trans] = get_quasigeo_coord (x_trans, y_trans);
end

function  [indx_BWskel_obj_fin] = eixamplar_indx_noendpoints(indx_BWskel_obj, indx_endpoints_BWskel, size_BW_objecte_skel)

% Donat una imatge esqueletonitzada, es fa el eixamplar_indx_BB, però els endpoints de la imatge no s'eixamplen.
%
%
% Temps de processament: Elapsed time is 0.001236 seconds.
%
% See also
% eixamplar_indx_BB
% pintar_indx_to_RGB


% INICI FUNCIÓ



[~, pos_ismemb] = ismember(indx_endpoints_BWskel, indx_BWskel_obj);

% Borrem les posicions
indx_BWskel_obj(pos_ismemb) = [];

[indx_BWskel_obj_eixamp] = eixamplar_indx_BB(indx_BWskel_obj, 1, size_BW_objecte_skel);

% Afegim els endpoints:
indx_BWskel_obj_fin = [indx_BWskel_obj_eixamp; indx_endpoints_BWskel];

% FINAL FUNCIÓ


end